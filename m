Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1FC2BBCE9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgKUEJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:09:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:42057 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgKUEJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:09:04 -0500
IronPort-SDR: g8/lJH5EXYvKSJLIIVRYpVU1OooS2jzAy+epdghiumxZ4et1uc7Vjv4q+KDjhhcNPljPxYnZd5
 pE1qQoWMqpFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="158613412"
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="158613412"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 20:09:04 -0800
IronPort-SDR: gEQAFfiNNHIfOCFTJMoOGYWrizjLb6ZPmMAivPWAJG4uF/F1heiBo90L6dTwTBqfrPbi8nQcQv
 TxPGcqxMPeOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="342265899"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 20 Nov 2020 20:09:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 20:09:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 20:09:03 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Fri, 20 Nov 2020 20:09:03 -0800
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
Thread-Index: AQHWv68gtA2is8bkI0S0yI/t2zyE76nSdHIA//99kIA=
Date:   Sat, 21 Nov 2020 04:09:02 +0000
Message-ID: <38db3c2d5d51432b95cd1011c9f83c27@intel.com>
References: <20201121023624.3604415-1-fenghua.yu@intel.com>
 <20201121023624.3604415-5-fenghua.yu@intel.com>
 <d90ce156-5c44-e0b2-276e-a818ce99317f@infradead.org>
In-Reply-To: <d90ce156-5c44-e0b2-276e-a818ce99317f@infradead.org>
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

SGksIFJhbmR5LA0KDQo+ID4gKwkJCXJhdGVsaW1pdDpOIC0NCj4gPiArCQkJCSAgU2V0IHJhdGUg
bGltaXQgdG8gTiBidXMgbG9ja3MgcGVyIHNlY29uZA0KPiA+ICsJCQkJICBmb3IgYnVzIGxvY2sg
ZGV0ZWN0aW9uLiAwIDwgTiA8PSBIWi8yIGFuZA0KPiA+ICsJCQkJICBOIGlzIGFwcHJveGltYXRl
LiBPbmx5IGFwcGxpZWQgdG8gbm9uLXJvb3QNCj4gPiArCQkJCSAgdXNlcnMuDQo+IA0KPiBTb3Jy
eSwgYnV0IEkgZG9uJ3Qga25vdyB3aGF0IHRoaXMgbWVhbnMuIEkgdGhpbmsgaXQncyB0aGUgImFu
ZCBOIGlzDQo+IGFwcHJvcHJpYXRlIg0KPiB0aGF0IGlzIGNvbmZ1c2luZyBtZS4NCj4gDQo+IAkw
IDwgTiA8PSBIWi8yIGFuZCBOIGlzIGFwcHJvcHJpYXRlLg0KDQpZb3UgYXJlIHJpZ2h0LiBJIHdp
bGwgcmVtb3ZlICJhbmQgTiBpcyBhcHByb3ByaWF0ZSIgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0K
Q291bGQgeW91IHBsZWFzZSBhY2sgdGhpcyBwYXRjaD8gQ2FuIEkgYWRkIEFja2VkLWJ5IGZyb20g
eW91IGluIHRoZSB1cGRhdGVkIHBhdGNoPw0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3Vy
IHJldmlldyENCg0KLUZlbmdodWENCg==
