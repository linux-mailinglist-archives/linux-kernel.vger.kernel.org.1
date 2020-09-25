Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD62781FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgIYHvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:51:00 -0400
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:40769
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727486AbgIYHux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:50:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enXq6Pwm9cZquieMf7nCZ0HR0S/LTKbKJkxeM4i5UMc4Z4aqOVCHthKnGTz80b7m9FEUE1YXRVryWkyt9y7pCX9c3ctJEovQ6VQTQVEd2afuGfb7t7XqAsK6ClgWpR/ge5TigyhLCUgZLo//XHRgln8u2/Du6DdD5T0J6x7zlWsseyC6Q83KocYi2WYLeE09xqtzovNgVVGPsLU8D+H34DZ4QvgrNiOfXpbtb7SmqdAj9WRy1vgDJ8fBBE42Kd4I80Pxsl22a3r+q1Iub23o8r4ur73m4ABaJueLRq8KhE+Z3YnBGNhbKXVMCF8liYmnqSvlcMoy8pjLb0dCkfItfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi5xPWrjtxm5PjZGJStuwAs+ZuRhYNkN9aYDUW22WOA=;
 b=Z2UaJ+Kp6rl0rONmdNGqZ8ZE2jJDa55O6oRqWUAbXtSrX30yRSWH+pnitqXeO9TSYYc5iEacfL7Bhdopm5cRKWmYbW/4B2+iTrfucvDvlDBS/UpSUYbBbB8RRL0EWaut1vAqp0jcOFMeeXB6Y1guPnWWcC++VofLi0sCIQ4saD3/rNh/1fIQ9+IAawiY3/x7h3BQ30af4lACxAgM6GUq/64j6lXViU5rJH6f2QiRp6E0DpaQTNWHwl3s4yVNm1UBr4WFZyMH4Gt80OhTXFGo808/y/LSzYyG0L3xLDvHY17VPHr7UXGUs5eAguI6o6kdkRe7fVW9xAkreK7RrtkLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi5xPWrjtxm5PjZGJStuwAs+ZuRhYNkN9aYDUW22WOA=;
 b=lSdSbhmi4cgMsr3qqmfwqm4gq7iSFK+fktcNFL3/FSc3JiOATSc/CQ43CQtylDm48jiJvCiWDkEGrkx3H/MTrGki0pI9CPSLNSJy5/DRKWsLmix416CdXibzJdyraGWqaLc45PS6DwufwKYFsddCgTk42X9ReRHHxIDglUoFKzg=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0401MB2382.eurprd04.prod.outlook.com (2603:10a6:800:23::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 07:50:49 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:50:49 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/4] mic: vop: copy data to kernel space then write to io
 memory
Thread-Topic: [PATCH 4/4] mic: vop: copy data to kernel space then write to io
 memory
Thread-Index: AQHWkwyY0woIw7FyBUOLtOs53jP4j6l49eAAgAAB0sA=
Date:   Fri, 25 Sep 2020 07:50:49 +0000
Message-ID: <VI1PR04MB4960F5105C6C54F17700352092360@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200925071831.8025-1-sherry.sun@nxp.com>
 <20200925071831.8025-5-sherry.sun@nxp.com>
 <CAK8P3a2jJBxEDD+FXpHsFXRd9BF3aND2jTtswzP1L6_T4BiS9A@mail.gmail.com>
In-Reply-To: <CAK8P3a2jJBxEDD+FXpHsFXRd9BF3aND2jTtswzP1L6_T4BiS9A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ab4f9c9-4583-4e08-988d-08d86127b84f
x-ms-traffictypediagnostic: VI1PR0401MB2382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB23829735330C913EAEFA7A2292360@VI1PR0401MB2382.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZLd6VX/8A+oaOtGbf+pB7l3XDJV/TPz7CWKQKkoJOwkwxi/H2D9NqKvJlcXRxR+WayqDFP2phUDLQkFxvWDMZbYtTu0yNmEFMXHKqla6iY77WU73xCYxh7vxw8TpzvrikBDSe1mgFwWcMEAuspcdcFvZIKdk03wSTsyI6btUqO1YH5ZVsCwWar0/1a3tDWWqzJJeLwMdcGahOeQv99tXwqeA23axnlTnIevW3eRwy5O5SOcR3lkzg3dzt9OrUMf+Z+U96wd6IY+yok6LUoIL+QgcnFnj4a7WVoPu27KFFCDuDWlo8taZLCt0tJi3q482N9TdUpXYeahfriyJC3Vy0tJIm1Bzsnik4SOLW+nxKiFA0oUrB//YMZvBiFn3I1u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(76116006)(6916009)(53546011)(5660300002)(186003)(66476007)(26005)(44832011)(316002)(54906003)(4744005)(6506007)(71200400001)(7696005)(33656002)(478600001)(83380400001)(4326008)(66446008)(8676002)(66946007)(9686003)(52536014)(86362001)(64756008)(55016002)(66556008)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xnj5vTDrNCHu3bJhRiU0XZL1bopkDngqyCkJbTqHshk2/YMBNyfxc/xQJ7nkfeRJ/zSvO9XLsLnEAHSSoiWNFewgBuyeOErnzTGNh1ymSDxHiynzx4NKV2GoS43mhcfXu6t//Mp4RWfn0aglYbm+ja39u3qr7svDEcaWW1d55ih80mj3ANm29jen5B11q9y/fIt/htOpRG4++L1jsnWN0BB7ZgzAtkVScqIROH+k/su60AeZ+L8MhInGutRiOh1Yaq/3ZmIDw1xOiNGjRZ6be0Hmi3Mj2mbeU3WMNbKvR/wlJMWzh2cMVuzDXMpYvz155W6/g/p1vaREoAl+RH4Imlvl8m9SmFgh4zdIhb+R0th3MhW9bOaHKjEuap3/OQKVNSmja/OBVHzcIMZd5MKEkkYDlsxcrnb5zmH7rkg3QwxmRm2VJqmaHYcYmSiR2BsKt2aeOC9+HOtm5Oe4eNHyQ2tqqdAqwjwuM/WE12ko/wdTQqhjnmboNj1I9z/Tt/F2iKfvcZdSUz9vWJdw0/6K0FH2X7sLQdpjFWuJi5PmzhM7i+qp+k4h+VS45l7I51Z5VZCwB8vUwOG4c+/f6Tcl4DbhYw/Lj14DxWFUAZGoUoW+pu/v+5MLOvfUiRA9WAcQHjBO2F5uQlS/2+X1bKwCdQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab4f9c9-4583-4e08-988d-08d86127b84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 07:50:49.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPBHKnwa+7X2zRtSVrc6GRTSFzkkBEmZfTa4a1fTdVTwqL2XSRQhMMfBWkTpSqbhUktWmNFRULJmenq1JEO9CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2382
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0gbWljOiB2b3A6IGNvcHkgZGF0
YSB0byBrZXJuZWwgc3BhY2UgdGhlbiB3cml0ZSB0byBpbw0KPiBtZW1vcnkNCj4gDQo+IE9uIEZy
aSwgU2VwIDI1LCAyMDIwIGF0IDk6MjIgQU0gU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29t
PiB3cm90ZToNCj4gPg0KPiANCj4gPiBAQCAtNjU1LDEyICs2NTYsMTUgQEAgc3RhdGljIGludCB2
b3BfdmlydGlvX2NvcHlfZnJvbV91c2VyKHN0cnVjdA0KPiB2b3BfdmRldiAqdmRldiwgdm9pZCBf
X3VzZXIgKnVidWYsDQo+ID4gICAgICAgICAgKiBXZSBhcmUgY29weWluZyB0byBJTyBiZWxvdyBh
bmQgc2hvdWxkIGlkZWFsbHkgdXNlIHNvbWV0aGluZw0KPiA+ICAgICAgICAgICogbGlrZSBjb3B5
X2Zyb21fdXNlcl90b2lvKC4uKSBpZiBpdCBleGlzdGVkLg0KPiA+ICAgICAgICAgICovDQo+ID4g
LSAgICAgICBpZiAoY29weV9mcm9tX3VzZXIoKHZvaWQgX19mb3JjZSAqKWRidWYsIHVidWYsIGxl
bikpIHsNCj4gPiArICAgICAgIHRlbXAgPSBrbWFsbG9jKGxlbiwgR0ZQX0tFUk5FTCk7DQo+ID4g
KyAgICAgICBpZiAoY29weV9mcm9tX3VzZXIodGVtcCwgdWJ1ZiwgbGVuKSkNCj4gDQo+IFRoaXMg
bmVlZHMgdG8gaGF2ZSBlcnJvciBoYW5kbGluZyBmb3IgYSBrbWFsbG9jKCkgZmFpbHVyZS4gQXMg
dGhlIGxlbmd0aA0KPiBhcHBlYXJzIHRvIGJlIHVzZXItcHJvdmlkZWQsIHlvdSBtaWdodCBhbHNv
IHdhbnQgdG8gbGltaXQgdGhlIHNpemUgb2YgdGhlDQo+IGFsbG9jYXRpb24gYW5kIGluc3RlYWQg
ZG8gYSBsb29wIHdpdGggbXVsdGlwbGUgY29waWVzIGlmIHRoZXJlIGlzIG1vcmUgZGF0YQ0KPiB0
aGFuIGZpdHMgaW50byB0aGUgYWxsb2NhdGlvbi4NCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJl
cGx5LCB5b3UgYXJlIHJpZ2h0LCB3aWxsIGFkZCBlcnJvciBoYW5kbGluZyBmb3Iga21hbGxvYygp
IGZhaWx1cmUgYW5kIHNpemUgbGltaXQgaGFuZGxpbmcgaW4gdjIuDQoNClJlZ2FyZHMNClNoZXJy
eSANCj4gDQo+ICAgICAgICBBcm5kDQo=
