Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA62A0ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgJ3Tkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:40:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:38744 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3Tjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:39:55 -0400
IronPort-SDR: mNLE9XVsFajNJb6lxtxpSE8WL8at/GFkSc7/6lEqJAkPliliao5YxothQrf3QsscaLHHZuFbnz
 KlfB6LruttUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="147942226"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="147942226"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:39:55 -0700
IronPort-SDR: DlHlHGWJsUImM1T/HVqSCfLTrVVPXp9apXMWpZjbnNEmOUUabun9y+9izWZ6MY/SunI+WWPijU
 Hvv08IP71JeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="351972319"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2020 12:39:55 -0700
Date:   Fri, 30 Oct 2020 19:39:55 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH RFC v2 2/4] x86/bus_lock: Handle warn and fatal in #DB
 for bus lock
Message-ID: <20201030193955.GA3568909@otcwcpicx6.sc.intel.com>
References: <20201028202804.3562179-1-fenghua.yu@intel.com>
 <20201028202804.3562179-3-fenghua.yu@intel.com>
 <20201029092747.GI2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029092747.GI2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, PeterZ,

On Thu, Oct 29, 2020 at 10:27:47AM +0100, Peter Zijlstra wrote:
> On Wed, Oct 28, 2020 at 08:28:02PM +0000, Fenghua Yu wrote:
> > diff --git a/arch/x86/include/uapi/asm/debugreg.h b/arch/x86/include/uapi/asm/debugreg.h
> > index d95d080b30e3..61078319fc6c 100644
> > --- a/arch/x86/include/uapi/asm/debugreg.h
> > +++ b/arch/x86/include/uapi/asm/debugreg.h
> > @@ -16,7 +16,7 @@
> >     are either reserved or not of interest to us. */
> >  
> >  /* Define reserved bits in DR6 which are always set to 1 */
> > -#define DR6_RESERVED	(0xFFFF0FF0)
> > +#define DR6_RESERVED	(0xFFFF07F0)
> 
> NAK

You are right. I will remove this piece of code in the next version.

Thank you very much for your review!

-Fenghua
