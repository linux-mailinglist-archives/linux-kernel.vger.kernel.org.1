Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243222F395A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406329AbhALTCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:02:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbhALTCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:02:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3467230F9;
        Tue, 12 Jan 2021 19:01:34 +0000 (UTC)
Date:   Tue, 12 Jan 2021 19:01:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] kasan, arm64: allow using KUnit tests with HW_TAGS
 mode
Message-ID: <X/3yDGfTJ+ng+GJt@Catalins-MacBook-Air.local>
References: <cover.1609871239.git.andreyknvl@google.com>
 <dd061dfca76dbf86af13393edacd37e0c75b6f4a.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd061dfca76dbf86af13393edacd37e0c75b6f4a.1609871239.git.andreyknvl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27:49PM +0100, Andrey Konovalov wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 3c40da479899..57d3f165d907 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -302,12 +302,20 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
>  static void report_tag_fault(unsigned long addr, unsigned int esr,
>  			     struct pt_regs *regs)
>  {
> -	bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> +	static bool reported;
> +	bool is_write;
> +
> +	if (READ_ONCE(reported))
> +		return;
> +
> +	if (mte_report_once())
> +		WRITE_ONCE(reported, true);

I guess the assumption here is that you don't get any report before the
tests start and temporarily set report_once to false. It's probably
fine, if we get a tag check failure we'd notice in the logs anyway.

>  	/*
>  	 * SAS bits aren't set for all faults reported in EL1, so we can't
>  	 * find out access size.
>  	 */
> +	is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;

I now noticed, you could write this in a shorter way:

	is_write = !!(esr & ESR_ELx_WNR);

>  	kasan_report(addr, 0, is_write, regs->pc);
>  }

The patch looks fine to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
