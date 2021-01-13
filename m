Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2642B2F4D45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbhAMOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbhAMOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:36:57 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70575C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:36:17 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id w18so4561273iot.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0W94dDXCvx9LJOldtOq3X07sn95kbaYg17AudZ1qMf0=;
        b=togBzejOMR3dc3xZWuGAJVxYAeCFTfaSFuj/KL/Oq+4GwlQ04I9bVHZyhKQNziOo+V
         dHPJQOAhMSzu4NkpjfpU+RN0K/2iNJiN6sjfvSBroEt3ajtjTMPsrGjsLWB4g7XLfQ5/
         csNPkoLN1TW1BDtH6AwnX9WpwoNrhyRE1QWxftBIJu2HSULKXb4fbDLZRePEeMg26M76
         34dCjlq+E6NJa+QqFIej6JnK9XaQZO9C+pSXeTQKHH/8VTmUjnnGE2UfHWn5XyQhiwuv
         m8rADzVBz1XiRomCKiVlQGuome1ifeaBRBSjY1PMJNsn6c9g+vwNadl/yPaH2HXtQw8c
         9DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0W94dDXCvx9LJOldtOq3X07sn95kbaYg17AudZ1qMf0=;
        b=DK5f8J277eD0P2aZTaZYoO70vW2ZAimSj8AMMKrsYurY+RQHDj6CxtLjWmdfYcVfli
         3CVRT+Q9naK64YWLggfE+6WqP1FNrZvTuJ9J1UO6Brkoh84xg9LZIOoCi+o0S/0IePKB
         7rGedH72utRTmbafH+t7u6uxnOgK3S5CDmgGioRKa93gI39C/kzN7GP6E1bUgUrKOiPn
         ncXCuC5+RwGJqMERX0D8XTqf80kJ06hg5iO+cWCbE9ZDEv8z+AzVdNprPYZ/JZisXMpd
         x0p9Tzl4AYW1nSQpfXOlMn2VXdB4XMf/TKlU9F2NIPg2gN4C+6Aj8KmL/+4PocgxVAUn
         yoDg==
X-Gm-Message-State: AOAM530KwdA4hT5VrVZz7p443VyThJVZMqGuNQtQBT65SKq6iKlDAKp6
        FU+kDwyWvMxik0T25hWRjWvA/i9ABKP2Po1sQEFZHA==
X-Google-Smtp-Source: ABdhPJytEXInoZolxRLSdaLxORC1HB4ARPjtfhih1uH3a90tL4/8dsBnnZgvOKIzamFWAZlGdRgBlbPXW1jHVf3SDso=
X-Received: by 2002:a92:9f59:: with SMTP id u86mr2600070ili.205.1610548576533;
 Wed, 13 Jan 2021 06:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20210113133523.39205-1-alobakin@pm.me> <20210113133635.39402-1-alobakin@pm.me>
 <20210113133635.39402-2-alobakin@pm.me>
In-Reply-To: <20210113133635.39402-2-alobakin@pm.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 13 Jan 2021 15:36:05 +0100
Message-ID: <CANn89i+azKGzpt4LrVVVCQdf82TLOC=dwUjA4NK3ziQHSKvtFw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] skbuff: (re)use NAPI skb cache on
 allocation path
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Guillaume Nault <gnault@redhat.com>,
        Yadu Kishore <kyk.segfault@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 2:37 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> Instead of calling kmem_cache_alloc() every time when building a NAPI
> skb, (re)use skbuff_heads from napi_alloc_cache.skb_cache. Previously
> this cache was only used for bulk-freeing skbuff_heads consumed via
> napi_consume_skb() or __kfree_skb_defer().
>
> Typical path is:
>  - skb is queued for freeing from driver or stack, its skbuff_head
>    goes into the cache instead of immediate freeing;
>  - driver or stack requests NAPI skb allocation, an skbuff_head is
>    taken from the cache instead of allocation.
>
> Corner cases:
>  - if it's empty on skb allocation, bulk-allocate the first half;
>  - if it's full on skb consuming, bulk-wipe the second half.
>
> Also try to balance its size after completing network softirqs
> (__kfree_skb_flush()).

I do not see the point of doing this rebalance (especially if we do not change
its name describing its purpose more accurately).

For moderate load, we will have a reduced bulk size (typically one or two).
Number of skbs in the cache is in [0, 64[ , there is really no risk of
letting skbs there for a long period of time.
(32 * sizeof(sk_buff) = 8192)
I would personally get rid of this function completely.


Also it seems you missed my KASAN support request ?
I guess this is a matter of using kasan_unpoison_range(), we can ask for help.




>
> prefetchw() on CONFIG_SLUB is dropped since it makes no sense anymore.
>
> Suggested-by: Edward Cree <ecree.xilinx@gmail.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  net/core/skbuff.c | 54 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index dc3300dc2ac4..f42a3a04b918 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -364,6 +364,7 @@ struct sk_buff *build_skb_around(struct sk_buff *skb,
>  EXPORT_SYMBOL(build_skb_around);
>
>  #define NAPI_SKB_CACHE_SIZE    64
> +#define NAPI_SKB_CACHE_HALF    (NAPI_SKB_CACHE_SIZE / 2)
>
>  struct napi_alloc_cache {
>         struct page_frag_cache page;
> @@ -487,7 +488,15 @@ EXPORT_SYMBOL(__netdev_alloc_skb);
>
>  static struct sk_buff *napi_skb_cache_get(struct napi_alloc_cache *nc)
>  {
> -       return kmem_cache_alloc(skbuff_head_cache, GFP_ATOMIC);
> +       if (unlikely(!nc->skb_count))
> +               nc->skb_count = kmem_cache_alloc_bulk(skbuff_head_cache,
> +                                                     GFP_ATOMIC,
> +                                                     NAPI_SKB_CACHE_HALF,
> +                                                     nc->skb_cache);
> +       if (unlikely(!nc->skb_count))
> +               return NULL;
> +
> +       return nc->skb_cache[--nc->skb_count];
>  }
>
>  /**
> @@ -867,40 +876,47 @@ void __consume_stateless_skb(struct sk_buff *skb)
>  void __kfree_skb_flush(void)
>  {
>         struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
> +       size_t count;
> +       void **ptr;
> +
> +       if (unlikely(nc->skb_count == NAPI_SKB_CACHE_HALF))
> +               return;
> +
> +       if (nc->skb_count > NAPI_SKB_CACHE_HALF) {
> +               count = nc->skb_count - NAPI_SKB_CACHE_HALF;
> +               ptr = nc->skb_cache + NAPI_SKB_CACHE_HALF;
>
> -       /* flush skb_cache if containing objects */
> -       if (nc->skb_count) {
> -               kmem_cache_free_bulk(skbuff_head_cache, nc->skb_count,
> -                                    nc->skb_cache);
> -               nc->skb_count = 0;
> +               kmem_cache_free_bulk(skbuff_head_cache, count, ptr);
> +               nc->skb_count = NAPI_SKB_CACHE_HALF;
> +       } else {
> +               count = NAPI_SKB_CACHE_HALF - nc->skb_count;
> +               ptr = nc->skb_cache + nc->skb_count;
> +
> +               nc->skb_count += kmem_cache_alloc_bulk(skbuff_head_cache,
> +                                                      GFP_ATOMIC, count,
> +                                                      ptr);
>         }
>  }
>
