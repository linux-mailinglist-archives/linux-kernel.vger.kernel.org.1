Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC03040DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405978AbhAZOtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:49:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:57726 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391453AbhAZOsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:48:08 -0500
IronPort-SDR: sg+eNhsF6g3R9iSOLH+4Xzm2cYBnvMDAa6/SYqjxHmeI1rNrP8tjjNMS47NMqZi54A1eNfJvq/
 1YqUxgRXEmKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179989953"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="179989953"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 06:47:18 -0800
IronPort-SDR: EB4OZYQkdO95OjnqJPUPt+ydhBARr4S7iJjtqxuSlGLMbGNvWdDoekyubCRHJ1hkY2j3tw5kER
 XFr49w0w70PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="393754808"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 26 Jan 2021 06:47:18 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 06:47:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 26 Jan 2021 06:47:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 26 Jan 2021 06:47:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNpxgiYs1ccsUd4T+fpIz5DG1F8KI6VgWHjexJMci1Z7wMk7hkV/prLO8Btci+4pYkJP/y9cvUJQh8tu8TbNjM3RatiJX1dz1zpET78hi+SozVcNPLE2WCwgu4ZQ79YYpddu3aUPvH3r9PsTiRhIvCjfAd5FzfEvjC80he86NXKVeLZleakO5R/ESKEKFNgy4WyM5cHrVUKkLNMvl2ogLQYyo1wSne5tByuQpFh/agRpWpUJdOm5iXtKyFEG0KusWt011ArGMdr/Lf2AZvoUS1e3mcDuKkx2ZshR5vdkQwp+FIDCAMy4CUxni3qfygnXAlwKT4IZLXCejM56T0UMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgF4NeHWm45TYiHftdoOStanld0iCRLwTC/THFi0rm4=;
 b=O9J6xle+mcGajEaI9c8kTdarRwSwiTVUymmlx0B1Ff7ZhTQxoFdUBwGoc031J6KdwUAFoFAWf7TpNnkyc5MX6+WDfIK2B+NyvATex1ueujDTksNLWLBw2PTnEv+WdnR+eePPHjDbNZPpRS8dBbBEDJbnXBLtnDFAbGDEm4+VYI8/jEtTBAsTWbkXBzq9RasjjPrDk6BQloZpB0010ExLEcfE0hIIURWPpoVUFItcDpr6DBdQaKsjqM+RbRAaxx9GpvwKvmTvz/nUIbLROdHb7f/oIeQR8Yobk6dcThgdl1I8d2VluCfGDrqSfCKHaaMoo2g9DYUSu9PKnj3vd1pHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgF4NeHWm45TYiHftdoOStanld0iCRLwTC/THFi0rm4=;
 b=OYaQXzVlRvYBFIARwGGoMC9w/+7o9RApL1i/zOdNd6afAGBsvuqtKo3UkagNSojdLHrjhHEkzsgOvzZm9yeF9SnoiNWFkaIe2jjPVIYorE3lhiw3hHAMtA/N1VgyX36rlYENduqRzDxKkKVlarqTvMELAqe0OYjQ4K8z4PypSNk=
Received: from MWHPR11MB1679.namprd11.prod.outlook.com (2603:10b6:301:f::12)
 by MWHPR1101MB2144.namprd11.prod.outlook.com (2603:10b6:301:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 14:47:15 +0000
Received: from MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c47e:d3c8:2a2f:8647]) by MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c47e:d3c8:2a2f:8647%10]) with mapi id 15.20.3784.017; Tue, 26 Jan
 2021 14:47:15 +0000
From:   "Gross, Mark" <mark.gross@intel.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Gross <mgross@linux.intel.com>
CC:     "markgross@kernel.org" <markgross@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
Subject: RE: [PATCH v3 02/34] dt-bindings: mailbox: Add Intel VPU IPC mailbox
 bindings
Thread-Topic: [PATCH v3 02/34] dt-bindings: mailbox: Add Intel VPU IPC mailbox
 bindings
Thread-Index: AQHW86XRg/AgdxWt4kK+TpTUV1HJvqo564IAgAAQ7uA=
Date:   Tue, 26 Jan 2021 14:47:15 +0000
Message-ID: <MWHPR11MB16792D061568C6FA30FA9B908EBC9@MWHPR11MB1679.namprd11.prod.outlook.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
 <20210126054036.61587-3-mgross@linux.intel.com>
 <CAL_Jsq+h9gaZuqKRyh2UqRq5FvBGEoeBLn=xF+K8Zu8Cn9norQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+h9gaZuqKRyh2UqRq5FvBGEoeBLn=xF+K8Zu8Cn9norQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.53.49.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc6bc818-88a3-4b4d-4789-08d8c2094613
x-ms-traffictypediagnostic: MWHPR1101MB2144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21444493768A087920AA5D248EBC9@MWHPR1101MB2144.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z16K8Gf6TUhasUrYLSaZ0qd7Oz6w/Mi2PqSBtkhXBRYy2K1avHSCQi7qgKSI+rkQl3uSn4eB9rd0DYCG1apEoCwkUUSyCtr3KIsBgcRabnAWZp8RoCNhxNZqnu6wI9Qs/NfbsdoiKYE4qtzJMVju7t1LJg7vcbglqLs1STdnj/STYEB55AHRatAOrKTbzqRdTKVWuPCRrfpI+BLMPbAULPI4QFDiDY3JJcMSCYlqRWaeobmW3iwO3IyiaTPivRnHmj8ottJ8RCQhrIxJ5apnv95Cjn0sz4spE1bS8RnkNMCUn81QfUseUZb8rg1kmRD3At72AhgYa8nqVmi8XKgth2c5/XhrFGlsOM+QIGhlLjtya3lTHmkk/mMbLugSRYVobwkJDXWZ1mRHjmPu/LACRNc+EFrHvVZEUBtWPIotltZKn0mSdGZqjk2AjbfbCSILj60fRChJrSaTJ8MncpYbH0k+1NzvVCoP9DOKXVvJUqKOI1hE3pmOMwHs5QUB5uC4e9a4L/P5TBhU2j3Tts+vjFbs4v45LhfdzMi/0M4sJDCZ5NbALeUMJhJl0iFUtw1OWkat/MWNCv6Ryl6BhedThWuUfePFGsLjlRIIbrcIx3Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1679.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(83380400001)(53546011)(8936002)(86362001)(7416002)(52536014)(33656002)(316002)(8676002)(5660300002)(6506007)(478600001)(110136005)(71200400001)(7696005)(2906002)(54906003)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(26005)(4326008)(55016002)(9686003)(186003)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MU9oV2YzN1lUdHVKS2RLVWtwQXVNeVVRSGdraHpDNWp3dXBaa1dSRmNwR1R6?=
 =?utf-8?B?d2o0RHk1bXJUZ2dYYTA0K3dvWGdBS2NRMWt6bTRXMzMyNE1NN3dVL3lpMCtP?=
 =?utf-8?B?czJZODhWNWxLbDZ6OE13ZXFKbnpUckR5UUZ4WFJzZEdOM0ZwYk5HVndKQTdx?=
 =?utf-8?B?eG1LVzhhK29VTVdXeFoycUdpZmpuTEpKQlFXamZtclU1UWhUL3VNNlNyR1Iv?=
 =?utf-8?B?V3N1T0YrWWFkU0FKbFlCeisxZWNhdElwdFVhOU96Q2MwQ0FYOGJVUFM1RFFF?=
 =?utf-8?B?Q2R0bkZmMjFVRms2UHl1SkhYbUhUbGVCQjkzSHdCVTlkb1YwY3hyOWNTSXBV?=
 =?utf-8?B?SWxPdGpCbGg2eTlqUW5qOVp2TEYrUXhtdGdpMjU1V21FOUdRZHhubnpLYTk5?=
 =?utf-8?B?d2pJbk5saXJMWmo5UFZpR1JpVHRjYjM4VGxTTlNaemUzU0VuNDRHK1dDb0d3?=
 =?utf-8?B?cS9kQW4xaG9HSXg0VWF4R3NHd0xiT0dja1FSRjBidms1aStNN3F4bm1Fclov?=
 =?utf-8?B?UXZVNE4wWm5xNHl1a3lxWTJrRHIrd3YrM1lQRUZPMXFCb2R6UDlERXhGZFhI?=
 =?utf-8?B?VVB3eDRyb3N3OW5FK1pxOGV5SUhzOW5yTUllZGZFUXY4V3N0dUMyMGhCbSt3?=
 =?utf-8?B?bzZkZFp2dWVZMFJhZlNsY0NhMzByMUtNMlMzR2xqOTVDL0xueXE4SnV5elBh?=
 =?utf-8?B?VXhzdEpRWGFyeE1ReENmYW5jbzllTU1FdVNIVkZ6ajZQNEFKT0pCczhGTkZO?=
 =?utf-8?B?RzdBZ2xCSVJ3T0xweXhRVVQySktpYy9QWjVDeXBSY0tUU2s2UHNIUG1jWENR?=
 =?utf-8?B?Z0U4bTNmQUhEUWN0a3MycE5RVEV6TXVDbk5CL2F1eStocnRIWkI1bUFiZ2VL?=
 =?utf-8?B?ZW1abUlNdTV6QlJvWHc0SVJlOE1SV1g3SHBEVGY4TUsvazZ1YjUxL1JRcUMv?=
 =?utf-8?B?UUJKZTF4OUJpdDRqN08zMStTQkp6K3d3bU1JcCtPN0Mva2U1NUtieGduaG5T?=
 =?utf-8?B?VVJxL0VqTkwzZGxQYnNRb1huSlordzQzaC9uWlRsOUhEOURpNTZJSFdvNGQy?=
 =?utf-8?B?QWRqT1VVZ3VaVkdKbHZsRmJEcXJnaWFtVkFTcVQ5OEQ0R3pRSE9FUEVhWjdv?=
 =?utf-8?B?SkpkdWVwUDNGeGJudnNKQzVpZkxUbFgwcXN4a0lxMU4zM0FxNWM1ZGQyNGxs?=
 =?utf-8?B?SEl5ZzBXYmprQ2d5Q1Z1TkxxNlJDd0FJbU0yQXJJcStzUHIyRW1LKzZLOHJC?=
 =?utf-8?B?UmZRTHNqOUh4RDlzS3l2eVYyZDhwZEFHd09RRTdkR2xOTlMyVFo4eWtjWW8r?=
 =?utf-8?B?K0VlajlSdERwczcxQSs1RzQ0OWNpSXpVZy9QNHoxL210Ukd5K21TbnBBM2Vn?=
 =?utf-8?B?ejhYS2R3MUk1eE5zWUk5eEM2OEgvWU9PM0tpREo5NDZpR2NLQkNhMm5sQ2lH?=
 =?utf-8?Q?dvmVzSRQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1679.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6bc818-88a3-4b4d-4789-08d8c2094613
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 14:47:15.7698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7UrNh25xmSqWUfLw5dcSd6cKSN2WMkCPQ4qBDoFtdfrSSEbqsWo3FnmWqrTWCFgbqnMx95vIdkFb7hhD9b2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2144
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAyNiwgMjAyMSA1OjQ1
IEFNDQo+IFRvOiBNYXJrIEdyb3NzIDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPg0KPiBDYzogbWFy
a2dyb3NzQGtlcm5lbC5vcmc7IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBCb3Jpc2xh
diBQZXRrb3YNCj4gPGJwQHN1c2UuZGU+OyBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEB3
ZGMuY29tPjsgRHJhZ2FuIEN2ZXRpYw0KPiA8ZHJhZ2FuLmN2ZXRpY0B4aWxpbnguY29tPjsgR3Jl
ZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IEpvbmF0aGFu
IENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBQYWxtZXINCj4gRGFiYmVsdCA8cGFsbWVyZGFiYmVs
dEBnb29nbGUuY29tPjsgUGF1bCBXYWxtc2xleQ0KPiA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29t
PjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtl
cm5lbC5vcmc+OyBKYXNzaSBCcmFyIDxqYXNzaXNpbmdoYnJhckBnbWFpbC5jb20+OyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgQWxlc3NhbmRyZWxsaSwgRGFuaWVsZQ0KPiA8ZGFu
aWVsZS5hbGVzc2FuZHJlbGxpQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAw
Mi8zNF0gZHQtYmluZGluZ3M6IG1haWxib3g6IEFkZCBJbnRlbCBWUFUgSVBDIG1haWxib3gNCj4g
YmluZGluZ3MNCj4gDQo+IE9uIE1vbiwgSmFuIDI1LCAyMDIxIGF0IDExOjQwIFBNIDxtZ3Jvc3NA
bGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERhbmllbGUgQWxlc3NhbmRy
ZWxsaSA8ZGFuaWVsZS5hbGVzc2FuZHJlbGxpQGludGVsLmNvbT4NCj4gPg0KPiA+IEFkZCBiaW5k
aW5ncyBmb3IgdGhlIEludGVsIFZQVSBJUEMgbWFpbGJveCBkcml2ZXIuDQo+IA0KPiBTaWdoLiBE
VCBsaXN0IHBsZWFzZSBzbyBpdCdzIGluIG15IHF1ZXVlIGFuZCBhdXRvbWF0ZWQgY2hlY2tzIHJ1
bi4NCkknbSBzb3JyeSBhYm91dCB0aGF0LiAgDQpRdWljayBxdWVzdGlvbiwgc2hvdWxkIEkgaW5j
bHVkZSB0aGUgRFQtbGlzdCBvbiBqdXN0IHRoZSBwYXRjaGVzIHdpdGggRFQgeWFtbCBvciBhbGwg
b2YgdGhlIHNlcmllcyBhcyBpdHMgZ290IERUIGNvbnRlbnQ/DQoNCi0tbWFyaw0KDQoNCj4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsZSBBbGVzc2FuZHJlbGxpIDxkYW5pZWxlLmFsZXNzYW5k
cmVsbGlAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vbWFpbGJveC9pbnRlbCx2cHUtaXBj
LW1haWxib3gueWFtbCAgICAgICAgfCA2OSArKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5U
QUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQN
Cj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9pbnRlbCx2cHUt
aXBjLW1haWxib3gueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvaW50ZWwsdnB1LWlwYy1tYWlsYm94LnlhbWwN
Cj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2ludGVsLHZw
dS1pcGMtbWFpbGJveC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLjkyM2E2ZDYxOWE2NA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9pbnRlbCx2cHUtaXBjLW1h
aWxib3guDQo+ID4gKysrIHlhbWwNCj4gPiBAQCAtMCwwICsxLDY5IEBADQo+ID4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAjIENvcHly
aWdodA0KPiA+ICsoYykgMjAyMCBJbnRlbCBDb3Jwb3JhdGlvbiAlWUFNTCAxLjINCj4gPiArLS0t
DQo+ID4gKyRpZDogImh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21haWxib3gvaW50ZWws
dnB1LWlwYy1tYWlsYm94LnlhbWwjIg0KPiA+ICskc2NoZW1hOiAiaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjIg0KPiA+ICsNCj4gPiArdGl0bGU6IEludGVsIFZQ
VSBJUEMgbWFpbGJveA0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBEYW5pZWxl
IEFsZXNzYW5kcmVsbGkgPGRhbmllbGUuYWxlc3NhbmRyZWxsaUBpbnRlbC5jb20+DQo+ID4gKw0K
PiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIEludGVsIFZQVSBTb0NzIGxpa2UgS2VlbSBCYXkg
aGF2ZSBoYXJkd2FyZSBGSUZPcyB0byBlbmFibGUNCj4gPiArSW50ZXItUHJvY2Vzc29yDQo+ID4g
KyAgQ29tbXVuaWNhdGlvbiAoSVBDKSBiZXR3ZWVuIHRoZSBDUFUgYW5kIHRoZSBWUFUuDQo+ID4g
Kw0KPiA+ICsgIFNwZWNpZmljYWxseSwgdGhlcmUgaXMgb25lIEhXIEZJRk8gZm9yIHRoZSBDUFUg
KGFrYSBBcHBsaWNhdGlvbg0KPiA+ICsgUHJvY2Vzc29yIC0NCj4gPiArICBBUCkgYW5kIG9uZSBm
b3IgdGhlIFZQVS4gRWFjaCBGSUZPIGNhbiBob2xkIDEyOCBlbnRyaWVzIG9mIDMyIGJpdHMNCj4g
PiArIGVhY2guIEEgICJGSUZPLW5vdC1lbXB0eSIgaW50ZXJydXB0IGlzIHJhaXNlZCBldmVyeSB0
aW1lIHRoZXJlIGlzIGF0DQo+ID4gKyBsZWFzdCBhIG1lc3NhZ2UgIGluIHRoZSBGSUZPLiBUaGUg
Q1BVIEZJRk8gcmFpc2VzIGludGVycnVwdHMgdG8gdGhlDQo+ID4gKyBDUFUsIHdoaWxlIHRoZSBW
UFUgRklGTyAgcmFpc2VzIGludGVycnVwdHMgdG8gVlBVLiBXaGVuIHRoZSBDUFUNCj4gPiArIHdh
bnRzIHRvIHNlbmQgYSBtZXNzYWdlIHRvIHRoZSBWUFUgaXQgIHdyaXRlcyB0byB0aGUgVlBVIEZJ
Rk8sDQo+ID4gKyBzaW1pbGFybHksIHdoZW4gdGhlIFZQVSB3YW50IHRvIHNlbmQgYSBtZXNzYWdl
IHRvIHRoZSAgQ1BVLCBpdCB3cml0ZXMgdG8gdGhlDQo+IENQVSBGSUZPLg0KPiA+ICsNCj4gPiAr
ICBSZWZlciB0byAuL21haWxib3gudHh0IGZvciBnZW5lcmljIGluZm9ybWF0aW9uIGFib3V0IG1h
aWxib3gNCj4gPiArIGRldmljZS10cmVlICBiaW5kaW5ncy4NCj4gPiArDQo+ID4gK3Byb3BlcnRp
ZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiBpbnRlbCx2cHUtaXBjLW1h
aWxib3gNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0g
ZGVzY3JpcHRpb246IFRoZSBDUFUgRklGTyByZWdpc3RlcnMNCj4gPiArICAgICAgLSBkZXNjcmlw
dGlvbjogVGhlIFZQVSBGSUZPIHJlZ2lzdGVycw0KPiA+ICsNCj4gPiArICByZWctbmFtZXM6DQo+
ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogY3B1X2ZpZm8NCj4gPiArICAgICAg
LSBjb25zdDogdnB1X2ZpZm8NCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0czoNCj4gPiArICAgIGl0
ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBDUFUgRklGTy1ub3QtZW1wdHkgaW50ZXJy
dXB0DQo+ID4gKw0KPiA+ICsgICIjbWJveC1jZWxscyI6DQo+ID4gKyAgICBjb25zdDogMQ0KPiA+
ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4g
PiArICAtIHJlZy1uYW1lcw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+ICsgIC0gIiNtYm94LWNl
bGxzIg0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+
ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICB2cHVfaXBjX21haWxi
b3hAMjAzMzAwZjAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiaW50ZWwsdnB1LWlwYy1t
YWlsYm94IjsNCj4gPiArICAgICAgICAjbWJveC1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICBy
ZWcgPSA8MHgyMDMzMDBmMCAweDMxMD4sDQo+ID4gKyAgICAgICAgICAgICAgPDB4MjA4MjAwZjAg
MHgzMTA+Ow0KPiA+ICsgICAgICAgIHJlZy1uYW1lcyA9ICJjcHVfZmlmbyIsICJ2cHVfZmlmbyI7
DQo+ID4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEyIElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPiA+ICsgICAgfTsNCj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJ
TkVSUyBpbmRleA0KPiA+IDk5MmZlM2IwOTAwYS4uMmI4MjUyNmEwMGRjIDEwMDY0NA0KPiA+IC0t
LSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAtOTE4MSw2ICs5
MTgxLDEyIEBAIEw6ICAgICAgIHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnDQo+
ID4gIFM6ICAgICBNYWludGFpbmVkDQo+ID4gIEY6ICAgICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbC12YnRuLmMNCj4gPg0KPiA+ICtJTlRFTCBWUFUgSVBDIE1BSUxCT1gNCj4gPiArTTogICAg
IERhbmllbGUgQWxlc3NhbmRyZWxsaSA8ZGFuaWVsZS5hbGVzc2FuZHJlbGxpQGludGVsLmNvbT4N
Cj4gPiArTTogICAgIE1hcmsgR3Jvc3MgPG1ncm9zc0BsaW51eC5pbnRlbC5jb20+DQo+ID4gK1M6
ICAgICBTdXBwb3J0ZWQNCj4gPiArRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tYWlsYm94L2ludGVsLHZwdS1pcGMtbWFpbGJveC55YW1sDQo+ID4gKw0KPiA+ICBJTlRF
TCBXSVJFTEVTUyAzOTQ1QUJHL0JHLCA0OTY1QUdOIChpd2xlZ2FjeSkNCj4gPiAgTTogICAgIFN0
YW5pc2xhdyBHcnVzemthIDxzdGZfeGxAd3AucGw+DQo+ID4gIEw6ICAgICBsaW51eC13aXJlbGVz
c0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
