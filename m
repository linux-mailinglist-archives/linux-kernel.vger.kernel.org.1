Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB12FAE86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 02:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404485AbhASB4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 20:56:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:64315 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbhASBz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 20:55:58 -0500
IronPort-SDR: 2FA8/91A7vV2a37kb8S+7tplagAGtebB/vAlAiBZBfcxVuMrAfXtVIqx05nXi8HP3LuHn2HJ/8
 Hu+vvXOAa0Mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="242936276"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="242936276"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 17:55:16 -0800
IronPort-SDR: OjTjmzZeGtgaBCZNBedTA+J7GwthUjz3cke8cA/2dGYbV+tSI/wpyCs8srt3psLsNd3oXNSecU
 t/plIS1KZtJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="353654790"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2021 17:55:16 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 17:55:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Jan 2021 17:55:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 18 Jan 2021 17:55:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 18 Jan 2021 17:55:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7JK7YPMOpBsnhYymgAkQoU+YREKez9ELl80CrKF5JKaQ0NBdDZCdP8kJMNuuJgFpPZkwfZXMdOTPxo8pUQdOx8wlh0HASdyyHdP1beGsqDTMTd+WSE6RT1e7Jv4u8GmRJyBaUSey1StsvSqbM52WiCT2ffx3Hy72Hf5Fi+dsT+ZRgX7DKKHwqRJTyQ1uChG2AdRprJBgncTww97srw8sujnUDReP4T4dOumHA1UBpc+1c2gIqcwVaUxTWmEvE+lx51OGWVH+YEH0Hiv+8OrRAdu8xJRr9s0WOSveuB3QSAGh4GT14C4t6Jqp0sCUUIqjE3ZLyS1aUH0DWHN5P58BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0FkHVel7Mf9z6SlzAtvwh+1uJNF9nUNnqQDDyc4H4s=;
 b=DjkuQZ24/K/oJl4yR1VjYL+gGUrGuQHPTCu5WmLNn5orYpFpIetg/xMdC0BdsiggtHw4hrGVUwcHt50EZ45b6piWtGT6JlU7RjMUcynDCHJaJ8JytYzlJXvyl6FAnWMkd1SAKpL6JbVoLZ2aM9aLQ+rbrPOWV/FEz6QbJZeg3YPppwwod+9U3ZAIIJo9cYh5npUeMFNWHlk+5hne3KKFgI7jUb4XtDT3xo1/OhBhrKWfy/xrlDQZcCI0erS13mvzzsGr7XHs+t6Thqd1/x3pLd4OgMJf4peRolovuAWfjGmL/LmVFhWHVzkptnjvXfEfvVqg8NcuueRlUsFEfQgqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0FkHVel7Mf9z6SlzAtvwh+1uJNF9nUNnqQDDyc4H4s=;
 b=uCwIPuAD+JNFruw6FS/YWU2rWV8WCG9gXReYFM6nPW+Aa5TWR/qokmYs2AMHhsKrfhnItIbLlqMWmk8n8AIvA/gDaLVyY2GlWcVEAXTlQMDT0d8xXCSWi3/fBtvQmvKtk2gmYOieT6/Yfc5wqTN0vO8EW64e4drNdHt2a+Qe/PA=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB2764.namprd11.prod.outlook.com (2603:10b6:5:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 01:55:14 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::6da6:c2ee:aa4a:d21f]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::6da6:c2ee:aa4a:d21f%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 01:55:13 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Seow, Chen Yong" <chen.yong.seow@intel.com>
Subject: RE: [PATCH v2 0/2] Add drivers for Intel Keem Bay SoC timer block
Thread-Topic: [PATCH v2 0/2] Add drivers for Intel Keem Bay SoC timer block
Thread-Index: AQHW3m7YxPa/m6s82EKpveVtdL87PqoldpUQgAgrgQCAAKkhYA==
Date:   Tue, 19 Jan 2021 01:55:13 +0000
Message-ID: <DM6PR11MB42504F46CCABB7DEC1AA28AAFBA30@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <DM6PR11MB4250A1E8C1F2CA97516A2E59FBA90@DM6PR11MB4250.namprd11.prod.outlook.com>
 <98fd451c-828e-e2e4-8462-51f9c88b6f1e@linaro.org>
In-Reply-To: <98fd451c-828e-e2e4-8462-51f9c88b6f1e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.176.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 932f882f-3bec-4cf3-8a17-08d8bc1d4322
x-ms-traffictypediagnostic: DM6PR11MB2764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2764D9023207F53FFB4DCC9AFBA30@DM6PR11MB2764.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7aQn4P9vWGXptT+oR3fKAawhQRcKwfxpVGCwqNHqaId7G4UnF8QwqiOqeCeg0JS2QSfll34GGgax+p6bGEcUA2TzfOUu40EuAiTyN6T1zZS6+auqUNl6mrM+8hAxkx3fBm+ZruvIzj3xSNefjCcr6a/CnwwGIsPlw2BlOtT3F0DH2lW66VbHeuWVuTg1e64GO6prbFHN3A0OVR6ET8SGmC9suWra+am6lJxjycoH1sqLWUsk42SCf+DepW/kJQiFTv+bhmn46MhWZW1++utkIuqljWwVmImAG689kpDk2NWa1HHbDXk4NMM60VCbyAHwDlZDkiqVYdvRY9Cr9plbqmVbpNepwAXKKAhZuWYLExzf8kHCpiy1bAiGVksa3rPlCEXoNYwe7a5I4TwCkMk+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(33656002)(83380400001)(110136005)(2906002)(54906003)(316002)(64756008)(5660300002)(6506007)(8676002)(26005)(55016002)(86362001)(71200400001)(4744005)(4326008)(76116006)(66946007)(9686003)(66446008)(52536014)(8936002)(7696005)(478600001)(186003)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MWFqOHlZWkhlbUtHZkQxY3B2cWNJOVZsbTJtRlR4cWUvM1djYnZwM3dHeHFJ?=
 =?utf-8?B?dmhNMzlxNGNtdm5LUUZFZUFjc2hHUVVxVnJGZTdUTWpsY2NjN3NWWk01Mks4?=
 =?utf-8?B?NGh4TGxVcGJqYXRFaHpNTi9GN3pDTTZ0ZTg1Z2xOVUk4amcrZmNpaWRCTkw1?=
 =?utf-8?B?L08xcG5oai9kZXNwN2hUSnBCMkRmUEJTWHRseTF0OGNRSEZ4RTNYeGs4dEVI?=
 =?utf-8?B?Y0psZGFaQ1ZwWHluSkNRYkhaREd2N3hpZTRYR0FDblpUa21rQ0NxL3FvdEo0?=
 =?utf-8?B?OU1KeVV5aHI5MC9GZ0pqS2N4L0NuQnM5RnRQai9vMGVEeXNjWTJkWjNPWmYw?=
 =?utf-8?B?WTZwZjFQT0I0MGpoNEdhSWE4cnBnOUl3U2hWVVBvZVF2UkxIeXJHVDVoU09S?=
 =?utf-8?B?TUp0eWoydFViN3B5ckJzZ21uV0xNWWliQytrcXBlbHlTU0FJdVlDNDFrYlpj?=
 =?utf-8?B?VUtJQTdNSGUzdjZEMk9FRUlKaE9Xd3A0RFNIU0tGSGhhb2tkeDVhUXE1N3dq?=
 =?utf-8?B?K3Q0NHpiUXdPaFVCdFM1NFZreERGd0RNbE10QVVOOEZwVGlmckRwNVN2cTMx?=
 =?utf-8?B?R2ZQeWZGbDhQQTBCb2poakxUdFZveno3Y3d2S0xzZGFHTzhOVVhBaHVOSXNU?=
 =?utf-8?B?cVQ1N0xzeHB2aVhoemlIalhSUTAzRHBQN2RFbHdyc2JXdDhxQ2FkUkdKS3VM?=
 =?utf-8?B?MzhJa1BTeFlvY09KVzNWd0pDSml2NUpBTE1vUTV3bmQ0d3grWk43UHYwK0h4?=
 =?utf-8?B?SkdmeHJWWUlpN0MzcTE5ajdSUHlNQlJ4WncxV0owVm9XdERXSWJpdGZyK3ZF?=
 =?utf-8?B?L3NpcGZhUVAwWS85a2x0T1B3Q1ZLTWcvL3R5dlh5cHRZc0c3aVMzRi9WTmwr?=
 =?utf-8?B?cGxVaUIvYnhIQzBvMXpvc0dPSkl2YzFCN2JqMUNndUtDWjNXODM2T2REeXBn?=
 =?utf-8?B?M0tQN0NiU1A4UE5uSnJGOTBGZDEyWjFEZnp5MmovWTREVHBjaHBTQTFOVk1z?=
 =?utf-8?B?dkx4c2xqejN1M09GeXFiSCtBVDV1RkMvU29MQW12SmR4d0x4YjdPS0NROUtL?=
 =?utf-8?B?by8rTEtISkgwQTNxMjZJUjJkMGlHNGF5K0gwaGdFS2w0YTBPOUE5RERvZjRu?=
 =?utf-8?B?MldjQXZRM1hNWlV6bzVQZGtrVkJvaDNyaC92Qk9oUEV6OHhpZU1md2VHbHhL?=
 =?utf-8?B?ZzdYWmxmakFYZERWc2RSVlcwcmRHL1cxNFB1Mnd5cWFlb2VNMW5ZZUZXenI3?=
 =?utf-8?B?dW56d1E5bHFNMXNkbjN6VTM5ZGhNRHVyUDAydndaTzFWTVpIc2x1ZEVBRFcv?=
 =?utf-8?Q?QZri7dhl8RwGE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932f882f-3bec-4cf3-8a17-08d8bc1d4322
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 01:55:13.7856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHw1aN3CiBHO1hVUAMoGp0oyDBiDnCzh2+SKE22NRCXnF7tEZAoWGpfkNsgRQkkb1pHQhi7yhyvQ0bWMfzOnZQ5FT+cPn+FDf8U9CBrIpe01GsL6LapsE1E1OdIctwzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2764
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQo+IEZyb206IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5h
cm8ub3JnPg0KPiA+PiBGcm9tOiBWaWpheWFrYW5uYW4gQXl5YXRodXJhaSA8dmlqYXlha2FubmFu
LmF5eWF0aHVyYWlAaW50ZWwuY29tPg0KPiA+Pg0KPiA+PiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+
PiAgLSBBZGQgc3VwcG9ydCBmb3IgS0VFTUJBWV9USU1FUiB0byBnZXQgc2VsZWN0ZWQgdGhyb3Vn
aA0KPiBLY29uZmlnLnBsYXRmb3Jtcy4NCj4gPj4gIC0gQWRkIENMT0NLX0VWVF9GRUFUX0RZTklS
USBhcyBwYXJ0IG9mIGNsb2NrZXZlbnQgZmVhdHVyZS4NCj4gPj4gIC0gQXZvaWQgb3ZlcmxhcHBp
bmcgcmVnIHJlZ2lvbnMgYWNyb3NzIDIgZGV2aWNlIG5vZGVzLg0KPiA+PiAgLSBTaW1wbGlmeSAy
IGRldmljZSBub2RlcyBhcyAxIGJlY2F1c2UgYm90aCBhcmUgZnJvbSBzYW1lIElQIGJsb2NrLg0K
PiA+PiAgLSBBZGFwdCB0aGUgZHJpdmVyIGNvZGUgYWNjb3JkaW5nIHRvIHRoZSBuZXcgc2ltcGxp
ZmllZCBkZXZpY2V0cmVlLg0KPiA+Pg0KPiA+PiBWaWpheWFrYW5uYW4gQXl5YXRodXJhaSAoMik6
DQo+ID4+ICAgZHQtYmluZGluZ3M6IHRpbWVyOiBBZGQgYmluZGluZ3MgZm9yIEludGVsIEtlZW0g
QmF5IFNvQyB0aW1lcg0KPiA+PiAgIGNsb2Nrc291cmNlOiBBZGQgSW50ZWwgS2VlbSBCYXkgVGlt
ZXIgU3VwcG9ydA0KPiA+DQo+ID4gS2luZGx5IGhlbHAgdXMgdG8gcmV2aWV3IHRoaXMgdXBkYXRl
ZCBwYXRjaCh2Mikgc2V0Lg0KPiANCj4gUmV2aWV3IGluIHByb2dyZXNzIC4uLiA6KQ0KPiANCg0K
VGhhbmsgeW91IGZvciB0aGUgUmV2aWV3LiANCg0KVGhhbmtzLA0KVmlqYXkNCg==
