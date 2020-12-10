Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F862D649F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392541AbgLJSOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390527AbgLJSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:13:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E21C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wtKwAp9LK0mJJfCtfcodrMg2CfX191QCiHtyQWRnMZI=; b=mh1gtQaLQy2/vLGVKDhsHWNLc3
        Mhqn1UY1n/8CtCRd5mu3fLnvSYW7zeNpUlI5N9K5y2QeqxtYbjsuRStbP/IyVLoX3bYx72GiXu2H2
        NlZrSzGYuLvsJU4fknts+nuTPThx/bWHhjag9huekqLAt+YeHAzVSfOgcDAAqJ9i74LqqJAG/nC4Y
        bxTFdBSYiqk0YND+GcKXVKsViX5aJ9rqIJj6s1a8xUEROxora6QbKvOJpg1SQOZcwyCh7eIo9K/oR
        foJmZSmYUKv7ZhM7oTE5KwEBvMBAe2WwWz7M7bPJ7mCe6gcOJAIJDn/ubOmf80PxLr6YUqwnbS8jx
        BJ+mmKrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knQQu-0002bI-Js; Thu, 10 Dec 2020 18:12:52 +0000
Date:   Thu, 10 Dec 2020 18:12:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Md Muazzam Husain <mdmuazzamhusain@gmail.com>
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mdakhil2003@gmail.com
Subject: Re: Slab bug during skb allocation
Message-ID: <20201210181252.GZ7338@casper.infradead.org>
References: <CAFQRB7rA6hHc_f8O7qJVn2ufrp_i0PQyTJ4OsNwzyahV5Uq+Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQRB7rA6hHc_f8O7qJVn2ufrp_i0PQyTJ4OsNwzyahV5Uq+Jg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:25:13PM +0530, Md Muazzam Husain wrote:
> Hi All,
>          I have kernel version 3.10.59. So during the allocation for skb i

That kernel is over 6 years old: https://lwn.net/Articles/618650/ It's
been out of support since November 2017.  The development kernel it was
based on is over 7 years old.  It's unreasonable to expect people to
know the answer to this.

Can you reproduce this problem with a recent kernel?

> am getting call trace for __netdev_alloc_skb which follows
> till cache_alloc_refill and finally crashes. Please find snapshot below.
> addr2line -e vmlinux ffffffffc114109c shows linux/mm/slab.c:2700 has the
> problem. Is there any existing bug and any patch for this.
> 
> Call Trace:
> [<ffffffffc114109c>] *cache_alloc_refill*+0x1b4/0x848
> [<ffffffffc1141854>] __kmalloc_track_caller+0x124/0x1f0
> [<ffffffffc144a930>] __kmalloc_reserve.isra.17+0x40/0xa8
> [<ffffffffc144b644>] __alloc_skb+0x84/0x1a0
> [<ffffffffc144d084>] *__netdev_alloc_skb*+0xdc/0x148
> [<ffffffffc13fb510>] xlpnae_irq+0x148/0x200
> [<ffffffffc10b87ac>] handle_irq_event_percpu+0x94/0x3f0
> [<ffffffffc10b8b5c>] handle_irq_event+0x54/0x98
> [<ffffffffc10bc724>] handle_level_irq+0xe4/0x170
> [<ffffffffc10b7d90>] generic_handle_irq+0x38/0x58
> [<ffffffffc1018a20>] do_IRQ+0x18/0x28
> [<ffffffffc1015ce8>] plat_irq_dispatch+0x258/0x490
> [<ffffffffc1016a00>] ret_from_irq+0x0/0x4
> [<ffffffffc1016ca0>] __r4k_wait+0x20/0x40
> [<ffffffffc109072c>] cpu_startup_entry+0xd4/0x2d8
> [<ffffffffc1014ab8>] prom_pre_boot_secondary_cpus+0x0/0x48
> 
> 
> Thanks,
> Muazzam
