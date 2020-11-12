Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD032B02BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgKLKbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgKLKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:31:07 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10BF622203;
        Thu, 12 Nov 2020 10:31:03 +0000 (UTC)
Date:   Thu, 12 Nov 2020 10:31:01 +0000
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
Subject: Re: [PATCH v2 05/20] kasan: allow VMAP_STACK for HW_TAGS mode
Message-ID: <20201112103100.GJ29613@gaia>
References: <cover.1605046662.git.andreyknvl@google.com>
 <3443e106c40799e5dc3981dec2011379f3cbbb0c.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3443e106c40799e5dc3981dec2011379f3cbbb0c.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20:09PM +0100, Andrey Konovalov wrote:
> Even though hardware tag-based mode currently doesn't support checking
> vmalloc allocations, it doesn't use shadow memory and works with
> VMAP_STACK as is. Change VMAP_STACK definition accordingly.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
> ---
>  arch/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..7e7d14fae568 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -914,16 +914,16 @@ config VMAP_STACK
>  	default y
>  	bool "Use a virtually-mapped stack"
>  	depends on HAVE_ARCH_VMAP_STACK
> -	depends on !KASAN || KASAN_VMALLOC
> +	depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC

From the arm64 perspective:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
