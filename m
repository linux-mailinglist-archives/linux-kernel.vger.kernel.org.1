Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD272F2EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbhALMYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbhALMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:24:09 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F3EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:23:28 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p187so3525898iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZIezxfzF5cQVfnp9/DvcL98QklFJMeqwz8OE0o7lBM=;
        b=cdhH9HEUB47b4fq3e07Gy4hh0BO4wPghQRXBEikULAHwkROwydMITx/LuS06kY8XkT
         hIngq3U3IZuDa/l2J6YMdt4dyvhL7iRs4NE9WlZGZ1K7iDpLya2TnUXsdJUlw00hIO4Y
         HiDq5o+4Zuy0jAJPVhAJ403wQW6Prj1ccTVWu8OYxUoGYkqbL1LJS5OXrx0LQhuWHgcY
         1yi2u/URnELdm3je9GrLljj9yxcMCLjH+XzoTjUzU/eyyBNpgcC2ms21MrRZFxRc8cwi
         fmGovBHSfx3oMiI+yzacG7Gz+0hgLiWpwj1DJI7gfWCZ+nKU0PZuwTUSrP7UhqOP0bQG
         ByaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZIezxfzF5cQVfnp9/DvcL98QklFJMeqwz8OE0o7lBM=;
        b=sljgolyKbzRx95F98raiXPSeLmLJS1h4NwRNWd8rvIuT5JK27+QWXkXeNuUyJlQWCh
         yqa8V571CbVJrjn6wu2YxY0TfF/mHLoEHYLbL2FPmgG37IH3MOWgsjx2xu0GmncdP8oz
         k4Kj3jUIlrVbISd32sKbeCAluTumvdxdeAwJyRCfSmhaDe8HTND648P/ULvgHRYu6hVJ
         ZJto7MZLur43lzkSCRZRZBSWLTJ+H/TLIbUTteUG0PZrMpOLcIh5RqiYmkg8ICdjOMGp
         Of3Ll783PN8jyo5VRMUVI3+PxIBvCnIwXClUwC40foUNPPYtwEgXyGoLv0Zj2h7hB+88
         /83g==
X-Gm-Message-State: AOAM533UkUmSX2GsxwwenZePw2axrnspWRUJnZG8stAdiHs0V4FKBfA5
        dP1RVVQugueezlcQtgbL54cgJSaqgNHrS3THfV84Mw==
X-Google-Smtp-Source: ABdhPJzCX4Z3ZyGgv0cScTyr9oPuvm6uuLBWsAZpZf4YTAFVuDYAtQ49Yue7KnksqB9gfzM0eWDP4MDKUCJ2/OTtvgY=
X-Received: by 2002:a02:c981:: with SMTP id b1mr4002348jap.6.1610454207998;
 Tue, 12 Jan 2021 04:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20210111182655.12159-1-alobakin@pm.me> <d4f4b6ba-fb3b-d873-23b2-4b5ba9cf4db8@gmail.com>
 <20210112110802.3914-1-alobakin@pm.me>
In-Reply-To: <20210112110802.3914-1-alobakin@pm.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Jan 2021 13:23:16 +0100
Message-ID: <CANn89iKEc_8_ySqV+KrbheTDKRL4Ws6JUKYeKXfogJNhfd+pGQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] skbuff: introduce skbuff_heads bulking and reusing
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Edward Cree <ecree.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Edward Cree <ecree@solarflare.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Guillaume Nault <gnault@redhat.com>,
        Yadu Kishore <kyk.segfault@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 12:08 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From: Edward Cree <ecree.xilinx@gmail.com>
> Date: Tue, 12 Jan 2021 09:54:04 +0000
>
> > Without wishing to weigh in on whether this caching is a good idea...
>
> Well, we already have a cache to bulk flush "consumed" skbs, although
> kmem_cache_free() is generally lighter than kmem_cache_alloc(), and
> a page frag cache to allocate skb->head that is also bulking the
> operations, since it contains a (compound) page with the size of
> min(SZ_32K, PAGE_SIZE).
> If they wouldn't give any visible boosts, I think they wouldn't hit
> mainline.
>
> > Wouldn't it be simpler, rather than having two separate "alloc" and "flush"
> >  caches, to have a single larger cache, such that whenever it becomes full
> >  we bulk flush the top half, and when it's empty we bulk alloc the bottom
> >  half?  That should mean fewer branches, fewer instructions etc. than
> >  having to decide which cache to act upon every time.
>
> I though about a unified cache, but couldn't decide whether to flush
> or to allocate heads and how much to process. Your suggestion answers
> these questions and generally seems great. I'll try that one, thanks!
>


The thing is : kmalloc() is supposed to have batches already, and nice
per-cpu caches.

This looks like an mm issue, are we sure we want to get over it ?

I would like a full analysis of why SLAB/SLUB does not work well for
your test workload.

More details, more numbers.... before we accept yet another
'networking optimization' adding more code to the 'fast' path.

More code means more latencies when all code needs to be brought up in
cpu caches.
