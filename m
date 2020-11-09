Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F308B2AC3D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgKIS3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgKIS3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:29:34 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4A0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:29:34 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id e8so1621108vkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLA7/mamq88rlEqhjwdpSzG3LkBhX2EWIU1whnjCGZU=;
        b=B7rwhjI0RLzwkFqQMa3OcYJxW6clmqovdwWLxiGbE2JhOl4pPKyEXj3+VowoG8xdwq
         J32UKP1mRlgB5VAGzAQc6X2Y/6CdTFx4SEGCr9tJvqirBKa8LWrfX92+Ji1DqaaYF4UW
         Spt5qjLccd502QWiuJqhnLJArWa20Dc2EMqkr8LyMcCeKGcTW2Z9pLsewCrWHmyabxej
         PinweqLPNYStuMZDfhoucH8qZuz/LOmmBKxQUBgJOre94Od6rXOxxWUGHqIYwGyTLn4m
         8R+h0p00lY2VwtE7YLTDHAovtHCwpBFtFgNwXKhxC/LRocTnJKUY/EnISDdWCy/7Ot+L
         IT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLA7/mamq88rlEqhjwdpSzG3LkBhX2EWIU1whnjCGZU=;
        b=IFCIDtPutoxxQ1nGpQYjehUE4hPSggofXanIBHvY1tjjRc51Lz7FokcrZXtU6USctv
         71AJGQ9tEvPo3TalCp+zd+//9ZbicfM//rW7eDZBgQcaYMTqMoolYW8p3/vF+7Lx99ld
         CjiFeBlFmVwCY0mD4JYWjmBlYAK7lkl9WVuI791P6yHQ35bQt4d3cunbFdHOSyjvvRp9
         5fN6LbK2hcniVSCVPdEO4rGmbr6jZqswxIa5NyfVOOilox4uFWZvq76GjhJfpqR+6+d0
         9yl51PQQ6atwJYYwVbIOGfgZHdZ8g5CY9nhcKBC5WAGXl/4yZf7VNmZZcz5sAhU7pbzd
         WdNQ==
X-Gm-Message-State: AOAM531cQaqHpECMlxmHL/807n328GF4HP/M6YbZ6FwjxnQsFTeJw4nB
        qmcMLoSrwTQAHVm+0F5yLojrMJ63gqE=
X-Google-Smtp-Source: ABdhPJyJuUKPhkZWdfF3vkeub5E6dD+4CJBvqo8jzQZlU/ETURUTcu9W0jxsuIcZFt1qRJmq8dlSxw==
X-Received: by 2002:a05:6122:1286:: with SMTP id i6mr2437886vkp.11.1604946572927;
        Mon, 09 Nov 2020 10:29:32 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id i19sm1220590uah.0.2020.11.09.10.29.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 10:29:31 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id x11so5503819vsx.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:29:31 -0800 (PST)
X-Received: by 2002:a67:ce0e:: with SMTP id s14mr8950211vsl.13.1604946571245;
 Mon, 09 Nov 2020 10:29:31 -0800 (PST)
MIME-Version: 1.0
References: <0eaG8xtbtKY1dEKCTKUBubGiC9QawGgB3tVZtNqVdY@cp4-web-030.plabs.ch> <d9d09931-8cd3-1eb6-673c-3ae5ebc3ee57@gmail.com>
In-Reply-To: <d9d09931-8cd3-1eb6-673c-3ae5ebc3ee57@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Nov 2020 13:28:54 -0500
X-Gmail-Original-Message-ID: <CA+FuTSc0QLM4QpinZ1XiLreRECBDVbanwoFtMhnF6caEWjXTBw@mail.gmail.com>
Message-ID: <CA+FuTSc0QLM4QpinZ1XiLreRECBDVbanwoFtMhnF6caEWjXTBw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: udp: fix Fast/frag0 UDP GRO
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 12:37 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 11/9/20 5:56 PM, Alexander Lobakin wrote:
> > While testing UDP GSO fraglists forwarding through driver that uses
> > Fast GRO (via napi_gro_frags()), I was observing lots of out-of-order
> > iperf packets:
> >
> > [ ID] Interval           Transfer     Bitrate         Jitter
> > [SUM]  0.0-40.0 sec  12106 datagrams received out-of-order
> >
> > Simple switch to napi_gro_receive() any other method without frag0
> > shortcut completely resolved them.
> >
> > I've found that UDP GRO uses udp_hdr(skb) in its .gro_receive()
> > callback. While it's probably OK for non-frag0 paths (when all
> > headers or even the entire frame are already in skb->data), this
> > inline points to junk when using Fast GRO (napi_gro_frags() or
> > napi_gro_receive() with only Ethernet header in skb->data and all
> > the rest in shinfo->frags) and breaks GRO packet compilation and
> > the packet flow itself.
> > To support both modes, skb_gro_header_fast() + skb_gro_header_slow()
> > are typically used. UDP even has an inline helper that makes use of
> > them, udp_gro_udphdr(). Use that instead of troublemaking udp_hdr()
> > to get rid of the out-of-order delivers.
> >
> > Present since the introduction of plain UDP GRO in 5.0-rc1.
> >
> > Since v1 [1]:
> >  - added a NULL pointer check for "uh" as suggested by Willem.
> >
> > [1] https://lore.kernel.org/netdev/YazU6GEzBdpyZMDMwJirxDX7B4sualpDG68ADZYvJI@cp4-web-034.plabs.ch
> >
> > Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
> > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > ---
> >  net/ipv4/udp_offload.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index e67a66fbf27b..7f6bd221880a 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -366,13 +366,18 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
> >  static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
> >                                              struct sk_buff *skb)
> >  {
> > -     struct udphdr *uh = udp_hdr(skb);
> > +     struct udphdr *uh = udp_gro_udphdr(skb);
> >       struct sk_buff *pp = NULL;
> >       struct udphdr *uh2;
> >       struct sk_buff *p;
> >       unsigned int ulen;
> >       int ret = 0;
> >
> > +     if (unlikely(!uh)) {
>
> How uh could be NULL here ?
>
> My understanding is that udp_gro_receive() is called
> only after udp4_gro_receive() or udp6_gro_receive()
> validated that udp_gro_udphdr(skb) was not NULL.

Oh indeed. This has already been checked before.

> > +             NAPI_GRO_CB(skb)->flush = 1;
> > +             return NULL;
> > +     }
> > +
> >       /* requires non zero csum, for symmetry with GSO */
> >       if (!uh->check) {
> >               NAPI_GRO_CB(skb)->flush = 1;
> >
>
> Why uh2 is left unchanged ?
>
>     uh2 = udp_hdr(p);

Isn't that the same as th2 = tcp_hdr(p) in tcp_gro_receive? no frag0
optimization to worry about for packets on the list.


> ...
>
