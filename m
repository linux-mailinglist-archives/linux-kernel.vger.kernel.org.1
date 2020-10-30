Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3AD2A0E56
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgJ3TIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:08:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:23979 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgJ3TIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:08:09 -0400
IronPort-SDR: 8SP93TkFEbCSkQEn5aHKEZVq4V/mk9JLHnK4lzrje5x/l1na395qtZ5qPuhbZ3/cl7NvAUoIsw
 /mt1m0WLJbYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="232831984"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="232831984"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:08:08 -0700
IronPort-SDR: 2HVcMSo12Sm5KKBwNdvW5f+GxI+aFV0l719IoVciWyy64zbqlm5QHIeqP7aYZKiBbyzE8gSGU9
 ph0lUpmHIMaA==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537169798"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:08:08 -0700
Date:   Fri, 30 Oct 2020 12:08:07 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Philippe Conde <conde.philippe@skynet.be>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Enable additional error logging on certain
 Intel CPUs
Message-ID: <20201030190807.GA13884@agluck-desk2.amr.corp.intel.com>
References: <fcb21490-84a1-8b99-b494-3a6ac2a0e16a@skynet.be>
 <20201029100655.GA31903@zn.tnic>
 <20201029151518.GA23990@agluck-desk2.amr.corp.intel.com>
 <20201029194118.GC31903@zn.tnic>
 <87ft5wo8zn.fsf@nanos.tec.linutronix.de>
 <20201030091056.GA6532@zn.tnic>
 <20201030190400.GA13797@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030190400.GA13797@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 12:04:03PM -0700, Luck, Tony wrote:

Bah, didn't notice this conversation didn't include LKML.

> The Xeon versions of Sandy Bridge, Ivy Bridge and Haswell support an
> optional additional error logging mode which is enabled by an MSR.
> 
> Previously this mode was enabled from the mcelog(8) tool via /dev/cpu,
> but the kernel is now very picky about which MSRs may be written. So
> move the enabling into the kernel.
> 
> Suggested-by: Boris Petkov <bp@alien8.de>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> N.B. I don't have any of these old systems in my lab any more. So
> this is untested :-(
> 
>  arch/x86/include/asm/msr-index.h |  1 +
>  arch/x86/kernel/cpu/mce/intel.c  | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 972a34d93505..b2dd2648c0e2 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -139,6 +139,7 @@
>  #define MSR_IA32_MCG_CAP		0x00000179
>  #define MSR_IA32_MCG_STATUS		0x0000017a
>  #define MSR_IA32_MCG_CTL		0x0000017b
> +#define MSR_ERROR_CONTROL		0x0000017f
>  #define MSR_IA32_MCG_EXT_CTL		0x000004d0
>  
>  #define MSR_OFFCORE_RSP_0		0x000001a6
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index abe9fe0fb851..b47883e364b4 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -509,12 +509,32 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
>  	}
>  }
>  
> +/*
> + * Enable additional error logs from the integrated
> + * memory controller on processors that support this.
> + */
> +static void intel_imc_init(struct cpuinfo_x86 *c)
> +{
> +	u64 error_control;
> +
> +	switch (c->x86_model) {
> +	case INTEL_FAM6_SANDYBRIDGE_X:
> +	case INTEL_FAM6_IVYBRIDGE_X:
> +	case INTEL_FAM6_HASWELL_X:
> +		rdmsrl(MSR_ERROR_CONTROL, error_control);
> +		error_control |= 2;
> +		wrmsrl(MSR_ERROR_CONTROL, error_control);
> +		break;
> +	}
> +}
> +
>  void mce_intel_feature_init(struct cpuinfo_x86 *c)
>  {
>  	intel_init_thermal(c);
>  	intel_init_cmci();
>  	intel_init_lmce();
>  	intel_ppin_init(c);
> +	intel_imc_init(c);
>  }
>  
>  void mce_intel_feature_clear(struct cpuinfo_x86 *c)
> -- 
> 2.21.1
> 
