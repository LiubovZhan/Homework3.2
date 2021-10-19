pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract hw321 {
    struct Task {
           string name;
           uint32 timestamp;
           bool undone;
           }
    
    mapping(int8 => Task) ID_task;

    Task[] tasks;
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


    // добавить задачу
    function Add (string new_task) public checkOwnerAndAccept {
    Task newTask = Task (new_task, now, true);
        tasks.push(newTask);

        ID_task [key] = newTask;
        key++;
    }

    // получить количество открытых задач
    function Amount() public checkOwnerAndAccept view returns (uint) {
    uint _amount = tasks.length;
    return (_amount);
    }

    //получить список задач
    function List() public checkOwnerAndAccept view returns (Task[]){
        
    }

     //получить описание задачи по ключу
    function KeyTask(int8 _key) public checkOwnerAndAccept returns (string){
        ID_task [_key];
        return (tasts.name);}
    }

    //удалить задачу по ключу
    function Remove(int8 _key) public checkOwnerAndAccept {
        if (ID_task [_key]= true) {
            tasks.pop();
        }
    }

    // отметить задачу как выполненную по ключу
    function Done(int8 _key) public checkOwnerAndAccept{
        if (ID_task [_key] = true) {
            tasks.undone=false;
        }
    }
}