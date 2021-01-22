Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22224300404
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbhAVNU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbhAVNUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:20:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC1AB23428;
        Fri, 22 Jan 2021 13:19:36 +0000 (UTC)
Date:   Fri, 22 Jan 2021 13:19:34 +0000
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
Subject: Re: [PATCH v5 3/6] kasan: Add report for async mode
Message-ID: <20210122131933.GD8567@gaia>
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
 <20210121163943.9889-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121163943.9889-4-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:39:40PM +0000, Vincenzo Frascino wrote:
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bb862d1f0e15..b0a1d9dfa85c 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -351,6 +351,8 @@ static inline void *kasan_reset_tag(const void *addr)
>  bool kasan_report(unsigned long addr, size_t size,
>  		bool is_write, unsigned long ip);
>  
> +void kasan_report_async(void);
> +
>  #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>  
>  static inline void *kasan_reset_tag(const void *addr)
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 234f35a84f19..2fd6845a95e9 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -358,6 +358,17 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>  	end_report(&flags);
>  }
>  
> +void kasan_report_async(void)
> +{
> +	unsigned long flags;
> +
> +	start_report(&flags);
> +	pr_err("BUG: KASAN: invalid-access\n");
> +	pr_err("Asynchronous mode enabled: no access details available\n");
> +	dump_stack();
> +	end_report(&flags);
> +}

I think the kernel test robot complains that with KASAN_SW_TAGS and
HW_TAGS disabled, the kasan_report_async() prototype is no longer
visible but you still have the non-static function definition here. So
either move kasan_report_async() out of this #ifdef or add the #ifdef
around the function definition.

It looks like the original kasan_report() prototype is declared in two
places (second one in mm/kasan/kasan.h). I'd remove the latter and try
to have a consistent approach for kasan_report() and
kasan_report_async().

-- 
Catalin
