Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57828335F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgJEJfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:35:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7FEC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 02:35:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07d50036327c3d826b48a2.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d500:3632:7c3d:826b:48a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30D8D1EC0426;
        Mon,  5 Oct 2020 11:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601890515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W8woDbvJLijb35fDU/RutftYrIqhVN2XUIRV2SFOGkE=;
        b=hJDoeb51CAbZB0+ATa/VLgy33Djo0NZLL3gR03T1pucCJ7/0JYIWZNv4DIlCXQ6XMrYd0z
        YonaXiEhA/Qd43YtGqHCiKni68EvogpOFRMgj0pYUnCedPpXhA5M99nr+KXlFNBEpBZVXO
        iGM3oNEBNS4WxpNlv6WiB2Tjuy+aoRE=
Date:   Mon, 5 Oct 2020 11:35:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/resctrl: Correct MBM total and local values
Message-ID: <20201005093506.GB21151@zn.tnic>
References: <1601331173-185230-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1601331173-185230-1-git-send-email-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 03:12:53PM -0700, Fenghua Yu wrote:
> MBM total and local readings are corrected by the following correction
> factor table on Broadwell server and Skylake server.
> 
> core		rmid		rmid			correction
> count		count		threshold		factor
> 1		8		0			1.000000
> 2		16		0			1.000000
> 3		24		15			0.969650
> 4		32		0			1.000000
> 5		40		31			1.066667
> 6		48		31			0.969650
> 7		56		47			1.142857
> 8		64		0			1.000000
> 9		72		63			1.185115
> 10		80		63			1.066553
> 11		88		79			1.454545
> 12		96		0			1.000000
> 13		104		95			1.230769
> 14		112		95			1.142857
> 15		120		95			1.066667
> 16		128		0			1.000000
> 17		136		127			1.254863
> 18		144		127			1.185255
> 19		152		0			1.000000
> 20		160		127			1.066667
> 21		168		0			1.000000
> 22		176		159			1.454334
> 23		184		0			1.000000
> 24		192		127			0.969744
> 25		200		191			1.280246
> 26		208		191			1.230921
> 27		216		0			1.000000
> 28		224		191			1.143118

Table is already in the code, why is it needed in the commit message
too?

> If rmid > rmid threshold, MBM total and local values should be multipled
> by the correction factor.
> 
> The above table is modified for better code:
> 1. The threshold 0 is changed to rmid count - 1 so we don't do correction

Who is "we"?

>    for the case.
> 2. Correction factor is normalized to 2^20 for better performance
>    by avoiding floating point and division calculation in corrected
>    MBM values.
> 
> Detailed information about the correction is described in erratum SKX99:
> https://www.intel.com/content/www/us/en/processors/xeon/scalable/xeon-scalable-spec-update.html
> and BDF102: https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-e5-v4-spec-update.pdf
> 
> The problem is described in details in "3.6 Intel MBM RMID Imbalance":
> https://software.intel.com/content/www/us/en/develop/articles/intel-resource-director-technology-rdt-reference-manual.html

I hear those URLs are awfully unstable. I'd suggested you upload the
pdfs to bugzilla but the erratum text is short enough so that you can
simply add it here.

> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> Applied to tip:x86/cache.
> 
>  arch/x86/kernel/cpu/resctrl/core.c     |  4 ++
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 75 +++++++++++++++++++++++++-
>  3 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 9e1712e8aef7..efe3ed61ae0c 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -893,6 +893,10 @@ static __init void __check_quirks_intel(void)
>  			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
>  		else
>  			set_rdt_options("!l3cat");
> +		/* FALLTHROUGH */

WARNING: Prefer 'fallthrough;' over fallthrough comment
#89: FILE: arch/x86/kernel/cpu/resctrl/core.c:896:
+               /* FALLTHROUGH */


Have you heard of checkpatch.pl?

> +	case INTEL_FAM6_BROADWELL_X:
> +		intel_rdt_mbm_quirk();
> +		break;
>  	}

...

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 54dffe574e67..05e06744e4b1 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
>  #include "internal.h"
>  
>  struct rmid_entry {
> @@ -64,6 +65,61 @@ unsigned int rdt_mon_features;
>   */
>  unsigned int resctrl_cqm_threshold;
>  
> +#define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
> +
> +/*
> + * MBM total and local correction table indexed by CBO which is equal to

"CBO" is?

> + * (x86_cache_max_rmid + 1) / 8 - 1 and is from 0 up to 27.
> + * The correction factor is normalized to 2^20 (1048576) so it's faster
> + * to calculate corrected value by shifting:
> + * corrected_value = (original_value * correction_factor) >> 20
> + */
> +static struct mbm_creation_factor_table {
> +	u32 rmidthreshold;
> +	u64 cf;
> +} mbm_cf_table[] = {

That array wants to be read-only right?

> +	{7,	CF(1.000000)},
> +	{15,	CF(1.000000)},
> +	{15,	CF(0.969650)},
> +	{31,	CF(1.000000)},
> +	{31,	CF(1.066667)},
> +	{31,	CF(0.969650)},
> +	{47,	CF(1.142857)},
> +	{63,	CF(1.000000)},
> +	{63,	CF(1.185115)},
> +	{63,	CF(1.066553)},
> +	{79,	CF(1.454545)},
> +	{95,	CF(1.000000)},
> +	{95,	CF(1.230769)},
> +	{95,	CF(1.142857)},
> +	{95,	CF(1.066667)},
> +	{127,	CF(1.000000)},
> +	{127,	CF(1.254863)},
> +	{127,	CF(1.185255)},
> +	{151,	CF(1.000000)},
> +	{127,	CF(1.066667)},
> +	{167,	CF(1.000000)},
> +	{159,	CF(1.454334)},
> +	{183,	CF(1.000000)},
> +	{127,	CF(0.969744)},
> +	{191,	CF(1.280246)},
> +	{191,	CF(1.230921)},
> +	{215,	CF(1.000000)},
> +	{191,	CF(1.143118)},
> +};
> +
> +static u32 mbm_cf_rmidthreshold = UINT_MAX;
> +static u64 mbm_cf;
> +
> +static inline u64 corrected_mbm_count(u32 rmid, unsigned long val)

Function name needs a verb.

> +{
> +	/* Correct MBM value. */
> +	if (rmid > mbm_cf_rmidthreshold)
> +		val = (val * mbm_cf) >> 20;
> +
> +	return val;
> +}

...

> @@ -644,3 +701,17 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>  
>  	return 0;
>  }
> +
> +void intel_rdt_mbm_quirk(void)

Function name needs a verb.

> +{
> +	int cf_index;
> +
> +	cf_index = (boot_cpu_data.x86_cache_max_rmid + 1) / 8 - 1;
> +	if (cf_index >= ARRAY_SIZE(mbm_cf_table)) {
> +		pr_info("No MBM correction factor available\n");
> +		return;
> +	}
> +
> +	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
> +	mbm_cf = mbm_cf_table[cf_index].cf;
> +}
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
