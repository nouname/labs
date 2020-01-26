package com.mobiledev.converter;

import android.os.Bundle;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.os.StrictMode;
import android.util.Xml;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import org.xml.sax.SAXException;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.xml.parsers.ParserConfigurationException;

public class MainActivity extends AppCompatActivity {
    private EditText source;
    private TextView result;
    double currentValute = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);

        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        try {
            final List<HashMap<String, String>> values = XmlParser.parse();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        }

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Converter listener = new Converter();
                String sourceText = source.getText().toString().replace(".", ",");
                NumberFormat format = NumberFormat.getInstance(Locale.FRANCE); // Handle ',' decimal delimiter
                try {
                    Number value = format.parse(sourceText);
                    result.setText(listener.onConvertEvent(value.doubleValue(), currentValute) + "");
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        });

        source = findViewById(R.id.source);
        result = findViewById(R.id.result);

        try {
            buildList(new Converter());
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private interface OnConvertEventListener {
        double onConvertEvent(double value, double valute);
    }

    private class Converter implements OnConvertEventListener {

        @Override
        public double onConvertEvent(double value, double valute) {
            Double result = value / valute;
            return BigDecimal.valueOf(result)
                    .setScale(3, RoundingMode.HALF_UP)
                    .doubleValue();
        }
    }

    private void buildList(final OnConvertEventListener listener) throws ParserConfigurationException, SAXException, IOException {
        final List<HashMap<String, String>> values = XmlParser.parse();
        ArrayList<String> names = new ArrayList<>();
        for (HashMap<String, String> map : values)
            names.add(map.get("name"));
        final ListView list = findViewById(R.id.list);
        list.setAdapter(new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, names));
        list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                String sourceText = source.getText().toString().replace(".", ",");
                NumberFormat format = NumberFormat.getInstance(Locale.FRANCE); // Handle ',' decimal delimiter
                try {
                    Number valute = format.parse(values.get(position).get("value"));
                    Number value = format.parse(sourceText);
                    result.setText(listener.onConvertEvent(value.doubleValue(), valute.doubleValue()) + "");
                    currentValute = valute.doubleValue();
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        });
    }
}
