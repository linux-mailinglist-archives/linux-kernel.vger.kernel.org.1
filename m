Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A1E27986A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIZKbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 06:31:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30333 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 06:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601116292; x=1632652292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xhORag1YPWed45wSVhujbLKlybpepoW4rfY7VwIlpSw=;
  b=gY0JEkDb9zm0VWmvYv5GbIkAY9cYnFsfev1Ko46ubkOp5cHx4FDSfuDd
   WEKXugCqqlSG1LzL/JbyPOhkoZcVj49F9QL4UraC7K2Cdu0XsHytibGx9
   AUuMuykg7lkPNHPQeee8rHZ/F7k9WKn9EQ6hsBAFINRBB0UlJLhB+NdmK
   DjGZ6qShCFbFyp23pUQ128e8C714J15Z412SJYKC3W/f8eLUVtBj7iFGK
   IMS5G1edvBFbq344dWIRESvK7H6x77rqLXZ6xHKQAH6DiomF8FH2ImfEx
   KQWiyUyerKU3oJTApG7fCipHYQEfoiTGQMXLNSrpyiAqSozdoto7G02Lt
   w==;
IronPort-SDR: ZHd6DDVZLrAwecLG5nOmkUf7ojotxS7T4OuVp26ZT7LTb3PpZhyyycmLLs/nAMrARw9a6f8d9g
 SqPs2v7WN19lxgQeqNbFC8JolUwoDLE5YCDj/hVd1QAc9ZZWUQB5dZFymBL4DxUSl+hiSNzfV2
 PpY6ACHKg4prlo3DxUqSSwvQkJQ3u0L7sLTgds/YI5oWw3VNsA8XzDlavkNNFb+PXEIqspjXUN
 xmZbHAQdVE0xUEwEb3QGKypIoAVrS3VZyyDCRGUpUlUin6n9KZlVtGdLvI3bqQRmuKoCzUL7BN
 9nk=
X-IronPort-AV: E=Sophos;i="5.77,305,1596470400"; 
   d="scan'208";a="152703438"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2020 18:31:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSKhCIpCQWB44uxF4JOU3eFtpn6Lsxdo+MEYrgjMGfUSXQwi0WdqtWQ2H2obj1hcM15yeV6OMQvvsBV/QoOTMmZQGDeE8XjSCm4Gtj/LYYUerrI9M8xRrqj78LVmekL8f5eEb7DPQLWDZw9jD5p7WJ+DVz0PlaCk36ZQGb1n8/OKM6O3YPqvpKjEeNa0CCdxvfoPEqo7AzcrR+pt7cvhOoxI2z79tI1TOVD0o+bFGXgwbHUQ49K/A76JRvQ3HSpL2UO8zqkscqVSonmrsrySDfTitdOoao8mgkK3J3Nm51+NgNYhwDierql9k8Kcz4W9TBD+kgCZW3i1RkJn528nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhORag1YPWed45wSVhujbLKlybpepoW4rfY7VwIlpSw=;
 b=AMjxnb0Za7y1jFyQYS2w2KG/HjraGC1Tmtl1bA/xkYr/qzfnIB/2BGgw26KwHUbuubztLpqacMunBMbf/JVWroiMPGwdRqusKX1lopB4bPFVbWKsMrP2kZYhlJQuYT/gdApbwq/ItNW6DiqNHGW7VdRE0+yE4thzR6kwjAbnn65TpoFRwQnkSWb+lN03bSVZWMxYDbg2P9JnJYE7MTPWOZtIdwKYO4KakG07OWXHuiaQxhqqEhPqMNYQ7MG/PQPsjCdhngTzlr3f1oO+2pLOTmzZtFCv4x4Quj8mVoJliCqb5Q5MIku8A+0cSR9RJLts0d6YQL8VSgCyn2kPu2asNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhORag1YPWed45wSVhujbLKlybpepoW4rfY7VwIlpSw=;
 b=eAkviBZ//0JY5DCYS6b/IfsQX1lcIjdEzY08lQsshGiMkEj6ENFrnHLarPdUQmcGE3UG1SqilK+N0dMf5t69rUuEexn2/SVZlTGXOCvel+YG5qYKQKkvCu9KfJdEfoA4GPXBdILF38IfbFkTptFBwF7KAfQp2XTDfWJbuBgqhCY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0374.namprd04.prod.outlook.com (2603:10b6:903:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Sat, 26 Sep
 2020 10:31:29 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.024; Sat, 26 Sep 2020
 10:31:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RISC-V: Check clint_time_val before use
Thread-Topic: [PATCH v2] RISC-V: Check clint_time_val before use
Thread-Index: AQHWk+71H95SGo2V/kutuSpuNsIDwql6uIQA
Date:   Sat, 26 Sep 2020 10:31:29 +0000
Message-ID: <4950cd11fcf66bc3606f309d6289577b5dc65b2e.camel@wdc.com>
References: <20200926102158.828461-1-anup.patel@wdc.com>
In-Reply-To: <20200926102158.828461-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cd3b59d-cfaf-4f3f-5403-08d86207543f
x-ms-traffictypediagnostic: CY4PR04MB0374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0374F274A95CF0FF3F14EA7DE7370@CY4PR04MB0374.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i66mQhETf45aiaZg7URva7hnWbFqyBPXUBDsD1dm2zDkvZX9GZe00kBmL7JawvvmCl3aXd1lQr/Yqh/dKPXxV2w2iNJmhV+zFZlm+xA6IOH0/uSCDRKxIinlv22KE//ZszCVHso8lGWzPRHzlb9rS/yxRcqaengRuv1wyc+jx0iQybzzFyk+/XLcRvSmjoKsaqKB6o9b8sH3Ieb2Mgy1HLNEEhwU12OzKIuJ8Kq94M2Z3DV5gWD1+ARj9idOuQbEqE8Mf0ufAGmO0NtgTwf9YF1Mo/7Pbbw2EEFGKqlVWQfwapSnrm2kOWpB3ItTw7X+midJERIwl5KEu2tgHZ2P/rUEc9nfZkIaAUR20PzJWiFKqX4+sS8T+8PQ7NS2RKfM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(71200400001)(91956017)(76116006)(86362001)(2616005)(54906003)(4326008)(110136005)(6486002)(478600001)(6512007)(5660300002)(66946007)(316002)(83380400001)(8676002)(66446008)(6506007)(66476007)(186003)(66556008)(64756008)(8936002)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AxDvdIdeVB0tFAVdvayE0t+QDqCOK4Oz7uwcPgFA/g4tljK59URmpDePQwKMu2Pt1nRkb2oItuk1mJYsaIPf/qLsO595b0oUrX2dqqS+Hb1v29RZqxvlxQWxo5t1rKbHs73HMTpw2PuHNWTuqvBp8OCMR0sRsyi3fax43b79cs/6+TOYRX0NsWAUULH2tSC3SzK5o0aww3QMHqHFgaqE+1Gpp7kdh66rlkS3YWFzIY4ogPeBmI9nh6aDYeQrWG979xkTz+Jy3sBX0fwK/0yZgMGQCI2vCwHZoZ0Uabmd9PvfydF11syKYsU06nY1U6LqZvOFEgyO1mSXitIWOQnZdb4ht6TOGt1BvQKlCTL8BcYQg2cd0uszGGQLBEBV9lwbdudWLc/a39SG9ptg3t1lzYZ+gBkqI8XlkU0/tMX7Dc6fddZ1l+nZIvcOyDK2rgOcGGAreKlV/vkwNnDaPz0ZUe9C6osxzZ9PmxPgyFk+Gl6vs51Y0ctkfgh08d6QdMI7nTIFRK57JG2rMVSvfTkyDFWD+dLRn0o4p/fURBtECDmRWKKVh/jgOv/8aKqjCeTcanHmv2SESBkucxUkW1pZ4PCi1ciJoWPLQ61PQh4WgYzCoLsk7OL5aYO4lRx0WJm8wns6URVzzI+zTpJMcyjSVQh9cGnoHDSeNqqDu9Fna9N7SMdZH1Kpb3iDiaay1inRSTxArUZ2SmhAi+fYia/Trw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2089336F1208AF429C9A44A5BB755997@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd3b59d-cfaf-4f3f-5403-08d86207543f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2020 10:31:29.0134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJWSl6n/zx0/r8Jpp/LCLfo7Xs8+N/Uuc4oZZHK7d5rV9gllCscp3LKXV555dl88YNI6mCoXrxIRi7R3J84+Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0374
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA5LTI2IGF0IDE1OjUxICswNTMwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBU
aGUgTm9NTVUga2VybmVsIGlzIGJyb2tlbiBmb3IgUUVNVSB2aXJ0IG1hY2hpbmUgZnJvbSBMaW51
eC01LjktcmM2DQo+IGJlY2F1c2UgdGhlIGdldF9jeWNsZXMoKSBhbmQgZnJpZW5kcyBhcmUgY2Fs
bGVkIHZlcnkgZWFybHkgZnJvbQ0KPiByYW5kX2luaXRpYWxpemUoKSBiZWZvcmUgQ0xJTlQgZHJp
dmVyIGlzIHByb2JlZC4gVG8gZml4IHRoaXMsIHdlDQo+IHNob3VsZCBjaGVjayBjbGludF90aW1l
X3ZhbCBiZWZvcmUgdXNlIGluIGdldF9jeWNsZXMoKSBhbmQgZnJpZW5kcy4NCj4gDQo+IEZpeGVz
OiBkNWJlODlhOGQxMTggKCJSSVNDLVY6IFJlc3VycmVjdCB0aGUgTU1JTyB0aW1lciBpbXBsZW1l
bnRhdGlvbg0KPiBmb3IgTS1tb2RlIHN5c3RlbXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbnVwIFBh
dGVsIDxhbnVwLnBhdGVsQHdkYy5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAg
LSBFeHBsaWNpdGx5IGluaXRpYWxpemUgY2xpbnRfdGltZV92YWwgdG8gTlVMTCBpbiBDTElOVCBk
cml2ZXIgdG8NCj4gICAgYXZvaWQgaGFuZyBvbiBLZW5kcnl0ZSBLMjEwDQo+IC0tLQ0KPiAgYXJj
aC9yaXNjdi9pbmNsdWRlL2FzbS90aW1leC5oICAgIHwgMTIgKysrKysrKysrLS0tDQo+ICBkcml2
ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWNsaW50LmMgfCAgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vdGltZXguaCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGlt
ZXguaA0KPiBpbmRleCA3ZjY1OWRkYTAwMzIuLjZlN2IwNDg3NDc1NSAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90aW1leC5oDQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVk
ZS9hc20vdGltZXguaA0KPiBAQCAtMTcsMTggKzE3LDI0IEBAIHR5cGVkZWYgdW5zaWduZWQgbG9u
ZyBjeWNsZXNfdDsNCj4gICNpZmRlZiBDT05GSUdfNjRCSVQNCj4gIHN0YXRpYyBpbmxpbmUgY3lj
bGVzX3QgZ2V0X2N5Y2xlcyh2b2lkKQ0KPiAgew0KPiAtCXJldHVybiByZWFkcV9yZWxheGVkKGNs
aW50X3RpbWVfdmFsKTsNCj4gKwlpZiAoY2xpbnRfdGltZV92YWwpDQo+ICsJCXJldHVybiByZWFk
cV9yZWxheGVkKGNsaW50X3RpbWVfdmFsKTsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gICNlbHNl
IC8qICFDT05GSUdfNjRCSVQgKi8NCj4gIHN0YXRpYyBpbmxpbmUgdTMyIGdldF9jeWNsZXModm9p
ZCkNCj4gIHsNCj4gLQlyZXR1cm4gcmVhZGxfcmVsYXhlZCgoKHUzMiAqKWNsaW50X3RpbWVfdmFs
KSk7DQo+ICsJaWYgKGNsaW50X3RpbWVfdmFsKQ0KPiArCQlyZXR1cm4gcmVhZGxfcmVsYXhlZCgo
KHUzMiAqKWNsaW50X3RpbWVfdmFsKSk7DQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+ICAjZGVmaW5l
IGdldF9jeWNsZXMgZ2V0X2N5Y2xlcw0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIHUzMiBnZXRfY3lj
bGVzX2hpKHZvaWQpDQo+ICB7DQo+IC0JcmV0dXJuIHJlYWRsX3JlbGF4ZWQoKCh1MzIgKiljbGlu
dF90aW1lX3ZhbCkgKyAxKTsNCj4gKwlpZiAoY2xpbnRfdGltZV92YWwpDQo+ICsJCXJldHVybiBy
ZWFkbF9yZWxheGVkKCgodTMyICopY2xpbnRfdGltZV92YWwpICsgMSk7DQo+ICsJcmV0dXJuIDA7
DQo+ICB9DQo+ICAjZGVmaW5lIGdldF9jeWNsZXNfaGkgZ2V0X2N5Y2xlc19oaQ0KPiAgI2VuZGlm
IC8qIENPTkZJR182NEJJVCAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS90
aW1lci1jbGludC5jIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1jbGludC5jDQo+IGluZGV4
IGQxNzM2N2RlZTAyYy4uOGRiZWM4NTk3OWZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsb2Nr
c291cmNlL3RpbWVyLWNsaW50LmMNCj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1j
bGludC5jDQo+IEBAIC0zNyw3ICszNyw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNsaW50X3Rp
bWVyX2ZyZXE7DQo+ICBzdGF0aWMgdW5zaWduZWQgaW50IGNsaW50X3RpbWVyX2lycTsNCj4gIA0K
PiAgI2lmZGVmIENPTkZJR19SSVNDVl9NX01PREUNCj4gLXU2NCBfX2lvbWVtICpjbGludF90aW1l
X3ZhbDsNCj4gK3U2NCBfX2lvbWVtICpjbGludF90aW1lX3ZhbCA9IE5VTEw7DQo+ICAjZW5kaWYN
Cj4gIA0KPiAgc3RhdGljIHZvaWQgY2xpbnRfc2VuZF9pcGkoY29uc3Qgc3RydWN0IGNwdW1hc2sg
KnRhcmdldCkNCg0KRm9yIEtlbmRyeXRlOg0KDQpUZXN0ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxk
YW1pZW4ubGVtb2FsQHdkYy5jb20+DQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rlcm4gRGln
aXRhbA0K
