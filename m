Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1852E7D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 02:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgLaA5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 19:57:06 -0500
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:63045
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgLaA5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 19:57:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/QYWriSRwI6CgVRHzIFaevQNsPV4Us/WRAkDXMGT8V4y0G0kSU4cXMg/+l0oSzUTpuQCxGOgwZr11TBu1Ci3ZVQ/ZkkeMGmZUxuXszcgmxD3hnxCin+ombG+9P11etEEGFb7Dt1Dnar+0c7DAkHL1rXsx2pl+RFgavxtfwtgLVFAYXwqRS5yo+7xDH3kFA8Dm5goQfFclfzvBFDSwW9R2xg8ni2i87aVAHKOQm4iuUNbQWjovRaOU+W1MlSEosgD8hfED7HPUfEHmgamUpzuf9HCT/qH41+wihYOqcM9zLrXGbu10Pw+zx+l2IHjaJaNzcpQRUhhAGr5384EMg7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8miRjjXLJlTm55ZlrzRQBudndAhnpFNsKi0y/Sb8kPw=;
 b=SZ11iyoee98/E0npvBVHgDnLEih14vWZ5tPjkcUf/lVEqV2NrHrvnADG2khvF/ZTsId0oBPcy+BUYFZ+g+x3VSoKfNkDpjZL6ZRq2dZGUFkSDKmWNFiinu8LyloM2pyyjQ1NhXK8d7FzC5bYqWbh2lspp+FXB9R0qnXdy+21uuXROsI1IijEBTZCfmDbZ0Cz6BBOu1oHaibdvmf629BlTLyJ3dw00BsU2Kh65nAG0XQt6liuB56zwOt4YQy7n8UYp7cDTfc+i8yJepEcgiXBeAav0u/Gm7ID/knTI/+f9UCVNVxTty70HnYJGos4j8viMiny1DAdLNxeNhIBXua/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8miRjjXLJlTm55ZlrzRQBudndAhnpFNsKi0y/Sb8kPw=;
 b=jOebLzhJ08DgVQZGCZhnbHUmHmeVpUrv4TtymExEM16/QMTsKaU+RCbfHyxJSRaWkQPf33O74lTNq6IRwEgZfqVU6/LBWlE5KlQRCsbyhJZAtwAzVelrLvoOqMQ3T62TrMzzT9fsh5sK7EcON6A0PRrJbNgqtkChh5DhZSpDGWA=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Thu, 31 Dec
 2020 00:56:16 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3700.031; Thu, 31 Dec 2020
 00:56:16 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "manfred@colorfullife.com" <manfred@colorfullife.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBpcGMvc2VtLmM6IENvbnZlcnQga2ZyZWVfcmN1KCkg?=
 =?gb2312?Q?to_call=5Frcu()_in_freeary_function?=
Thread-Topic: [PATCH] ipc/sem.c: Convert kfree_rcu() to call_rcu() in freeary
 function
Thread-Index: AQHW3qNrbToW5aBDxkKptCOkHF9DjaoP0eCAgACPdlQ=
Date:   Thu, 31 Dec 2020 00:56:16 +0000
Message-ID: <BYAPR11MB26329E4008C108B4BA85D4A4FFD60@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20201230120038.19489-1-qiang.zhang@windriver.com>,<20201230161941.GN2657@paulmck-ThinkPad-P72>
In-Reply-To: <20201230161941.GN2657@paulmck-ThinkPad-P72>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [106.39.151.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6133aff1-39c2-488d-7d9b-08d8ad26e0f1
x-ms-traffictypediagnostic: SJ0PR11MB4896:
x-microsoft-antispam-prvs: <SJ0PR11MB4896C7AEA8E7405D82ED353FFFD60@SJ0PR11MB4896.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYXn0fM9eufArAmD3rz3HHZplAYQYD870QSCUVWyPu4EtbTQLtg5h0e68iAgpnnY8/QX+/xGgmT7iewLQ+yLWmfYqRrD4hSLMMOQpvok117o/wOnYe3PDHQ7n2BLWdZeuw9Yp3GrHQ6uaioGuJtejjSrk5EFYRIvFN6cOTACLZd9CB0DVBqRDRcTjitM6Wz65ne/njwMKO5PjZ/sXeWYvSrb9ilGak5xWVInSkMzO25XwV8Fown3os70tiGgIEl59xWfngjPqWKwOnoBRK9/qp69lNshYJMSNV4VOmggxbtwTKP4/yaaD8a6ODI7tyNdnaO23Xwubt51kxVwlD0T4f74zN8Fjo1dMs2TT7qSjbMh/tv5xmzhq3bv+9T2/UTqWmcorEh5n9lbRC4+S1+mHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(376002)(396003)(136003)(316002)(91956017)(76116006)(9686003)(5660300002)(478600001)(66946007)(64756008)(7696005)(66476007)(66446008)(8936002)(66556008)(186003)(55016002)(54906003)(2906002)(83380400001)(6916009)(71200400001)(4326008)(33656002)(26005)(52536014)(6506007)(86362001)(224303003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?MFdXOE9hc0lXT3B0MGZCeTRDdEhnajByTE1ZdGcxUmMrSmpodVgrSW9TQWph?=
 =?gb2312?B?UDZrUi9YVHZHUkgyUU40NG5Fblhlb095Z0JoRXkzQU9JR0syL2gzc3hiK2dU?=
 =?gb2312?B?a01CS29HV0hZNUd4cHRKbkdaeXVneittRk45cFhXQ01BZC9XVUhKREloYi9Y?=
 =?gb2312?B?QzZmVm9nWFl4TUNwTXVidnEraTYvdXZqOXFNeVY2S2s3OUZlc291aUpUMFNq?=
 =?gb2312?B?YzJwVUlHcEtsaHVsS00vSFBiTWlZYjRnL1lWcWxyZ2c0T1QzcUxMc1BVRGxw?=
 =?gb2312?B?VGt4ZkN2MHArZHl5RWZoSVpzNDROdzZFV3prV05vbmVPcmhsNURqbEs4RGtt?=
 =?gb2312?B?WkNHSlVqaHpjVE42dk5hY2J5K2E3QklRYlRNS2Nmc1l5YXIveUt3b29xdnNu?=
 =?gb2312?B?UE5xeFFZZ3BXR0tKODdPVG42Lzh1RnUrMUw5VWtXVmYyOW5xQ0QxQ29ybExu?=
 =?gb2312?B?NEdJT2RaZGxqem9PcUhxZ2wxcDBISHJodVU1Z3lDU0VZcURVaS9oOHNDU1Av?=
 =?gb2312?B?WG0xUE5OVmVOT2U3cHZ3dk42OUhVNUF1NG9BWHpIdTdLZ2ozSm04NHpsNjRR?=
 =?gb2312?B?dVRGZStweEM5RmpRMlZ4anV6blBXQjhNa1AxZUtrWFJzZitKSEFiVmVnRFVL?=
 =?gb2312?B?S0orcnBOMTZjNmZudDRLSVRyQ3JkcTBaMkRYaXptdFc5WGVhUHVUTFBmWE83?=
 =?gb2312?B?OVVndUxNNTNBaU4vL0IzSEFxbFBIU3lST3poOGxNYVF4TnhUTTVTYlpvbUZs?=
 =?gb2312?B?eWhrVWZMNnpDOGdXRUZuS3pBZVBtNTJ6bzk0NWNyd1RDajVvcld1bGdXR21y?=
 =?gb2312?B?N212MjJMdGJYNG5GaEZRTTR4NVExTFNnNzZWejdGclhQTlBzU3pzeU5lT0x1?=
 =?gb2312?B?WENYNWordTdUUHV3cEZxWE5DVFBGYUlaUy9DcXVabDlsblhPN2k3eXVZNzA4?=
 =?gb2312?B?Ly84TTl2ZEVkRHM5ZUNJN0h2YmgvZm9LMFVrTkNpTkdXZmtpMTBFeUNTalZx?=
 =?gb2312?B?dEhKK1kwKy9xcGVIczYxblhUVEt4L1RSTjMyMURHZlBpV3lSQnFSL2QrSGZD?=
 =?gb2312?B?TEZaQmJRWVRlaVMwenNDUytOZkNqcVZLYlB5ZkdXOVNYZlYxQWZuSmRyMzE4?=
 =?gb2312?B?M0w5NGFNWkI5RkhjSWdHbGIrNUdGZW1ySjJUME9Ub1FuTGhiTFhqU3MwblIr?=
 =?gb2312?B?QWxpUXpoUWZxSzVhaUhHSStVYVV4WlpGZ0V6Q2c1RGRkSjE3TmNOdzJmUDJG?=
 =?gb2312?B?M2oxd05yN0VhVEdTeHpKSDhjT28xSEF5Q2tSUDdrOHdoKzg0T0dnMUxqOWhI?=
 =?gb2312?Q?aSEklp5rVYDdk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6133aff1-39c2-488d-7d9b-08d8ad26e0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2020 00:56:16.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRvUev8pWkgX9DnRdhV21ot6c49aC6ZO7/ISPwqEOTLIFQt03zg2DfhpJCGmzvejop1uzDfqnI7ALjAzDB37gAZktWgXG7NnRnh3c9PFhxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUGF1bCBF
LiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPgq3osvNyrG85DogMjAyMMTqMTLUwjMxyNUg
MDoxOQrK1bz+yMs6IFpoYW5nLCBRaWFuZwqzrcvNOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3Jn
OyBtYW5mcmVkQGNvbG9yZnVsbGlmZS5jb207IGd1c3Rhdm9hcnNAa2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZwrW98ziOiBSZTogW1BBVENIXSBpcGMvc2VtLmM6IENvbnZl
cnQga2ZyZWVfcmN1KCkgdG8gY2FsbF9yY3UoKSBpbiBmcmVlYXJ5IGZ1bmN0aW9uCgpPbiBXZWQs
IERlYyAzMCwgMjAyMCBhdCAwODowMDozOFBNICswODAwLCBxaWFuZy56aGFuZ0B3aW5kcml2ZXIu
Y29tIHdyb3RlOgo+IEZyb206IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPgo+
IER1ZSB0byBmcmVlYXJ5IGZ1bmN0aW9uIGlzIGNhbGxlZCB3aXRoIHNwaW5sb2NrIGJlIGhlbGQs
Cj4gdGhlIHN5bmNocm9uaXplX3JjdSBmdW5jdGlvbiBtYXkgYmUgY2FsbGVkIGluIGtmcmVlX3Jj
dQo+IGZ1bmN0aW9uLCB0aGUgc2NoZWR1bGUgbWF5IGJlIGhhcHBlbiBpbiBzcGlubG9jayBjcml0
aWNhbAo+IHJlZ2lvbiwgbmVlZCB0byByZXBsYWNlIGtmcmVlX3JjdSgpIHdpdGggY2FsbF9yY3Uo
KS4KPgo+RXhjZXB0IHRoYXQgdGhlIGNhbGwgdG8ga2ZyZWVfcmN1KCkgYmVsb3cgaGFzIHR3byBh
cmd1bWVudHMsIGFuZCA+dGh1cwo+cHJvdmlkZXMgYSBsaW5rIGZvciBxdWV1aW5nIHRoZSBjYWxs
YmFjay4gIEl0IHdpbGwgbmV2ZXIgZGlyZWN0bHkgaW52b2tlCj5zeW5jaHJvbml6ZV9yY3UoKS4g
IEl0IGlzIG9ubHkgdGhlIHNpbmdsZS1hcmd1bWVudCB2YXJpYW50IG9mID5rZnJlZV9yY3UoKQo+
dGhhdCBtaWdodCBpbnZva2Ugc3luY2hyb25pemVfcmN1KCkuCgpTb3JyeS4gSXQgd2FzIG15IG1p
c3Rha2UsIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaC4KClRoYW5rcwpRaWFuZwoKPk9yIGFyZSB5
b3Ugc2VlaW5nIGxvY2tkZXAgb3IgbWlnaHQtc2xlZXAgZmFpbHVyZXMgd2l0aCB0aGUgY3VycmVu
dCA+Y29kZT8KPklmIHNvLCBwbGVhc2UgcG9zdCB0aGUgcmVsZXZhbnQgcG9ydGlvbnMgb2YgdGhl
IGNvbnNvbGUgb3V0cHV0Lgo+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBUaGFueCwgUGF1bAo+Cj4gRml4ZXM6IDY5M2E4YjZlZWNjZSAoImlw
YyxyY3U6IENvbnZlcnQgY2FsbF9yY3UoZnJlZV91bikgdG8ga2ZyZWVfcmN1KCkiKQo+IFNpZ25l
ZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPiAtLS0KPiAgaXBj
L3NlbS5jIHwgOSArKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2lwYy9zZW0uYyBiL2lwYy9zZW0uYwo+IGlu
ZGV4IGY2YzMwYTg1ZGFkZi4uMTJjMzE4NDM0N2Q5IDEwMDY0NAo+IC0tLSBhL2lwYy9zZW0uYwo+
ICsrKyBiL2lwYy9zZW0uYwo+IEBAIC0xMTMyLDYgKzExMzIsMTMgQEAgc3RhdGljIGludCBjb3Vu
dF9zZW1jbnQoc3RydWN0IHNlbV9hcnJheSAqc21hLCB1c2hvcnQgc2VtbnVtLAo+ICAgICAgIHJl
dHVybiBzZW1jbnQ7Cj4gIH0KPgo+ICtzdGF0aWMgdm9pZCBmcmVlX3VuKHN0cnVjdCByY3VfaGVh
ZCAqaGVhZCkKPiArewo+ICsgICAgIHN0cnVjdCBzZW1fdW5kbyAqdW4gPSBjb250YWluZXJfb2Yo
aGVhZCwgc3RydWN0IHNlbV91bmRvLCByY3UpOwo+ICsKPiArICAgICBrZnJlZSh1bik7Cj4gK30K
PiArCj4gIC8qIEZyZWUgYSBzZW1hcGhvcmUgc2V0LiBmcmVlYXJ5KCkgaXMgY2FsbGVkIHdpdGgg
c2VtX2lkcy5yd3NlbSBsb2NrZWQKPiAgICogYXMgYSB3cml0ZXIgYW5kIHRoZSBzcGlubG9jayBm
b3IgdGhpcyBzZW1hcGhvcmUgc2V0IGhvbGQuIHNlbV9pZHMucndzZW0KPiAgICogcmVtYWlucyBs
b2NrZWQgb24gZXhpdC4KPiBAQCAtMTE1Miw3ICsxMTU5LDcgQEAgc3RhdGljIHZvaWQgZnJlZWFy
eShzdHJ1Y3QgaXBjX25hbWVzcGFjZSAqbnMsIHN0cnVjdCBrZXJuX2lwY19wZXJtICppcGNwKQo+
ICAgICAgICAgICAgICAgdW4tPnNlbWlkID0gLTE7Cj4gICAgICAgICAgICAgICBsaXN0X2RlbF9y
Y3UoJnVuLT5saXN0X3Byb2MpOwo+ICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJnVuLT51bHAt
PmxvY2spOwo+IC0gICAgICAgICAgICAga2ZyZWVfcmN1KHVuLCByY3UpOwo+ICsgICAgICAgICAg
ICAgY2FsbF9yY3UoJnVuLT5yY3UsIGZyZWVfdW4pOwo+ICAgICAgIH0KPgo+ICAgICAgIC8qIFdh
a2UgdXAgYWxsIHBlbmRpbmcgcHJvY2Vzc2VzIGFuZCBsZXQgdGhlbSBmYWlsIHdpdGggRUlEUk0u
ICovCj4gLS0KPiAyLjE3LjEKPgo=
