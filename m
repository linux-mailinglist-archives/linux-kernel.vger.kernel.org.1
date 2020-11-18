Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859502B8480
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgKRTPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRTPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:15:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B55CC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:15:36 -0800 (PST)
Received: from zn.tnic (p200300ec2f0caf00cee835374c0b640d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:cee8:3537:4c0b:640d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 103321EC03CE;
        Wed, 18 Nov 2020 20:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605726935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqIotljMeQRb3ZrNXDcMWCo5/iu4qA1ZsSfiXmWn2G4=;
        b=MZueEn9IjMFjItc8MGA39Bv4Ew88Nh1/FP6mtKFx5sPdP0cmyTpzElVwrzXtiPHsIxJ7DS
        1yiCPcgxwx2l52hMAeiyzeSH9wy2+it0RfwGmK11ZdZ82petKzzqHPjbr2TcBVDBNJD6Zo
        4v81b3LM0GMrCrUn83HvJ3Zq/2Cs8/M=
Date:   Wed, 18 Nov 2020 20:15:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        thomas.lendacky@amd.com, yazen.ghannam@amd.com, wei.huang2@amd.com
Subject: Re: [RFC PATCH v3] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20201118191529.GN7472@zn.tnic>
References: <1603344083-100742-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1603344083-100742-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:21:23PM +0800, Feng Tang wrote:
> diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
> new file mode 100644
> index 0000000..9bd35b7
> --- /dev/null
> +++ b/tools/arch/x86/kcpuid/kcpuid.c
> @@ -0,0 +1,618 @@
> +// SPDX-License-Identifier: GPL-2.0

You need here:

#define _GNU_SOURCE

otherwise:

cc -Wextra -O2 -Wall -I../../../include -o kcpuid kcpuid.c 
kcpuid.c: In function ‘parse_line’:
kcpuid.c:324:6: warning: implicit declaration of function ‘strcasestr’; did you mean ‘strcasecmp’? [-Wimplicit-function-declaration]
  324 |  if (strcasestr(buf, "EAX"))
      |      ^~~~~~~~~~
      |      strcasecmp


Also, options text needs fixing:

  usage: kcpuid [-abdfhr] [-l leaf] [-s subleaf]
        -a|--all             Show info of all CPUID leafs and subleafs(default on)
        -b|--bitflags        Show boolean flags only
        -d|--detail          Show details of the flag/fields
        -f|--flags           Show boolean flags only

that f is user_csv, above in the "usage" line too.

        -h|--help            Show usage info
        -l|--leaf=index      Specify the leaf you want to check
        -r|--raw             Show raw cpuid data
        -s|--subleaf=sub     Specify the subleaf you want to check

> +/*
> + * Parse text file, and construct the array of all CPUID leafs and subleafs
> + */
> +static void parse_text(void)
> +{
> +	FILE *file;
> +	char *filename, *line = NULL;

Do here:

	char *filename = def_csv;

> +	size_t len = 0;
> +	int ret;
> +
> +	if (show_raw)
> +		return;
> +
> +	filename = user_csv ? user_csv : def_csv;

And now you do:

	if (user_csv)
		filename = user_csv;


But something's not working still. I've added debug output and it chokes
on the test data:

$ ./kcpuid -f cpuid.csv 
This platform has 51 CPUID leafs and subleafs.

parse_text: filename: cpuid.csv
open
parsing [# The basic row format is:
]parsing [# LEAF,SUBLEAF,register_name,bits,short name,long description
]parsing [
]parsing [# Leaf 00H
]parsing [         0,    0,  EAX,   31:0, max_basic_leafs,  Max input value for supported subleafs
]parsing [# Leaf 01H
]parsing [         1,    0,  EAX,    3:0, stepping,  Stepping ID
]parsing [         1,    0,  EAX,    7:4, model,  Model
]parsing [         1,    0,  EAX,   11:8, family,  Family ID
]parsing [         1,    0,  EAX,  13:12, processor,  Processor Type
]parsing [         1,    0,  EAX,  19:16, model_ext,  Extended Model ID
]parsing [         1,    0,  EAX,  27:20, family_ext,  Extended Family ID
]parsing [
]parsing [         1,    0,  EBX,    7:0, brand,  Brand Index
]parsing [         1,    0,  EBX,   15:8, clflush_size,  CLFLUSH line size (value * 8) in bytes
]parsing [         1,    0,  EBX,  23:16, max_cpu_id,  Maxim number of addressable logic cpu in this package
]parsing [         1,    0,  EBX,  31:24, apic_id,  Initial APIC ID
]parsing [
]parsing [         1,    0,  ECX,      0, sse3,  Streaming SIMD Extensions 3(SSE3)
]parsing [         1,    0,  ECX,      1, pclmulqdq,  PCLMULQDQ instruction supported
]parsing [         1,    0,  ECX,      2, dtes64,  DS area uses 64-bit layout
]parsing [         1,    0,  ECX,      3, mwait,  MONITOR/MWAIT supported
]parsing [         1,    0,  ECX,      4, ds_cpl,  CPL Qualified Debug Store which allows for branch message storage qualified by CPL
]parsing [         1,    0,  ECX,      5, vmx,  Virtual Machine Extensions supported
]parsing [         1,    0,  ECX,      6, smx,  Safer Mode Extension supported
]parsing [         1,    0,  ECX,      7, eist,  Enhanced Intel SpeedStep Technology
]parsing [         1,    0,  ECX,      8, tm2,  Thermal Monitor 2
]parsing [         1,    0,  ECX,      9, ssse3,  Supplemental Streaming SIMD Extensions 3 (SSSE3)
]parsing [         1,    0,  ECX,     10, l1_ctx_id,  L1 data cache could be set to either adaptive mode or shared mode (check IA32_MISC_ENABLE bit 24 definition)
]parsing [         1,    0,  ECX,     11, sdbg,  IA32_DEBUG_INTERFACE MSR for silicon debug supported
]parsing [         1,    0,  ECX,     12, fma,  FMA extensions using YMM state supported
]parsing [         1,    0,  ECX,     13, cmpxchg16b,  'CMPXCHG16B - Compare and Exchange Bytes' supported
]parsing [         1,    0,  ECX,     14, xtpr_update,  xTPR Update Control supported
]parsing [         1,    0,  ECX,     15, pdcm,  Perfmon and Debug Capability present
]parsing [         1,    0,  ECX,     17, pcid,  Process-Context Identifiers feature present
]parsing [         1,    0,  ECX,     18, dca,  Prefetching data from a memory mapped device supported
]parsing [         1,    0,  ECX,     19, sss4_1,  SSE4.1 feature present
]parsing [         1,    0,  ECX,     20, sse4_2,  SSE4.2 feature present
]parsing [         1,    0,  ECX,     21, x2apic,  x2APIC supported
]parsing [         1,    0,  ECX,     22, movbe,  MOVBE instruction supported
]parsing [         1,    0,  ECX,     23, popcnt,  POPCNT instruction supported
]parsing [         1,    0,  ECX,     24, tsc_deadline_timer,  LAPIC supports one-shot operation using a TSC deadline value
]parsing [         1,    0,  ECX,     25, aesni,  AESNI instruction supported
]parsing [         1,    0,  ECX,     26, xsave,  XSAVE/XRSTOR processor extended states (XSETBV/XGETBV/XCR0)
]parsing [         1,    0,  ECX,     27, osxsave,  OS has set CR4.OSXSAVE bit to enable XSETBV/XGETBV/XCR0
]parsing [         1,    0,  ECX,     28, avx,  AVX instruction supported
]parsing [         1,    0,  ECX,     29, f16c,  16-bit floating-point conversion instruction supported
]parsing [         1,    0,  ECX,     30, rdrand,  RDRAND instruction supported
]parsing [
]parsing [#
]parsing [# !!! Test data for testing different options, will be updated in formal version
]parsing [#
]parsing [         4,    0,  ECX,      1, aaa,  AAA
Segmentation fault
$

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
