Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0C72CC7EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgLBUg4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Dec 2020 15:36:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:1712 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgLBUg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:36:56 -0500
IronPort-SDR: Lmd6mXmjS40ZS/OXtCXxGdOEzzIBFPe5ZRDkmkEk5e2zvQYCWmW/V9EHs2y1oJeONOQN/As7t0
 dbiLSYCb9z/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="170517888"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="170517888"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 12:36:13 -0800
IronPort-SDR: KVsXxdEIGH0WO4Y8DHnZZYFabT9nbW/WWcaHwhjqob/VY78THRaYMoNv4+w+tK2uc6xHgwfILX
 9DcJ9CapMQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="373296501"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2020 12:36:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 12:36:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 12:36:11 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Wed, 2 Dec 2020 12:36:12 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v4 0/4] x86/bus_lock: Enable bus lock detection
Thread-Topic: [PATCH v4 0/4] x86/bus_lock: Enable bus lock detection
Thread-Index: AQHWwqPI8KLTpoG8aUep9FiVmYQyOankT8Zg
Date:   Wed, 2 Dec 2020 20:36:11 +0000
Message-ID: <34d86c3a1cd044f28f70202292e1d13a@intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com>
In-Reply-To: <20201124205245.4164633-1-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dear maintainers,

> A bus lock [1] is acquired through either split locked access to writeback (WB)
> memory or any locked access to non-WB memory. This is typically >1000
> cycles slower than an atomic operation within a cache line. It also disrupts
> performance on other cores.

...

> Change Log:
> v4:
> - Fix a ratelimit wording issue in the doc (Randy).
> - Patch 4 is acked by Randy (Randy).

Friendly reminder about this series...

Thank you very much in advance for your time!

-Fenghua
