Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8280301E1F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbhAXS2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:28:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:22943 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbhAXS2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:28:35 -0500
IronPort-SDR: Xn1Wdv+dIqpWkroL4cIBQ3FVgexcsRfZqqC/4+48P/R0TnMSh2Ihl6i10Dyx5cv0PIOqxe5VVS
 upHRTS5GIAqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176118858"
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="176118858"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 10:27:53 -0800
IronPort-SDR: LzuAT22CE4Vt4lQS/ZMlswcd22BWBSp+VlQAnaywfpMWKouzXhfNG49d5Dkt9H/LwpK5B4IQIS
 Za1pwBUjc8bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="428894612"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2021 10:27:53 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 24 Jan 2021 10:27:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 24 Jan 2021 10:27:52 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 24 Jan 2021 10:27:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKmEq31PTi8DOo7w2mhyWneDR/e3AbF1rmJQsOfBVAeuKZTf89+5NHFla2QSqtgkzi8R6ex4FfJEpby82poUKAVeFrJ56G0AWjjpAEJIiUjNxxFmugRTov6kzntVMNLEGJkBc6sGCLsDwvHfKuVvNdNYGZJKk9Nw2mMrMQGrBnUHTRiFq7Ia6lfUyrjWl+w8QK2vIpZdrFKpNtMJ+zPgwIVpaoQq5o2ja7E0ANQhATU7I6ykireDPvgA21lJ670o8mCePiR35lEp/4FfEAkScIUPgiDSDrTsYkyS+9eYLsQiT7MZyrNp/+lDdxg8bwLNZPh/HjD8o5RcYnk00/DtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRnvMwZanQIrDi8s0X0+GZ4kf7PwUBiLG0BrQwQPUa0=;
 b=RWQ1eQ8SaprxZnIU9yylDuNiHJpthMBE/EVgb9UxHJBzZrkYlQSZndvhzm/kMSxKGdZwheqtw1BYjjtudPosXOr4yv+pYKgqq8Hl/FdQ+5zRlilXsO4ujaUkSMuDVmcoQEu8ap/vbv72Cfu5JAYmjbBOFztv4Oy7cIXjffI8Pi2DvXaHzqTz3C8D7wx/scXmntBLLzL0YCW2o8ZCnbpC0WtMRIaHIcFUNn0pF+sUI5kmAT7Xxs2Ssq+sgaZRW5rMeq4snG+bNB09cJWFZuJJtm8cPyslQYZ0w44uBC2v2SFT+LUAPXFaU/t/uvrxTxFx+FBLa6Jz0NcSmLNrSBdNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRnvMwZanQIrDi8s0X0+GZ4kf7PwUBiLG0BrQwQPUa0=;
 b=kKwtH4RxUMZ/6YBtm7BHg1WKR7NAT3zVO3WQ+PFwKyzmpy63hhcbbmXR3brAK1B4s3Lbr4S3NQsCPSzoSWIK/qejK3c+/DNFByuJ9S/YOWonhiPIAz+BoXdsem/sJvaZF56zEvgPqbiCxzQ2VvbXEfMCOo00gMVUoMH4gK2J3RA=
Received: from MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18)
 by MWHPR11MB1520.namprd11.prod.outlook.com (2603:10b6:301:b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Sun, 24 Jan
 2021 18:27:48 +0000
Received: from MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a]) by MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a%7]) with mapi id 15.20.3784.017; Sun, 24 Jan 2021
 18:27:48 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v2 08/34] misc: xlink-pcie: Add documentation for XLink
 PCIe driver
Thread-Topic: [PATCH v2 08/34] misc: xlink-pcie: Add documentation for XLink
 PCIe driver
Thread-Index: AQHW5gTlrLsYBjhAWEGzNhJgwXX0t6ovaK8AgAdZb3A=
Date:   Sun, 24 Jan 2021 18:27:47 +0000
Message-ID: <MWHPR11MB14063D4E9312923FF5F9DFB885BE9@MWHPR11MB1406.namprd11.prod.outlook.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-9-mgross@linux.intel.com>
 <0e68a2f9-f02d-c777-d9b8-b1ad13555ab3@infradead.org>
In-Reply-To: <0e68a2f9-f02d-c777-d9b8-b1ad13555ab3@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.167.96.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e08e2754-9471-4bcd-9eef-08d8c095c03f
x-ms-traffictypediagnostic: MWHPR11MB1520:
x-microsoft-antispam-prvs: <MWHPR11MB1520F24A8B916D8E6AD1B46B85BE9@MWHPR11MB1520.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fgXHAUvz0hywVJLGQVkbBwAuizRl1tboc0f3/ZOxQk2vOOIo5uFGlRlqoUbxqag4OmvZQJq0/ePTOpkCimISdZsfOaw+XPu55lXqpLga1JIh0yqUPUhfX3AZ/+NalZeQPmn5WXdVIjV4KULMvil0cWDuDkOk7Ht7jCePFDpJ8qPcbPTr7/fqPNpYdhp7dPbr3tx0RCdz0cCIvWVas04RvFWAM23u6mi8YzdrRLfECPKxHPlTgvTQFccFPVAch51UWCN8SGmgsqF9PYvA2kZJbMblSLfcDGvfSMaE3UmiWqB3/ROiUFtx2VLJ5yfwtGkVrjW/yLb7p/PcNWBEL+4vj3WeNxQrhNR7ugZ7rYT+PRGoErRJXK5sPt52RSOft2fgTRQLAQ7PH32kkTUs8K5gdX8GihBohxGkWrISEdc9pRtiF0j9J0NK/aPOmGaZ2Wcm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1406.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(53546011)(478600001)(6506007)(8676002)(83380400001)(55016002)(26005)(66946007)(4326008)(76116006)(316002)(54906003)(110136005)(86362001)(5660300002)(66476007)(64756008)(66446008)(66556008)(52536014)(9686003)(921005)(33656002)(71200400001)(2906002)(186003)(7416002)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ajRkNDFpRHgrYjRHNlBOVkhpWUY3ZC9vNXFNTjI4bnRTN0JndndwSUUrRWhj?=
 =?utf-8?B?Z1BPM29wZVY5emNkZTk3ZFlveFN5bXdMS1VHemt4MmE5dmtDRHAxbFB6eHhH?=
 =?utf-8?B?MGlzZElaL0hGS0h5Z3V3WTNaQ201aWJSYVpFbTFvZnNMQWdQVTZpRDVOYWpp?=
 =?utf-8?B?UFZLQld6ejNsQncveXYydnBQejAyUFFiUks1M3lrZXZsU1dzL3huc0JkRjlp?=
 =?utf-8?B?KzFnQkllTWU4MnpjZnpVdEdzOTlmT0JIQk5zdk92VHlLb3J3dTNPRHRZVXZn?=
 =?utf-8?B?MUg2UnVqWUlVNmU4ZEpsREQrVUdVZjlEMzQxL09lck1ONGFpUHR2TnFmbno5?=
 =?utf-8?B?ZzFvSEU5NXpnMjdRYklTUlhVelhsZlUvYjJKd0VxKzlDdmZvN3BwSDBDTkxy?=
 =?utf-8?B?d0JHZy80dWJMQzh1bWN4V0x5blFuVVJCeEhVWmxNS0xwckpkaHE3Z2U1aXk0?=
 =?utf-8?B?cytDR3VSTExyL0UvMWp6SFNTTWdlSG1tWFdrMlprZ0RQN0JwQzBHdTBRWmI1?=
 =?utf-8?B?LzZYZFJmR2kwR0hxZmwyTm42S2tBeVJoUXNySFFwdEhDY0U2UExTSFNRcjBU?=
 =?utf-8?B?SklCTVhoR0NqbnY3RE1LWnNNY3J4OXNlNWkzN1JGanJnM1lHL0ltcUtiaUhr?=
 =?utf-8?B?WlVVdUVhQ29ZMjQ3YTU2R055U2RWQ2ozVTV2RER6L3EwdmhzZ2Yxci95TUdM?=
 =?utf-8?B?c0t2SmFlNVBiemh3SmpoKzlpQXBJTEVwaTdIcWpNU1hHZ09Bc1Y4cWo3ZEl5?=
 =?utf-8?B?dEI3NUsrcCtOSlAxRU16U2pkSnJmalN4SHZXRlhBUWFPS1d6ajY1U1dEbGZM?=
 =?utf-8?B?RFE0NWp5WFNkb3hXaG1RaFprMFdReXJFVjlBOW1BbnV6K1htc3o4Uktwbm9y?=
 =?utf-8?B?VmVKNG10K2dOQ0ZoRnBsNFBqTlNvdzltZUlhdmRIQVpDdTU3Mi80WlhGWTZj?=
 =?utf-8?B?a1EzeEdtVlN2c3ErQVZ6RlZUVURncWZ3cVhwMzdUY2hhMnlIN0FMRWdlT3ky?=
 =?utf-8?B?YWVGSUZsSzVhbUYzRnJQZnpIV1ZQK1JLQ2NscC9MQ1Y3VzNCYUYxZTBXcGRa?=
 =?utf-8?B?T1RMWW05SEdyaGhSMmZOcys2RGs3VVJBUDk5ZFVhWjFhNlBKcERwWmFJSnhR?=
 =?utf-8?B?S2VnOUNZREE3ZlYzWkFnVkxGa0h6UTlCa25zREdlbEdkelQ5YWhKMC9nUDR2?=
 =?utf-8?B?eWhEL0s4ejdLVHdSWmxxSVFNcHFHZDNhdDB1MUt6dFF3ZEFJazEvVUtmUTFi?=
 =?utf-8?B?OTJxbjB0Ris0OXlvaG1PdUlRTkN5VFdySU94VzREQTZLdTlzbFEybG41V3Jk?=
 =?utf-8?Q?Owjko8m8BqAZU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1406.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e2754-9471-4bcd-9eef-08d8c095c03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2021 18:27:47.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IegNnBWXN3aNuKDT3n6zFgW8fW9423a0OZqZsRmfHhklg3xGEN6E1NnEtW/2OMcx9GAbDJE5AwByp+LDfOyiL3NqIrxIvY82Z8yWBO8sO1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1520
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9y
Zz4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDIwLCAyMDIxIDE6MDYgQU0NCj4gVG86IG1n
cm9zc0BsaW51eC5pbnRlbC5jb207IG1hcmtncm9zc0BrZXJuZWwub3JnOyBhcm5kQGFybmRiLmRl
Ow0KPiBicEBzdXNlLmRlOyBkYW1pZW4ubGVtb2FsQHdkYy5jb207IGRyYWdhbi5jdmV0aWNAeGls
aW54LmNvbTsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGNvcmJldEBsd24ubmV0OyBs
ZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbTsNCj4gcGFsbWVyZGFiYmVsdEBnb29nbGUuY29tOyBwYXVs
LndhbG1zbGV5QHNpZml2ZS5jb207IHBlbmcuZmFuQG54cC5jb207DQo+IHJvYmgrZHRAa2VybmVs
Lm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgamFzc2lzaW5naGJyYXJAZ21haWwuY29tDQo+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUaG9rYWxhLCBTcmlrYW50aA0KPiA8c3Jp
a2FudGgudGhva2FsYUBpbnRlbC5jb20+OyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDgvMzRdIG1pc2M6IHhsaW5rLXBjaWU6IEFkZCBkb2N1bWVu
dGF0aW9uIGZvcg0KPiBYTGluayBQQ0llIGRyaXZlcg0KPiANCj4gSGksDQo+IEhlcmUgYXJlIGEg
ZmV3IGRvYyBjb21tZW50cyBmb3IgeW91Og0KPiANCj4gT24gMS84LzIxIDE6MjUgUE0sIG1ncm9z
c0BsaW51eC5pbnRlbC5jb20gd3JvdGU6DQo+ID4gRnJvbTogU3Jpa2FudGggVGhva2FsYSA8c3Jp
a2FudGgudGhva2FsYUBpbnRlbC5jb20+DQo+ID4NCj4gPiBQcm92aWRlIG92ZXJ2aWV3IG9mIFhM
aW5rIFBDSWUgZHJpdmVyIGltcGxlbWVudGF0aW9uDQo+ID4NCj4gPiBDYzogSm9uYXRoYW4gQ29y
YmV0IDxjb3JiZXRAbHduLm5ldD4NCj4gPiBDYzogbGludXgtZG9jQHZnZXIua2VybmVsLm9yZw0K
PiA+IFJldmlld2VkLWJ5OiBNYXJrIEdyb3NzIDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNyaWthbnRoIFRob2thbGEgPHNyaWthbnRoLnRob2thbGFAaW50ZWwu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL3ZwdS9pbmRleC5yc3QgICAgICB8ICAx
ICsNCj4gPiAgRG9jdW1lbnRhdGlvbi92cHUveGxpbmstcGNpZS5yc3QgfCA5MCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlv
bnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdnB1L3hsaW5rLXBj
aWUucnN0DQo+ID4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdnB1L3hsaW5r
LXBjaWUucnN0IGIvRG9jdW1lbnRhdGlvbi92cHUveGxpbmstDQo+IHBjaWUucnN0DQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjJkODc3Yzk2NmIxZQ0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL3ZwdS94bGluay1wY2ll
LnJzdA0KPiA+IEBAIC0wLDAgKzEsOTAgQEANCj4gPiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjANCj4gPiArDQo+ID4gKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQo+ID4gK0tlcm5lbCBkcml2ZXI6IFhsaW5rLXBjaWUgZHJpdmVyDQo+ID4gKz09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+ID4gK1N1cHBvcnRlZCBjaGlwczoNCj4gPiArICAqIElu
dGVsIEVkZ2UuQUkgQ29tcHV0ZXIgVmlzaW9uIHBsYXRmb3JtczogS2VlbSBCYXkNCj4gPiArICAg
IFN1ZmZpeDogQmF5DQo+ID4gKyAgICBTbGF2ZSBhZGRyZXNzOiA2MjQwDQo+ID4gKyAgICBEYXRh
c2hlZXQ6IFB1YmxpY2x5IGF2YWlsYWJsZSBhdCBJbnRlbA0KPiA+ICsNCj4gPiArQXV0aG9yOiBT
cmlrYW50aCBUaG9rYWxhIFNyaWthbnRoLlRob2thbGFAaW50ZWwuY29tDQo+ID4gKw0KPiA+ICtJ
bnRyb2R1Y3Rpb24NCj4gPiArPT09PT09PT09PT09DQo+ID4gK1RoZSBYbGluay1wY2llIGRyaXZl
ciBwcm92aWRlcyB0cmFuc3BvcnQgbGF5ZXIgaW1wbGVtZW50YXRpb24gZm9yDQo+ID4gK3RoZSBk
YXRhIHRyYW5zZmVycyB0byBzdXBwb3J0IFhsaW5rIHByb3RvY29sIHN1YnN5c3RlbSBjb21tdW5p
Y2F0aW9uDQo+IHdpdGggdGhlDQo+ID4gK3BlZXIgZGV2aWNlLiBpLmUsIGJldHdlZW4gcmVtb3Rl
IGhvc3Qgc3lzdGVtIGFuZCBLZWVtIEJheSBkZXZpY2UuDQo+IA0KPiAgICAgICAgIGRldmljZSwg
aS5lLiwNCg0KT2suDQoNCj4gDQo+ID4gKw0KPiA+ICtUaGUgS2VlbSBCYXkgZGV2aWNlIGlzIGFu
IEFSTS1iYXNlZCBTT0MgdGhhdCBpbmNsdWRlcyBhIHZpc2lvbg0KPiBwcm9jZXNzaW5nDQo+ID4g
K3VuaXQgKFZQVSkgYW5kIGRlZXAgbGVhcm5pbmcsIG5ldXJhbCBuZXR3b3JrIGNvcmUgaW4gdGhl
IGhhcmR3YXJlLg0KPiA+ICtUaGUgWGxpbmstcGNpZSBkcml2ZXIgZXhwb3J0cyBhIGZ1bmN0aW9u
YWwgZGV2aWNlIGVuZHBvaW50IHRvIHRoZSBLZWVtDQo+IEJheQ0KPiA+ICtkZXZpY2UgYW5kIHN1
cHBvcnRzIHR3by13YXkgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSBwZWVyIGRldmljZS4NCj4gPiAr
DQo+ID4gK0hpZ2gtbGV2ZWwgYXJjaGl0ZWN0dXJlDQo+ID4gKz09PT09PT09PT09PT09PT09PT09
PT09DQo+ID4gK1JlbW90ZSBIb3N0OiBJQSBDUFUNCj4gPiArTG9jYWwgSG9zdDogQVJNIENQVSAo
S2VlbSBCYXkpOjoNCj4gPiArDQo+ID4gKyAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0rDQo+
ID4gKyAgICAgICAgfCAgUmVtb3RlIEhvc3QgSUEgQ1BVICAgICAgICAgICAgICB8IHwgTG9jYWwg
SG9zdCBBUk0gQ1BVIChLZWVtDQo+IEJheSkgfCAgIHwNCj4gPiArDQo+ICs9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Kz0rPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSs9
PT0rDQo+ID4gKyAgICAgICAgfCAgVXNlciBBcHAgICAgICAgICAgICAgICAgICAgICAgICB8IHwg
VXNlciBBcHANCj4gfCAgIHwNCj4gPiArICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSstKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tKy0tLSsNCj4g
PiArICAgICAgICB8ICAgWExpbmsgVUFQSSAgICAgICAgICAgICAgICAgICAgIHwgfCBYTGluayBV
QVBJDQo+IHwgICB8DQo+ID4gKyAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0rLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLSstLS0rDQo+ID4gKyAg
ICAgICAgfCAgIFhMaW5rIENvcmUgICAgICAgICAgICAgICAgICAgICB8IHwgWExpbmsgQ29yZQ0K
PiB8ICAgfA0KPiA+ICsgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Ky0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0rLS0tKw0KPiA+ICsgICAgICAg
IHwgICBYTGluayBQQ0llICAgICAgICAgICAgICAgICAgICAgfCB8IFhMaW5rIFBDSWUNCj4gfCAg
IHwNCj4gPiArICAgICAgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tKy0tLSsNCj4gPiArICAgICAgICB8ICAg
WExpbmstUENJZSBSZW1vdGUgSG9zdCBkcml2ZXIgIHwgfCBYTGluay1QQ0llIExvY2FsIEhvc3QN
Cj4gZHJpdmVyICB8ICAgfA0KPiA+ICsgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKy0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0rLS0tKw0KPiA+
ICsgICAgICAgIHwtOi06LTotOi06LTotOi06LTotOi06LTotOi06LTotOi06fDp8Oi06LTotOi06
LTotOi06LTotOi06LTotDQo+IDotOi06LTotOi06fA0KPiA+ICsgICAgICAgICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAt
LS0tLS0rLS0tKw0KPiA+ICsgICAgICAgIHwgICAgIFBDSWUgSG9zdCBDb250cm9sbGVyICAgICAg
ICAgfCB8IFBDSWUgRGV2aWNlIENvbnRyb2xsZXINCj4gfCBIV3wNCj4gPiArICAgICAgICArLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gLS0tLS0tKy0tLSsNCj4gPiArICAgICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gPiArICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiArICAgICAgICAg
ICAgICAgfC0tLS0tLS0tLS0tLS0gUENJZSB4MiBMaW5rICAtLS0tLS0tLS0tLS0tLS0tLXwNCj4g
PiArDQo+ID4gK1RoaXMgWExpbmsgUENJZSBkcml2ZXIgY29tcHJpc2VzIG9mIHR3byB2YXJpYW50
czoNCj4gPiArKiBMb2NhbCBIb3N0IGRyaXZlcg0KPiA+ICsNCj4gPiArICAqIEludGVuZGVkIGZv
ciBBUk0gQ1BVDQo+ID4gKyAgKiBJdCBpcyBiYXNlZCBvbiBQQ0kgRW5kcG9pbnQgRnJhbWV3b3Jr
DQo+ID4gKyAgKiBEcml2ZXIgcGF0aDoge3RyZWV9L2RyaXZlcnMvbWlzYy9YbGluay1wY2llL2xv
Y2FsX2hvc3QNCj4gPiArDQo+ID4gKyogUmVtb3RlIEhvc3QgZHJpdmVyDQo+ID4gKw0KPiA+ICsg
ICAgICAgKiBJbnRlbmRlZCBmb3IgSUEgQ1BVDQo+ID4gKyAgICAgICAqIEl0IGlzIGEgUENJZSBl
bmRwb2ludCBkcml2ZXINCj4gPiArICAgICAgICogRHJpdmVyIHBhdGg6IHt0cmVlfS9kcml2ZXJz
L21pc2MvWGxpbmstcGNpZS9yZW1vdGVfaG9zdA0KPiA+ICsNCj4gPiArWExpbmsgUENJZSBjb21t
dW5pY2F0aW9uIGJldHdlZW4gbG9jYWwgaG9zdCBhbmQgcmVtb3RlIGhvc3QgaXMgYWNoaWV2ZWQN
Cj4gdGhyb3VnaA0KPiA+ICtyaW5nIGJ1ZmZlciBtYW5hZ2VtZW50IGFuZCBNU0kvRG9vcmJlbGwg
aW50ZXJydXB0cy4NCj4gPiArDQo+ID4gK1RoZSBYbGluay1wY2llIGRyaXZlciBzdWJzeXN0ZW0g
cmVnaXN0ZXJzIHRoZSBLZWVtIEJheSBkZXZpY2UgYXMgYW4NCj4gZW5kcG9pbnQNCj4gPiArZHJp
dmVyIGFuZCBwcm92aWRlcyBzdGFuZGFyZCBsaW51eCBQQ0llIHN5c2ZzIGludGVyZmFjZSwgIw0K
PiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBMaW51eA0KDQpPay4NCg0KPiBX
aGF0IGlzIHRoZSAnIycgc2lnbiBmb3IgYWJvdmU/DQoNCkl0IGRlbm90ZXMgTGludXggcHJvbXB0
OyBJIHdpbGwgY2hhbmdlIGl0IHRvIGJlIG1vcmUgbWVhbmluZ2Z1bC4NCg0KVGhhbmtzIQ0KU3Jp
a2FudGgNCg0KPiANCj4gPiArL3N5cy9idXMvcGNpL2RldmljZXMveHh4eDp4eDp4eC4wLw0KPiA+
ICsNCj4gPiArDQo+ID4gK1hMaW5rIHByb3RvY29sIHN1YnN5c3RlbQ0KPiA+ICs9PT09PT09PT09
PT09PT09PT09PT09PT0NCj4gPiArWGxpbmsgaXMgYW4gYWJzdHJhY3RlZCBjb250cm9sIGFuZCBj
b21tdW5pY2F0aW9uIHN1YnN5c3RlbSBiYXNlZCBvbg0KPiBjaGFubmVsDQo+ID4gK2lkZW50aWZp
Y2F0aW9uLiBJdCBpcyBpbnRlbmRlZCB0byBzdXBwb3J0IFZQVSB0ZWNobm9sb2d5IGJvdGggYXQg
U29DDQo+IGxldmVsIGFzDQo+ID4gK3dlbGwgYXMgYXQgSVAgbGV2ZWwsIG92ZXIgbXVsdGlwbGUg
aW50ZXJmYWNlcy4NCj4gPiArDQo+ID4gKy0gVGhlIFhsaW5rIHN1YnN5c3RlbSBhYnN0cmFjdHMg
c2V2ZXJhbCB0eXBlcyBvZiBjb21tdW5pY2F0aW9uIGNoYW5uZWxzDQo+ID4gKyAgdW5kZXJuZWF0
aCwgYWxsb3dpbmcgdGhlIHVzYWdlIG9mIGRpZmZlcmVudCBpbnRlcmZhY2VzIHdpdGggdGhlDQo+
ID4gKyAgc2FtZSBmdW5jdGlvbiBjYWxsIGludGVyZmFjZS4NCj4gPiArLSBUaGUgQ29tbXVuaWNh
dGlvbiBjaGFubmVscyBhcmUgZnVsbC1kdXBsZXggcHJvdG9jb2wgY2hhbm5lbHMgYWxsb3dpbmcN
Cj4gPiArICBjb25jdXJyZW50IGJpZGlyZWN0aW9uYWwgY29tbXVuaWNhdGlvbi4NCj4gPiArLSBU
aGUgWGxpbmsgc3Vic3lzdGVtIGFsc28gc3VwcG9ydHMgY29udHJvbCBvcGVyYXRpb25zIHRvIFZQ
VSBlaXRoZXINCj4gPiArICBmcm9tIHN0YW5kYWxvbmUgbG9jYWwgc3lzdGVtIG9yIGZyb20gcmVt
b3RlIHN5c3RlbSBiYXNlZCBvbg0KPiBjb21tdW5pY2F0aW9uDQo+ID4gKyAgaW50ZXJmYWNlIHVu
ZGVybmVhdGguDQo+ID4gKy0gVGhlIFhsaW5rIHN1YnN5c3RlbSBzdXBwb3J0cyB0aGUgZm9sbG93
aW5nIGNvbW11bmljYXRpb24gaW50ZXJmYWNlczoNCj4gPiArICAgICogVVNCIENEQw0KPiA+ICsg
ICAgKiBHaWdhYml0IEV0aGVybmV0DQo+ID4gKyAgICAqIFBDSWUNCj4gPiArICAgICogSVBDDQo+
ID4NCj4gDQo+IA0KPiAtLQ0KPiB+UmFuZHkNCj4gIkhlIGNsb3NlcyBoaXMgZXllcyBhbmQgZHJv
cHMgdGhlIGdvZ2dsZXMuICBZb3UgY2FuJ3QgZ2V0IGh1cnQNCj4gYnkgbG9va2luZyBhdCBhIGJp
dG1hcC4gIE9yIGNhbiB5b3U/Ig0KPiAoTmVhbCBTdGVwaGVuc29uOiBTbm93IENyYXNoKQ0K
