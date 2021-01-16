Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79D92F8E47
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbhAPR2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:28:15 -0500
Received: from foss.arm.com ([217.140.110.172]:54342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbhAPR2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:28:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D70F11396;
        Sat, 16 Jan 2021 06:23:52 -0800 (PST)
Received: from [10.37.8.30] (unknown [10.37.8.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD9563F719;
        Sat, 16 Jan 2021 06:23:49 -0800 (PST)
Subject: Re: [PATCH] kasan: fix HW_TAGS boot parameters
To:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <4e9c4a4bdcadc168317deb2419144582a9be6e61.1610736745.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <83972adc-420b-ca38-3672-b39a5618bd32@arm.com>
Date:   Sat, 16 Jan 2021 14:27:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4e9c4a4bdcadc168317deb2419144582a9be6e61.1610736745.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/21 6:53 PM, Andrey Konovalov wrote:
> The initially proposed KASAN command line parameters are redundant.
> 
> This change drops the complex "kasan.mode=off/prod/full" parameter
> and adds a simpler kill switch "kasan=off/on" instead. The new parameter
> together with the already existing ones provides a cleaner way to
> express the same set of features.
> 
> The full set of parameters with this change:
> 
> kasan=off/on             - whether KASAN is enabled
> kasan.fault=report/panic - whether to only print a report or also panic
> kasan.stacktrace=off/on  - whether to collect alloc/free stack traces
> 
> Default values:
> 
> kasan=on
> kasan.fault=report
> kasan.stacktrace=on  (if CONFIG_DEBUG_KERNEL=y)
> kasan.stacktrace=off (otherwise)
> 
> Link: https://linux-review.googlesource.com/id/Ib3694ed90b1e8ccac6cf77dfd301847af4aba7b8
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Since it is a fix could you please add the "Fixes:" tag.

Otherwise:

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  Documentation/dev-tools/kasan.rst | 27 +++--------
>  mm/kasan/hw_tags.c                | 77 +++++++++++++------------------
>  2 files changed, 38 insertions(+), 66 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 0fc3fb1860c4..1651d961f06a 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -160,29 +160,14 @@ intended for use in production as a security mitigation. Therefore it supports
>  boot parameters that allow to disable KASAN competely or otherwise control
>  particular KASAN features.
>  
> -The things that can be controlled are:
> +- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>  
> -1. Whether KASAN is enabled at all.
> -2. Whether KASAN collects and saves alloc/free stacks.
> -3. Whether KASAN panics on a detected bug or not.
> +- ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
> +  traces collection (default: ``on`` for ``CONFIG_DEBUG_KERNEL=y``, otherwise
> +  ``off``).
>  
> -The ``kasan.mode`` boot parameter allows to choose one of three main modes:
> -
> -- ``kasan.mode=off`` - KASAN is disabled, no tag checks are performed
> -- ``kasan.mode=prod`` - only essential production features are enabled
> -- ``kasan.mode=full`` - all KASAN features are enabled
> -
> -The chosen mode provides default control values for the features mentioned
> -above. However it's also possible to override the default values by providing:
> -
> -- ``kasan.stacktrace=off`` or ``=on`` - enable alloc/free stack collection
> -					(default: ``on`` for ``mode=full``,
> -					 otherwise ``off``)
> -- ``kasan.fault=report`` or ``=panic`` - only print KASAN report or also panic
> -					 (default: ``report``)
> -
> -If ``kasan.mode`` parameter is not provided, it defaults to ``full`` when
> -``CONFIG_DEBUG_KERNEL`` is enabled, and to ``prod`` otherwise.
> +- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
> +  report or also panic the kernel (default: ``report``).
>  
>  For developers
>  ~~~~~~~~~~~~~~
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 55bd6f09c70f..e529428e7a11 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -19,11 +19,10 @@
>  
>  #include "kasan.h"
>  
> -enum kasan_arg_mode {
> -	KASAN_ARG_MODE_DEFAULT,
> -	KASAN_ARG_MODE_OFF,
> -	KASAN_ARG_MODE_PROD,
> -	KASAN_ARG_MODE_FULL,
> +enum kasan_arg {
> +	KASAN_ARG_DEFAULT,
> +	KASAN_ARG_OFF,
> +	KASAN_ARG_ON,
>  };
>  
>  enum kasan_arg_stacktrace {
> @@ -38,7 +37,7 @@ enum kasan_arg_fault {
>  	KASAN_ARG_FAULT_PANIC,
>  };
>  
> -static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
> +static enum kasan_arg kasan_arg __ro_after_init;
>  static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
>  static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>  
> @@ -52,26 +51,24 @@ DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
>  /* Whether panic or disable tag checking on fault. */
>  bool kasan_flag_panic __ro_after_init;
>  
> -/* kasan.mode=off/prod/full */
> -static int __init early_kasan_mode(char *arg)
> +/* kasan=off/on */
> +static int __init early_kasan_flag(char *arg)
>  {
>  	if (!arg)
>  		return -EINVAL;
>  
>  	if (!strcmp(arg, "off"))
> -		kasan_arg_mode = KASAN_ARG_MODE_OFF;
> -	else if (!strcmp(arg, "prod"))
> -		kasan_arg_mode = KASAN_ARG_MODE_PROD;
> -	else if (!strcmp(arg, "full"))
> -		kasan_arg_mode = KASAN_ARG_MODE_FULL;
> +		kasan_arg = KASAN_ARG_OFF;
> +	else if (!strcmp(arg, "on"))
> +		kasan_arg = KASAN_ARG_ON;
>  	else
>  		return -EINVAL;
>  
>  	return 0;
>  }
> -early_param("kasan.mode", early_kasan_mode);
> +early_param("kasan", early_kasan_flag);
>  
> -/* kasan.stack=off/on */
> +/* kasan.stacktrace=off/on */
>  static int __init early_kasan_flag_stacktrace(char *arg)
>  {
>  	if (!arg)
> @@ -113,8 +110,8 @@ void kasan_init_hw_tags_cpu(void)
>  	 * as this function is only called for MTE-capable hardware.
>  	 */
>  
> -	/* If KASAN is disabled, do nothing. */
> -	if (kasan_arg_mode == KASAN_ARG_MODE_OFF)
> +	/* If KASAN is disabled via command line, don't initialize it. */
> +	if (kasan_arg == KASAN_ARG_OFF)
>  		return;
>  
>  	hw_init_tags(KASAN_TAG_MAX);
> @@ -124,43 +121,28 @@ void kasan_init_hw_tags_cpu(void)
>  /* kasan_init_hw_tags() is called once on boot CPU. */
>  void __init kasan_init_hw_tags(void)
>  {
> -	/* If hardware doesn't support MTE, do nothing. */
> +	/* If hardware doesn't support MTE, don't initialize KASAN. */
>  	if (!system_supports_mte())
>  		return;
>  
> -	/* Choose KASAN mode if kasan boot parameter is not provided. */
> -	if (kasan_arg_mode == KASAN_ARG_MODE_DEFAULT) {
> -		if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> -			kasan_arg_mode = KASAN_ARG_MODE_FULL;
> -		else
> -			kasan_arg_mode = KASAN_ARG_MODE_PROD;
> -	}
> -
> -	/* Preset parameter values based on the mode. */
> -	switch (kasan_arg_mode) {
> -	case KASAN_ARG_MODE_DEFAULT:
> -		/* Shouldn't happen as per the check above. */
> -		WARN_ON(1);
> -		return;
> -	case KASAN_ARG_MODE_OFF:
> -		/* If KASAN is disabled, do nothing. */
> +	/* If KASAN is disabled via command line, don't initialize it. */
> +	if (kasan_arg == KASAN_ARG_OFF)
>  		return;
> -	case KASAN_ARG_MODE_PROD:
> -		static_branch_enable(&kasan_flag_enabled);
> -		break;
> -	case KASAN_ARG_MODE_FULL:
> -		static_branch_enable(&kasan_flag_enabled);
> -		static_branch_enable(&kasan_flag_stacktrace);
> -		break;
> -	}
>  
> -	/* Now, optionally override the presets. */
> +	/* Enable KASAN. */
> +	static_branch_enable(&kasan_flag_enabled);
>  
>  	switch (kasan_arg_stacktrace) {
>  	case KASAN_ARG_STACKTRACE_DEFAULT:
> +		/*
> +		 * Default to enabling stack trace collection for
> +		 * debug kernels.
> +		 */
> +		if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> +			static_branch_enable(&kasan_flag_stacktrace);
>  		break;
>  	case KASAN_ARG_STACKTRACE_OFF:
> -		static_branch_disable(&kasan_flag_stacktrace);
> +		/* Do nothing, kasan_flag_stacktrace keeps its default value. */
>  		break;
>  	case KASAN_ARG_STACKTRACE_ON:
>  		static_branch_enable(&kasan_flag_stacktrace);
> @@ -169,11 +151,16 @@ void __init kasan_init_hw_tags(void)
>  
>  	switch (kasan_arg_fault) {
>  	case KASAN_ARG_FAULT_DEFAULT:
> +		/*
> +		 * Default to no panic on report.
> +		 * Do nothing, kasan_flag_panic keeps its default value.
> +		 */
>  		break;
>  	case KASAN_ARG_FAULT_REPORT:
> -		kasan_flag_panic = false;
> +		/* Do nothing, kasan_flag_panic keeps its default value. */
>  		break;
>  	case KASAN_ARG_FAULT_PANIC:
> +		/* Enable panic on report. */
>  		kasan_flag_panic = true;
>  		break;
>  	}
> 

-- 
Regards,
Vincenzo
