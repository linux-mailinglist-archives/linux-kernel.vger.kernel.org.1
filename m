Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8422A82DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgKEP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:59:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730660AbgKEP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:59:07 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637012087D;
        Thu,  5 Nov 2020 15:59:03 +0000 (UTC)
Date:   Thu, 5 Nov 2020 15:59:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 28/43] arm64: mte: Reset the page tag in page->flags
Message-ID: <20201105155859.GA30030@gaia>
References: <cover.1604531793.git.andreyknvl@google.com>
 <fc9e96c022a147120b67056525362abb43b2a0ce.1604531793.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc9e96c022a147120b67056525362abb43b2a0ce.1604531793.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 12:18:43AM +0100, Andrey Konovalov wrote:
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 8f99c65837fd..06ba6c923ab7 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -34,6 +34,7 @@ static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>  			return;
>  	}
>  
> +	page_kasan_tag_reset(page);
>  	mte_clear_page_tags(page_address(page));

I think we need an smp_wmb() between setting the flags and clearing the
actual tags. If another threads reads page->flags and builds a tagged
address out of it (see page_to_virt) there's an address dependency to
the actual memory access. However, on the current thread, we don't
guarantee that the new page->flags are visible before the tags were
updated.

>  }
>  
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index 70a71f38b6a9..348f4627da08 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -22,6 +22,7 @@ void copy_highpage(struct page *to, struct page *from)
>  	copy_page(kto, kfrom);
>  
>  	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
> +		page_kasan_tag_reset(to);
>  		set_bit(PG_mte_tagged, &to->flags);
>  		mte_copy_page_tags(kto, kfrom);

Nitpick: move page_kasan_tag_reset() just above mte_copy_page_tags() for
consistency with the other places where PG_mte_tagged is set before or
after the actual tag setting.

>  	}
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index c52c1847079c..0e7eccbe598a 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -53,6 +53,7 @@ bool mte_restore_tags(swp_entry_t entry, struct page *page)
>  	if (!tags)
>  		return false;
>  
> +	page_kasan_tag_reset(page);
>  	mte_restore_page_tags(page_address(page), tags);

There is another mte_restore_page_tags() caller in hibernate.c. That one
doesn't need page_kasan_tag_reset() since the page->flags would have
been already restored but please add a comment in that file why its not
needed.

-- 
Catalin
