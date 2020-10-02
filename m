Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED3281CFB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgJBUfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:35:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41056 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBUfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:35:01 -0400
Received: from zn.tnic (p200300ec2f0d6300a6f76f26514807a6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6300:a6f7:6f26:5148:7a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A3831EC04EF;
        Fri,  2 Oct 2020 22:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601670900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gIhn2nJNgPkHLjBHd02FlAZpUX9eip5ib99uM1At14Y=;
        b=ZsNxOdMSbxqkhZoJr3DUQuwVYKuKhRC35Eu2tFxJ5V4pVDRaeWy6SRSHYtnDs10M7nOLDO
        FhlfnS/y4ZfmBUFJretgd2iILe6/giLGhgAE/XBmNJJxZcNlznGMNAcNYf/aCHr7H5I6IM
        c9RpyxY+wj8LfTIDyPJYttvzPwVZ2uk=
Date:   Fri, 2 Oct 2020 22:34:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
Message-ID: <20201002203452.GE17436@zn.tnic>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
 <20201002201931.2826-3-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002201931.2826-3-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:19:30PM -0700, Ricardo Neri wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 35ad8480c464..0778b3ad26b3 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -932,6 +932,11 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>  		c->x86_capability[CPUID_D_1_EAX] = eax;
>  	}
>  
> +	if (cpu_has(c, X86_FEATURE_HYBRID_CPU)) {
> +		cpuid_count(0x0000001a, 0, &eax, &ebx, &ecx, &edx);
> +		c->x86_cpu_type = eax;

		c->x86_cpu_type = cpuid_eax(0x0000001a);

should do too.

But send this patch together with the code that uses it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
