Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD42E998A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbhADQBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:01:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:14845 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbhADQBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:01:08 -0500
IronPort-SDR: LY0IhoNdLQZksucFQmZA9WCpG8buArL1LE9vaGFuZDj54kVdPr1/AzN0YhyiJJceGLeYRxKR5A
 AkiihvIbMokg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="195494085"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="195494085"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 08:00:27 -0800
IronPort-SDR: gRxx+WKWDxZsIc1NEWudMjU3+XMIeKAERsZSqb04jHajrz5fqAY8SH/Eb7zfhdNLYTuBwaH/ue
 qYJCCthTRgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="421412074"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2021 08:00:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 08:00:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 08:00:26 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Mon, 4 Jan 2021 08:00:26 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ia64: fix xchg() warning
Thread-Topic: [PATCH] ia64: fix xchg() warning
Thread-Index: AQHW4ne7MfwZlffP1Ui4sWDmvkQA/6oXsvCAgAAHY4D//+Wi4A==
Date:   Mon, 4 Jan 2021 16:00:26 +0000
Message-ID: <71274a7cdf7d48bf9c2fda873fa37727@intel.com>
References: <20210104085806.4176886-1-arnd@kernel.org>
 <ad54481b-15da-e795-0c1a-bd54d3e8ab87@physik.fu-berlin.de>
 <CAK8P3a3zDB5wh-bdg+fq6nvg9gHrESFhhgss4f47VJ1JOvoE1Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3zDB5wh-bdg+fq6nvg9gHrESFhhgss4f47VJ1JOvoE1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIGhhdmUgbm90IHJlY2VpdmVkIGFueSByZXBseSBmcm9tIHRoZSBpYTY0IG1haW50YWluZXJz
LCBJIGFzc3VtZSB0aGV5IHdlcmUNCj4gYm90aCBvdXQgb2Ygb2ZmaWNlIGZvciBDaHJpc3RtYXMu
DQoNCkknbSBiYWNrIGluIHRoZSBvZmZpY2UgLi4uIGJ1dCBoYXZlIG5vIHdvcmtpbmcgaWE2NCBt
YWNoaW5lcywgbm9yIHRpbWUgdG8gbG9vayBhdCBwYXRjaGVzIDotKA0KDQpTaG91bGQgZHJvcCBt
ZSBmcm9tIHRoZSBNQUlOVEFJTlRFUlMgZmlsZS4NCg0KLVRvbnkNCg==
