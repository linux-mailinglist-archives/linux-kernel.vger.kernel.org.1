Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0672BBCFD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgKUEgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:36:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:9572 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgKUEgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:36:39 -0500
IronPort-SDR: Vi4skcKYnIzXdjRQl7sczs4lO/MpRigX6vP3QeJs8Gn11JiIbIt2AU0AP8UGMxVToKD8rMVVTb
 UtPjZbUkiGYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="150837451"
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="150837451"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 20:36:38 -0800
IronPort-SDR: 5BPTAn62+bAnR7hqNUyvkySBxJCyb1IyX314fQUtARoDmnUIM7sm/6dbbaCtQhI5dhueYdWAYP
 niuwKWKNdTjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="535429095"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2020 20:36:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 20:36:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 20:36:36 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Fri, 20 Nov 2020 20:36:36 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v3 4/4] Documentation/admin-guide: Change doc for
 split_lock_detect parameter
Thread-Topic: [PATCH v3 4/4] Documentation/admin-guide: Change doc for
 split_lock_detect parameter
Thread-Index: AQHWv68gtA2is8bkI0S0yI/t2zyE76nSdHIA//99kICAAI2vgP//gG8g
Date:   Sat, 21 Nov 2020 04:36:36 +0000
Message-ID: <0cec6aea4dd14171a216ceb7960f6996@intel.com>
References: <20201121023624.3604415-1-fenghua.yu@intel.com>
 <20201121023624.3604415-5-fenghua.yu@intel.com>
 <d90ce156-5c44-e0b2-276e-a818ce99317f@infradead.org>
 <38db3c2d5d51432b95cd1011c9f83c27@intel.com>
 <171caa46-8431-ee58-2cad-954cb63cb1f3@infradead.org>
In-Reply-To: <171caa46-8431-ee58-2cad-954cb63cb1f3@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJhbmR5LA0KDQo+ID4+PiArCQkJCSAgZm9yIGJ1cyBsb2NrIGRldGVjdGlvbi4gMCA8IE4g
PD0gSFovMiBhbmQNCj4gPj4+ICsJCQkJICBOIGlzIGFwcHJveGltYXRlLiBPbmx5IGFwcGxpZWQg
dG8gbm9uLXJvb3QNCj4gPj4+ICsJCQkJICB1c2Vycy4NCj4gPj4NCj4gPj4gU29ycnksIGJ1dCBJ
IGRvbid0IGtub3cgd2hhdCB0aGlzIG1lYW5zLiBJIHRoaW5rIGl0J3MgdGhlICJhbmQgTiBpcw0K
PiA+PiBhcHByb3ByaWF0ZSINCj4gPj4gdGhhdCBpcyBjb25mdXNpbmcgbWUuDQo+ID4+DQo+ID4+
IAkwIDwgTiA8PSBIWi8yIGFuZCBOIGlzIGFwcHJvcHJpYXRlLg0KPiA+DQo+ID4gWW91IGFyZSBy
aWdodC4gSSB3aWxsIHJlbW92ZSAiYW5kIE4gaXMgYXBwcm9wcmlhdGUiIGluIHRoZSBuZXh0IHZl
cnNpb24uDQo+ID4NCj4gPiBDb3VsZCB5b3UgcGxlYXNlIGFjayB0aGlzIHBhdGNoPyBDYW4gSSBh
ZGQgQWNrZWQtYnkgZnJvbSB5b3UgaW4gdGhlDQo+IHVwZGF0ZWQgcGF0Y2g/DQo+ID4NCj4gPiBU
aGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHJldmlldyENCj4gDQo+IFN1cmUsIG5vIHByb2Js
ZW0uDQo+IA0KPiBBY2tlZC1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+
DQoNClJlYWxseSBhcHByZWNpYXRlIHlvdXIgcmV2aWV3IQ0KDQotRmVuZ2h1YQ0K
