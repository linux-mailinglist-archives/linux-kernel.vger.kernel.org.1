Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02C427E1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgI3GuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:50:22 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:65220 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgI3GuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601448612; x=1632984612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rSr0T7lQHu1yaJgDPGrvsiXKR9Wt/+8kvMIxSALEhPo=;
  b=Ucxqptl1EbcpQ0vv4lWY8sS9HPfUVORo0+n852cs1CMz3225B8kv/jhr
   w1e1MVJgMo9fp0/GfC+zGlEv1I0vQrwj6irc0Rzbs+LPFX2IecagUdNcz
   MFFzaEsXYmOAP0YblZKoZWU38a8LKLtQKwHAYj7KkTnZzz8pLGrgrfzs1
   gDLeasu8NEkjQbSRdLQzcpaUD5RjXL72i3nTQFYkrLtto0FQIhyE8mWGN
   vbSBRQZriQwf4mV2TLNSZ1bRDB8Nlc1nqj7/fcO3Fc0g6hHZaNY635xUq
   xXojT71mxfVacWuuLOpaT3C+HoZQnTZMdmSGe7fratSbf3M/QeVqjnQRs
   w==;
IronPort-SDR: QzpdOiN/+WOCbZg3Hix/TDtDhXkdNDD6gmZpCgQS1i/PHdNajMu4aTkzES4eJ/ufaqi4hSL3Im
 sh3BS6HOwe5r1ghTW2W4d2NASyxisAo1KIKvIS4OQwKLKl09BhBU9RcBoz9833nhOF33ZrDAsO
 1NO/0PdChnY7VJfNFbeQONpWjba//bIVtrAuw+g8XzlxZRib35jbpPYhH7cvXEPwLEUWq2dmYK
 gkBN6KqZp95GtT3lHPdZvbsr4W7hRjbBHzAdnlzROaEr6DahoADt/g3kz5GfmQIbk1uzm7WR+2
 ZAc=
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="93692166"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 23:50:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 23:49:56 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 29 Sep 2020 23:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQVV0395RVGq3EDxqky8aKnZBGc2g9XHig0h66PRcyBlGxO68lJ4V4jLLUyefWQhBHjN0u51jsvFdTDLBTYbP2abRHZ7k1t+PmB7tNGyGOtd8ZMYQr08BigqWZhxZjhcCRXhW8EcCErIod03TMWT/As5vQxB2Axbx2C/MyaLeAtCPGzjV7iLciPgp7XW2yPnv8oUG4Oy2P5CM7UK2bdcEc+IVtOU6SnSS0JWHoQqR9j9Prt8f6XItgAn/3oZbbDjxo7GDMJxb9PjsAZoTn/7WgAqyXzbj08I3Zz8vIMkL6jK7SWokcI8Vz17p4zDttRl/sJdGR0PHGq+WuIz6aesWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSr0T7lQHu1yaJgDPGrvsiXKR9Wt/+8kvMIxSALEhPo=;
 b=h+LRvxX+amcQE2oOKDfu17qDo0FIAkOLBxAffIVkZDoQM/DmppWHT2Mzzh7NMzJ+2jC5eVxSYvAwZG0p/rbvgKw17znCQTURLOboBa8osalvADf2Y9xaBkkM2WUtw1nrEKKf/v1gQDae79jRFgMrE333jxjmIvka3B/P8KSv07/GEvJ/RfUpIO7W1gqowgFC5hnNJR9bapbWGNbOLEvYR3SQli2jtLFpL5w70ZLylEYeeKQ4u7MHVkDjUMJuH1Y2bjH2ggUxWGp6FcTceCQ/WGVYkD98T+FvgM9T4M5zfoUbLEg1KKOJW4XGTt0I/3eDTg80/Z8nY9vn3Fx4c3YvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSr0T7lQHu1yaJgDPGrvsiXKR9Wt/+8kvMIxSALEhPo=;
 b=FwA51Z4FgQsRUsy9JaektNl5jCo2i/FNetAarWfR+4G49xbPjdf34pRBP07DHurPJEo2kW+ncWXqeuSmGdrOBD0ha0RfgXMZWgYPOG5zUQbOj61IISAGba/IjREHvgEwONEaI+Zg5asg4SPcJdpnNadC11u72ELSgEGajefvmhU=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4123.namprd11.prod.outlook.com (2603:10b6:5:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Wed, 30 Sep
 2020 06:50:09 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 06:50:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 08/15] mtd: spi-nor: core: do 2 byte reads for SR and
 FSR in DTR mode
Thread-Topic: [PATCH v13 08/15] mtd: spi-nor: core: do 2 byte reads for SR and
 FSR in DTR mode
Thread-Index: AQHWlvXvbGbh0YzMp0+DVtDRFRmraw==
Date:   Wed, 30 Sep 2020 06:50:09 +0000
Message-ID: <6198a69a-2800-d14f-1d29-9511ba6a3f5f@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-9-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-9-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc37b08b-c583-493c-7d63-08d8650d12d9
x-ms-traffictypediagnostic: DM6PR11MB4123:
x-microsoft-antispam-prvs: <DM6PR11MB4123A59AA2634AEE98F4432BF0330@DM6PR11MB4123.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJ973W/XEo5P3mqUkCixdFsPUkrNXtAyjnge+Is2or4GLVi2hVT0y6OfLDq+5t39f/NyTzozCXw7K1W9BY5IGaou00fLBQhJaRVWtHTAN1tX07vwNRxLPqtRUrNBVxP6qvdqROfQ6Xm1V6IYvBUhTy78+Ih88+wgXrSVuk4yvc3aTTEN/S7130epB+b4Xl6BW3jXnoNkTJHqMrlTDSiCMM5TyxQZJvksvkkQCwsLhlnkTE7cHe6gD4pdUjhlELM7iGcR1TeqrXBUZKlnDWGnmLpHK9rWT1n3tYIugKwvewpfYGHXtQHiroJME1eRGh2OQvg00HzMYYNiFkiX+oedGggsksuXTefFlnojbulReQjchLoFYtB50lmcKSqTs+dPSEA6jd0V5xLTvaTgjIe8/IU3S+w3tGPonirOVfz15VcQyQPNXkKKvrHpjRS8kC9B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(8936002)(8676002)(6512007)(6486002)(5660300002)(2616005)(66946007)(91956017)(31686004)(66556008)(66476007)(76116006)(316002)(71200400001)(64756008)(66446008)(54906003)(110136005)(6506007)(53546011)(86362001)(478600001)(83380400001)(26005)(36756003)(4326008)(31696002)(186003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cG/OjKntCaHtLwUE/Yq47ZK6uvae6hRhYFryCH8V+8H9JutP0vI1mqwm/Z1t3N9IakXl8Rd5QDIgGrYzQyeBwhV60cqroHM7Y3HnTs63pfHLy/2IoH/tffrQYbuCrvQocO4BLIixr6i3EqM2OrettjqQXp7OPXNhE+YOixzrxUW8eII50J8oiBPPSAKoD995SUTUrq+nH2Y8RcBHoVLQ2/cJFGcWvOeFhue2cvEGn2N/9e4OWpEujt1oSpD0dLHN5woUaHIq8W4Da6bJedJTj0SVTxipieQCC81ziAHa2OADA63pA7K9bXvzhlz7TN2+9o9JEH9nqI24pfhJiOlO+G2DZQu+Q5YAa8IGQFtf39It9JPzvbyCo2XK6Ow7BK+qML5vUkt0FCT5o7SQ4GYHQ1Q7ZGIPWxthwutdftzzXP4pqprnnPgv/JPMQX/MGNsvBJoF43sHekQj5ZpcbSDQ+RJZEpp+XbaiPuwkWStnKCq8v4zv8kG9MEDjp3TFkL/ZokNt4OHx6QpyYsWbW0lBr8q5gTGVYDXeLc7wP9zhCOrEI1WWyrIROVPKOz2k/aLP5/ZcOV1WfiorQr83lAAd592QVa5ZHtImqrxmUUsDseIkwxYsEzDX+guUKVytJ5XWsFosEAttsT1/TadnYeAnhw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B57AAD26DACF2F488105D183D68C2FEA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc37b08b-c583-493c-7d63-08d8650d12d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 06:50:09.6329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yoYvN4yaUEeqJQHtvtWA14CFYqm3i5a4dX9dhSJl+wXmRWU4CrGITHN1x/7GwfXuTMX8Z65tWVPyyI4H8VwHVfkxzqCS5U7lRU4wnRDlMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTb21lIGNvbnRyb2xsZXJzLCBsaWtlIHRoZSBj
YWRlbmNlIHFzcGkgY29udHJvbGxlciwgaGF2ZSB0cm91YmxlIHJlYWRpbmcNCj4gb25seSAxIGJ5
dGUgaW4gRFRSIG1vZGUuIFNvLCBkbyAyIGJ5dGUgcmVhZHMgZm9yIFNSIGFuZCBGU1IgY29tbWFu
ZHMgaW4NCg0KZGlkIHlvdSBnZXQgZ2FyYmFnZSB3aGVuIHJlYWRpbmcgb25seSBvbmUgYnl0ZT8N
Cg0KPiBEVFIgbW9kZSwgYW5kIHRoZW4gZGlzY2FyZCB0aGUgc2Vjb25kIGJ5dGUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCAxNSArKysrKysrKysrKysrLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMNCj4gaW5kZXggODhjOWUxODA2N2Y0Li44N2M1NjhkZWJmMTQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jDQo+IEBAIC0zNjgsNyArMzY4LDcgQEAgaW50IHNwaV9ub3Jfd3JpdGVfZGlzYWJsZShz
dHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgICogc3BpX25vcl9yZWFkX3NyKCkgLSBSZWFkIHRoZSBT
dGF0dXMgUmVnaXN0ZXIuDQo+ICAgKiBAbm9yOiAgICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3Bp
X25vcicuDQo+ICAgKiBAc3I6ICAgICAgICAgICAgICAgIHBvaW50ZXIgdG8gYSBETUEtYWJsZSBi
dWZmZXIgd2hlcmUgdGhlIHZhbHVlIG9mIHRoZQ0KPiAtICogICAgICAgICAgICAgIFN0YXR1cyBS
ZWdpc3RlciB3aWxsIGJlIHdyaXR0ZW4uDQo+ICsgKiAgICAgICAgICAgICAgU3RhdHVzIFJlZ2lz
dGVyIHdpbGwgYmUgd3JpdHRlbi4gU2hvdWxkIGJlIGF0IGxlYXN0IDIgYnl0ZXMuDQo+ICAgKg0K
PiAgICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UuDQo+ICAgKi8NCj4g
QEAgLTM4Niw2ICszODYsMTEgQEAgc3RhdGljIGludCBzcGlfbm9yX3JlYWRfc3Ioc3RydWN0IHNw
aV9ub3IgKm5vciwgdTggKnNyKQ0KPiAgICAgICAgICAgICAgICAgaWYgKHNwaV9ub3JfcHJvdG9j
b2xfaXNfZHRyKG5vci0+cmVnX3Byb3RvKSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBv
cC5hZGRyLm5ieXRlcyA9IG5vci0+cGFyYW1zLT5yZHNyX2FkZHJfbmJ5dGVzOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBvcC5kdW1teS5uYnl0ZXMgPSBub3ItPnBhcmFtcy0+cmRzcl9kdW1t
eTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICogV2UgZG9uJ3Qgd2FudCB0byByZWFkIG9ubHkgb25lIGJ5dGUgaW4gRFRSIG1vZGUuIFNv
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgKiByZWFkIDIgYW5kIHRoZW4gZGlzY2FyZCB0
aGUgc2Vjb25kIGJ5dGUuDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBvcC5kYXRhLm5ieXRlcyA9IDI7DQoNCmp1c3QgZm9yIG9jdGFsIGR0
ciwgYnV0IHNob3VsZCBiZSBmaW5lIGlmIHlvdSB1cGRhdGUgdGhlIHByZXZpb3VzIHBhdGNoDQoN
Cj4gICAgICAgICAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgICAgICAgICBzcGlfbm9yX3NwaW1l
bV9zZXR1cF9vcChub3IsICZvcCwgbm9yLT5yZWdfcHJvdG8pOw0KPiBAQCAtNDA1LDcgKzQxMCw4
IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkX3NyKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4ICpz
cikNCj4gICAqIHNwaV9ub3JfcmVhZF9mc3IoKSAtIFJlYWQgdGhlIEZsYWcgU3RhdHVzIFJlZ2lz
dGVyLg0KPiAgICogQG5vcjogICAgICAgcG9pbnRlciB0byAnc3RydWN0IHNwaV9ub3InDQo+ICAg
KiBAZnNyOiAgICAgICBwb2ludGVyIHRvIGEgRE1BLWFibGUgYnVmZmVyIHdoZXJlIHRoZSB2YWx1
ZSBvZiB0aGUNCj4gLSAqICAgICAgICAgICAgICBGbGFnIFN0YXR1cyBSZWdpc3RlciB3aWxsIGJl
IHdyaXR0ZW4uDQo+ICsgKiAgICAgICAgICAgICAgRmxhZyBTdGF0dXMgUmVnaXN0ZXIgd2lsbCBi
ZSB3cml0dGVuLiBTaG91bGQgYmUgYXQgbGVhc3QgMg0KPiArICogICAgICAgICAgICAgIGJ5dGVz
Lg0KPiAgICoNCj4gICAqIFJldHVybjogMCBvbiBzdWNjZXNzLCAtZXJybm8gb3RoZXJ3aXNlLg0K
PiAgICovDQo+IEBAIC00MjMsNiArNDI5LDExIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkX2Zz
cihzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCAqZnNyKQ0KPiAgICAgICAgICAgICAgICAgaWYgKHNw
aV9ub3JfcHJvdG9jb2xfaXNfZHRyKG5vci0+cmVnX3Byb3RvKSkgew0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBvcC5hZGRyLm5ieXRlcyA9IG5vci0+cGFyYW1zLT5yZHNyX2FkZHJfbmJ5dGVz
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICBvcC5kdW1teS5uYnl0ZXMgPSBub3ItPnBhcmFt
cy0+cmRzcl9kdW1teTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICogV2UgZG9uJ3Qgd2FudCB0byByZWFkIG9ubHkgb25lIGJ5dGUgaW4g
RFRSIG1vZGUuIFNvLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgKiByZWFkIDIgYW5kIHRo
ZW4gZGlzY2FyZCB0aGUgc2Vjb25kIGJ5dGUuDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAq
Lw0KPiArICAgICAgICAgICAgICAgICAgICAgICBvcC5kYXRhLm5ieXRlcyA9IDI7DQo+ICAgICAg
ICAgICAgICAgICB9DQo+IA0KPiAgICAgICAgICAgICAgICAgc3BpX25vcl9zcGltZW1fc2V0dXBf
b3Aobm9yLCAmb3AsIG5vci0+cmVnX3Byb3RvKTsNCj4gLS0NCj4gMi4yOC4wDQo+IA0KDQo=
