Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169AC2F510C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbhAMRXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbhAMRXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:23:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CDA423437;
        Wed, 13 Jan 2021 17:22:31 +0000 (UTC)
Date:   Wed, 13 Jan 2021 17:22:28 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 2/4] arm64: mte: Add asynchronous mode support
Message-ID: <20210113172228.GE27045@gaia>
References: <20210107172908.42686-1-vincenzo.frascino@arm.com>
 <20210107172908.42686-3-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107172908.42686-3-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 05:29:06PM +0000, Vincenzo Frascino wrote:
> MTE provides an asynchronous mode for detecting tag exceptions. In
> particular instead of triggering a fault the arm64 core updates a
> register which is checked by the kernel at the first entry after the tag
> exception has occurred.

Just rephrase the "tag exception" here as there's no exception taken.
Also we don't check this only when the kernel is first entered after a
tag check fault, as per patch 3.

> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -153,8 +153,35 @@ void mte_init_tags(u64 max_tag)
>  
>  void mte_enable_kernel(enum kasan_arg_mode mode)
>  {
> -	/* Enable MTE Sync Mode for EL1. */
> -	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> +	const char *m;
> +
> +	/* Preset parameter values based on the mode. */
> +	switch (mode) {
> +	case KASAN_ARG_MODE_OFF:
> +		return;
> +	case KASAN_ARG_MODE_LIGHT:
> +		/* Enable MTE Async Mode for EL1. */
> +		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_ASYNC);
> +		m = "asynchronous";
> +		break;
> +	case KASAN_ARG_MODE_DEFAULT:
> +	case KASAN_ARG_MODE_PROD:
> +	case KASAN_ARG_MODE_FULL:
> +		/* Enable MTE Sync Mode for EL1. */
> +		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> +		m = "synchronous";
> +		break;
> +	default:
> +		/*
> +		 * kasan mode should be always set hence we should
> +		 * not reach this condition.
> +		 */
> +		WARN_ON_ONCE(1);
> +		return;
> +	}

I guess the switch statement here will be re-written as we want kasan to
drive the actual sync/async modes as it sees fit rather than MTE
guessing what PROD/FULL/LIGHT means.

-- 
Catalin
