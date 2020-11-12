Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A502B01FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKLJbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:31:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgKLJbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:31:37 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12A1207DE;
        Thu, 12 Nov 2020 09:31:33 +0000 (UTC)
Date:   Thu, 12 Nov 2020 09:31:31 +0000
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
Subject: Re: [PATCH v9 28/44] arm64: mte: Reset the page tag in page->flags
Message-ID: <20201112093130.GD29613@gaia>
References: <cover.1605046192.git.andreyknvl@google.com>
 <4a7819f8942922451e8075d7003f7df357919dfc.1605046192.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a7819f8942922451e8075d7003f7df357919dfc.1605046192.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:10:25PM +0100, Andrey Konovalov wrote:
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index 70a71f38b6a9..f0efa4847e2f 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -23,6 +23,7 @@ void copy_highpage(struct page *to, struct page *from)
>  
>  	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
>  		set_bit(PG_mte_tagged, &to->flags);
> +		page_kasan_tag_reset(to);
>  		mte_copy_page_tags(kto, kfrom);

Any reason why this doesn't have an smp_wmb() between resetting the tags
and copying them into kto?

-- 
Catalin
