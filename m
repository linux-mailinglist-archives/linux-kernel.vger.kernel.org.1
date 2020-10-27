Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95F129ABFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbgJ0MX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:23:29 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:60416
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751284AbgJ0MX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:23:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzVJ9oMrURQsJzA3WDSKYYz783MyD2P4McccGPkeFRQ55QZcAjFdJng8DERnOZJJrQsY1AgEOTrN75b7W6W0tVMDcLms67sKK3WCMLaBBxKiVJo1fO4dZFm6+cUQvwiKQIdQmSHVpSQMBfeemmEPMQRMCLuFnmkJ6+w77bfbR6Tn2tsuH5bdTRHCYV8jbCcbzH009g9Wuq1Y76pavElgSktATUWyBBBC44z9uIJgBldYs1E+wUQS2d23JzjlKUCI6wxJD/aD9dtJf40ge7kQSf9lCyp8CKNg5Xyu3jVY9kYokqlf2iH3B8+5r0n1ViEOs4aYptZisPC2C9UgvgpZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSZ8H1iDpRpMWSfYWDTWlorfglxYhyHxJ7eOyk58GFw=;
 b=XMpcezivuX0L51NJxyeWSa+dTSP5jPMvSSEWkaZuyZrYrCUNjS2dCzFFz9XdLRB1HlumqWTADB+JRKuQsMtt5pc/i3gI7aPzDLt7ySGKDiuLaZXes5lctPiYD81zGNfmTp9qeGx/L6xidMEhtkH9q5tAtS7Qty3iCNo1Muhw4IPKsTNi1qpWO16NuHzn/7cZJ52lsl1jAcTc1gkNIx/ZCcQoy/biKtglAvRaw2hDVtic6VmmbVglHZiPUXpvoCF74bod5RurPU68P2DUO1BOAs25Ekf4Ko0p05NjMpAyhokXd7kiFGnghmeLDHjXmqfYFBmXNY0OCQWq7ew06uzC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSZ8H1iDpRpMWSfYWDTWlorfglxYhyHxJ7eOyk58GFw=;
 b=p2ZFspBxj33s5BBDxEUT0DU5va+VJqS72B0lEoTuG2G5czicBXAQYdDOesr0OJYzpwgALXRyjtM4GEjugsHGVPk9KP65c1OlCAynYypA7a6Skatl6UFKPZ1L3kpnt3uOv0CQeFo4W35lKMwjLnXsWB2NqiivDG1haP+VPV5iU0w=
Received: from BYAPR02MB3941.namprd02.prod.outlook.com (2603:10b6:a02:f8::18)
 by BYAPR02MB4184.namprd02.prod.outlook.com (2603:10b6:a02:ff::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 12:23:24 +0000
Received: from BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f923:e06c:f837:bd7e]) by BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f923:e06c:f837:bd7e%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 12:23:24 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Michal Simek <michals@xilinx.com>, Arnd Bergmann <arnd@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH] firmware: xilinx: fix out-of-bounds access
Thread-Topic: [PATCH] firmware: xilinx: fix out-of-bounds access
Thread-Index: AQHWq7BcZtWlKQFhOUiN9ze4b/47+6mrNpSAgAApuaA=
Date:   Tue, 27 Oct 2020 12:23:24 +0000
Message-ID: <BYAPR02MB39417FEC6A86636833EF25ECB7160@BYAPR02MB3941.namprd02.prod.outlook.com>
References: <20201026155449.3703142-1-arnd@kernel.org>
 <459e03f1-2a9e-5bc4-4bf6-9a0ddf5c4a70@xilinx.com>
In-Reply-To: <459e03f1-2a9e-5bc4-4bf6-9a0ddf5c4a70@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 590f6e92-98fe-46ec-8dd6-08d87a7319f0
x-ms-traffictypediagnostic: BYAPR02MB4184:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4184848C93716872D4F027C6B7160@BYAPR02MB4184.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wgn6gpe+9BZCRjw+lMZxeCC48I0b+vmmLHLyn/XSMtYwHbzcm/dyMU52YbD8jJK/rlIPcDIrKv07Fc4ZJW9CZIVHfJ2+WB0a+NPNSStxT/2wIknl0xafuwaWMwn5W1Fnew1McVUSmDadoR0Uh+JHiIhGyJs2608XqS6exIrwss2jeDnqpu2dHrhEpy3fW8CpISc/aKb1KKikCAH9S9JHFokxWtC3KBSVFMMOasjg7yE7iqaM4UGFUOWfDdY0ATkIVz3TAgrN5348wo+6yELJlL41lULPrCdyvntns/95UFgZ13N/IoDv6UBTIRUfHnrYrlT6HHOBU0XDaKKFv6K0bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB3941.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(6506007)(54906003)(86362001)(53546011)(76116006)(71200400001)(52536014)(4326008)(8676002)(9686003)(26005)(7696005)(5660300002)(8936002)(6636002)(2906002)(107886003)(478600001)(110136005)(33656002)(66446008)(83380400001)(316002)(66476007)(186003)(55016002)(66556008)(64756008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: COUbmHpg/sIWzyzsXVPuAlQgCEpwO/CrlSjBXsu1IX8CLDpPB/UuHtcJnaMzLfnRsiYpQ5iagdJluNYnzMnlakEZGyKUCkNWI1wutc0zhBnJeZOrZNs0/8PBQ2V1+z4ydrCmXVpoqEpSq386LuPS3Vjbqc/XmksJfBVKspOCc9kKIqXuwACrZiiERIZcNCZdz6USZlbKGsdcKTH1XAWOzItk1zyGxIossR5mEaFzA44WZa1dG3K7ADzju/llzBt8hoWQC+JZsAZ/LW/ro9Rs3EWZDhpij0pdaTU3YmvoNYdQ84pAQ9kjLZGNvKu2Q/jr6pmXoWatDC1UnOYuqIXFBqI37xycJ5JlJPDKO037uUqOPKqbiZaQUO9Y59ycdxmmuNNb0L0a1pFblJdi4TT/oD3DDEedwOvfvi2/E1LVKAELldHs4txmZgn4exX5TrxwjviQRWCN7HUmi8TuefJEKErRjIIzSvpAlg95gOxCWojB4+6fWgEs9uLog94egfwumfjdiAC3KdgtGY/Os5c8gYzKkB0Qg1YYVIiUdfdijapyUIgntotKAOt4ac9jaHrXrtOvuo44RAwr6lIjsuuZ02eJgCGHjXVuqv4c/tTIK/GngWBblorHQzhOcl0VRDRcAKcMxImdHNZZQaxsLuYQ0Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590f6e92-98fe-46ec-8dd6-08d87a7319f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 12:23:24.6529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ipQLjCuoJXgzRCtUP3FguGXV8l8JTECu2YCzowznDvDMTb3Qw5iX5g+rBNHEEzYqX23/YTTEq9TBavs2+SYSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hh
bCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+IFNlbnQ6IDI3IE9jdG9iZXIgMjAy
MCAwMjo1Mw0KPiBUbzogQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3JnPjsgTWljaGFsIFNp
bWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNv
bT4NCj4gQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBSYWphbiBWYWphIDxSQUpB
TlZAeGlsaW54LmNvbT47IEdyZWcNCj4gS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+OyBUZWphcyBQYXRlbA0KPiA8VEVKQVNQQHhpbGlueC5jb20+OyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBnaXQgPGdpdEB4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBmaXJtd2Fy
ZTogeGlsaW54OiBmaXggb3V0LW9mLWJvdW5kcyBhY2Nlc3MNCj4gDQo+IA0KPiANCj4gT24gMjYu
IDEwLiAyMCAxNjo1NCwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gPiBGcm9tOiBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+DQo+ID4gVGhlIHp5bnFtcF9wbV9zZXRfc3VzcGVuZF9t
b2RlKCkgYW5kDQo+IHp5bnFtcF9wbV9nZXRfdHJ1c3R6b25lX3ZlcnNpb24oKQ0KPiA+IGZ1bmN0
aW9ucyBwYXNzIHZhbHVlcyBhcyBhcGlfaWQgaW50byB6eW5xbXBfcG1faW52b2tlX2ZuDQo+ID4g
dGhhdCBhcmUgYmV5b25kIFBNX0FQSV9NQVgsIHJlc3VsdGluZyBpbiBhbiBvdXQtb2YtYm91bmRz
IGFjY2VzczoNCj4gPg0KPiA+IGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jOiBJbiBm
dW5jdGlvbg0KPiAnenlucW1wX3BtX3NldF9zdXNwZW5kX21vZGUnOg0KPiA+IGRyaXZlcnMvZmly
bXdhcmUveGlsaW54L3p5bnFtcC5jOjE1MDoyNDogd2FybmluZzogYXJyYXkgc3Vic2NyaXB0IDI1
NjIgaXMgYWJvdmUNCj4gYXJyYXkgYm91bmRzIG9mICd1MzJbNjRdJyB7YWthICd1bnNpZ25lZCBp
bnRbNjRdJ30gWy1XYXJyYXktYm91bmRzXQ0KPiA+ICAgMTUwIHwgIGlmICh6eW5xbXBfcG1fZmVh
dHVyZXNbYXBpX2lkXSAhPSBQTV9GRUFUVVJFX1VOQ0hFQ0tFRCkNCj4gPiAgICAgICB8ICAgICAg
fn5+fn5+fn5+fn5+fn5+fn5+Xn5+fn5+fn4NCj4gPiBkcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96
eW5xbXAuYzoyODoxMjogbm90ZTogd2hpbGUgcmVmZXJlbmNpbmcNCj4gJ3p5bnFtcF9wbV9mZWF0
dXJlcycNCj4gPiAgICAyOCB8IHN0YXRpYyB1MzIgenlucW1wX3BtX2ZlYXR1cmVzW1BNX0FQSV9N
QVhdOw0KPiA+ICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4NCj4gDQo+IFdo
aWNoIENPTkZJRyBvcHRpb24vdG9vbCBpcyByZXBvcnRpbmcgdGhpcyBpc3N1ZT8NCj4gDQo+ID4N
Cj4gPiBSZXBsYWNlIHRoZSByZXN1bHRpbmcgdW5kZWZpbmVkIGJlaGF2aW9yIHdpdGggYW4gZXJy
b3IgcmV0dXJuLg0KPiA+IFRoaXMgbWF5IGJyZWFrIHNvbWUgdGhpbmdzIHRoYXQgaGFwcGVuIHRv
IHdvcmsgYXQgdGhlIG1vbWVudA0KPiA+IGJ1dCBzZWVtcyBiZXR0ZXIgdGhhbiByYW5kb21seSBv
dmVyd3JpdGluZyBrZXJuZWwgZGF0YS4NCj4gPg0KPiA+IEkgYXNzdW1lIHdlIG5lZWQgYWRkaXRp
b25hbCBmaXhlcyBmb3IgdGhlIHR3byBmdW5jdGlvbnMgdGhhdCBub3cNCj4gPiByZXR1cm4gYW4g
ZXJyb3IuDQo+ID4NCj4gPiBGaXhlczogNzY1ODI2NzFlYjVkICgiZmlybXdhcmU6IHhpbGlueDog
QWRkIFp5bnFtcCBmaXJtd2FyZSBkcml2ZXIiKQ0KPiA+IEZpeGVzOiBlMTc4ZGYzMWNmNDEgKCJm
aXJtd2FyZTogeGlsaW54OiBJbXBsZW1lbnQgWnlucU1QIHBvd2VyIG1hbmFnZW1lbnQNCj4gQVBJ
cyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMgfCAzICsrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMNCj4gYi9kcml2ZXJzL2Zpcm13YXJlL3hp
bGlueC96eW5xbXAuYw0KPiA+IGluZGV4IDhkMWZmMjQ1NGUyZS4uZWZiOGE2NmVmYzY4IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMNCj4gPiBAQCAtMTQ3LDYgKzE0Nyw5IEBA
IHN0YXRpYyBpbnQgenlucW1wX3BtX2ZlYXR1cmUodTMyIGFwaV9pZCkNCj4gPiAgCQlyZXR1cm4g
MDsNCj4gPg0KPiA+ICAJLyogUmV0dXJuIHZhbHVlIGlmIGZlYXR1cmUgaXMgYWxyZWFkeSBjaGVj
a2VkICovDQo+ID4gKwlpZiAoYXBpX2lkID4gQVJSQVlfU0laRSh6eW5xbXBfcG1fZmVhdHVyZXMp
KQ0KPiA+ICsJCXJldHVybiBQTV9GRUFUVVJFX0lOVkFMSUQ7DQo+ID4gKw0KPiA+ICAJaWYgKHp5
bnFtcF9wbV9mZWF0dXJlc1thcGlfaWRdICE9IFBNX0ZFQVRVUkVfVU5DSEVDS0VEKQ0KPiA+ICAJ
CXJldHVybiB6eW5xbXBfcG1fZmVhdHVyZXNbYXBpX2lkXTsNCj4gPg0KPiA+DQo+IA0KPiBEZWZp
bml0ZWx5IGdvb2QgY2F0Y2ggYnV0IG5vdCBxdWl0ZSBzdXJlIHdoYXQgc2hvdWxkIGJlIGNvcnJl
Y3QgcmVhY3Rpb24uDQo+IFJhamFuOiBDYW4geW91IHBsZWFzZSB0YWtlIGEgbG9vayBhdCBpdCB3
aXRoIHByaW9yaXR5Pw0KW1JhamFuXSBDaGFuZ2UgbG9va3MgZmluZSB0byBtZS4NCg0KVGhhbmtz
LA0KUmFqYW4NCj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQo=
