Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185CF2AC84D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgKIWZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIWZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:25:09 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7317AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 14:25:09 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id k12so3311706uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 14:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7J1frim2Gmu7cnIZwRAm8GwdYdgbW4mQlO83f03DoX8=;
        b=G2FkNP618JGFUMp5BYl/j3zIMXpd90SRIlm1x34j85v/YAIKgp+G35i3I1ylf/zOeu
         SKeP6Ss3R+ceMRfgIdSz64Qhi86bNiaI+4OoNEKy/fg81IY/Z0YxtoldKvMjXo0WLVH2
         m/nshf5OOgwHM0b1t+OO9kE1czwo1Vc14Ub4unnSL/N6rO2cOr8FTPZiTFCctDyWtjqe
         ffMSJy+7Z+v4NyScTdg25gfX3vNk5Uk1GcxO771JY390VqKE6QJbkgFJ6IsQfQT0bFjg
         shgbBgbPN6XMTc/JQJFhW4OLTPLGR5gRogZXTGMkcmkJOAlomWvgSNT5HV63ltNFkkto
         rr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7J1frim2Gmu7cnIZwRAm8GwdYdgbW4mQlO83f03DoX8=;
        b=ShjnnNIe/v2SzZSAMC8NIL80WN44xiKEASFoDQkG/YHdDcyGyXNCqUi8HhicNQk4bb
         p/3r6yzremHFDWvIWkmMvqcWe7pJvaYkzY5veARZyREdg5Us6SN8dP08wW/7MMVVe9P+
         2/uI5BCCDKtOSkO+qpVXIWEzs9UksNfMYrHhDSe/VN+G+Q9LTvicrPvtBa53WMuV6unU
         zEVWvfkKzY+Gg9ojST8Ez+sJhJbRc7sO+e8oqQADr1ljG6DJswq2teK45vY/5pQ3RCDP
         tEly8Cdg/NcJUAnW3AzQZ92sxinSXDvcXR7JnNaKoOLst5q/JHcFXxGP1tFp0wz5lgx6
         3etQ==
X-Gm-Message-State: AOAM5317pr7sVc4vB/ExxtWQWF3nHNvtYDZtW8V8RlDl8PtT8ZIDgOSu
        ENzUuOdcjuqUVrXRtyL8Lj5D8uXxUqU=
X-Google-Smtp-Source: ABdhPJyG7im/LQ+qNW1yQx8aPoIFXYJXE1dC5Oh5qjgtbvG8ILOFWvlsTPeW49+HPi30UE5K9aPMig==
X-Received: by 2002:ab0:2101:: with SMTP id d1mr7692768ual.125.1604960708105;
        Mon, 09 Nov 2020 14:25:08 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id n190sm1379852vsn.34.2020.11.09.14.25.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 14:25:07 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id f7so5898457vsh.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 14:25:07 -0800 (PST)
X-Received: by 2002:a67:ed4b:: with SMTP id m11mr345672vsp.14.1604960706575;
 Mon, 09 Nov 2020 14:25:06 -0800 (PST)
MIME-Version: 1.0
References: <MgZce9htmEtCtHg7pmWxXXfdhmQ6AHrnltXC41zOoo@cp7-web-042.plabs.ch>
In-Reply-To: <MgZce9htmEtCtHg7pmWxXXfdhmQ6AHrnltXC41zOoo@cp7-web-042.plabs.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 9 Nov 2020 17:24:30 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdWQyWmq5NT_syXCSUX9+kgKxhz1Rg+2JKNYTBCFQ0e-g@mail.gmail.com>
Message-ID: <CA+FuTSdWQyWmq5NT_syXCSUX9+kgKxhz1Rg+2JKNYTBCFQ0e-g@mail.gmail.com>
Subject: Re: [PATCH v3 net] net: udp: fix Fast/frag0 UDP GRO
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 4:15 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> While testing UDP GSO fraglists forwarding through driver that uses
> Fast GRO (via napi_gro_frags()), I was observing lots of out-of-order
> iperf packets:
>
> [ ID] Interval           Transfer     Bitrate         Jitter
> [SUM]  0.0-40.0 sec  12106 datagrams received out-of-order
>
> Simple switch to napi_gro_receive() any other method without frag0
> shortcut completely resolved them.
>
> I've found that UDP GRO uses udp_hdr(skb) in its .gro_receive()
> callback. While it's probably OK for non-frag0 paths (when all
> headers or even the entire frame are already in skb->data), this
> inline points to junk when using Fast GRO (napi_gro_frags() or
> napi_gro_receive() with only Ethernet header in skb->data and all
> the rest in shinfo->frags) and breaks GRO packet compilation and
> the packet flow itself.
> To support both modes, skb_gro_header_fast() + skb_gro_header_slow()
> are typically used. UDP even has an inline helper that makes use of
> them, udp_gro_udphdr(). Use that instead of troublemaking udp_hdr()
> to get rid of the out-of-order delivers.
>
> Present since the introduction of plain UDP GRO in 5.0-rc1.
>
> Since v2 [1]:
>  - dropped redundant check introduced in v2 as it's performed right
>    before (thanks to Eric);
>  - udp_hdr() switched to data + off for skbs from list (also Eric);
>  - fixed possible malfunction of {,__}udp{4,6}_lib_lookup_skb() with
>    Fast/frag0 due to ip{,v6}_hdr() usage (Willem).
>
> Since v1 [2]:
>  - added a NULL pointer check for "uh" as suggested by Willem.
>
> [1] https://lore.kernel.org/netdev/0eaG8xtbtKY1dEKCTKUBubGiC9QawGgB3tVZtNqVdY@cp4-web-030.plabs.ch
> [2] https://lore.kernel.org/netdev/YazU6GEzBdpyZMDMwJirxDX7B4sualpDG68ADZYvJI@cp4-web-034.plabs.ch
>
> Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  net/ipv4/udp.c         | 4 ++--
>  net/ipv4/udp_offload.c | 9 ++++++---
>  net/ipv6/udp.c         | 4 ++--
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 09f0a23d1a01..948ddc9a0212 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -534,7 +534,7 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
>                                                  __be16 sport, __be16 dport,
>                                                  struct udp_table *udptable)
>  {
> -       const struct iphdr *iph = ip_hdr(skb);
> +       const struct iphdr *iph = skb_gro_network_header(skb);

This function is called from the normal UDP stack, not the GRO stack.
It's not safe to use this helper here.

>
>         return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
>                                  iph->daddr, dport, inet_iif(skb),
> @@ -544,7 +544,7 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
>  struct sock *udp4_lib_lookup_skb(struct sk_buff *skb,
>                                  __be16 sport, __be16 dport)
>  {
> -       const struct iphdr *iph = ip_hdr(skb);
> +       const struct iphdr *iph = skb_gro_network_header(skb);

This one is, but I think it would be preferable to avoid leaking this
frag0 optimization stuff outside of the core GRO code if we can help
it.

Also haven't checked whether that helper is safe to call from
.gro_complete handlers such as udp_gro_complete. It's not needed
there, in any case.

Instead, perhaps we can call __udp4_lib_lookup which takes the exact
fields as arguments, and do the network header lookup in
udp_gro_complete itself.

Less important (because it's not working before), does the use of
skb_gro_network_header break any nested tunnel support that the
p->data + off change would add?
