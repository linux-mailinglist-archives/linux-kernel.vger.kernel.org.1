Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4E2FA0C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391996AbhARNIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390718AbhARNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:07:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABABC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:06:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d13so16360502wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cKlyhU48mWEpYzjNOoia+4brb6Khl72pdXiLf43hFhE=;
        b=ekhROC2aXDBAWTCzv6WFgHCmRShFyHm1v7sHZ5+v5tFn2ZpS55LuYKWlMD8RbcwgPi
         hYOWPS5cQCRRY6kIAJFxyQwG/VenhFj9rX3agQn3MN0M9KFnSC89ocEtGf8/Y9BtdxAt
         DbE7ItMx0GHz0wGRfFClKB9C6Xkxwd9AmS/CE/TNuTSbqwbm1ABpJK9mwkF0dJJgPQhr
         Wbu+RVfuYvQ1urD0tvmZjuV42+GD5YTpiiluPcXpgj5lFH+s6/7ysrrvrHo1G9faNl88
         OC+mlP0VfpyESp4NqldQXtbA5RJu1D2KuVplkQ33HKRyFxf2I1UU9lghS4yAGEvnDmaU
         BXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKlyhU48mWEpYzjNOoia+4brb6Khl72pdXiLf43hFhE=;
        b=tPHSGZuC6l1rN0jfB7Swttk8yOpVi9JpcZQmXgn+cfl26Eoo5m6nha05jUFQB4eLco
         DmOCUDK4qGskMiBPylRyj2cjr3otBVZONPGKVQ/8gqhLyzgPmHdvjroi6HOsyYR7hJf/
         T/ULh9/UMSpiiOJq4iVuwf160iC7j2P0LpZrdfZHS7TS70eN/Ll1TpPa8F7KARCGF1rP
         oAl9y4nezguV+Yioj2OJdy5PvgWz2dbXBHx2qGw1vSYCfloYAiaWKM+eo5vaSiu2u80B
         cBXV5YEOjX59/m6T3Ysjurb4GZHfnPHGvism7feV/cKY86sSXt7Hm5NZDWZIWlkQSKnd
         UPOQ==
X-Gm-Message-State: AOAM530Gh29UnukHzWvpAY4cr13NyUW7B4iZARWSF4NBbyqGw+p/YR2R
        D0wwyGvpAcgGwxTV/+uev1J/dQ==
X-Google-Smtp-Source: ABdhPJzdA1N8blZ8UvYuCd8AnUXhh8zHaT41utBC4h2/zlwG6uU4shC3cJWbhg76gb3tCpg+sHiFsQ==
X-Received: by 2002:a5d:4241:: with SMTP id s1mr25922028wrr.269.1610975213753;
        Mon, 18 Jan 2021 05:06:53 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id x128sm26669557wmb.29.2021.01.18.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 05:06:52 -0800 (PST)
Date:   Mon, 18 Jan 2021 14:06:47 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: fix HW_TAGS boot parameters
Message-ID: <YAWH56mMdRf7uPBB@elver.google.com>
References: <4e9c4a4bdcadc168317deb2419144582a9be6e61.1610736745.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e9c4a4bdcadc168317deb2419144582a9be6e61.1610736745.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 07:53PM +0100, Andrey Konovalov wrote:
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

Thanks for the simplification.

Reviewed-by: Marco Elver <elver@google.com>

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
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
