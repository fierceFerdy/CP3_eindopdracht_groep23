/**
 * Created with IntelliJ IDEA.
 * User: Arnoke
 * Date: 11/12/13
 * Time: 14:13
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.services {
import flash.display.Sprite;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class FormuleService extends Sprite{
    private var _f:File;

    public function FormuleService() {

        this.parseJson();
    }

    private function parseJson():void{
        _f = File.applicationStorageDirectory.resolvePath("test.json");
        trace("[Formules] JSON File Path: " + _f.nativePath);
        if(!_f.exists) {
            var writeStream:FileStream = new FileStream();

            writeStream.open(_f, FileMode.WRITE);
            var dataToWrite:Array = [
                {
                    id: 1,
                    name: "Price to Fuel",
                    factoren: [["Super 98", 1.2], ["Diesel", 1.1]]
                },
                {
                    id: 2,
                    name: "Miles to Kilometer",
                    factoren: [["kilometer", 1.60934]]
                }
            ];

            writeStream.writeUTFBytes(JSON.stringify(dataToWrite));
            writeStream.close();
        }
        var readStream:FileStream = new FileStream();
        readStream.open(_f, FileMode.READ);
        var dataString:String = readStream.readUTFBytes(readStream.bytesAvailable);
        readStream.close();
        var parsedData:Array = JSON.parse(dataString) as Array;
        trace(parsedData);
    }
}
}