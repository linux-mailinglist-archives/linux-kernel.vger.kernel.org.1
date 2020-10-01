Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B70F27FB1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgJAIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:09:20 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:55953 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgJAIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601539758; x=1633075758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cafUnTESJDdjYnNnJexgVcRUCwTh+2d84mIQYBQ8VyE=;
  b=w6uns0/1tPF7lGeUigDZ9Ym5yBUmpt9gWi8L2GCwWMybrwMqn8x5HI9f
   J10g71IQ6+aHufuB7PQUclYgRPXrQ6YigH5QL/D2+KhGQny4JnPk761gL
   I+k//Aj6Q3/pVoN8DhllkRhJxhWck9S6MrxlnmP11lSa7Z08nV7fGsTXd
   j90V2f4/ebpp5JgVAHnu7LIylNKyj8CxQIRTSsTcrYdEK1woaC15rh4vF
   7d2buNFQ1XH1uaEtG3qgpSp3Wn8vnSMq5NHL4VoOnbjrD2bsP3ebWTMUG
   17mNNg7/PB+chy6tdCs1VBXC5ooqYC7oJwufIKJIlt1m5mX/pgJimCpnd
   A==;
IronPort-SDR: efg51cydjfx5k1TGotrWtZAtGcN9PsDV9PjtXWRn7kXKgvcp0Mk5soc7hqroMPrk042PEEbMYJ
 QZHQszJLna+/7HCVj2KFIaEW+WjBLXHGYjnNis6PCwlV0FocE3yxdCbldiXwB71zwzOR44IidF
 TYqUMDB8lWDqILXzKZCICo5fi60gMc1IqOH6GjQa7L9f0D2cYIZe17jl0SMfI7Kkk4cDDZop9t
 +5dq5PXhp46+EAXXnZURg44KOBMrGOib72U8DLHWJtb0hf74QhTCAdcmKLJYuUE9wsjMXjEPbB
 Kf8=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="28340985"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 01:09:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 01:08:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 01:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZeYwBHaAn/uLG6Tl+1I/CNoUu74cRZh0PNxziCSFhfybBm5Q13HpuZ8cAoD4F7y/5JWr0Rk27/Clc/N0JjyLE4fIZB3+e74GrfedqBSnUwoir1M7uY5uhLFdxLnA3lXpUkZgfd/d6xwwgFyp/MzU6KUJ1vtd0+PXBwP8DQCLUaB3e8pCd3XrtTj6ul0pmgEwU9hE4uzmXG9gukYc1taXUW8kVemi+lWu7EVLtSfuVYiXBBTn5IN4JWfkV1wQ1czIvDLejaYWVNFjkZNHG0HkEbu4eSYEsupVfglv+mYmFcXyqUUQ0PvoDziw7ucxqXpXuq7zflYVoVgVjPv7Dmt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cafUnTESJDdjYnNnJexgVcRUCwTh+2d84mIQYBQ8VyE=;
 b=JZPL21raHh/3mnWyPBOLdaqeQq0Tn3C2jFkDVFxFdUobCzff5U2LLhljQafuJERN5OfFJMIeDKYZZ0Pg/CNRYZ/SCX647bjvTuEzng/uwy4Uht+9oUi40sEl3nYLcPnBb7/B05LCsGtKK2GhjfxmsIwkZnp0oj8GjnOCTiKU/Bdvuz7zivsPXWjeaReDdKu7MV/A9jMHfrpFQjDgqw172ObZa0Ur0krv44MecTlqGWFUCCv3/MzqnJ5LnZPquV6WFcOxB7pGD+LP1mM35j6vTZy1hQkcw4xpWCEyzrqvbJgh70jbp+CJxd+6WYGTmONcB99PZQgonPliBlXY2lR3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cafUnTESJDdjYnNnJexgVcRUCwTh+2d84mIQYBQ8VyE=;
 b=kFAscr2Uvhjrd0gmE8M/U3VhlgXePoAD1FBdCp8mCeMUCD7U4e/DGshnjWLRTQn5iVy0RGNKPxoy/J8L2tjQHnx8teEvJCaIgem3QJSLYQIk5GHHbn1lQSdH7P4zBV1/lVA2qUaeFSnfnDzI4phQV4DKJgYvwH237lTtxG+fZ/E=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (10.175.91.12) by
 DM6PR11MB4594.namprd11.prod.outlook.com (20.180.252.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Thu, 1 Oct 2020 08:09:14 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 08:09:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 08/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Topic: [PATCH v14 08/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Index: AQHWl8oabzlDdL0vp0ONiMw+1kL2TA==
Date:   Thu, 1 Oct 2020 08:09:14 +0000
Message-ID: <3e162719-80c7-03dc-dc2a-29a46bc4cb2c@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-9-p.yadav@ti.com>
In-Reply-To: <20200930185732.6201-9-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f10d3e00-d79d-4445-8683-08d865e14920
x-ms-traffictypediagnostic: DM6PR11MB4594:
x-microsoft-antispam-prvs: <DM6PR11MB4594FA27B0D01DDD237E2D36F0300@DM6PR11MB4594.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORoWjD6ab27FRl1pC2Ua5nUeCo3ORCEX/+aJvMi8avELMGMUihxeh6kUErwCk5SWHM0D6SgCDh7GOfBi0ERd0fIh92QxQJ0zDldxcJk8y55YAvjDmyXX41Ue8N795YE7HA0C4GwkTacdlfCSpEZUfMourSn0bZcYqvLYKsJK4Fku+01qpmOyxP4VN0NyZcaU6fAm76OOkFCTvvyKpNCyJVJxRiJHgD59cuLNGs3VjXme2VVO8DMXrf4YTF4PMM/3pRIoBVENGkmj39VcIAe1jc6sPCgQ6no0i9nd7dsP2+HIqCdybsD3I1tfc9FwQzxoQVYXoZxznfsUcsWzCaHh/A/n8NHtjt73nTd1+teEjt0RVz+XlbIYSApK35iYWQYf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(346002)(136003)(86362001)(6512007)(36756003)(83380400001)(4326008)(478600001)(8676002)(110136005)(31696002)(2616005)(8936002)(31686004)(91956017)(5660300002)(76116006)(71200400001)(54906003)(186003)(6486002)(2906002)(66946007)(316002)(64756008)(6506007)(53546011)(66446008)(66556008)(66476007)(26005)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: P2k6YTXtV7Q9wEPEQDvwdYuVdjCMn2xvhwiQgNQFOGVK7Dmu2ylGKoTLtUKRa4hG9sfWOubEIaF60NC+m6mqn6O9h/3dcf3oTfGw2rV9LoWiNS3GwXNwp+CM/Yy6yh3Mw2cvm5f7TJgeSIGePy1DjC99mgyJRtE6NpPtU3+6SrNl6vmMmngI6u+4CfGd82orGSgPGbjDSIczopRMK3qap18N+tfyjDEg7zantKyZrrAIiYsmS+hlFke2N7fX5Ccqvdc5omZe7vMBdiXLonGEUc/y53cvHDby4lBQr3jORD7sCIg+VYnHvw7QavIJuT9hj39ga6nyVfba0NBnyig/WqX7gmAQM57pjj5fLjjO2mOkCO0vIg8yRynEmtlnHWuDRqPr9YwwGBt3XshGjFVSz0paJNJl9LtA2Qj2FIHcyQvXf3vTloCXBJss9Ux8qDmRmFGwBWEj86zUQLxOlBGQbq+QtUWqjCa34gAbApn0zrnHcKPVCnrLllUutXgbYIpsFmHsZRzULK7EkqnZWjoCIy36VEoom48ADZ2y/ZUiC7yTbjkK9V7qY/sFLunuwDdA/ozMCJCa6X9IBEfv5piraM+PLIIzsoaHGx0NK3voBPv1uM17Qpe4dhiVMNBqKrRUxH1ZtNi7A6LwPUu0YMBQ7A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <33019604D7CEC649B137852452E1D41B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10d3e00-d79d-4445-8683-08d865e14920
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 08:09:14.0800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsj2M2H9oFiXucxxo4PHaKiung+jZxTrxSg1PqAd4fZf+NuIZFgBYbsIASCdYzvq/78JshzOl/Nd0/vjc308wb0vMWiTTXgMDuiTkC13B+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbGxvdyBmbGFzaGVzIHRvIHNwZWNpZnkgYSBo
b29rIHRvIGVuYWJsZSBvY3RhbCBEVFIgbW9kZS4gVXNlIHRoaXMgaG9vaw0KPiB3aGVuZXZlciBw
b3NzaWJsZSB0byBnZXQgb3B0aW1hbCB0cmFuc2ZlciBzcGVlZHMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9t
dGQvc3BpLW5vci9jb3JlLmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggfCAgMiArKw0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCAzNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3Bp
LW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBpbmRleCA3M2EyNmU3
ZTMyYzIuLjZiNTRhOTIzMDAyYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gQEAgLTMwNjgsNiAr
MzA2OCwzNSBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3Ig
Km5vcikNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICsvKiogc3BpX25vcl9vY3Rh
bF9kdHJfZW5hYmxlKCkgLSBlbmFibGUgT2N0YWwgRFRSIEkvTyBpZiBuZWVkZWQNCj4gKyAqIEBu
b3I6ICAgICAgICAgICAgICAgICBwb2ludGVyIHRvIGEgJ3N0cnVjdCBzcGlfbm9yJw0KPiArICog
QGVuYWJsZTogICAgICAgICAgICAgIHdoZXRoZXIgdG8gZW5hYmxlIG9yIGRpc2FibGUgT2N0YWwg
RFRSDQo+ICsgKg0KPiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2Uu
DQo+ICsgKi8NCj4gK3N0YXRpYyBpbnQgc3BpX25vcl9vY3RhbF9kdHJfZW5hYmxlKHN0cnVjdCBz
cGlfbm9yICpub3IsIGJvb2wgZW5hYmxlKQ0KPiArew0KPiArICAgICAgIGludCByZXQ7DQo+ICsN
Cj4gKyAgICAgICBpZiAoIW5vci0+cGFyYW1zLT5vY3RhbF9kdHJfZW5hYmxlKQ0KPiArICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gKyAgICAgICBpZiAoIShub3ItPnJlYWRfcHJvdG8g
PT0gU05PUl9QUk9UT184XzhfOF9EVFIgJiYNCj4gKyAgICAgICAgICAgICBub3ItPndyaXRlX3By
b3RvID09IFNOT1JfUFJPVE9fOF84XzhfRFRSKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiArDQo+ICsgICAgICAgcmV0ID0gbm9yLT5wYXJhbXMtPm9jdGFsX2R0cl9lbmFibGUobm9y
LCBlbmFibGUpOw0KDQpJZGVhbGx5IHBhdGNoIDkvMTUgYW5kIDEwLzE1IHNob3VsZCBoYXZlIGJl
ZW4gYmVmb3JlIDgvMTUuIFdlIHNob3VsZCBkZW55DQp0aGUgYWNjZXNzIHRvIG9jdGFsIGR0ciBl
bmFibGUgZm9yIE5WIGZsYXNoZXMgc2luY2UgbW9tZW50IDAuDQoNCj4gKyAgICAgICBpZiAocmV0
KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKw0KPiArICAgICAgIGlmIChlbmFi
bGUpDQo+ICsgICAgICAgICAgICAgICBub3ItPnJlZ19wcm90byA9IFNOT1JfUFJPVE9fOF84Xzhf
RFRSOw0KPiArICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIG5vci0+cmVnX3Byb3RvID0g
U05PUl9QUk9UT18xXzFfMTsNCj4gKw0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo+
ICAvKioNCj4gICAqIHNwaV9ub3JfcXVhZF9lbmFibGUoKSAtIGVuYWJsZSBRdWFkIEkvTyBpZiBu
ZWVkZWQuDQo+ICAgKiBAbm9yOiAgICAgICAgICAgICAgICBwb2ludGVyIHRvIGEgJ3N0cnVjdCBz
cGlfbm9yJw0KPiBAQCAtMzEwNyw2ICszMTM2LDEyIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9pbml0
KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICB7DQo+ICAgICAgICAgaW50IGVycjsNCj4gDQo+ICsg
ICAgICAgZXJyID0gc3BpX25vcl9vY3RhbF9kdHJfZW5hYmxlKG5vciwgdHJ1ZSk7DQo+ICsgICAg
ICAgaWYgKGVycikgew0KPiArICAgICAgICAgICAgICAgZGV2X2RiZyhub3ItPmRldiwgIm9jdGFs
IG1vZGUgbm90IHN1cHBvcnRlZFxuIik7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0K
PiArICAgICAgIH0NCj4gKw0KPiAgICAgICAgIGVyciA9IHNwaV9ub3JfcXVhZF9lbmFibGUobm9y
KTsNCj4gICAgICAgICBpZiAoZXJyKSB7DQo+ICAgICAgICAgICAgICAgICBkZXZfZGJnKG5vci0+
ZGV2LCAicXVhZCBtb2RlIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9jb3JlLmggYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPiBpbmRl
eCA5YTMzYzhkMDczMzUuLjVjZmUyZGI5ZWUxMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQv
c3BpLW5vci9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gQEAg
LTIwMyw2ICsyMDMsNyBAQCBzdHJ1Y3Qgc3BpX25vcl9sb2NraW5nX29wcyB7DQo+ICAgKiAgICAg
ICAgICAgICAgICAgICAgICBoaWdoZXIgaW5kZXggaW4gdGhlIGFycmF5LCB0aGUgaGlnaGVyIHBy
aW9yaXR5Lg0KPiAgICogQGVyYXNlX21hcDogICAgICAgICB0aGUgZXJhc2UgbWFwIHBhcnNlZCBm
cm9tIHRoZSBTRkRQIFNlY3RvciBNYXAgUGFyYW1ldGVyDQo+ICAgKiAgICAgICAgICAgICAgICAg
ICAgICBUYWJsZS4NCj4gKyAqIEBvY3RhbF9kdHJfZW5hYmxlOiAgZW5hYmxlcyBTUEkgTk9SIG9j
dGFsIERUUiBtb2RlLg0KPiAgICogQHF1YWRfZW5hYmxlOiAgICAgICBlbmFibGVzIFNQSSBOT1Ig
cXVhZCBtb2RlLg0KPiAgICogQHNldF80Ynl0ZV9hZGRyX21vZGU6IHB1dHMgdGhlIFNQSSBOT1Ig
aW4gNCBieXRlIGFkZHJlc3NpbmcgbW9kZS4NCj4gICAqIEBjb252ZXJ0X2FkZHI6ICAgICAgY29u
dmVydHMgYW4gYWJzb2x1dGUgYWRkcmVzcyBpbnRvIHNvbWV0aGluZyB0aGUgZmxhc2gNCj4gQEAg
LTIyNiw2ICsyMjcsNyBAQCBzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgew0KPiANCj4g
ICAgICAgICBzdHJ1Y3Qgc3BpX25vcl9lcmFzZV9tYXAgICAgICAgIGVyYXNlX21hcDsNCj4gDQo+
ICsgICAgICAgaW50ICgqb2N0YWxfZHRyX2VuYWJsZSkoc3RydWN0IHNwaV9ub3IgKm5vciwgYm9v
bCBlbmFibGUpOw0KPiAgICAgICAgIGludCAoKnF1YWRfZW5hYmxlKShzdHJ1Y3Qgc3BpX25vciAq
bm9yKTsNCj4gICAgICAgICBpbnQgKCpzZXRfNGJ5dGVfYWRkcl9tb2RlKShzdHJ1Y3Qgc3BpX25v
ciAqbm9yLCBib29sIGVuYWJsZSk7DQo+ICAgICAgICAgdTMyICgqY29udmVydF9hZGRyKShzdHJ1
Y3Qgc3BpX25vciAqbm9yLCB1MzIgYWRkcik7DQo+IC0tDQo+IDIuMjguMA0KPiANCg0K
