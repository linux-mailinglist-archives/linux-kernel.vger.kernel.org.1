Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF152A9E94
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgKFUbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:31:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:28719 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbgKFUbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:31:50 -0500
IronPort-SDR: CrL1qW8QXV5OYjXf+OT3cQ10CkNnUgdD0FnMpy19vP3JRrlLM9P/exKqwn+IB3/VpUXocybT7p
 UfU73kWyIYBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="156598889"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="156598889"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 12:31:49 -0800
IronPort-SDR: /JA9U5PSw7i9DRVQWtgfeKWF9CEinqTxMQFDQDLt/eU3JnhtwYfpFZcdPDlOa56UoknaQ/9esC
 ODJH/rcloQZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="306958458"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga008.fm.intel.com with ESMTP; 06 Nov 2020 12:31:49 -0800
Date:   Fri, 6 Nov 2020 20:31:49 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Xiaoyao Li <xiaoyao.li@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH RFC v3 2/4] x86/bus_lock: Handle warn and fatal in #DB
 for bus lock
Message-ID: <20201106203149.GA4097366@otcwcpicx6.sc.intel.com>
References: <20201031002714.3649728-1-fenghua.yu@intel.com>
 <20201031002714.3649728-3-fenghua.yu@intel.com>
 <21d0415c-9af4-db18-8e65-410f6ab5ec68@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d0415c-9af4-db18-8e65-410f6ab5ec68@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xiaoyao,

On Tue, Nov 03, 2020 at 08:15:27PM +0800, Xiaoyao Li wrote:
> On 10/31/2020 8:27 AM, Fenghua Yu wrote:
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 3c70fb34028b..1c3442000972 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -953,6 +953,13 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
> >   		goto out_irq;
> >   	}
> > +	/*
> > +	 * Handle bus lock. #DB for bus lock can only be triggered from
> > +	 * userspace.
> > +	 */
> > +	if (!(dr6 & DR_BUS_LOCK))
> 
> it should be
> 
> 	if (dr6 & DR_BUS_LOCK)
> 
> since you keep DR6.[bit 11] reserved in this version. bit 11 of
> debug_read_clear_dr6() being set to 1 means bus lock detected.

You are right. Will fix it in the next version.

Thank you very much!

-Fenghua
