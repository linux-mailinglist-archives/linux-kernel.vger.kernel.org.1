Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95392A30C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgKBRDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:03:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:57706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbgKBRDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:03:20 -0500
IronPort-SDR: fbBPK8TksxOC/RS4oEA6vMHoto2IKDKgcsv+8vSDSxjEeFVmHDWcT2xSsIerslTHLJH7ZJaYN/
 tbLPXK9Cq8Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="169049448"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="169049448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 09:03:19 -0800
IronPort-SDR: q5kmdPiKEtQDKNNWp+n72w+wUAUyWfY3tUxS3k3CVvY5IEgUBiU1BFDs6Dk5GONGTIi/F68pAa
 dRiql6loEmvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="352870894"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2020 09:03:18 -0800
Date:   Mon, 2 Nov 2020 17:03:18 +0000
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
Subject: Re: [PATCH RFC v3 4/4] Documentation/admin-guide: Change doc for
 split_lock_detect parameter
Message-ID: <20201102170318.GA3666727@otcwcpicx6.sc.intel.com>
References: <20201031002714.3649728-1-fenghua.yu@intel.com>
 <20201031002714.3649728-5-fenghua.yu@intel.com>
 <ed101622-11f8-0b98-76ad-6c100a2574da@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed101622-11f8-0b98-76ad-6c100a2574da@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy,

On Fri, Oct 30, 2020 at 08:14:15PM -0700, Randy Dunlap wrote:
> On 10/30/20 5:27 PM, Fenghua Yu wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 526d65d8573a..ee419ce659f5 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5044,27 +5044,45 @@
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
> > +			for split lock detection or a debug exception for
> > +			bus lock detection.
> >  
> >  			off	- not enabled
> >  
> >  			warn	- the kernel will emit rate limited warnings
> 
> 				                       rate-limited
> 
> >  				  about applications triggering the #AC
> > -				  exception. This mode is the default on CPUs
> > -				  that supports split lock detection.
> > +				  exception or the #DB exception. This mode is
> > +				  the default on CPUs that supports split lock
> 
> 				                           support
> 
> > +				  detection or bus lock detection. Default
> > +				  behavior is from #DB if both features are
> 
> I would say			           is by #DB
> 
> > +				  enabled in hardware.
> >  
> >  			fatal	- the kernel will send SIGBUS to applications
> > -				  that trigger the #AC exception.
> > +				  that trigger the #AC exception or the #DB
> > +				  exception. Default behavior is from #AC
> 
> and				                              is by #AC
> 
> > +				  if both features are enabled in hardware.
> > +
> > +			ratelimit:N -
> > +				  Set rate limit to N bus locks per second
> > +				  for bus lock detection. 0 < N <= HZ/2 and
> > +				  N is approximate. Only applied to non root
> 
> 				                                    non-root
> 
> > +				  user.
> 
> 				  users.

I'll fix the issues in the next version.

Thank you very much for your review!

-Fenghua
