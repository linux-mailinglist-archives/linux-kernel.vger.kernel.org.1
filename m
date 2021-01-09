Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323852F0266
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 18:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbhAIRlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 12:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbhAIRlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 12:41:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF947C0617BA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 09:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wjy+oUPsZ8buL5dmm9rElHwglZCYmMO+xrU2yMPZN2E=; b=tRqJ5VUxjTQU9l+KsBws/ekINg
        rZfbXAMqdRe/BRVgV1tyMywHtunnRuVai9jN9irMHBUItzZViRDc1sTf2mcYudpwLx8wEXqSwvvdi
        rFb52P+lp7vEcZnNJlnL92pb+PgZaWfxBRJc17fMregodGGWeBQgRCjRGQmgcd55juhR7iOZQrMIs
        3RvaF8Tym5FwD3MDEVdHn/fXixV7EVaEyN+hKB5DfY4x/z47uYGQqp/vlLqzDsjd8kAIB4bxw2Aty
        hyssByaCY1A82oBEzTgBg64ThwMGf/aPiRwIeUa38MJDk7gO4OLVpP/bfc8EC23B0iNEuK9e/AeQ9
        gmBiDomQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kyIDo-000ll2-7I; Sat, 09 Jan 2021 17:40:20 +0000
Date:   Sat, 9 Jan 2021 17:40:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap_slots.c: Remove unnecessary NULL pointer check
Message-ID: <20210109174016.GA35215@casper.infradead.org>
References: <20210109080943.34832-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109080943.34832-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 03:09:43AM -0500, Miaohe Lin wrote:
> The cache->slots and cache->slots_ret is already checked before we try to
> drain it. And kvfree can handle the NULL pointer itself. So remove the
> NULL pointer check here.

> @@ -178,7 +178,7 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
>  		swapcache_free_entries(cache->slots + cache->cur, cache->nr);
>  		cache->cur = 0;
>  		cache->nr = 0;
> -		if (free_slots && cache->slots) {
> +		if (free_slots) {

Prove that swapcache_free_entries() doesn't change cache->slots.

> @@ -188,13 +188,12 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
>  		spin_lock_irq(&cache->free_lock);
>  		swapcache_free_entries(cache->slots_ret, cache->n_ret);
>  		cache->n_ret = 0;
> -		if (free_slots && cache->slots_ret) {
> +		if (free_slots) {

... or ->slots_ret

> -		if (slots)
> -			kvfree(slots);
> +		kvfree(slots);

This is fine.
