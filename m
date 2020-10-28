Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF9B29D79E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgJ1WYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:24:45 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:36281 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732970AbgJ1WYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603923872; x=1635459872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A+9m0pFs0ir54wp+MgVZWoHjwig2VWrcIw6C6koOzAw=;
  b=h9McuRSUF5jhyfJSysmmHKgA/6MIcbK97fq3nyHRFUZmmahPGpDg6C68
   iQ4WleaLAPFvX9scN5zF2xuViw5ifojABQ1d2C0D1hLKmCXwGkB7XQtDi
   HaT4jNxghnqqGqqRREFIVOBpCPUWSxOjIJVgYeLOAXd2GoclObkbgRIps
   M3AYUoMkPFDHuA4KCYbCI12y9AaV9YrmhUrNn36bubzxcMBDjOKPDgpHW
   TNrqXkafhO7YPCb4eJC0y/xyRq06bV35/CeP5f7D7ncGT2kdIMuq1p9Dq
   /DAHstCjcaREDPjiRNAv0j7b/KOENisZdTyfX/ZyMxxTElmicJ5rqrVoH
   g==;
IronPort-SDR: OHaSpts81VJrZU3iqxFKLDYwWqFkBB2PlzdZGx80vqJpkRCspLIv+BUCz8wiVLaTGK04eeqVGH
 oPLYWSGVfwGNK3o9gfxI0k2H9BKr5/XbNoYxHxl9jljhx9EhNksdxSZIb3OoY4QFKXTXsc8x8p
 SBcmzxTj3I/u3aZmOhRcwgyDRA5lEGdaNz4UPu+RKRiFp0r3pamKapm7hvtS+7iD5FWVuNPqVP
 olwk1RX8a4oz8CxKDvrtlHD5A0npTYaqjww+ZY0UMpt/eYLbGhqqnxKsgZ/lTrsP2qfpY19sxR
 +Vo=
X-IronPort-AV: E=Sophos;i="5.77,426,1596524400"; 
   d="scan'208";a="94251028"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2020 08:21:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 28 Oct 2020 08:21:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 28 Oct 2020 08:21:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRKeDum1wqftGazLJknVEvZ6QzdqkUhoBSNuJWiqED4+eylT7NgWIBHFAHOEOq4vN0gQBfL6mQz5EBLsS9/dqP5KIIR0jorfgZEfopWQfCrIqeABVPGQVeHbDFB8EzoXsRloR9Dp8duLFGibjjDBAbW0OtOf6fiTgM38bqoujNHhHGDCqS0FsNaropFe8YcBMvVeuB4NeeUpCn9E83nnz4hOzj7jQJDFbtck3fldZYHMiwS4VT8Hw/ys0stAREix7mvJh/XbsI1MPVERN/GO53eSwCbtO53fbWzdJ9HonLSCArf0QR72H+krkI9hqJY6xGFQDYBkYd85ep2yvVH8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+9m0pFs0ir54wp+MgVZWoHjwig2VWrcIw6C6koOzAw=;
 b=nRYGZVPD9hhbATwVNnZwQMtCg1yapQu67EgND0Nk3L0GoR8VmmZo/qCV2MqfDQeTgb5hNS6HQDAN/rYBskjIaI+DrU/XxoLnRJkKHqWgcfcskr1+lzGoieN70FzaLE+kQhUYjXLvJPqrshfP02h0DHQtEgiSRjC8NUztNllRnD6Zpqe4FhaViAv8jUqAWNNGqd14uEhPBGR8X7+2LPyS9N3gYh8Ge1gfl0HFHJmDpc4/FS8mqeJhoY1vofEc3iyFkqR0KoKnoT77co7VcEsm6MpxDnzXgvSB2Nrvqgs8B0kGmdvjcfsIb2iuztxtI3cAFWie7mSs7c1KeS8g97c4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+9m0pFs0ir54wp+MgVZWoHjwig2VWrcIw6C6koOzAw=;
 b=jYFKWOBHQ8wf133X07PhQvH5nhX7OkAUBfWJPOQ947M406wqG8enFOhJDONEfKAf5jcfxacGI3LdcjsIJwflwGqX/O6348AqyTkabo2gUQsh/Abj7VK+0xuXPo/932qhCNPDL6dtusSTJ65XDoRP8l2tbRUzN8ZfpAP2oZKmo9U=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3200.namprd11.prod.outlook.com (2603:10b6:805:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 28 Oct
 2020 15:21:02 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f%3]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 15:21:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v16 00/15] mtd: spi-nor: add xSPI Octal DTR support
Thread-Topic: [PATCH v16 00/15] mtd: spi-nor: add xSPI Octal DTR support
Thread-Index: AQHWrP9znYtyl4SgskmwPX4NHXsKvg==
Date:   Wed, 28 Oct 2020 15:21:02 +0000
Message-ID: <d9d96eda-4cb6-fe68-7469-e73dc7ba2fda@microchip.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
 <d0d702c1-761b-1480-c74d-135193b33c26@microchip.com>
 <20201028124920.pot77v4phkqiswhr@ti.com>
In-Reply-To: <20201028124920.pot77v4phkqiswhr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.107.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69d7fa1d-3f8e-45f0-3ade-08d87b55150e
x-ms-traffictypediagnostic: SN6PR11MB3200:
x-microsoft-antispam-prvs: <SN6PR11MB32006C376F861E3B382AF016F0170@SN6PR11MB3200.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufvSZ/7yhTYe9/HNzDj1+CCevMdTu3pqmiXBpg8n5I9Kq4THjKma9GvYZqDt2+UWkrx2Lh6kj9UkSmw4vweCQdHboBaqOPqxWhiLWmrAKmJTz98vQIXU16Mo4HkgM156kBqKy4JzTW33/s1xdBxV5a2lQRdb9DsE9HuFbrCfwmx1UvLwP26HBgIaljBrNUJ0GUqbhxEUGYN+MOPXfdjvPrBZNWBFGPmdMLp6bp3b+yI0+NI5or0abDZq4mXobWxKcs/7SmlXoofzbjJ6lF2EtLxsR0PpFLF5XtaDdR6flbgSVba5dm7kvo3iT8kcYOg7DjAjmjP46jW3Lhm4yd700laME/Q8XUk0vFYY0Gh6AjkOX9XVAjnKe/Yhnl7FFwb0uLjg2gTCPZU6YjeT0WbAA+Fn243njDaFt7VNWA4pBoyl6n6+IWKjanI4As59TQwU3FUg1fJZ9ybU3BjbHKgTtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(366004)(136003)(54906003)(966005)(6506007)(4326008)(64756008)(2906002)(36756003)(316002)(186003)(71200400001)(8936002)(478600001)(31686004)(26005)(5660300002)(66556008)(6916009)(53546011)(8676002)(6486002)(66446008)(86362001)(66946007)(6512007)(66476007)(2616005)(31696002)(76116006)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ICaW3/lxo6f2jHXcYMtFD2OT3bZkTE3TrGt0MLBFhhqaLcv6hQvtrWE/gRpRey5YRnVxmgi7fkvvyBV0mxxo3wtV1eY7Da5poPMDYada3orehVIEM7vvnNoaxfj3ZYCwy0Z0OSdslPhR9CaLwGtwfapcC0WJtuk84dRE/FF5MIX3Ucjn8S1xDiq5R/N0hAdAMX1OS8MRpb68ZBHTHjRmRQ6faJ2TPNKM1irE3LtJu2th/+2KnUX+PGaAe96sD+cfORwAhrBG6sXZy26jQmDcTfD7/raJkLx/8QtsAEBpDySL3zQ1QiE9b5N/DaQpfvjqWAtKgEbAEawZZxI0Xx4whbsIK2ANeCkLSG8hUpGz2qHCQppLqXB4IUnWkm0DWQalojrQ2XerDMsWBY4yKAiLyrsUyLYqHjFTuBFK+nN7H3xwntEZHIUl+mCcCWwNa5t3sMJCV7bis+6lmZXHvW6pFhLp5OzXCt0bYwhkuQnFDKR3xNBXNe5RxkiuXfMtdVHHe1cj/0dJiBLbuaJ0PvXLtsVLYz9Tvz9WcX4LGZYExci+BDLDvKaHNB2m5ltDwmAoLYjzynR/iFNo0LfYkRzGKtalFgwEkXE2R96kMNauxnz5X3FAMqoFyqu6W8XB0XOxCYCYjeBxP3WmuTtW8S6gBw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BEAC9624A6D79408A943E70818B4767@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d7fa1d-3f8e-45f0-3ade-08d87b55150e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 15:21:02.7968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLdU8X52V8S4ENl3iEjS6SkEb7F2w7eRFk/a+8/TikRThTguWU2VemsBoUXJmS8s1U+oMUVYWittR6+HmHI1HqvlwZ+2Od/M4D/Dnj+4sJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjgvMjAgMjo0OSBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgVHVkb3IsDQo+IA0KPiBPbiAyOC8xMC8y
MCAwNzo1M0FNLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBIaSwgUHJh
dHl1c2gsDQo+Pg0KPj4gT24gMTAvNS8yMCA2OjMxIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToN
Cj4+PiBUZXN0ZWQgb24gTWljcm9uIE1UMzVYIGFuZCBTMjhIUyBmbGFzaGVzIGZvciBPY3RhbCBE
VFIuDQo+Pg0KPj4gRG8gdGhlc2UgZmxhc2hlcyBkZWZpbmUgdGhlICJDb21tYW5kIFNlcXVlbmNl
cyB0byBDaGFuZ2UgdG8NCj4+IE9jdGFsIEREUiAoOEQtOEQtOEQpIG1vZGUiIHRhYmxlPyBDYW4n
dCB3ZSB1c2UgdGhhdCB0YWJsZQ0KPj4gaW5zdGVhZCBvZiBkZWZpbmluZyBvdXIgb3duIG9jdGFs
IGR0ciBlbmFibGUgZnVuY3Rpb25zPw0KPiANCj4gVGhlIE1pY3JvbiBmbGFzaCBkb2VzIG5vdCBo
YXZlIHRoaXMgdGFibGUuIFRoZSBDeXByZXNzIGZsYXNoIGRvZXMuIFRoZQ0KPiBwcm9ibGVtIGlz
IHRoYXQgb25lIG9mIHRoZSBzYW1wbGVzIG9mIHRoZSBDeXByZXNzIGZsYXNoIEkgdGVzdGVkIG9u
IGhhZA0KPiBpbmNvcnJlY3QgZGF0YSBpbiB0aGF0IHRhYmxlIHdoaWNoIG1lYW50IHRoZSBzZXF1
ZW5jZSB3b3VsZCBmYWlsLiBUaGUNCj4gbmV3ZXIgc2FtcGxlcyBvZiB0aGUgZmxhc2ggaGF2ZSB0
aGUgY29ycmVjdCBkYXRhLg0KDQpDYW4gd2UgZGlmZmVyZW50aWF0ZSB0aGUgQ3lwcmVzcyBmbGFz
aGVzPyBEbyB5b3UgcmVtZW1iZXIgd2hhdA0Kd2FzIHRoZSBpbmNvcnJlY3QgZGF0YT8NCg0KPiAN
Cj4gSSBkb24ndCBrbm93IGhvdyBtYW55IG9mIHRob3NlIGZhdWx0eSBmbGFzaGVzIGFyZSBvdXQg
dGhlcmUgaW4gdGhlIHdpbGQuDQo+IElNTywgdG8gYmUgb24gdGhlIHNhZmUgc2lkZSBzcGlfbm9y
X2N5cHJlc3Nfb2N0YWxfZHRyX2VuYWJsZSgpIG5lZWRzIHRvDQo+IGJlIGltcGxlbWVudGVkLiBT
byBmcm9tIHRoZSBwb2ludCBvZiB2aWV3IG9mIHRoaXMgc2VyaWVzIHRoZXJlIGlzIG5vDQo+IG5l
ZWQgdG8gcGFyc2UgdGhlIE9jdGFsIEREUiBlbmFibGUgdGFibGUuDQoNCk1laCwgd2UgY292ZXIg
bWFudWZhY3R1cmVyJ3MgbWlzdGFrZXMuIE9uIHRoZSBsb25nIHJ1biwgb3VyIGFpbSBzaG91bGQg
YmUNCnRvIGZvbGxvdyB0aGUgU0ZEUCBzdGFuZGFyZCBhbmQgaWYgYSBmbGFzaCBpbXBsZW1lbnRz
IGl0IHdyb25nLCB0byBlaXRoZXINCmZpeCBpdCB2aWEgYSBmaXh1cCBob29rIChpZiB0aGUgZml4
IGlzIG1pbmltYWwpLCBvciB0byBza2lwIHRoZSBmYXVsdHkNCnRhYmxlLg0KDQpSZWdhcmRpbmcg
IkNvbW1hbmQgU2VxdWVuY2VzIHRvIENoYW5nZSB0byBPY3RhbCBERFIgKDhELThELThEKSBtb2Rl
Ig0KdGFibGUuIEhhdmUgeW91IGxvb2tlZCBvdmVyDQpodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3Byb2plY3QvbGludXgtbXRkL3BhdGNoLzE1OTA3Mzc3NzUtNDc5OC00LWdpdC1zZW5kLWVt
YWlsLW1hc29uY2N5YW5nQG14aWMuY29tLnR3Lw0KPw0KSXMgdGhlcmUgYSBzdGFuZGFyZCB3YXkg
dG8gZGV0ZXJtaW5lIHRoZSBvZmZzZXRzIG9mIG9wY29kZSwgYWRkciBhbmQNCmRhdGEgaW4gdGhl
IGNtZCBzZXE/DQoNCkNoZWVycywNCnRhDQo+IA0KPj4gSSBzZWUgdGhhdCBNYXNvbiB1c2VkIHRo
aXMgdGFibGUgZm9yIGEgbWFjcm9uaXggZmxhc2g6DQo+PiBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvbGludXgtbXRkL3BhdGNoLzE1OTA3Mzc3NzUtNDc5OC00LWdpdC1zZW5k
LWVtYWlsLW1hc29uY2N5YW5nQG14aWMuY29tLnR3Lw0KPj4gaHR0cHM6Ly9wYXRjaHdvcmsub3ps
YWJzLm9yZy9wcm9qZWN0L2xpbnV4LW10ZC9wYXRjaC8xNTkwNzM3Nzc1LTQ3OTgtOC1naXQtc2Vu
ZC1lbWFpbC1tYXNvbmNjeWFuZ0BteGljLmNvbS50dy8NCj4+DQo+PiBDaGVlcnMsDQo+PiB0YQ0K
PiANCj4gLS0NCj4gUmVnYXJkcywNCj4gUHJhdHl1c2ggWWFkYXYNCj4gVGV4YXMgSW5zdHJ1bWVu
dHMgSW5kaWENCj4gDQoNCg==
