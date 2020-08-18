Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D22486F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHROQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 10:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgHROPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:15:47 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D2BC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:15:47 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k4so17718474ilr.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbZdFPM5mBHqNGZT0LL+I7dna9RSXYnxxpFw086pKfU=;
        b=RmVr4Ws8VwlRGBEkpomlyGq7Aa0s7haUzbe8y/edlWahTFpVVmh6pJL1CXEQXYIUMn
         KxKzn9CWd8KWZVijUNs5WUvP5lHaCC/QdCQwNFqlKfruuVjzi4lrNfv+Tlqr5gTPTTOK
         ZnSmqHecyXnOclp15Ft5knVdiGdSIIBiIvg1KB+h/U2p3IeTvxUWJavPZvXRUdSrleeG
         NGhG5Pt85VWQ8TgPQZLu2hglWQCkb6xYpLuh7aPxYBer5dh+edoA5MXkRNmCgydpMcbO
         BXfXuDsO64NYGcxdY0OuwhTzrMZaFxF8KLNg0jLHU9puqySUm11CZ4y3CpnYIwCjcYWJ
         dFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbZdFPM5mBHqNGZT0LL+I7dna9RSXYnxxpFw086pKfU=;
        b=YsLlaegqs1MQfW+/QoRf+lI5M9/UUfAlOy5myRTWZSXi+xwuwHIayt9HVWATkQqVGc
         qku8Q3MB5KO6KIy9ESu1IiGSjyhV1yQrzLs4BWHjlTRHs7nYYfvhI02jgjTXSyMC4OT/
         ySEYnBDJuLCNtNbnFyE3ZUsd0KHV8C3nUUs2rr9XkFWdeDFS8mWqzp+YYC9z+Qlq8cTB
         XvuXNeM+Opm3bkn/amy2dPhTayyT5nnXlVanK6ktKBvlBQmZ1XTGNzWqU1U496xe/nXz
         HOY3eqAN746Tz9aKrUCnksEg9Mj9GNHdnpOkLZGgD6EcOTr4PJ9Q4sCF77488pod7I+m
         G2Mw==
X-Gm-Message-State: AOAM533qCbbeprvRJ3D5t/cXXZoLK4deLH+bET6F4Y9G9SIxsz/yMwJg
        AKSzoY9xMRUOp/uY8Ntc6Om8K8O37LdOsvUsTMWw+g==
X-Google-Smtp-Source: ABdhPJyEbAN+iTARA7Bg/Z96WFkMrFUm1/8bnjeKgQoDf0vjSXWxYSCOO5hB7Cboyb71Za9ILdQaTPfP1VPvInU6J7A=
X-Received: by 2002:a92:bb0e:: with SMTP id w14mr16467650ili.68.1597760146420;
 Tue, 18 Aug 2020 07:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200818115712.36497-1-linmiaohe@huawei.com>
In-Reply-To: <20200818115712.36497-1-linmiaohe@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 18 Aug 2020 07:15:35 -0700
Message-ID: <CANn89iLuh-3OHDmRKKm3N59oHzC15K+k84KD42Ej+3qP_GC57Q@mail.gmail.com>
Subject: Re: [PATCH] net: Relax the npages test against MAX_SKB_FRAGS
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, martin.varghese@nokia.com,
        Florian Westphal <fw@strlen.de>,
        Pravin B Shelar <pshelar@ovn.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Paolo Abeni <pabeni@redhat.com>, shmulik@metanetworks.com,
        kyk.segfault@gmail.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 4:58 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The npages test against MAX_SKB_FRAGS can be relaxed if we succeed to
> allocate high order pages as the note in comment said.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  net/core/skbuff.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 2f7dd689bccc..ca432bbfd90b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5758,13 +5758,6 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
>         struct page *page;
>         int i;
>
> -       *errcode = -EMSGSIZE;
> -       /* Note this test could be relaxed, if we succeed to allocate
> -        * high order pages...
> -        */
> -       if (npages > MAX_SKB_FRAGS)
> -               return NULL;
> -
>         *errcode = -ENOBUFS;
>         skb = alloc_skb(header_len, gfp_mask);
>         if (!skb)
> @@ -5775,6 +5768,10 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
>         for (i = 0; npages > 0; i++) {
>                 int order = max_page_order;
>
> +               if (unlikely(i >= MAX_SKB_FRAGS)) {
> +                       *errcode = -EMSGSIZE;
> +                       goto failure;
> +               }
>                 while (order) {
>                         if (npages >= 1 << order) {
>                                 page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
> --
> 2.19.1




We do not want this change.

This interface is used by datagram providers, we do not want to claim
they can safely use skb allocations over 64KB.

Returning -EMSGSIZE should not depend on availability of high-order pages.

The comment was a hint, but we need first a valid user before
considering expanding the interface.
