pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract hw321 {
    //создали структура
    struct Task {
           string name;
           uint32 timestamp;
           bool undone;
           }
    
    //присвоили ключ
    mapping(int8 => Task) ID_task;

    //создали массив для ключа (каждому ключу соответвуют данные из структуры)
    int8[] taskKey;

    int8 key = 1;
        
    constructor() public {
        require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
        
    }

    modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
		_;
    }
    // добавить задачу+
    function Add (string new_task) public checkOwnerAndAccept {
        ID_task[key].name = new_task;
        ID_task[key].timestamp = now;
        ID_task[key].undone = true;
        taskKey.push(key);
        key++;
        
    }

    // получить количество открытых задач+
    function Amount() public checkOwnerAndAccept view  returns (uint) {
    return taskKey.length;
    }

    //получить список задач+
    function List() public checkOwnerAndAccept view returns (Task[]){
        uint256 x = taskKey.length;
        Task[] Todo;
        for (int8 i=1; i<=int(x); i++){
            int8 y = i;
            Task newTask = Task(ID_task[i].name, ID_task[i].timestamp, ID_task[i].undone);
        Todo.push(newTask);}
        return Todo;
    }

     //получить описание задачи по ключу+
    function KeyTask(int8 _key) public checkOwnerAndAccept view returns (string, uint32, bool){
        return (ID_task[_key].name, ID_task[_key].timestamp, ID_task[_key].undone);}
    

    //удалить задачу по ключу+
    function DeleteKey(int8 _key) public checkOwnerAndAccept{
        delete ID_task[_key];
    }

    // отметить задачу как выполненную по ключу+
    function Done(int8 _key) public checkOwnerAndAccept{
        ID_task[_key].undone = false;
    }
}