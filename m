Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799FD2B0246
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgKLJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:51:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgKLJvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:51:40 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C632053B;
        Thu, 12 Nov 2020 09:51:37 +0000 (UTC)
Date:   Thu, 12 Nov 2020 09:51:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/20] kasan, arm64: unpoison stack only with
 CONFIG_KASAN_STACK
Message-ID: <20201112095134.GI29613@gaia>
References: <cover.1605046662.git.andreyknvl@google.com>
 <7e95d4739f5617b2c1acf52f37e01f1ca83750b5.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e95d4739f5617b2c1acf52f37e01f1ca83750b5.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20:08PM +0100, Andrey Konovalov wrote:
> There's a config option CONFIG_KASAN_STACK that has to be enabled for
> KASAN to use stack instrumentation and perform validity checks for
> stack variables.
> 
> There's no need to unpoison stack when CONFIG_KASAN_STACK is not enabled.
> Only call kasan_unpoison_task_stack[_below]() when CONFIG_KASAN_STACK is
> enabled.
> 
> Note, that CONFIG_KASAN_STACK is an option that is currently always
> defined when CONFIG_KASAN is enabled, and therefore has to be tested
> with #if instead of #ifdef.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/If8a891e9fe01ea543e00b576852685afec0887e3
> ---
>  arch/arm64/kernel/sleep.S        |  2 +-
>  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
>  include/linux/kasan.h            | 10 ++++++----
>  mm/kasan/common.c                |  2 ++
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index ba40d57757d6..bdadfa56b40e 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
>  	 */
>  	bl	cpu_do_resume
>  
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
>  	mov	x0, sp
>  	bl	kasan_unpoison_task_stack_below
>  #endif

I don't understand why CONFIG_KASAN_STACK is not a bool (do you plan to
add more values to it?) but for arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
