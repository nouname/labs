package com.mobiledev.converter;
import android.content.Context;
import android.util.Xml;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

public class XmlParser {
    private static InputStream downloadUrl(String urlString) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setReadTimeout(10000);
        conn.setConnectTimeout(15000);
        conn.setRequestMethod("GET");
        conn.setDoInput(true);
        conn.connect();
        return conn.getInputStream();
    }

    private static String getNodeValue(String tag, Element element) {
        NodeList nodeList = element.getElementsByTagName(tag);
        Node node = nodeList.item(0);
        if(node!=null){
            if(node.hasChildNodes()){
                Node child = node.getFirstChild();
                while (child!=null){
                    if(child.getNodeType() == Node.TEXT_NODE){
                        return  child.getNodeValue();
                    }
                }
            }
        }
        return "";
    }

    public static List<HashMap<String, String>> parse() throws IOException, SAXException, ParserConfigurationException {
        List<HashMap<String, String>> values = new ArrayList<>();
        DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
        InputStream stream = downloadUrl("http://www.cbr.ru/scripts/XML_daily.asp");
        DocumentBuilder docBuilder = builderFactory.newDocumentBuilder();
        Document doc = docBuilder.parse(stream);
        NodeList nodeList = doc.getElementsByTagName("Valute");
        for (int i = 0; i < nodeList.getLength(); i++) {
            if(nodeList.item(0).getNodeType() == Node.ELEMENT_NODE){
                HashMap<String, String> value = new HashMap<>();
                Element e = (Element)nodeList.item(i);
                value.put("name", getNodeValue("Name", e));
                value.put("value", getNodeValue("Value", e));
                values.add(value);
            }
        }
        return values;
    }
}
