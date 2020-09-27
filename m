Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70B279F42
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 09:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgI0HUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 03:20:14 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:64993
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729797AbgI0HUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 03:20:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoUUrUPyevjjyHGexdeOz/3PVsfXvG1R4YMB5KZuDl76Shj9nLazd9kH+txSQXFlLRdfYTPBCFtVk58k7BksjhbpFHpu5ftDwdRKzAa1Sy5dM3UU6rNzhQU9PPjiP2k7dl7Hsfsw0tS4X4yO8VGQ95DOs1Apa7uXhRdT1OsfM+zQ0oUqnOu0kVyb9wgHz+4n5r08HnAfYWbQhVmFMSh5fE3ifyquJPrh76Ju52Lan86B4w3zPw4IOK2zWpU03lteQUlvsPWfA8g5/0BaDJvuoK5n+gNOVtFKCS9bAsvQlokJk21bAoCrkSnh+N7czYaru33qkgrScIdPbGp5aiijVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUBkqetcxbbB7OpKhIGEPwjdpppGs0aViVLlONhvRWE=;
 b=afEK0TG3zJOZ11iUzrEk7JEFEZEAVRdfBdy0IrHKVhZZ0DHTTgji26TplHpem5q8zvMkrPzL/iCq0o6VE8CiIwa4+L/E3TlLuc4E3NOzEs9M6VZiXQ7TtmRyEIrIHOEFOHrw0Ho4wlrePkWSYamvTAqNlVZQTy7TNuUbxSCD6DhKuJClECMPNueL+PWRZ7NcsUEq01qrD4z5/S6lRjPCZS8ZFeC5Y1LZbU5hDDaPL4It1F4msEhl61p+a/fh8SzOB8H4Enq/Gt9V6kPTI2AFwWHD8KTGI+wB9ulMcNlFmavILgmzSlZTgB+QZIjhFQ5I8FpphbXkkrQ73gI2uHBFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUBkqetcxbbB7OpKhIGEPwjdpppGs0aViVLlONhvRWE=;
 b=UNt0JxGbl3lGIQHKYehyNyL2PfwDCHZ5hrk6Rs2flwZpPv4AkzVj27oxWiKKz0AS4MihNBzoXAuxBX+h1ggOsX1GuH8rTPROndd8/AjkZQDcoJShj+7OYfhc+dSpGfhoiomDaLOBG9KsO/5T0L+RYR9VyYqIxALhtH6HzWoetuU=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Sun, 27 Sep
 2020 07:20:09 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Sun, 27 Sep 2020
 07:20:09 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "huang.zijiang@zte.com.cn" <huang.zijiang@zte.com.cn>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for
 nocoherent platform
Thread-Topic: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for
 nocoherent platform
Thread-Index: AQHWkw1eiKshQWh5tEeFNUo8iDoDOal5RViAgALOaBA=
Date:   Sun, 27 Sep 2020 07:20:09 +0000
Message-ID: <VI1PR04MB49600F7F1601B99810BB0ACE92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-5-sherry.sun@nxp.com>
 <20200925121641.GB2680110@kroah.com>
In-Reply-To: <20200925121641.GB2680110@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fcf82c9-24ab-45de-51e0-08d862b5c444
x-ms-traffictypediagnostic: VI1PR04MB5389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB53898B7831EE1A9965EB456D92340@VI1PR04MB5389.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyWA913dL2fyBqO9wR1ZfFY32awhk2Gd+n0zbKEcSDiak9yB1L8vxXvnhtPM36rOxJ1YwqX9jgIAOhuLT6WgEWebqWhMOdlbFtveRvGq9p3USN/Aj6plJv9oBvbF0gcGQv/gNL7xqxes97l3sBGqrn4BG3tS6Zh0BmCGRYnGsx41jSRtOqOa+Gx43hFhWn9FWyIcq1X8re3Fhv187IF6MoszonJzcOI02gSnTWehqIuHYBKNnWBAa7mamnkKUpL0EQUv1LUQ2LZ1OjL/0OODVp6kHIFTO40Yhyo5zMdAFOtpF37SGGTw6j3/oImU5kfXKoB94RbdTVTjV9rlwtrGiAGM7H09zIk96bswgok0YzWB5VTUsKaI68zj+luHgwxw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(55016002)(2906002)(186003)(9686003)(44832011)(7416002)(8676002)(5660300002)(7696005)(4326008)(53546011)(6506007)(26005)(66946007)(6916009)(76116006)(52536014)(86362001)(66446008)(8936002)(64756008)(478600001)(33656002)(54906003)(316002)(66556008)(83380400001)(66476007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9+FB2SjXOXLF14y1bYs5GiQ82Kxh2eGHFKjyMwvLbvRkBZUuKH1ypGmiY9+bAdYkM6JNJeC36djKXHUurOhZSo7nyVdG21LR340fnyQjbFho0q1wbgacm8AwRwJlE9HVTs6s+UcxxCsRVUX2PHBDByhRVWFUFBf/fR3zQt6kfZefF6kYzCWXFyCGeFAwAKokSc3KYSLNC/P0HpfTwgL5sywd6HxTpCg+bAcDPim5/dkqf7lt7lrJH0Fqv8XHJc5XiDRsBoPJy2WM8wK75biNmckcxUu3olnJCNaKTarlNPBtXiU9UwbyfnuiRz+eWq31ts5T0fSw0xmH9ifcHm3kV1BgmIuekyZ7NmzTFVdzvjk4wrihAbkqMEiM5sjahm2waIFqEC7hbhJhVaJuKqodjtHzjI4Zuyh3hATeizuO8FhsT1aEB9kcXblydM3j8dQVRqFoNt4HyBegwyKSsRSzg/sRlQCj/nBGI51ft3IvQslD/c5RJw36e0ZJAkzovRyJnSt14rQHmIWIjcQUZkogsAFqsep6/KhCzadcBgbJsgHybILh5bjknQWsbM7lsc6VnPuAyXk0QJap5qNpMVz3s64ch29jUCIfw9gKlPbZ+/1trxcFTCtE7NHR0vgoEgaxJPdoQBu0Enupy9M0AXPUzA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcf82c9-24ab-45de-51e0-08d862b5c444
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 07:20:09.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5P+6OsRX2LCvD5lcxk0QQJnNR6mYqo+K/rMkp42zBbS7GcyqZTUAev0En32SR25Xrt1vjRZBkZoW64LpQLvkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5389
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogMjAyMMTqOdTCMjXI1SAyMDox
Nw0KPiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBDYzogc3VkZWVwLmR1
dHRAaW50ZWwuY29tOyBhc2h1dG9zaC5kaXhpdEBpbnRlbC5jb207IGFybmRAYXJuZGIuZGU7DQo+
IHdhbmcueWk1OUB6dGUuY29tLmNuOyBodWFuZy56aWppYW5nQHp0ZS5jb20uY247DQo+IHJpa2Fy
ZC5mYWxrZWJvcm5AZ21haWwuY29tOyBsZWUuam9uZXNAbGluYXJvLm9yZzsgbXN0QHJlZGhhdC5j
b207IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gbWlzYzogdm9wOiBzZXQg
VklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGZvcg0KPiBub2NvaGVyZW50IHBsYXRmb3JtDQo+IA0K
PiBPbiBGcmksIFNlcCAyNSwgMjAyMCBhdCAwMzoyNjoyOVBNICswODAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+IFNldCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gZmVhdHVyZSBmb3Igbm9jb2hl
cmVudCBwbGF0Zm9ybSwgc2luY2UgaXQNCj4gPiBuZWVkcyB0aGUgRE1BIEFQSSBmb3IgdmlydGlv
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWlzYy9taWMvdm9wL3ZvcF9tYWluLmMgfCAzICsr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9taXNjL21pYy92b3Avdm9wX21haW4uYw0KPiA+IGIvZHJpdmVycy9taXNj
L21pYy92b3Avdm9wX21haW4uYyBpbmRleCBkMzY0NTEyMmM5ODMuLmQ2MDlmMGRjNjEyNA0KPiA+
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWlzYy9taWMvdm9wL3ZvcF9tYWluLmMNCj4gPiAr
KysgYi9kcml2ZXJzL21pc2MvbWljL3ZvcC92b3BfbWFpbi5jDQo+ID4gQEAgLTEyNSw2ICsxMjUs
OSBAQCBzdGF0aWMgdm9pZCB2b3BfdHJhbnNwb3J0X2ZlYXR1cmVzKHN0cnVjdA0KPiB2aXJ0aW9f
ZGV2aWNlICp2ZGV2KQ0KPiA+ICAJICogY3JlYXRlcyB2aXJ0aW8gcmluZ3Mgb24gcHJlYWxsb2Nh
dGVkIG1lbW9yeS4NCj4gPiAgCSAqLw0KPiA+ICAJX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJ
UlRJT19GX1JJTkdfUEFDS0VEKTsNCj4gPiArDQo+ID4gKwlpZiAoIWRldl9pc19kbWFfY29oZXJl
bnQodmRldi0+ZGV2LnBhcmVudCkpDQo+ID4gKwkJX192aXJ0aW9fc2V0X2JpdCh2ZGV2LCBWSVJU
SU9fRl9BQ0NFU1NfUExBVEZPUk0pOw0KPiANCj4gV2h5IGxvb2sgYXQgdGhlIHBhcmVudCBhbmQg
bm90IHRoZSBkZXZpY2UgaXRzZWxmPw0KDQpUaGF0J3MgYSBnb29kIHF1ZXN0aW9uLCBoZXJlIHVz
ZSB2ZGV2LT5kZXYucGFyZW50IHRvIGdldCB0aGUgdm9wIGRldmljZSBpbnN0ZWFkIG9mIHZpcnRp
byBkZXZpY2UsICB3aGljaCBjYW4ga2VlcCBjb25zaXN0ZW50IHdpdGggb3RoZXIgZGV2X2lzX2Rt
YV9jb2hlcmVudCBjaGVjay4NCg0KVGhhbmtzDQpTaGVycnkgDQo=
