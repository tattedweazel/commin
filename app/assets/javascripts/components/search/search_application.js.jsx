var SearchApplication = React.createClass({

  render: function () {
    return (
        <div className="search animate-away">
          <div className="input-field">
            <input id="search" type="text" className="validate valign" placeholder="Search"/>
            <i className="fa fa-search fa-2x main-search animated">
            </i>
            <span className="highlight"></span>
          </div>
        </div>
    );
  }
});