Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F7279250
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgIYUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgIYUif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:38:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF2FC0613DD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:19:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 000641EC02C1;
        Fri, 25 Sep 2020 21:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601061559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o6dxeuW4w4YTyZlUnMwe5bDuH5gje8wdVrfJtINpDoE=;
        b=D2NaNJcbApdtaYaViyQyZkrqtiqlW1JuIRncAQ4X9fUcF7+Nd+N03ykguuXblxs5DEsEnH
        8wbQyy3eohWxwiKYhUexLbEGODDjYjTzkpAOitCdxS1ZbnpkZRF91QxtIbJV1mETmf2Mda
        +k/bNk2jhAD6CizI3Zd3f/hJHb1iBUE=
Date:   Fri, 25 Sep 2020 21:19:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Song, Youquan" <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Message-ID: <20200925191912.GO16872@zn.tnic>
References: <20200615184056.26531-1-tony.luck@intel.com>
 <20200616192952.GO13515@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F670974@ORSMSX115.amr.corp.intel.com>
 <20200617074158.GB10118@zn.tnic>
 <20200617184901.GA387@agluck-desk2.amr.corp.intel.com>
 <20200828202150.GA11854@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828202150.GA11854@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 01:21:50PM -0700, Luck, Tony wrote:
> +static void adjust_mce_log(struct mce *m)
> +{
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +
> +	if (c->x86_vendor == X86_VENDOR_INTEL && c->x86 == 6 &&
> +	    c->x86_model == INTEL_FAM6_SKYLAKE_X && c->x86_stepping >= 4) {
> +		/*
> +		 * Check the error code to see if this is an uncorrected patrol
> +		 * scrub error from one of the memory controller banks. If so,
> +		 * then adjust the severity level to MCE_AO_SEVERITY
> +		 */
> +		if (((m->status & MCACOD_SCRUBMSK) == MCACOD_SCRUB) &&
> +		    ((m->status & MSCOD_MASK) == MSCOD_UCE_SCRUB) &&
> +		    m->bank >= 13 && m->bank <= 18)
> +			m->severity = MCE_AO_SEVERITY;
> +	}
> +}
> +
>  DEFINE_PER_CPU(unsigned, mce_poll_count);
>  
>  /*
> @@ -772,6 +801,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
>  			goto clear_it;
>  
> +		adjust_mce_log(&m);
>  		mce_log(&m);

Coming back to this and looking at it, I can't say that I like it. We're
sticking hooks to look at and massage the logged data everywhere on the
MCE processing path and it is getting really unwieldy.

And after staring at this a bit, it looks like all it wants to do is to
adjust the severity. And we have a severity grading mechanism. So let's
see how ugly it would become if we extended it to check that too.

So how's that below instead?

It builds here, I haven't even thought about testing it and I might've
missed out on some aspects but tbh this looks much better to me. Because
it is not bolted on the handling path but integral part of it.

Thoughts?

---
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index e1da619add19..8c1a41aa5e40 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -9,9 +9,11 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
-#include <asm/mce.h>
 #include <linux/uaccess.h>
 
+#include <asm/mce.h>
+#include <asm/intel-family.h>
+
 #include "internal.h"
 
 /*
@@ -40,9 +42,14 @@ static struct severity {
 	unsigned char context;
 	unsigned char excp;
 	unsigned char covered;
+	unsigned char cpu_model;
+	unsigned char cpu_stepping;
+	unsigned char bank_lo, bank_hi;
 	char *msg;
 } severities[] = {
 #define MCESEV(s, m, c...) { .sev = MCE_ ## s ## _SEVERITY, .msg = m, ## c }
+#define BANK_RANGE(l, h) .bank_lo = l, .bank_hi = h
+#define MODEL_STEPPING(m,s) .cpu_model = m, .cpu_stepping = s
 #define  KERNEL		.context = IN_KERNEL
 #define  USER		.context = IN_USER
 #define  KERNEL_RECOV	.context = IN_KERNEL_RECOV
@@ -97,7 +104,10 @@ static struct severity {
 		KEEP, "Corrected error",
 		NOSER, BITCLR(MCI_STATUS_UC)
 		),
-
+	MCESEV(AO, "UnCorrected Patrol Scrub Error",
+		NOSER, MASK(0xffffeff0, 0x001000c0),
+		MODEL_STEPPING(INTEL_FAM6_SKYLAKE_X, 4),BANK_RANGE(13,18)
+	),
 	/*
 	 * known AO MCACODs reported via MCE or CMC:
 	 *
@@ -324,6 +334,12 @@ static int mce_severity_intel(struct mce *m, int tolerant, char **msg, bool is_e
 			continue;
 		if (s->excp && excp != s->excp)
 			continue;
+		if (s->cpu_model && boot_cpu_data.x86_model != s->cpu_model)
+			continue;
+		if (s->cpu_stepping && boot_cpu_data.x86_stepping <= s->cpu_stepping)
+			continue;
+		if (s->bank_lo && (s->bank_lo <= m->bank && m->bank <= s->bank_hi))
+			continue;
 		if (msg)
 			*msg = s->msg;
 		s->covered = 1;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
