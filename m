Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86D02AE22D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbgKJVvX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Nov 2020 16:51:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:41660 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbgKJVvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:51:23 -0500
IronPort-SDR: zeE6BVXe3ONJZveYVeEVHCK+Ei2N3dpiPEKKQedFaijlVnqPD/ib5zYHF4FFf/U1K2pCDRcaQ0
 eb+lDguyGz1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157834602"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="157834602"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 13:51:22 -0800
IronPort-SDR: hgbN+aSzxJUobyUNKP5Ey77nbpJmKsz6Z24SAOBjXf3jZ9TvwqUnPs7qo1oXmiuMrhUSTQkJ18
 sdNR9d9fhRGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="366009589"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 10 Nov 2020 13:51:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 13:51:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 13:51:21 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Tue, 10 Nov 2020 13:51:21 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH 2/4] x86/bus_lock: Handle warn and fatal in #DB for bus
 lock
Thread-Topic: [PATCH 2/4] x86/bus_lock: Handle warn and fatal in #DB for bus
 lock
Thread-Index: AQHWtYfF4TjZwnZuxk2663g267Awp6nAABEAgAHrMjA=
Date:   Tue, 10 Nov 2020 21:51:21 +0000
Message-ID: <52f0c74cb1714a78bc84e158d26e7c38@intel.com>
References: <20201108042918.1011889-1-fenghua.yu@intel.com>
 <20201108042918.1011889-3-fenghua.yu@intel.com>
 <20201109082958.GZ2594@hirez.programming.kicks-ass.net>
In-Reply-To: <20201109082958.GZ2594@hirez.programming.kicks-ass.net>
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

> On Sun, Nov 08, 2020 at 04:29:16AM +0000, Fenghua Yu wrote:
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
> 
> > +void handle_bus_lock(struct pt_regs *regs) {
> > +	if (!bld)
> > +		return;
> > +
> > +	pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address:
> 0x%lx\n",
> > +			    current->comm, current->pid, regs->ip); }
> 
> So the Changelog above, and the state_show() below, seem to suggest there
> should be SIGBUS code in #DB, but I'm having trouble spotting it.

You are right. The SIGBUS is missing here. Somehow my tests didn't capture the issue.

I will add:
+		force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
to send SIGBUS in fatal case for #DB bus lock.

Thank you very much for your review!

-Fenghua

