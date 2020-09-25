Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC0279551
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgIZACc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:02:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:51330 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgIZACc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:02:32 -0400
IronPort-SDR: ecWFLi2tbqR/p25QMIHXSNoSrNn3kza5XI0TLNsAXwFewv90a0/y6+8qew9PwzJvxHjtMn7BGl
 6VQB4aMGP6Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="159010602"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="159010602"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 16:06:22 -0700
IronPort-SDR: Gj73vju1PevShmuOPOGSqNY1n7hilQGGdQO/3rcDX3UxbTjM1GWgBi+oN98rBEpKyzftWs7sCC
 Ia8iPlg5Natw==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="337032376"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 16:06:22 -0700
Date:   Fri, 25 Sep 2020 16:06:20 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Song, Youquan" <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Message-ID: <20200925230620.GA26621@agluck-desk2.amr.corp.intel.com>
References: <20200615184056.26531-1-tony.luck@intel.com>
 <20200616192952.GO13515@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F670974@ORSMSX115.amr.corp.intel.com>
 <20200617074158.GB10118@zn.tnic>
 <20200617184901.GA387@agluck-desk2.amr.corp.intel.com>
 <20200828202150.GA11854@agluck-desk2.amr.corp.intel.com>
 <20200925191912.GO16872@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925191912.GO16872@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 09:19:12PM +0200, Borislav Petkov wrote:
> And after staring at this a bit, it looks like all it wants to do is to
> adjust the severity. And we have a severity grading mechanism. So let's
> see how ugly it would become if we extended it to check that too.
> 
> So how's that below instead?

In some ways that's pretty neat. But it would still be ugly if we need
to extend it further for other issues. Especially if they don't have such
a simple rule to adjust the severity.

> It builds here, I haven't even thought about testing it and I might've
> missed out on some aspects but tbh this looks much better to me. Because
> it is not bolted on the handling path but integral part of it.
> 
> Thoughts?
> 
> ---
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index e1da619add19..8c1a41aa5e40 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -9,9 +9,11 @@
>  #include <linux/seq_file.h>
>  #include <linux/init.h>
>  #include <linux/debugfs.h>
> -#include <asm/mce.h>
>  #include <linux/uaccess.h>
>  
> +#include <asm/mce.h>
> +#include <asm/intel-family.h>
> +
>  #include "internal.h"
>  
>  /*
> @@ -40,9 +42,14 @@ static struct severity {
>  	unsigned char context;
>  	unsigned char excp;
>  	unsigned char covered;
> +	unsigned char cpu_model;
> +	unsigned char cpu_stepping;
> +	unsigned char bank_lo, bank_hi;

This would be better as a bit mask. I don't think we need this same
hack on the next generation of CPUs ... but if we did, the bank numbers
that would be affected don't form a continuous sequence.

>  	char *msg;
>  } severities[] = {
>  #define MCESEV(s, m, c...) { .sev = MCE_ ## s ## _SEVERITY, .msg = m, ## c }
> +#define BANK_RANGE(l, h) .bank_lo = l, .bank_hi = h
> +#define MODEL_STEPPING(m,s) .cpu_model = m, .cpu_stepping = s
>  #define  KERNEL		.context = IN_KERNEL
>  #define  USER		.context = IN_USER
>  #define  KERNEL_RECOV	.context = IN_KERNEL_RECOV
> @@ -97,7 +104,10 @@ static struct severity {
>  		KEEP, "Corrected error",
>  		NOSER, BITCLR(MCI_STATUS_UC)
>  		),
> -
> +	MCESEV(AO, "UnCorrected Patrol Scrub Error",
> +		NOSER, MASK(0xffffeff0, 0x001000c0),
> +		MODEL_STEPPING(INTEL_FAM6_SKYLAKE_X, 4),BANK_RANGE(13,18)
> +	),

I'd need to stare at the placement of this in the sequence of rules at some
non-Friday-afternoon time. It might be right, but as we've grumbled together
many times before that code is full of surprise side effects.

>  	/*
>  	 * known AO MCACODs reported via MCE or CMC:
>  	 *
> @@ -324,6 +334,12 @@ static int mce_severity_intel(struct mce *m, int tolerant, char **msg, bool is_e
>  			continue;
>  		if (s->excp && excp != s->excp)
>  			continue;
> +		if (s->cpu_model && boot_cpu_data.x86_model != s->cpu_model)
> +			continue;
> +		if (s->cpu_stepping && boot_cpu_data.x86_stepping <= s->cpu_stepping)
> +			continue;
> +		if (s->bank_lo && (s->bank_lo <= m->bank && m->bank <= s->bank_hi))
> +			continue;
>  		if (msg)
>  			*msg = s->msg;
>  		s->covered = 1;

-Tony
