Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39122B9D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 23:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKSWX4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 17:23:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:38388 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKSWXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 17:23:55 -0500
IronPort-SDR: k4i+zSMw4xda2NAFwdjKQfwgWCcwTP2Z3U1EtpVKy0pPTaFLK5kj1H7zo9iHM8zbYgDHuIFXSs
 Zs4vf50V2Bww==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="150643515"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="150643515"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 14:23:54 -0800
IronPort-SDR: dP6HCZlNXDz1NsBiTXGFFaIBrS7of0Yj+0DUbKRY2Lm0exCHk+4poOGlE8dT4YrMW+CNaG1LNv
 bPlxbbv2835A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="545202729"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2020 14:23:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 14:23:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 14:23:53 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Thu, 19 Nov 2020 14:23:53 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v2 2/4] x86/bus_lock: Handle warn and fatal in #DB for bus
 lock
Thread-Topic: [PATCH v2 2/4] x86/bus_lock: Handle warn and fatal in #DB for
 bus lock
Thread-Index: AQHWuF/UusXszEAgtU+4M68272E2dKnMzqyAgANEr9A=
Date:   Thu, 19 Nov 2020 22:23:53 +0000
Message-ID: <6eb1e38d9d184a188e0c2f12aabc370e@intel.com>
References: <20201111192048.2602065-1-fenghua.yu@intel.com>
 <20201111192048.2602065-3-fenghua.yu@intel.com>
 <20201117122455.GG3121406@hirez.programming.kicks-ass.net>
In-Reply-To: <20201117122455.GG3121406@hirez.programming.kicks-ass.net>
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

Hi, Peter,

> > #DB for bus lock is enabled by bus lock detection bit 2 in DEBUGCTL
> > MSR while #AC for split lock is enabled by split lock detection bit 29
> > in TEST_CTRL MSR.
> >
> > Delivery of #DB for bus lock in userspace clears DR6[11]. To avoid
> > confusion in identifying #DB, #DB handler sets the bit to 1 before
> > returning to the interrupted task.
> >
> > Use the existing kernel command line option "split_lock_detect=" to
> > handle #DB for bus lock:
> >
> > split_lock_detect=
> > 		#AC for split lock		#DB for bus lock
> >
> > off		Do nothing			Do nothing
> >
> > warn		Kernel OOPs			Warn once per task and
> > 		Warn once per task and		and continues to run.
> > 		disable future checking 	When both features are
> > 						supported, warn in #DB
> >
> > fatal		Kernel OOPs			Send SIGBUS to user
> > 		Send SIGBUS to user
> > 		When both features are
> > 		supported, fatal in #AC.
> >
> > Default option is "warn".
> >
> > Hardware only generates #DB for bus lock detect when CPL>0 to avoid
> > nested #DB from multiple bus locks while the first #DB is being handled.
> > So no need to handle #DB for bus lock detected in the kernel.
> >
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> Sane enough I suppose,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thank you very much for your review!

Can I put your Acked-by tag in all 4 patches?

> 
> The one thing I found still missing is a better description of the things tickling
> SLD vs BLD. IIRC BLD detects a wider range of issues.
> Therefore it _might_ make sense to allow SLD && BLD when fatal, instead of
> only SLD.
> 
> Still, that's nitpicking.

You are right. BLD can detect both split lock and UC memory access while SLD
only detects split lock. Enabling both SLD and BLD when fatal can capture
both split lock in #AC and UC access in #DB.

I will send the fixing series to enable both SLD and BLD when fatal.

-Fenghua
