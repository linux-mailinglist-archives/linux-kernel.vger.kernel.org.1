Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13F128436F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFAnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:43:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:37810 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgJFAnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:43:49 -0400
IronPort-SDR: 5g0sG7IrbYcyE7zxvxkOjOwp7KySsRavwrxjZ0xOojWJReeIiCCqBwTC7EZmVO2srIMNILKbvn
 8gz3VxKk4SXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163511715"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="163511715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 17:43:48 -0700
IronPort-SDR: OOFCHfBm4/akDzY00d2dzxIjXsV3R3XPLlolbmVOu+fdMvHVutRSlz5upIfNw1czD5QxbgjPrn
 PuEAbCvbG2kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="341724465"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2020 17:43:48 -0700
Date:   Tue, 6 Oct 2020 00:43:48 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/resctrl: Correct MBM total and local values
Message-ID: <20201006004348.GA1415745@otcwcpicx6.sc.intel.com>
References: <1601331173-185230-1-git-send-email-fenghua.yu@intel.com>
 <20201005093506.GB21151@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005093506.GB21151@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris,

On Mon, Oct 05, 2020 at 11:35:06AM +0200, Borislav Petkov wrote:
> On Mon, Sep 28, 2020 at 03:12:53PM -0700, Fenghua Yu wrote:
> > MBM total and local readings are corrected by the following correction
> > factor table on Broadwell server and Skylake server.
> > 
> > core		rmid		rmid			correction
> > count		count		threshold		factor
> > 1		8		0			1.000000
> > 2		16		0			1.000000
> > 3		24		15			0.969650
> > 4		32		0			1.000000
> > 5		40		31			1.066667
> > 6		48		31			0.969650
> > 7		56		47			1.142857
> > 8		64		0			1.000000
> > 9		72		63			1.185115
> > 10		80		63			1.066553
> > 11		88		79			1.454545
> > 12		96		0			1.000000
> > 13		104		95			1.230769
> > 14		112		95			1.142857
> > 15		120		95			1.066667
> > 16		128		0			1.000000
> > 17		136		127			1.254863
> > 18		144		127			1.185255
> > 19		152		0			1.000000
> > 20		160		127			1.066667
> > 21		168		0			1.000000
> > 22		176		159			1.454334
> > 23		184		0			1.000000
> > 24		192		127			0.969744
> > 25		200		191			1.280246
> > 26		208		191			1.230921
> > 27		216		0			1.000000
> > 28		224		191			1.143118
> 
> Table is already in the code, why is it needed in the commit message
> too?

This is the original table I get from hardware guys. The table is not
published anywhere else (not in errata docs) except in this patch. To
optimize the code, the table is converted to an array in the patch. 

I keep this original table here for two reasons:
1. It's an original table that can be tracked by any one in the future.
   If I don't list the original table here, others may wonder where I
   get the converted table from.
2. Reviewers may check if the converted table in the patch is correctly
   converted by comparing the converted table to the original table.

So I can keep this original table in the commit message, right? I will
add more info why I keep it in the commit message.

> 
> > If rmid > rmid threshold, MBM total and local values should be multipled
> > by the correction factor.
> > 
> > The above table is modified for better code:
> > 1. The threshold 0 is changed to rmid count - 1 so we don't do correction
> 
> Who is "we"?

I will not use "we".

> 
> >    for the case.
> > 2. Correction factor is normalized to 2^20 for better performance
> >    by avoiding floating point and division calculation in corrected
> >    MBM values.
> > 
> > Detailed information about the correction is described in erratum SKX99:
> > https://www.intel.com/content/www/us/en/processors/xeon/scalable/xeon-scalable-spec-update.html
> > and BDF102: https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-e5-v4-spec-update.pdf
> > 
> > The problem is described in details in "3.6 Intel MBM RMID Imbalance":
> > https://software.intel.com/content/www/us/en/develop/articles/intel-resource-director-technology-rdt-reference-manual.html
> 
> I hear those URLs are awfully unstable. I'd suggested you upload the
> pdfs to bugzilla but the erratum text is short enough so that you can
> simply add it here.

Ok. I will describe the problem in the commit message.

> 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> > 
> > Applied to tip:x86/cache.
> > 
> >  arch/x86/kernel/cpu/resctrl/core.c     |  4 ++
> >  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
> >  arch/x86/kernel/cpu/resctrl/monitor.c  | 75 +++++++++++++++++++++++++-
> >  3 files changed, 78 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 9e1712e8aef7..efe3ed61ae0c 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -893,6 +893,10 @@ static __init void __check_quirks_intel(void)
> >  			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
> >  		else
> >  			set_rdt_options("!l3cat");
> > +		/* FALLTHROUGH */
> 
> WARNING: Prefer 'fallthrough;' over fallthrough comment
> #89: FILE: arch/x86/kernel/cpu/resctrl/core.c:896:
> +               /* FALLTHROUGH */
> 
> 
> Have you heard of checkpatch.pl?
> 

Ok. Will fix the warning.

> > +	case INTEL_FAM6_BROADWELL_X:
> > +		intel_rdt_mbm_quirk();
> > +		break;
> >  	}
> 
> ...
> 
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index 54dffe574e67..05e06744e4b1 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <asm/cpu_device_id.h>
> > +#include <asm/intel-family.h>
> >  #include "internal.h"
> >  
> >  struct rmid_entry {
> > @@ -64,6 +65,61 @@ unsigned int rdt_mon_features;
> >   */
> >  unsigned int resctrl_cqm_threshold;
> >  
> > +#define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
> > +
> > +/*
> > + * MBM total and local correction table indexed by CBO which is equal to
> 
> "CBO" is?

CBO is Caching Agent. To make it more readable, I will change the words to
"... indexed by core count which ...".

> 
> > + * (x86_cache_max_rmid + 1) / 8 - 1 and is from 0 up to 27.
> > + * The correction factor is normalized to 2^20 (1048576) so it's faster
> > + * to calculate corrected value by shifting:
> > + * corrected_value = (original_value * correction_factor) >> 20
> > + */
> > +static struct mbm_creation_factor_table {
> > +	u32 rmidthreshold;
> > +	u64 cf;
> > +} mbm_cf_table[] = {
> 
> That array wants to be read-only right?

Ok. Will add "const" to the array.

> 
> > +	{7,	CF(1.000000)},
> > +	{15,	CF(1.000000)},
> > +	{15,	CF(0.969650)},
> > +	{31,	CF(1.000000)},
> > +	{31,	CF(1.066667)},
> > +	{31,	CF(0.969650)},
> > +	{47,	CF(1.142857)},
> > +	{63,	CF(1.000000)},
> > +	{63,	CF(1.185115)},
> > +	{63,	CF(1.066553)},
> > +	{79,	CF(1.454545)},
> > +	{95,	CF(1.000000)},
> > +	{95,	CF(1.230769)},
> > +	{95,	CF(1.142857)},
> > +	{95,	CF(1.066667)},
> > +	{127,	CF(1.000000)},
> > +	{127,	CF(1.254863)},
> > +	{127,	CF(1.185255)},
> > +	{151,	CF(1.000000)},
> > +	{127,	CF(1.066667)},
> > +	{167,	CF(1.000000)},
> > +	{159,	CF(1.454334)},
> > +	{183,	CF(1.000000)},
> > +	{127,	CF(0.969744)},
> > +	{191,	CF(1.280246)},
> > +	{191,	CF(1.230921)},
> > +	{215,	CF(1.000000)},
> > +	{191,	CF(1.143118)},
> > +};
> > +
> > +static u32 mbm_cf_rmidthreshold = UINT_MAX;
> > +static u64 mbm_cf;
> > +
> > +static inline u64 corrected_mbm_count(u32 rmid, unsigned long val)
> 
> Function name needs a verb.

Will add a verb in the name.

> 
> > +{
> > +	/* Correct MBM value. */
> > +	if (rmid > mbm_cf_rmidthreshold)
> > +		val = (val * mbm_cf) >> 20;
> > +
> > +	return val;
> > +}
> 
> ...
> 
> > @@ -644,3 +701,17 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
> >  
> >  	return 0;
> >  }
> > +
> > +void intel_rdt_mbm_quirk(void)
> 
> Function name needs a verb.

Will add a verb in the name.

> 
> > +{
> > +	int cf_index;
> > +
> > +	cf_index = (boot_cpu_data.x86_cache_max_rmid + 1) / 8 - 1;
> > +	if (cf_index >= ARRAY_SIZE(mbm_cf_table)) {
> > +		pr_info("No MBM correction factor available\n");
> > +		return;
> > +	}
> > +
> > +	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
> > +	mbm_cf = mbm_cf_table[cf_index].cf;
> > +}
> > -- 
> 

Thank you very much for your review!

-Fenghua
