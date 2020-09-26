Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B24279835
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIZJqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 05:46:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63973 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601114317; x=1632650317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eQ92xVBS6abZd2FKtuolJEogq61AL2uz/DvE0un+cG4=;
  b=qgObtnXfvnpMcusIKXDlXXMwM5J+G4+ir/qKiWH2t59/ogb+ZU2KiIvs
   A/agooe+3taNuEIXP3rPgX30e+tZlKvFVFE0CWmrDDx9b/obVnw4Aa3Yi
   YGIOVi5snrpxwgNN/W3rUxJBjWr/wIMLgmTw+yepZs0KPMDzH80f3zyZK
   u/3Gk2Wo23whv8bUizyFKrSWndRGt242/5LLuMsuSUZLrf72Ni+TDkGaN
   VIkPlHyEWWRvWXe2LHb1+lTFCh2XJwujQVZ5OdKCDZyT+bIW3MTDlJSmA
   AU4Ma8xpS1Rc227ykA0GfkWJW/+PqUsNJrwQEpvB6RH3TX9j1Kan9ksE2
   g==;
IronPort-SDR: j2iaUQxMil6jXW2OXV7I/jjOK2os5l89eySxES1NO1x5XvpdQsCoir38CZTakYi2GkEzkt+HTd
 s6ew8vqSSp/BSDU6FdTJeoIga5lwzLDKPNgKaAmyLDPpy+39MvUMXWyT4igQMJaWlbsfVbO1c4
 qhtv0xDIu+/JGd/KrjLSef1Okr49vHE+VPzgx1ORPAb6YvSmrH+AgOJMLdH2IOqMgnl2okV7zv
 o3fQtQPqh736l88lS9wFduy6vpKsTD24oMuVeEFy8NysWIvL3UnTRx0gPJu3tMXzQXCGlKEON4
 sTk=
X-IronPort-AV: E=Sophos;i="5.77,305,1596470400"; 
   d="scan'208";a="251722611"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2020 17:58:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzdJxUV/YDsijLnHF+nyKrEU/IrZjCtZpsxm4z81bWsS/RKqb6ce+mGS5plnu3wJf+cmkOWMhoPrY5vhqD/GC0tLMzDlMUJ8Hsxux3HExIn2jE+YRhURwYQy8uUgi9k781vdeD5hks/YfU6iLDYMLdWS4XhnHYrEOxxD+POdGObex3NBuDXU9d1RXJc4CypYnYaT3jmAfTTaqDjRAHX6qk9x2t9t6dYQY4BA/AaC74iIQSVBPMdNTpgAiQhZDpiHuGfH0xN+Fcg0skWJjLheCd/ZUwwpcdA8MTWZOzt44GUuMXwU8/JOKP4SuWLrCLYSQDqBcl1HjFc+S2rRvDyLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ92xVBS6abZd2FKtuolJEogq61AL2uz/DvE0un+cG4=;
 b=VwEsE52W8KjVlR50LjU1nzuECnQ9BgsJS8lnS59Z4dOGdxYpEYv8Lj/K3xDGtl6P5jP0s5ieEAjhnhrG2J58qFcJFSHizt0vZcYRL2qZsPwtc60S+Y3BcSFjNL+RdDRJvzT0vAOO/wbC2heYrJzPqAWZJNm655dHQ5JfrucvXk4lpfkbX07sC4REpxgwTTkxIp9bRDNbBnCAigiex4ghnhrWt8esJSf3EwIkkEs+gO9hLIJUtqpGz3Ji1tO9CPqvL4ypqdWGZssHN/uq4ZYBQ1Ax/TmS49T4nRrNKd5JY4JsymaO3RB7JLGPoLWwNi96kfVx+T6xb3neow0QNCZL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ92xVBS6abZd2FKtuolJEogq61AL2uz/DvE0un+cG4=;
 b=iGVmN5LzTCp0p91SOStkn671JCm9fGOO8mwtMxPRWtbxnKP5q5jYxwE0eM6R69TA9sx5c9vDX1V/tVOiQ7dt65RfDxP+DKqsN4uHb2/waQLa+nC35HwBf/msUsZgB5E1xca6xQSfInglzW9OkPpjPKnDLabfCl7W+1KW24T+8Yg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1030.namprd04.prod.outlook.com (2603:10b6:910:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Sat, 26 Sep
 2020 09:46:17 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.024; Sat, 26 Sep 2020
 09:46:17 +0000
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
Subject: Re: [PATCH] RISC-V: Check clint_time_val before use
Thread-Topic: [PATCH] RISC-V: Check clint_time_val before use
Thread-Index: AQHWk9aYSJLcKwhKG0OB2/Vy4ql06al6pkQAgAAB0ICAAAQAAA==
Date:   Sat, 26 Sep 2020 09:46:17 +0000
Message-ID: <0e1990c99bf2a342cd2e78ec7ecfc2fdecaf67fb.camel@wdc.com>
References: <20200926072750.807764-1-anup.patel@wdc.com>
         <1ee25b9bca3956d15a4a0dbf83f43d1ead454220.camel@wdc.com>
         <DM6PR04MB62017875C739101DF83280ED8D370@DM6PR04MB6201.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB62017875C739101DF83280ED8D370@DM6PR04MB6201.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: da2abd71-4d8c-4ccc-879e-08d8620103eb
x-ms-traffictypediagnostic: CY4PR04MB1030:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1030843F1596D6B029CAD4FDE7370@CY4PR04MB1030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CbANwWAnDqKX2dBTRO4apoEe0skoMxd5zxT1b4ujyxTOpuS8y2fZUHnBSmYzod+g63m1j7i63mNeLI83/axn9e+vhzhZwtLTU3XJGG6vsauWcWKNiUxWhXIwukGjU1wVEnpcmV35urddwoVnOy693xIWvfW1AbYNC6rtKpH7wVzMoE4pCdJtpdk8ahAoqzwcb8N16kJabEW+Edwp2KuT8tyZ6vbpKKzX2lCPsCie+EzIiJ21ReasfH6B/QaaGU7Ghhm/70j3X0LPKReaTKq/eK+VSv5OkBEusXuiQs0f8UjZV2JTSwZor3uQsoRcptmcl45LkRmy+I8OC2ntjq4EEP7tk/0Qcw3e3/WoBmLgsbFA113kOUsSB7h29NusguxC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(2906002)(316002)(6486002)(4326008)(54906003)(110136005)(5660300002)(2616005)(478600001)(66476007)(71200400001)(66446008)(64756008)(66556008)(76116006)(66946007)(91956017)(186003)(6506007)(53546011)(6512007)(8936002)(83380400001)(36756003)(8676002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jw3ohs00kSqOw/qrm4s03WvJUuJrYKhW1lcN98J1pLD1t6eNUCd9rTfi8jG8VX9skyM49vFmin/HMVhJ1I2RAhDPWvN9DR1RnM2tlc+20M7cKB82B9osb1yPONJpUHoegqheRrAjljPZ35AW3+kq6+mFYpEe+LJwBYUAr4zzG3hY0+ztFbcGdcqsgRrG8XtuPbUajVnwC3b5uX+n5rY/xI627EF5B2hrSbxAEtnC6o7m2L7mR0RoihIn6pjdYIh7FfbB/VZ4HfJyEVqqQi2OtNyEeNPhkxLedoVOTo5GS9DE4/23qjLO/1ja+ik5apNWMLI+2ECmHP0NXf5xtIuqKUGlvkp8TOAWHFZxILmqBVfkJRFweKfvPaYAiR4fXkJrYVMZm1xmlOzy0AQCYUKVqfuHsdhACu4tqbmRagzq04JJCyiPOQovFp3J256xGgtoyoQKUvkJqXVHOTHRQxd61XIErwv9D4shUbxGHOXmY+o3jiDqdHQxAAGcJ5nJuysTXC0syZKmEHyNIfep+NkI2ts/kLcSqhLLQaHM2clQSt3wdSVs6XgWIxz9hvIEiK1iq3iUuDVCzSUOvw0dATABSYp/uRQ9zw3EQODgr580IEhAprF1LDeQvkvH79XZNTqTIPEFCrGoga14mKkjZATSdph+SMJcmyCUx900aa7A0vL5B2BPWEPa6h6Ng/6FGwQHCInPunrU0ixyRKZLJwg11w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9646FE83BC4B2D4DA08E2068DA4BBCA3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2abd71-4d8c-4ccc-879e-08d8620103eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2020 09:46:17.2212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGwdFFObzBjkNaoxUitWVLE2zA9TdtrD+dZ9kpTYwgNjDaYaUNLoNeeGaXqLbiFmJFkFi2/WZCoru369Z7hF9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA5LTI2IGF0IDA5OjMxICswMDAwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogRGFtaWVuIExlIE1vYWwgPERh
bWllbi5MZU1vYWxAd2RjLmNvbT4NCj4gPiBTZW50OiAyNiBTZXB0ZW1iZXIgMjAyMCAxNDo1NQ0K
PiA+IFRvOiBwYXVsLndhbG1zbGV5QHNpZml2ZS5jb207IHBhbG1lckBkYWJiZWx0LmNvbTsNCj4g
PiBwYWxtZXJkYWJiZWx0QGdvb2dsZS5jb207IEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNv
bT47DQo+ID4gYW91QGVlY3MuYmVya2VsZXkuZWR1DQo+ID4gQ2M6IGFudXBAYnJhaW5mYXVsdC5v
cmc7IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IEF0aXNoIFBhdHJhDQo+ID4gPEF0
aXNoLlBhdHJhQHdkYy5jb20+OyBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lzQHdk
Yy5jb20+OyBsaW51eC0NCj4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gU3ViamVjdDog
UmU6IFtQQVRDSF0gUklTQy1WOiBDaGVjayBjbGludF90aW1lX3ZhbCBiZWZvcmUgdXNlDQo+ID4g
DQo+ID4gT24gU2F0LCAyMDIwLTA5LTI2IGF0IDEyOjU3ICswNTMwLCBBbnVwIFBhdGVsIHdyb3Rl
Og0KPiA+ID4gVGhlIE5vTU1VIGtlcm5lbCBpcyBicm9rZW4gZm9yIFFFTVUgdmlydCBtYWNoaW5l
IGZyb20gTGludXgtNS45LXJjNg0KPiA+ID4gYmVjYXVzZSB0aGUgZ2V0X2N5Y2xlcygpIGFuZCBm
cmllbmRzIGFyZSBjYWxsZWQgdmVyeSBlYXJseSBmcm9tDQo+ID4gPiByYW5kX2luaXRpYWxpemUo
KSBiZWZvcmUgQ0xJTlQgZHJpdmVyIGlzIHByb2JlZC4gVG8gZml4IHRoaXMsIHdlDQo+ID4gPiBz
aG91bGQgY2hlY2sgY2xpbnRfdGltZV92YWwgYmVmb3JlIHVzZSBpbiBnZXRfY3ljbGVzKCkgYW5k
IGZyaWVuZHMuDQo+ID4gPiANCj4gPiA+IEZpeGVzOiBkNWJlODlhOGQxMTggKCJSSVNDLVY6IFJl
c3VycmVjdCB0aGUgTU1JTyB0aW1lciBpbXBsZW1lbnRhdGlvbg0KPiA+ID4gZm9yIE0tbW9kZSBz
eXN0ZW1zIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFudXAucGF0ZWxAd2Rj
LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGltZXguaCB8
IDEyICsrKysrKysrKy0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL3RpbWV4LmgNCj4gPiA+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90aW1leC5o
IGluZGV4IDdmNjU5ZGRhMDAzMi4uNTJiNDJiYjE2MDJjDQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0t
LSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGltZXguaA0KPiA+ID4gKysrIGIvYXJjaC9yaXNj
di9pbmNsdWRlL2FzbS90aW1leC5oDQo+ID4gPiBAQCAtMTcsMTggKzE3LDI0IEBAIHR5cGVkZWYg
dW5zaWduZWQgbG9uZyBjeWNsZXNfdDsgICNpZmRlZg0KPiA+ID4gQ09ORklHXzY0QklUICBzdGF0
aWMgaW5saW5lIGN5Y2xlc190IGdldF9jeWNsZXModm9pZCkgIHsNCj4gPiA+IC0JcmV0dXJuIHJl
YWRxX3JlbGF4ZWQoY2xpbnRfdGltZV92YWwpOw0KPiA+ID4gKwlpZiAoY2xpbnRfdGltZV92YWwp
DQo+ID4gPiArCQlyZXR1cm4gcmVhZHFfcmVsYXhlZChjbGludF90aW1lX3ZhbCk7DQo+ID4gPiAr
CXJldHVybiAwOw0KPiA+ID4gIH0NCj4gPiA+ICAjZWxzZSAvKiAhQ09ORklHXzY0QklUICovDQo+
ID4gPiAgc3RhdGljIGlubGluZSB1MzIgZ2V0X2N5Y2xlcyh2b2lkKQ0KPiA+ID4gIHsNCj4gPiA+
IC0JcmV0dXJuIHJlYWRsX3JlbGF4ZWQoKCh1MzIgKiljbGludF90aW1lX3ZhbCkpOw0KPiA+ID4g
KwlpZiAoY2xpbnRfdGltZV92YWwpDQo+ID4gPiArCQlyZXR1cm4gcmVhZGxfcmVsYXhlZCgoKHUz
MiAqKWNsaW50X3RpbWVfdmFsKSk7DQo+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gIH0NCj4gPiA+
ICAjZGVmaW5lIGdldF9jeWNsZXMgZ2V0X2N5Y2xlcw0KPiA+ID4gDQo+ID4gPiAgc3RhdGljIGlu
bGluZSB1MzIgZ2V0X2N5Y2xlc19oaSh2b2lkKSAgew0KPiA+ID4gLQlyZXR1cm4gcmVhZGxfcmVs
YXhlZCgoKHUzMiAqKWNsaW50X3RpbWVfdmFsKSArIDEpOw0KPiA+ID4gKwlpZiAoY2xpbnRfdGlt
ZV92YWwpDQo+ID4gPiArCQlyZXR1cm4gcmVhZGxfcmVsYXhlZCgoKHUzMiAqKWNsaW50X3RpbWVf
dmFsKSArIDEpOw0KPiA+ID4gKwlyZXR1cm4gMA0KPiA+ID4gIH0NCj4gPiA+ICAjZGVmaW5lIGdl
dF9jeWNsZXNfaGkgZ2V0X2N5Y2xlc19oaQ0KPiA+ID4gICNlbmRpZiAvKiBDT05GSUdfNjRCSVQg
Ki8NCj4gPiANCj4gPiBBcHBseWluZyB0aGlzIG9uIHRvcCBvZiByYzYsIEkgbm93IGdldCBhIGhh
bmcgb24gS2VuZHJ5dGUgYm9vdC4uLg0KPiA+IE5vIHByb2JsZW1zIHdpdGhvdXQgdGhlIHBhdGNo
IG9uIHRoZSBvdGhlciBoYW5kLg0KPiANCj4gTm90IHN1cmUgYWJvdXQgdGhlIGlzc3VlIHdpdGgg
S2VuZHJ5dGUgYnV0IEkgZ2V0IGEgY3Jhc2ggb24NCj4gUUVNVSB2aXJ0IG1hY2hpbmUgd2l0aG91
dCB0aGlzIHBhdGNoLg0KDQpXaXRoIHRoaXMgYXBwbGllZCBpbiBhZGRpdGlvbiB0byB5b3VyIHBh
dGNoLCBpdCB3b3Jrcy4NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXIt
Y2xpbnQuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItDQpjbGludC5jDQppbmRleCBkMTcz
NjdkZWUwMmMuLjhkYmVjODU5NzlmZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2Uv
dGltZXItY2xpbnQuYw0KKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1jbGludC5jDQpA
QCAtMzcsNyArMzcsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBjbGludF90aW1lcl9mcmVxOw0K
IHN0YXRpYyB1bnNpZ25lZCBpbnQgY2xpbnRfdGltZXJfaXJxOw0KIA0KICNpZmRlZiBDT05GSUdf
UklTQ1ZfTV9NT0RFDQotdTY0IF9faW9tZW0gKmNsaW50X3RpbWVfdmFsOw0KK3U2NCBfX2lvbWVt
ICpjbGludF90aW1lX3ZhbCA9IE5VTEw7DQogI2VuZGlmDQogDQogc3RhdGljIHZvaWQgY2xpbnRf
c2VuZF9pcGkoY29uc3Qgc3RydWN0IGNwdW1hc2sgKnRhcmdldCkNCg0KLS0gDQpEYW1pZW4gTGUg
TW9hbA0KV2VzdGVybiBEaWdpdGFsDQo=
