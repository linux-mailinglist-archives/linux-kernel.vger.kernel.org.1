Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678D72A0ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgJ3Tmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:42:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:27176 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgJ3TmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:42:23 -0400
IronPort-SDR: H8baRqi+RF0MeV4/YFrIGgvvLthUiaHU+MYJTzrchE3NqRv+5uqEm0oYOfWzk/TEjmGx1EF+CW
 pCDPSBr8SyHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="186470801"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="186470801"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:42:23 -0700
IronPort-SDR: 2LqzMpecaSGCZgZvZ74w3bc3M2jxvYKrTt1mYBKkqHn7PTdeCWM98yxWZGilqE2kHyCRsaei8f
 23ZRHIjMRZYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="425432865"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2020 12:42:22 -0700
Date:   Fri, 30 Oct 2020 19:42:22 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH RFC v2 4/4] Documentation: Change doc for
 split_lock_detect parameter
Message-ID: <20201030194222.GB3568909@otcwcpicx6.sc.intel.com>
References: <20201028202804.3562179-1-fenghua.yu@intel.com>
 <20201028202804.3562179-5-fenghua.yu@intel.com>
 <1bb9d2f7-e20d-a0d9-c94f-328e1dc83323@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb9d2f7-e20d-a0d9-c94f-328e1dc83323@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy,

On Wed, Oct 28, 2020 at 10:14:20PM -0700, Randy Dunlap wrote:
> On 10/28/20 1:28 PM, Fenghua Yu wrote:
> > Since #DB for bus lock detect changes the split_lock_detect parameter,
> > update the documentation for the changes.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 47 +++++++++++++++----
> >  1 file changed, 39 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 526d65d8573a..51312484c2b6 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5044,27 +5044,58 @@
> >  	spia_peddr=
> >  
> >  	split_lock_detect=
> > -			[X86] Enable split lock detection
> > +			[X86] Enable split lock detection or bus lock detection
> >  
> >  			When enabled (and if hardware support is present), atomic
> >  			instructions that access data across cache line
> > -			boundaries will result in an alignment check exception.
> > +			boundaries will result in an alignment check exception
> > +			for split lock detection or an debug exception for
> > +			bus lock detection.
> >  
> >  			off	- not enabled
> >  
> > -			warn	- the kernel will emit rate limited warnings
> > -				  about applications triggering the #AC
> > -				  exception. This mode is the default on CPUs
> > -				  that supports split lock detection.
> > +			warn	- Default mode.
> >  
> > -			fatal	- the kernel will send SIGBUS to applications
> > -				  that trigger the #AC exception.
> > +				  If split lock detection is enabled in
> > +				  hardware, the kernel will emit rate limited
> > +				  warnings about applications triggering the #AC
> > +				  exception.
> > +
> > +				  If bus lock detection is enabled in hardware,
> > +				  the kernel will emit rate limited warnings
> > +				  about applications triggering the #DB
> > +				  exception.
> > +
> > +				  Default behavior is from bus lock detection
> > +				  if both features are enabled in hardware.
> > +
> > +			fatal	- If split lock detection is enabled in
> > +				  hardware, the kernel will send SIGBUS to
> > +				  applications that trigger the #AC exception.
> > +
> > +				  If bus lock detection is enabled in hardware,
> > +				  the kernel will send SIGBUS to application
> > +				  that trigger the #DB exception.
> > +
> > +				  Default behavior is from split lock detection
> > +				  if both are enabled in hardware.
> > +
> 
> Hi,
> This appears to have quite a bit of duplicated lines....

Ok. I will simplify this paragraph.

Thank you very much for your review!

-Fenghua
