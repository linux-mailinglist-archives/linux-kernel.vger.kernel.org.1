Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD12F1C7383
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgEFPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:02:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:47339 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgEFPCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:02:52 -0400
IronPort-SDR: 1bDuFxHBGKKc36ngQQV+Mg3WexG4k/q/ZLi4E6bdWo5yOnxVwMCplm7nnkCx08uL7r5YuCH29d
 LcfzlDsk7jog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:02:51 -0700
IronPort-SDR: iotEaeJZfdzSqwRTQhkamwGWxxlw64uGGZ2fiMMRCLgrxGllRlY210BhUCnbtsFu47WbZj8zZ8
 uUQVtxbY/ciA==
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="284648279"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:02:50 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id F1870636E;
        Wed,  6 May 2020 15:02:48 +0000 (UTC)
Date:   Wed, 6 May 2020 08:02:49 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 1/3] x86/cpu: Add a steppings field to struct x86_cpu_id
Message-ID: <20200506150249.GC2961@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200506071516.25445-1-bp@alien8.de>
 <20200506071516.25445-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506071516.25445-2-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+1

--mark

On Wed, May 06, 2020 at 09:15:14AM +0200, Borislav Petkov wrote:
> From: Mark Gross <mgross@linux.intel.com>
> 
> Intel uses the same family/model for several CPUs. Sometimes the
> stepping must be checked to tell them apart.
> 
> On x86 there can be at most 16 steppings. Add a steppings bitmask to
> x86_cpu_id and a X86_MATCH_VENDOR_FAMILY_MODEL_STEPPING_FEATURE macro
> and support for matching against family/model/stepping.
> 
>  [ bp: Massage. ]
> 
> Signed-off-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/include/asm/cpu_device_id.h | 27 ++++++++++++++++++++++++---
>  arch/x86/kernel/cpu/match.c          |  7 ++++++-
>  include/linux/mod_devicetable.h      |  2 ++
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
> index cf3d621c6892..10426cd56dca 100644
> --- a/arch/x86/include/asm/cpu_device_id.h
> +++ b/arch/x86/include/asm/cpu_device_id.h
> @@ -20,12 +20,14 @@
>  #define X86_CENTAUR_FAM6_C7_D		0xd
>  #define X86_CENTAUR_FAM6_NANO		0xf
>  
> +#define X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
>  /**
> - * X86_MATCH_VENDOR_FAM_MODEL_FEATURE - Base macro for CPU matching
> + * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
>   * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
>   *		The name is expanded to X86_VENDOR_@_vendor
>   * @_family:	The family number or X86_FAMILY_ANY
>   * @_model:	The model number, model constant or X86_MODEL_ANY
> + * @_steppings:	Bitmask for steppings, stepping constant or X86_STEPPING_ANY
>   * @_feature:	A X86_FEATURE bit or X86_FEATURE_ANY
>   * @_data:	Driver specific data or NULL. The internal storage
>   *		format is unsigned long. The supplied value, pointer
> @@ -37,15 +39,34 @@
>   * into another macro at the usage site for good reasons, then please
>   * start this local macro with X86_MATCH to allow easy grepping.
>   */
> -#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(_vendor, _family, _model,	\
> -					   _feature, _data) {		\
> +#define X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(_vendor, _family, _model, \
> +						    _steppings, _feature, _data) { \
>  	.vendor		= X86_VENDOR_##_vendor,				\
>  	.family		= _family,					\
>  	.model		= _model,					\
> +	.steppings	= _steppings,					\
>  	.feature	= _feature,					\
>  	.driver_data	= (unsigned long) _data				\
>  }
>  
> +/**
> + * X86_MATCH_VENDOR_FAM_MODEL_FEATURE - Macro for CPU matching
> + * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
> + *		The name is expanded to X86_VENDOR_@_vendor
> + * @_family:	The family number or X86_FAMILY_ANY
> + * @_model:	The model number, model constant or X86_MODEL_ANY
> + * @_feature:	A X86_FEATURE bit or X86_FEATURE_ANY
> + * @_data:	Driver specific data or NULL. The internal storage
> + *		format is unsigned long. The supplied value, pointer
> + *		etc. is casted to unsigned long internally.
> + *
> + * The steppings arguments of X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE() is
> + * set to wildcards.
> + */
> +#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data) \
> +	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(vendor, family, model, \
> +						X86_STEPPING_ANY, feature, data)
> +
>  /**
>   * X86_MATCH_VENDOR_FAM_FEATURE - Macro for matching vendor, family and CPU feature
>   * @vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index d3482eb43ff3..ad6776081e60 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -39,13 +39,18 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
>  	const struct x86_cpu_id *m;
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  
> -	for (m = match; m->vendor | m->family | m->model | m->feature; m++) {
> +	for (m = match;
> +	     m->vendor | m->family | m->model | m->steppings | m->feature;
> +	     m++) {
>  		if (m->vendor != X86_VENDOR_ANY && c->x86_vendor != m->vendor)
>  			continue;
>  		if (m->family != X86_FAMILY_ANY && c->x86 != m->family)
>  			continue;
>  		if (m->model != X86_MODEL_ANY && c->x86_model != m->model)
>  			continue;
> +		if (m->steppings != X86_STEPPING_ANY &&
> +		    !(BIT(c->x86_stepping) & m->steppings))
> +			continue;
>  		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
>  			continue;
>  		return m;
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 4c2ddd0941a7..0754b8d71262 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -663,6 +663,7 @@ struct x86_cpu_id {
>  	__u16 vendor;
>  	__u16 family;
>  	__u16 model;
> +	__u16 steppings;
>  	__u16 feature;	/* bit index */
>  	kernel_ulong_t driver_data;
>  };
> @@ -671,6 +672,7 @@ struct x86_cpu_id {
>  #define X86_VENDOR_ANY 0xffff
>  #define X86_FAMILY_ANY 0
>  #define X86_MODEL_ANY  0
> +#define X86_STEPPING_ANY 0
>  #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
>  
>  /*
> -- 
> 2.21.0
> 
