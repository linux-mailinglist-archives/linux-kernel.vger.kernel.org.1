Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FC2FB88E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392165AbhASNHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:07:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:18185 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393136AbhASNAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:00:08 -0500
IronPort-SDR: UbsR6+4d7YihrdqgNZhvhtn7vwh4npX5AOsgRChKLEa9p0rn3iIpmbeWypGCy8vGfHIVL20jDe
 1Dw8xxNLYyRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158692379"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="158692379"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 04:56:43 -0800
IronPort-SDR: yny2GPwwxTHgqcvt25gt0Pk9rP/v06zLB2Pgzamcqf+oLXM2XDX8rN727fFbWp5IEPf0pLHsRN
 TO3RxTm5viPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="355582899"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 04:56:40 -0800
Date:   Tue, 19 Jan 2021 20:56:39 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        thomas.lendacky@amd.com, yazen.ghannam@amd.com, wei.huang2@amd.com
Subject: Re: [PATCH v4] tools/x86: Add a kcpuid tool to show raw CPU features
Message-ID: <20210119125639.GA7976@shbuild999.sh.intel.com>
References: <1610955311-77910-1-git-send-email-feng.tang@intel.com>
 <20210119051942.GA87207@shbuild999.sh.intel.com>
 <20210119091116.GA27433@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119091116.GA27433@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 10:11:16AM +0100, Borislav Petkov wrote:
> On Tue, Jan 19, 2021 at 01:19:42PM +0800, Feng Tang wrote:
> > Sorry, after testing on more platforms, the following is needed to fix
> > a potential array overflow ((a full patch with fix is also attached)
> > 
> > diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
> > index 3ea607b..bf68335 100644
> > --- a/tools/arch/x86/kcpuid/kcpuid.c
> > +++ b/tools/arch/x86/kcpuid/kcpuid.c
> > @@ -329,7 +329,8 @@ static int parse_line(char *line)
> >  		range = leafs_basic;
> >  
> >  	index &= 0x7FFFFFFF;
> > -	if ((int)index > range->nr)
> > +	/* range->nr equals to max index plus 1 */
> > +	if ((int)index >= range->nr)
> 
> That comment is basically repeating the code. What it should do is
> explain *why* that test is being done or not be there at all.
 
Right! So this is better?
/* Skip line parsing for non-existing indexes */ 

Thanks,
Feng

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
