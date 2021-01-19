Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83B12FC3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbhASWqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:46:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:44763 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405602AbhASOdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:33:40 -0500
IronPort-SDR: Ij/heY7QV8fP6ascbN4QGGAyoVwVSpSQY24J6rSZL5/wo90Y9euqi+L6wUONOU+JkLb/pY5tBI
 OdoTXd4F/G8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="179082871"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="179082871"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:32:49 -0800
IronPort-SDR: eGswL6oLFS+RNE5MBYCeLColcIYBDEtCBt91/1bkpKs47Wb8CQS5PSSHkXLIV3DWAWaEreDndd
 Al/m9vUfbUVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="466715903"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 06:32:49 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 06:32:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Jan 2021 06:32:48 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 19 Jan 2021 06:32:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH6WSkpY65gKb+M63wrSQudYS+5SSnMW93k2oTPHxeo3uxJ/6LooU24BdxVQUyvElPSNB+TyxxGcbsTwey8ANE7h19k85FIAq4w0ka1FEpJxVtifqn2vxkr/Qb+3A+ofvC6SR+kgPzuOxzzVLmyjJANWW7cV4fMVSmgXr+v0ihgJymOLDxWh8Z2++2xBDLGPpy5Uj3iPkwkiDmf9ROcXfrH9xbxRbfWWROb5oR9YfA65R9LCLe04nGqtY2/tnZc6aeej+hQEaacrNFh4U1ISDaJ35ZukFMsFl60cHagmcsfAD0xsEvB0o0Y90pchAbTe177ZZS5I8sQbSHKqZqZwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MiTBr+IIi0414K6fsh1E3uuEgswosYah6l86DQvgEo=;
 b=ADGFmbCoh3pEyDlbzIyixXwmhv1T6z9e0YXfD/b1zTMMfV0TpgmAaUmExOa/jVKEzjOiN9THb40qvIF+ax9Sw54NGf9LDWGln4YjP0ZpelCiCUtBhUSKbnYeGg7oohst2h4tKPbDWgZZHXCDj45hphV4SXh0bcaCLNSxsSnqlCb/OyckAl77tAJDOi/MEmEoz8lIHtmGkSBTndspzijGfIfqDqbMG5Pd1Y+AfCinUKW126uLTJcM91jyu/XOKfBgjgH0ENFiSxFOFdi0SS8YyViWDl/aa3KRtgaV/Hz7VlNbJKZPtna8reER7ea3PQY8T0ZqsUYBMsVy6KzmNMAP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MiTBr+IIi0414K6fsh1E3uuEgswosYah6l86DQvgEo=;
 b=yag614zQw1YChx8CyDquebCDy6dDiDPK+19K7wN7yJqetiwCUvIc62lEqAcYD5KDGmySTT0/kI0bS/apJ5nsSnSPKmVxjQchUkENoootvEkKB8Guna56twEH+qh9rO3oA8jQ/LDm7xxwZJRx5gG4hbdgWd6hyjSEtVl3Q8UUTD4=
Received: from SN6PR11MB3055.namprd11.prod.outlook.com (2603:10b6:805:dc::18)
 by SN6PR11MB3152.namprd11.prod.outlook.com (2603:10b6:805:cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 19 Jan
 2021 14:32:45 +0000
Received: from SN6PR11MB3055.namprd11.prod.outlook.com
 ([fe80::d4a0:9ff0:15b8:cd76]) by SN6PR11MB3055.namprd11.prod.outlook.com
 ([fe80::d4a0:9ff0:15b8:cd76%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 14:32:45 +0000
From:   "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "bp@suse.de" <bp@suse.de>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>
Subject: Re: [PATCH v2 06/34] dt-bindings: Add bindings for Keem Bay VPU IPC
 driver
Thread-Topic: [PATCH v2 06/34] dt-bindings: Add bindings for Keem Bay VPU IPC
 driver
Thread-Index: AQHW5gUqnBV4122GgUK33GrNg6gsuaoi0qIAgAxBNwA=
Date:   Tue, 19 Jan 2021 14:32:45 +0000
Message-ID: <9996e4a93e79ffc70e1c401c2ce3ec526060f48c.camel@intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
         <20210108212600.36850-7-mgross@linux.intel.com>
         <20210111192410.GA2906041@robh.at.kernel.org>
In-Reply-To: <20210111192410.GA2906041@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d19a8b09-1c67-48f4-6037-08d8bc871644
x-ms-traffictypediagnostic: SN6PR11MB3152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3152DE16A07A43839F56EDD7F2A39@SN6PR11MB3152.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYFmRhQHByK3+YzFiTNeuMKyeYHwnSMMV3mM3NTCMqv1laxCJxjZS6zZ3n8a9fgAbVwc60su9PisQrN4r+eKRtXDfY0KSUudvN/k+sZSImCsAYueqVHiT2WHJwBTM/FSfBUikkaaKLs5MySuLqKgSxfWdX4MiPgWV0Uab6ZhiDz/QoxUwjprHgWgRoomIjqDAmnEF0D3R9dXe4W9ECZylyn22ubqiegmdrPXVxoIqvD8i2W+6Ping8iST1I3aShJsvTU93l9w7Yu8vkDiMBbxV+FWoJgf2Ny3Bx3v4IShGD2LPx5nA+DVDy0SLcLSY8g6v5YZo3mE/ZVLq88TNFrjT4Vsa5IxwOSEz+fX/mX73CWibi+HYj2vWB/aah5I9byNaWFRCzZt8OCAaCCY3dTu82hNA7Z2/JrdjGtrrXK/Wlw7XcJR3iXdGML/P8crSC5lg/z4ItuUd+KrXbY3UtkpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3055.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(316002)(36756003)(186003)(26005)(4326008)(8936002)(71200400001)(6512007)(6486002)(7416002)(6506007)(8676002)(2906002)(83380400001)(966005)(91956017)(478600001)(66476007)(66946007)(86362001)(110136005)(64756008)(66446008)(2616005)(66556008)(5660300002)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y0RHeXFXd2JkMkVrS0tJYzRoZTFaZEhQTUhlUDB4WWJwNE5kdEdOSTV0ZFFN?=
 =?utf-8?B?cy9UWFpBVFIyT200bUorMG1acFZhd2x2enR4YWRRZVRGMThEMlNQMzJIZWpa?=
 =?utf-8?B?UXhoTUZZWTVpc29zU0loOWtoQUJpY2FTSERWOHEyU2JQSGI4NkNVdXBXOS9W?=
 =?utf-8?B?Wk9DaXRwQUN3THJFV2Z5WWtZU1F6Q2NHL2V3S0wwKzV0YmJvQ1FLQ3pUdWVI?=
 =?utf-8?B?dnlJNzluUWpndFhFQlZHUWFscitUMWlIajY3Q3J6OE1LVndqWUE2QTRTRDlu?=
 =?utf-8?B?a2hleFN4ZkF1UGR6T3BVYkx4OHFDSURTTWJIUW9EUVduOGpiZ2hLVWU5NU1r?=
 =?utf-8?B?aEh2dnk1NDZRS0V2bk50QjhvUnN0MWFDb3N3cFJ0dzZSQ0lWZjBnQlVScFhF?=
 =?utf-8?B?dGFQc09uN2R6T3NqTHJIMTdCR2lkUWJjbFFMZDY5azUxdWlCNnUwSXFWcXZD?=
 =?utf-8?B?UklGRkNvaURMaXJSV1YyQUlrZDZ1eElSbFIxQnh3ZjB4KytwWFkyWnBVUExY?=
 =?utf-8?B?OVg3WW9BdUlPOG9ROTlBdEFwVDZPR2l0dDdINWVBMVN1ZU42Tk0rSjZMRjZD?=
 =?utf-8?B?akhyZldlaEt6WWdrZ3o4REdvM1pDQUN2dE9PMkcyNlJZQk43V1pCSGxJMEMz?=
 =?utf-8?B?SnpNNS85K1BkZDJVQWtwUnlCT2hyTFdhazMvWWtkVitVc3pKbWpleHBsa2d4?=
 =?utf-8?B?M0dqdnpaYjlwRThrakh2V1M2dVJhaTZKL0Y1ZDdnMDlNcGVMTDhjeHBOdW1z?=
 =?utf-8?B?NGlPMjBXdWpuQTVwSnhLZzNOTW5lSXZOSTd0UG1JbHhoeU9qbGVNMTJNUjRB?=
 =?utf-8?B?TUNmb1Fnd1l3NDZONCt3TTZtU3hEREhpekZxd2N1MkZEK0h0czBaRTdNVmpn?=
 =?utf-8?B?d0JIclFKUFBHb2tDTTJmYTFObmlFYnM1WkczNjlmc2t6eXUxUDFXei9ndzJ5?=
 =?utf-8?B?STRDS3FJZDhYUkNKMTdQMHBHYld4TjhpTVNOWFgyWjhmZkZ1TXk5VCsyeDZn?=
 =?utf-8?B?NFMwT3ozWmZMMVI2cHlDQnlBWFJ4dDQ2N3Yrc0I5UXRjSmcrdFlFVU5OTGpu?=
 =?utf-8?B?UnVXdDBBOWFFN0hpRjdLcG82TmNRTjRHVEZLT0ZjMFB3YVlCanRBeEtPTUtr?=
 =?utf-8?B?Mm1HYktHZkZiTlRXOG1BVi90aktMLzBaMFArWTZpWUxvcGNJT1FMRzlhN3Q3?=
 =?utf-8?B?VGliNG9YSHRuMUxDTE01c0xuQnZOdnhjUlFmNlU0NUZ2VG1XVnNlWVV5YXo1?=
 =?utf-8?B?dE1PTXpTNGgvTFFiam1pL1oyN21XTTc4SzE0bmlrOGkrNG1NRW9kWlhFZTRo?=
 =?utf-8?Q?tyIseNeV3eem11KUg2L5EBHSvkltPeyC5V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F6FA139721DC9459838C1063E1E40AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3055.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19a8b09-1c67-48f4-6037-08d8bc871644
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 14:32:45.2002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VaSyaztOjGU8A+BlTNhE2UZIaHw+VSxJbGlLwp6X850hmZpgNTXTBoylO6R7uczOJx3gpo9i6veSGM37GKoem5OmYQn3e6rAOhDVME9Rti8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3152
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpPbiBNb24sIDIwMjEtMDEtMTEg
YXQgMTM6MjQgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBGcmksIEphbiAwOCwgMjAy
MSBhdCAwMToyNTozMlBNIC0wODAwLCBtZ3Jvc3NAbGludXguaW50ZWwuY29tDQo+IHdyb3RlOg0K
PiA+IEZyb206IFBhdWwgTXVycGh5IDxwYXVsLmoubXVycGh5QGludGVsLmNvbT4NCj4gPiANCj4g
PiBBZGQgRFQgYmluZGluZ3MgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIEtlZW0gQmF5IFZQVSBJUEMg
ZHJpdmVyLg0KPiA+IA0KPiA+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0K
PiA+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiA+IFJldmlld2VkLWJ5OiBNYXJr
IEdyb3NzIDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBhdWwg
TXVycGh5IDxwYXVsLmoubXVycGh5QGludGVsLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IERh
bmllbGUgQWxlc3NhbmRyZWxsaSA8DQo+ID4gZGFuaWVsZS5hbGVzc2FuZHJlbGxpQGludGVsLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWxlIEFsZXNzYW5kcmVsbGkgPA0KPiA+IGRhbmll
bGUuYWxlc3NhbmRyZWxsaUBpbnRlbC5jb20+DQo+IA0KPiBOZWVkcyB5b3VyIFNvYi4NCj4gDQo+
ID4gLS0tDQo+ID4gIC4uLi9zb2MvaW50ZWwvaW50ZWwsa2VlbWJheS12cHUtaXBjLnlhbWwgICAg
ICB8IDE1Mw0KPiA+ICsrKysrKysrKysrKysrKysrKw0KPiANCj4gVGhpcyBkb2Vzbid0IGZpdCBz
b21ld2hlcmUgZWxzZT8NCg0KSXQncyBxdWl0ZSBhIFNvQy1zcGVjaWZpYyBkcml2ZXIsIGRlc2ln
bmVkIHRvIGNvbnRyb2wgKHN0YXJ0LCBzdG9wLA0KbW9uaXRvciwgZXRjKSB0aGUgVmlzaW9uIFBy
b2Nlc3NpbmcgVW5pdCAoVlBVKSBpbnRlZ3JhdGVkIGluIHRoZSBLZWVtDQpCYXkgU29DLg0KDQpE
byB5b3UgdGhpbmsgaXQgd291bGQgZml0IGJldHRlciBzb21ld2hlcmUgZWxzZT8NCg0KPiANCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDE1MyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW50ZWwvaW50
ZWwsa2VlbWJheS12cHUtDQo+ID4gaXBjLnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2ludGVsL2ludGVsLGtlZW1i
YXktdnB1LQ0KPiA+IGlwYy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL2ludGVsL2ludGVsLGtlZW1iYXktdnB1LQ0KPiA+IGlwYy55YW1sDQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmNkMWM0YWJlOGJjOQ0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL2ludGVsL2ludGVsLGtlZW1iYXktDQo+ID4gdnB1LWlwYy55YW1sDQo+ID4gQEAg
LTAsMCArMSwxNTMgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAg
T1IgQlNELTItQ2xhdXNlKQ0KPiA+ICsjIENvcHlyaWdodCAoYykgSW50ZWwgQ29ycG9yYXRpb24u
IEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlk
OiAiDQo+ID4gaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL2ludGVsL2ludGVsLGtl
ZW1iYXktdnB1LWlwYy55YW1sIw0KPiA+ICINCj4gPiArJHNjaGVtYTogImh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIyINCj4gPiArDQo+ID4gK3RpdGxlOiBJbnRl
bCBLZWVtIEJheSBWUFUgSVBDDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFBh
dWwgTXVycGh5IDxwYXVsLmoubXVycGh5QGludGVsLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0
aW9uOg0KPiA+ICsgIFRoZSBWUFUgSVBDIGRyaXZlciBmYWNpbGl0YXRlcyBsb2FkaW5nIG9mIGZp
cm13YXJlLCBjb250cm9sLCBhbmQNCj4gPiBjb21tdW5pY2F0aW9uDQo+ID4gKyAgd2l0aCB0aGUg
VlBVIG92ZXIgdGhlIElQQyBGSUZPIGluIHRoZSBJbnRlbCBLZWVtIEJheSBTb0MuDQo+IA0KPiBW
UFUgaXMgbmV2ZXIgZGVmaW5lZC4gDQoNCldlJ2xsIHNwZWxsIG91dCB0aGUgYWNyb255bSBpbiB2
My4NCg0KQW55d2F5LCBWUFUgPSBWaXNpb24gUHJvY2Vzc2luZyBVbml0DQoNCg0KPiANCj4gQmlu
ZGluZ3MgYXJlIGZvciBoL3cgYmxvY2tzLCBub3QgZHJpdmVycy4NCg0KV2lsbCBiZSBmaXhlZCBp
biB2Mw0KDQo+IA0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0K
PiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgLSBjb25z
dDogaW50ZWwsa2VlbWJheS12cHUtaXBjDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIGl0
ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBOQ0UgV0RUIHJlZ2lzdGVycw0KPiA+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBOQ0UgVElNX0dFTl9DT05GSUcgcmVnaXN0ZXJzDQo+ID4gKyAg
ICAgIC0gZGVzY3JpcHRpb246IE1TUyBXRFQgcmVnaXN0ZXJzDQo+ID4gKyAgICAgIC0gZGVzY3Jp
cHRpb246IE1TUyBUSU1fR0VOX0NPTkZJRyByZWdpc3RlcnMNCj4gPiArDQo+ID4gKyAgcmVnLW5h
bWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IG5jZV93ZHQNCj4gPiAr
ICAgICAgLSBjb25zdDogbmNlX3RpbV9jZmcNCj4gPiArICAgICAgLSBjb25zdDogbXNzX3dkdA0K
PiA+ICsgICAgICAtIGNvbnN0OiBtc3NfdGltX2NmZw0KPiA+ICsNCj4gPiArICBtZW1vcnktcmVn
aW9uOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IHJlZmVyZW5j
ZSB0byB0aGUgVlBVIHJlc2VydmVkIG1lbW9yeSByZWdpb24NCj4gPiArICAgICAgLSBkZXNjcmlw
dGlvbjogcmVmZXJlbmNlIHRvIHRoZSBYNTA5IHJlc2VydmVkIG1lbW9yeSByZWdpb24NCj4gPiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogcmVmZXJlbmNlIHRvIHRoZSBNU1MgSVBDIGFyZWENCj4gPiAr
DQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRp
b246IGNwdSBjbG9jaw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBwbGwgMCBvdXQgMCByYXRl
DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IHBsbCAwIG91dCAxIHJhdGUNCj4gPiArICAgICAg
LSBkZXNjcmlwdGlvbjogcGxsIDAgb3V0IDIgcmF0ZQ0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9u
OiBwbGwgMCBvdXQgMyByYXRlDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IHBsbCAxIG91dCAw
IHJhdGUNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogcGxsIDEgb3V0IDEgcmF0ZQ0KPiA+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBwbGwgMSBvdXQgMiByYXRlDQo+ID4gKyAgICAgIC0gZGVzY3Jp
cHRpb246IHBsbCAxIG91dCAzIHJhdGUNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogcGxsIDIg
b3V0IDAgcmF0ZQ0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBwbGwgMiBvdXQgMSByYXRlDQo+
ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IHBsbCAyIG91dCAyIHJhdGUNCj4gPiArICAgICAgLSBk
ZXNjcmlwdGlvbjogcGxsIDIgb3V0IDMgcmF0ZQ0KPiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoN
Cj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBjcHVfY2xvY2sNCj4gPiArICAg
ICAgLSBjb25zdDogcGxsXzBfb3V0XzANCj4gPiArICAgICAgLSBjb25zdDogcGxsXzBfb3V0XzEN
Cj4gPiArICAgICAgLSBjb25zdDogcGxsXzBfb3V0XzINCj4gPiArICAgICAgLSBjb25zdDogcGxs
XzBfb3V0XzMNCj4gPiArICAgICAgLSBjb25zdDogcGxsXzFfb3V0XzANCj4gPiArICAgICAgLSBj
b25zdDogcGxsXzFfb3V0XzENCj4gPiArICAgICAgLSBjb25zdDogcGxsXzFfb3V0XzINCj4gPiAr
ICAgICAgLSBjb25zdDogcGxsXzFfb3V0XzMNCj4gPiArICAgICAgLSBjb25zdDogcGxsXzJfb3V0
XzANCj4gPiArICAgICAgLSBjb25zdDogcGxsXzJfb3V0XzENCj4gPiArICAgICAgLSBjb25zdDog
cGxsXzJfb3V0XzINCj4gPiArICAgICAgLSBjb25zdDogcGxsXzJfb3V0XzMNCj4gPiArDQo+ID4g
KyAgaW50ZXJydXB0czoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9u
OiBudW1iZXIgb2YgTkNFIHN1Yi1zeXN0ZW0gV0RUIHRpbWVvdXQgSVJRDQo+ID4gKyAgICAgIC0g
ZGVzY3JpcHRpb246IG51bWJlciBvZiBNU1Mgc3ViLXN5c3RlbSBXRFQgdGltZW91dCBJUlENCj4g
PiArDQo+ID4gKyAgaW50ZXJydXB0LW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAg
IC0gY29uc3Q6IG5jZV93ZHQNCj4gPiArICAgICAgLSBjb25zdDogbXNzX3dkdA0KPiA+ICsNCj4g
PiArICBpbnRlbCxrZWVtYmF5LXZwdS1pcGMtbmNlLXdkdC1yZWRpcmVjdDoNCj4gPiArICAgICRy
ZWY6ICIvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzIiDQo+ID4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gPiArICAgICAgTnVtYmVyIHRvIHdoaWNoIHdlIHdpbGwgcmVxdWVzdCB0
aGF0IHRoZSBOQ0Ugc3ViLXN5c3RlbQ0KPiA+ICsgICAgICByZS1kaXJlY3RzIGl0J3MgV0RUIHRp
bWVvdXQgSVJRDQo+ID4gKw0KPiA+ICsgIGludGVsLGtlZW1iYXktdnB1LWlwYy1tc3Mtd2R0LXJl
ZGlyZWN0Og0KPiA+ICsgICAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3VpbnQzMiINCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBOdW1iZXIgdG8gd2hp
Y2ggd2Ugd2lsbCByZXF1ZXN0IHRoYXQgdGhlIE1TUyBzdWItc3lzdGVtDQo+ID4gKyAgICAgIHJl
LWRpcmVjdHMgaXQncyBXRFQgdGltZW91dCBJUlENCj4gDQo+IFRoZXNlIGxvb2sgbGlrZSB0aGUg
c2FtZSB2YWx1ZSBhcyB0aGUgaW50ZXJydXB0IG51bWJlcnM/DQoNClRoYXQncyBhIHZlcnkgZ29v
ZCBwb2ludC4gV2UnbGwgZHJvcCB0aGVzZSBhZGRpdGlvbmFsIHByb3BlcnRpZXMgYW5kDQpyZS11
c2UgdGhlIGludGVycnVwdCBudW1iZXJzLg0KDQo+IA0KPiA+ICsNCj4gPiArICBpbnRlbCxrZWVt
YmF5LXZwdS1pcGMtaW1yOg0KPiA+ICsgICAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2Rl
ZmluaXRpb25zL3VpbnQzMiINCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBJTVIg
KGlzb2xhdGVkIG1lbW9yeSByZWdpb24pIG51bWJlciB3aGljaCB3ZSB3aWxsIHJlcXVlc3QNCj4g
PiArICAgICAgdGhlIHJ1bnRpbWUgc2VydmljZSB1c2VzIHRvIHByb3RlY3QgdGhlIFZQVSBtZW1v
cnkgcmVnaW9uDQo+ID4gKyAgICAgIGJlZm9yZSBhdXRoZW50aWNhdGlvbg0KPiA+ICsNCj4gPiAr
ICBpbnRlbCxrZWVtYmF5LXZwdS1pcGMtaWQ6DQo+ID4gKyAgICAkcmVmOiAiL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyIg0KPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBW
UFUgSUQgdG8gYmUgcGFzc2VkIHRvIHRoZSBWUFUgZmlybXdhcmUuDQo+ID4gKw0KPiA+ICthZGRp
dGlvbmFsUHJvcGVydGllczogRmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0g
fA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2Fy
bS1naWMuaD4NCj4gPiArICAgIHZwdS1pcGNAM2YwMDIwOWMgew0KPiA+ICsgICAgICAgIGNvbXBh
dGlibGUgPSAiaW50ZWwsa2VlbWJheS12cHUtaXBjIjsNCj4gPiArICAgICAgICByZWcgPSA8MHgz
ZjAwMjA5YyAweDEwPiwNCj4gPiArICAgICAgICAgICAgICA8MHgzZjAwMzAwOCAweDQ+LA0KPiA+
ICsgICAgICAgICAgICAgIDwweDIwODIwMDljIDB4MTA+LA0KPiA+ICsgICAgICAgICAgICAgIDww
eDIwODIxMDA4IDB4ND47DQo+ID4gKyAgICAgICAgcmVnLW5hbWVzID0gIm5jZV93ZHQiLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICJuY2VfdGltX2NmZyIsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIm1zc193ZHQiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICJtc3NfdGltX2NmZyI7
DQo+ID4gKyAgICAgICAgbWVtb3J5LXJlZ2lvbiA9IDwmdnB1X3Jlc2VydmVkPiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgPCZ2cHVfeDUwOV9yZXNlcnZlZD4sDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgIDwmbXNzX2lwY19yZXNlcnZlZD47DQo+ID4gKyAgICAgICAgY2xvY2tz
ID0gPCZzY21pX2NsayAwPiwNCj4gPiArICAgICAgICAgICAgICAgICA8JnNjbWlfY2xrIDA+LA0K
PiA+ICsgICAgICAgICAgICAgICAgIDwmc2NtaV9jbGsgMT4sDQo+ID4gKyAgICAgICAgICAgICAg
ICAgPCZzY21pX2NsayAyPiwNCj4gPiArICAgICAgICAgICAgICAgICA8JnNjbWlfY2xrIDM+LA0K
PiA+ICsgICAgICAgICAgICAgICAgIDwmc2NtaV9jbGsgND4sDQo+ID4gKyAgICAgICAgICAgICAg
ICAgPCZzY21pX2NsayA1PiwNCj4gPiArICAgICAgICAgICAgICAgICA8JnNjbWlfY2xrIDY+LA0K
PiA+ICsgICAgICAgICAgICAgICAgIDwmc2NtaV9jbGsgNz4sDQo+ID4gKyAgICAgICAgICAgICAg
ICAgPCZzY21pX2NsayA4PiwNCj4gPiArICAgICAgICAgICAgICAgICA8JnNjbWlfY2xrIDk+LA0K
PiA+ICsgICAgICAgICAgICAgICAgIDwmc2NtaV9jbGsgMTA+LA0KPiA+ICsgICAgICAgICAgICAg
ICAgIDwmc2NtaV9jbGsgMTE+Ow0KPiA+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gImNwdV9jbG9j
ayIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAicGxsXzBfb3V0XzAiLCAicGxsXzBfb3V0
XzEiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgInBsbF8wX291dF8yIiwgInBsbF8wX291
dF8zIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJwbGxfMV9vdXRfMCIsICJwbGxfMV9v
dXRfMSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAicGxsXzFfb3V0XzIiLCAicGxsXzFf
b3V0XzMiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgInBsbF8yX291dF8wIiwgInBsbF8y
X291dF8xIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICJwbGxfMl9vdXRfMiIsICJwbGxf
Ml9vdXRfMyI7DQo+ID4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDYzIElSUV9UWVBF
X0xFVkVMX0hJR0g+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSA0NyBJUlFf
VFlQRV9MRVZFTF9ISUdIPjsNCj4gPiArICAgICAgICBpbnRlcnJ1cHQtbmFtZXMgPSAibmNlX3dk
dCIsICJtc3Nfd2R0IjsNCj4gPiArICAgICAgICBpbnRlbCxrZWVtYmF5LXZwdS1pcGMtbmNlLXdk
dC1yZWRpcmVjdCA9IDw2Mz47DQo+ID4gKyAgICAgICAgaW50ZWwsa2VlbWJheS12cHUtaXBjLW1z
cy13ZHQtcmVkaXJlY3QgPSA8NDc+Ow0KPiA+ICsgICAgICAgIGludGVsLGtlZW1iYXktdnB1LWlw
Yy1pbXIgPSA8OT47DQo+ID4gKyAgICAgICAgaW50ZWwsa2VlbWJheS12cHUtaXBjLWlkID0gPDA+
Ow0KPiA+ICsgICAgfTsNCj4gPiAtLSANCj4gPiAyLjE3LjENCj4gPiANCg==
