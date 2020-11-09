Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CFB2AC49D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgKITGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbgKITGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:06:47 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493A5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 11:06:47 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id w123so2134876vka.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 11:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34A9y+yX9Z8HhcZWQDfMZ80c8nxtzTwsEMhJ3ulg5M8=;
        b=TnBT2SALNgylz4kI271r88B8/6bT2co6API7/SlfQxFS24kwp+rt4MiubfxZEpR3Xg
         DgUJr5v3Zl0/dLJk2bmXuQ1OEoPnwxyWv0JiqYwd6svj3dBxOb8m3mWouN7NeUBMoHpR
         SwGpVWmRzbLBBT1a2wbQTb9Ht/Ef1OcnxD83gl8WELIdtjKOiW01284bTaWHtgu9CXrd
         JnHEMbePhp2krOIFJ+wGMtsM0qmbCpVfUWWUGNVwloRuCDp4hI7ZMWXI793B/bxHliHJ
         +eAUob13PaC31LqZH8LrJPKkNKCHt5fu7R0A1Mfl9bafmqUsP16G0vtETo9r3W/xMEUQ
         g2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34A9y+yX9Z8HhcZWQDfMZ80c8nxtzTwsEMhJ3ulg5M8=;
        b=i0GGKubHjytJttfQdgF9Lk5GpHNxyflRzta6seyWzm/lL+ggSiPnu/UYOheLFuYl3D
         yf/m0QxqG76PIE4MftB3DC2b+QXQ0Z21anV2t0QWrAXk2mgkBjvtkC4FmCPiUPYM9KIk
         5LeL4fzGI+LAzXMqHDVwNH5fK+mOAVMSu7fKLrI26do6dTYCanSAz84xGywr1fcSbNuE
         H+y39pqDnZ3gXUUKCbXKT4osGOtDX7YNekAv7QZIYVKT0IVBwCqsPiGXbWb+Tpdu9jeR
         JA+fom40/7O+ec0WPbTxAD31KTyOB1N1uQfICdWBsIMavK6mm233V90x7AnypyWmrxbG
         y7aw==
X-Gm-Message-State: AOAM530DyiLJZoA0n3wFL2+Kge+7yXpubDRw4y+xO6G/gGbEo7JMaMuR
        Txu+NgB++iPQ3OrYXiRN0rFAMC2uSxc=
X-Google-Smtp-Source: ABdhPJzlt6gaRdIbLV/Ny7iy1oQS2vvRXg8IG4IENVlRJ24AYv2fxzK5paNXv72cK5gimoGsVbHPIg==
X-Received: by 2002:a1f:d205:: with SMTP id j5mr8356824vkg.9.1604948806072;
        Mon, 09 Nov 2020 11:06:46 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id v4sm1396946vsa.16.2020.11.09.11.06.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:06:45 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id z123so5590936vsb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 11:06:44 -0800 (PST)
X-Received: by 2002:a05:6102:240f:: with SMTP id j15mr9497300vsi.22.1604948804487;
 Mon, 09 Nov 2020 11:06:44 -0800 (PST)
MIME-Version: 1.0
References: <0eaG8xtbtKY1dEKCTKUBubGiC9QawGgB3tVZtNqVdY@cp4-web-030.plabs.ch>
 <d9d09931-8cd3-1eb6-673c-3ae5ebc3ee57@gmail.com> <CA+FuTSc0QLM4QpinZ1XiLreRECBDVbanwoFtMhnF6caEWjXTBw@mail.gmail.com>
 <3729478a-77b5-aeb5-0192-49f0e0d170ac@gmail.com>
In-Reply-To: <3729478a-77b5-aeb5-0192-49f0e0d170ac@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Nov 2020 14:06:07 -0500
X-Gmail-Original-Message-ID: <CA+FuTSd2q=zaBJffxi+ORs7rxZN50c8X3n4NoJcrAq+pAZAMCA@mail.gmail.com>
Message-ID: <CA+FuTSd2q=zaBJffxi+ORs7rxZN50c8X3n4NoJcrAq+pAZAMCA@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: udp: fix Fast/frag0 UDP GRO
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 1:54 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 11/9/20 7:28 PM, Willem de Bruijn wrote:
> > On Mon, Nov 9, 2020 at 12:37 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >>
> >>
> >>
> >> On 11/9/20 5:56 PM, Alexander Lobakin wrote:
> >>> While testing UDP GSO fraglists forwarding through driver that uses
> >>> Fast GRO (via napi_gro_frags()), I was observing lots of out-of-order
> >>> iperf packets:
> >>>
> >>> [ ID] Interval           Transfer     Bitrate         Jitter
> >>> [SUM]  0.0-40.0 sec  12106 datagrams received out-of-order
> >>>
> >>> Simple switch to napi_gro_receive() any other method without frag0
> >>> shortcut completely resolved them.
> >>>
> >>> I've found that UDP GRO uses udp_hdr(skb) in its .gro_receive()
> >>> callback. While it's probably OK for non-frag0 paths (when all
> >>> headers or even the entire frame are already in skb->data), this
> >>> inline points to junk when using Fast GRO (napi_gro_frags() or
> >>> napi_gro_receive() with only Ethernet header in skb->data and all
> >>> the rest in shinfo->frags) and breaks GRO packet compilation and
> >>> the packet flow itself.
> >>> To support both modes, skb_gro_header_fast() + skb_gro_header_slow()
> >>> are typically used. UDP even has an inline helper that makes use of
> >>> them, udp_gro_udphdr(). Use that instead of troublemaking udp_hdr()
> >>> to get rid of the out-of-order delivers.
> >>>
> >>> Present since the introduction of plain UDP GRO in 5.0-rc1.
> >>>
> >>> Since v1 [1]:
> >>>  - added a NULL pointer check for "uh" as suggested by Willem.
> >>>
> >>> [1] https://lore.kernel.org/netdev/YazU6GEzBdpyZMDMwJirxDX7B4sualpDG68ADZYvJI@cp4-web-034.plabs.ch
> >>>
> >>> Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
> >>> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> >>> ---
> >>>  net/ipv4/udp_offload.c | 7 ++++++-
> >>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> >>> index e67a66fbf27b..7f6bd221880a 100644
> >>> --- a/net/ipv4/udp_offload.c
> >>> +++ b/net/ipv4/udp_offload.c
> >>> @@ -366,13 +366,18 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
> >>>  static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
> >>>                                              struct sk_buff *skb)
> >>>  {
> >>> -     struct udphdr *uh = udp_hdr(skb);
> >>> +     struct udphdr *uh = udp_gro_udphdr(skb);
> >>>       struct sk_buff *pp = NULL;
> >>>       struct udphdr *uh2;
> >>>       struct sk_buff *p;
> >>>       unsigned int ulen;
> >>>       int ret = 0;
> >>>
> >>> +     if (unlikely(!uh)) {
> >>
> >> How uh could be NULL here ?
> >>
> >> My understanding is that udp_gro_receive() is called
> >> only after udp4_gro_receive() or udp6_gro_receive()
> >> validated that udp_gro_udphdr(skb) was not NULL.
> >
> > Oh indeed. This has already been checked before.
> >
> >>> +             NAPI_GRO_CB(skb)->flush = 1;
> >>> +             return NULL;
> >>> +     }
> >>> +
> >>>       /* requires non zero csum, for symmetry with GSO */
> >>>       if (!uh->check) {
> >>>               NAPI_GRO_CB(skb)->flush = 1;
> >>>
> >>
> >> Why uh2 is left unchanged ?
> >>
> >>     uh2 = udp_hdr(p);
> >
> > Isn't that the same as th2 = tcp_hdr(p) in tcp_gro_receive? no frag0
> > optimization to worry about for packets on the list.
>
> My feeling was that tcp_gro_receive() is terminal in the GRO stack.
>
> While UDP could be encapsulated in UDP :)
>
> I guess we do not support this yet.
>
> Years ago we made sure to propagate the current header offset into GRO stack
> (when we added SIT/IPIP/GRE support to GRO)
> 299603e8370a93dd5d8e8d800f0dff1ce2c53d36 ("net-gro: Prepare GRO stack for the upcoming tunneling support")

On which note, and Alexander's mention of udp4_lib_lookup_skb(), that
performs a standard ip_hdr on the possibly frag0 optimized incoming
packet:

struct sock *udp4_lib_lookup_skb(struct sk_buff *skb,
                                 __be16 sport, __be16 dport)
{
        const struct iphdr *iph = ip_hdr(skb);

        return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
                                 iph->daddr, dport, inet_iif(skb),
                                 inet_sdif(skb), &udp_table, NULL);
}

This should use skb_gro_header_.. too, then?
