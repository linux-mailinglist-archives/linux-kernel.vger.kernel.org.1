Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E976E3006F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbhAVPSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbhAVPBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:01:20 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:00:35 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id o186so3156128vso.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0quo8ti+4vH65Fpdig8fTmdFyU+6QHTwCulp0MuqxA=;
        b=Jd2YZaLLqWsYuwmgzvQnRqyPqdBt9M7dGKomjV01QA3MVF7jC+0LZVISGnRUgSWIW0
         oHvxTbMl5ZGR3Vfa+nZc1RASLvUL1o+BOI1xeFmhpXby7g6DUV3nQo+upA5o4nfgVDGh
         EFkOwr11bLU50WJ+tvhhgf/hNsOU9Cv1+46PgaSFEefuri//ccllH7hOTEOBC8IzLNj3
         8T20E7LUPU7xOO3pI8e+Q1UWfEjEtMg4CA8jbXauz27JTL1VWvfaT1zp/KvTHGIyzttb
         X558gAobOahh4QDrlu6++yfiXnTQFWEqdKiMWMgStKEW8msVGkJsx1DzJpenl49l7Mqy
         XFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0quo8ti+4vH65Fpdig8fTmdFyU+6QHTwCulp0MuqxA=;
        b=SBXk6it65cdGBVZ9oDpJUul/5qoZF6tqmCuX23FQyQ917xP028vrg3JGsnESiYiyYK
         TmxfX/3uujCas71JH029LAFCyM8FweUSgRz7ueNgke0KtPoyzhiBscoRkp13RkW1H5Yd
         Jpdv+O8d5/bMery6Z7r551AaoVCQSg/7znZL20mhF906+7eoX/fFoqNqGxW9FQQH4QfK
         whqN8BjhIjClnKSEcuwgzZOfB/ysryQ6wGV6/1x9i87OouhbYdHpkk6xEmZHdo8jeQqS
         hCO8JC8xsUCVlNjUP05dOUuIkvfiiNNS23hz3w8cVTu4I54Qmaio3GS7VxbEqIUykg6N
         R6lw==
X-Gm-Message-State: AOAM533+Bk+ZHGHaFLy/uz3uSsEGobINe0kqhtD9MhVe/pCOQ8WCVltI
        NIGn5nJirH2LjsNTJqpjEs+UObydlMY=
X-Google-Smtp-Source: ABdhPJwKfZuf5vb85nwIcZsvm2goWHEGEbCyGFdX7Yh5NvamAKDJhR9gyxcv1orpi4Q3CshcadRlLA==
X-Received: by 2002:a05:6102:1008:: with SMTP id q8mr1374342vsp.25.1611327634979;
        Fri, 22 Jan 2021 07:00:34 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id r79sm1244628vkr.42.2021.01.22.07.00.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:00:34 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id q140so631348vkb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:00:33 -0800 (PST)
X-Received: by 2002:a1f:5c16:: with SMTP id q22mr3198899vkb.12.1611327632725;
 Fri, 22 Jan 2021 07:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20210118193122.87271-1-alobakin@pm.me> <20210118193232.87583-1-alobakin@pm.me>
 <20210118193232.87583-2-alobakin@pm.me> <CA+FuTSeZu6Z0eQ20Fwhr6DmraV1a90vMb1LQcwLxesD04LXGgw@mail.gmail.com>
 <20210122111919.1973-1-alobakin@pm.me>
In-Reply-To: <20210122111919.1973-1-alobakin@pm.me>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 22 Jan 2021 09:59:56 -0500
X-Gmail-Original-Message-ID: <CA+FuTScQ8m5CUzEb6q3KzFH65ePJNQWhXn0wQG1mmfvfLG+4CA@mail.gmail.com>
Message-ID: <CA+FuTScQ8m5CUzEb6q3KzFH65ePJNQWhXn0wQG1mmfvfLG+4CA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] udp: allow forwarding of plain
 (non-fraglisted) UDP GRO packets
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Antoine Tenart <atenart@kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Andrew Lunn <andrew@lunn.ch>,
        Meir Lichtinger <meirl@mellanox.com>,
        Aya Levin <ayal@mellanox.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 6:25 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Thu, 21 Jan 2021 21:47:47 -0500
>
> > On Mon, Jan 18, 2021 at 2:33 PM Alexander Lobakin <alobakin@pm.me> wrote:
> > >
> > > Commit 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.") actually
> > > not only added a support for fraglisted UDP GRO, but also tweaked
> > > some logics the way that non-fraglisted UDP GRO started to work for
> > > forwarding too.
> > > Commit 2e4ef10f5850 ("net: add GSO UDP L4 and GSO fraglists to the
> > > list of software-backed types") added GSO UDP L4 to the list of
> > > software GSO to allow virtual netdevs to forward them as is up to
> > > the real drivers.
> > >
> > > Tests showed that currently forwarding and NATing of plain UDP GRO
> > > packets are performed fully correctly, regardless if the target
> > > netdevice has a support for hardware/driver GSO UDP L4 or not.
> > > Plain UDP GRO forwarding even shows better performance than fraglisted
> > > UDP GRO in some cases due to not wasting one skbuff_head per every
> > > segment.
> >
> > That is surprising. The choice for fraglist based forwarding was made
> > on the assumption that it is cheaper if software segmentation is needed.
> >
> > Do you have a more specific definition of the relevant cases?
>
> "Classic" UDP GRO shows better performance when forwarding to a NIC
> that supports GSO UDP L4 (i.e. no software segmentation occurs), like
> the one that I test kernel on.
> I don't have much info about performance without UDP GSO offload
> as I usually test NAT, and fralisted UDP GRO currently fails on
> this [0].
>
> > There currently is no option to enable GRO for forwarding, without
> > fraglist if to a device with h/w udp segmentation offload. This would
> > add that option too.
>
> Yes, that's exactly what I want. I want to maximize UDP
> forwarding/NATing performance when NIC is capable of UDP GSO offload,
> as I said above, non-fraglisted UDP GRO is better for that case.

That makes sense. Better to make explicit that that is the case
targeted here, rather than "some cases".

> > Though under admin control, which may make it a rarely exercised option.
> > Assuming most hosts to have single or homogeneous NICs, the OS should
> > be able to choose the preferred option in most cases (e.g.,: use fraglist
> > unless all devices support h/w gro).
>
> I though about some sort of auto-selection, but at the moment of
> receiving we can't know which interface this skb will be forwarded
> to.
> Also, as Paolo Abeni said in a comment to v2, UDP GRO may cause
> sensible delays, which may be inacceptable in some environments.
> That's why we have to use a sockopt and netdev features to explicitly
> enable UDP GRO.

I'm suspect that such fine-grained toggles end up broadly unused.

Agreed that it is not always possible to predict the destination NIC,
but that is why I suggested a very low bar that I believe captures the
majority of installed systems: where all NICs support the feature.
Anyway, that can always be added later -- as long as having this flag
off is not interpreted as demanding fraglist on forwarding.

> Regarding all this, I introduced NETIF_F_UDP_GRO to have the
> following chose:
>  - both NETIF_F_UDP_GRO and NETIF_F_GRO_FRAGLIST is off - no UDP GRO;
>  - NETIF_F_UDP_GRO is on, NETIF_F_GRO_FRAGLIST is off - classic GRO;
>  - both NETIF_F_UDP_GRO and NETIF_F_GRO_FRAGLIST is on - fraglisted
>    UDP GRO.
>
> > > Add the last element and allow to form plain UDP GRO packets if
> > > there is no socket -> we are on forwarding path, and the new
> > > NETIF_F_GRO_UDP is enabled on a receiving netdevice.
> > > Note that fraglisted UDP GRO now also depends on this feature, as
> >
> > That may cause a regression for applications that currently enable
> > that device feature.
>
> Thought about this one too. Not sure if it would be better to leave
> it as it is for now or how it's done in this series. The problem
> that we may have in future is that in some day we may get fraglisted
> TCP GRO, and then NETIF_F_GRO_FRAGLIST will affect both TCP and UDP,
> which is not desirable as for me. So I decided to guard this possible
> case.
>
> > > NETIF_F_GRO_FRAGLIST isn't tied to any particular L4 protocol.

As its name implies. I think it makes more sense to see it as an
explicit request to use fraglist for any protocol that supports it.

> > >
> > > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > > ---
> > >  net/ipv4/udp_offload.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > > index ff39e94781bf..781a035de5a9 100644
> > > --- a/net/ipv4/udp_offload.c
> > > +++ b/net/ipv4/udp_offload.c
> > > @@ -454,13 +454,19 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
> > >         struct sk_buff *p;
> > >         struct udphdr *uh2;
> > >         unsigned int off = skb_gro_offset(skb);
> > > -       int flush = 1;
> > > +       int flist = 0, flush = 1;
> > > +       bool gro_by_feat = false;
> >
> > What is this variable shorthand for? By feature? Perhaps
> > gro_forwarding is more descriptive.
>
> Yes, I chose "by feature" because fraglisted GRO also starts to
> work for local traffic if enabled, so "gro_forwarding" would be
> inaccurate naming.
>
> > >
> > > -       NAPI_GRO_CB(skb)->is_flist = 0;
> > > -       if (skb->dev->features & NETIF_F_GRO_FRAGLIST)
> > > -               NAPI_GRO_CB(skb)->is_flist = sk ? !udp_sk(sk)->gro_enabled: 1;
>
> I mean this. is_flist gets enabled if socket GRO option is disabled.
>
> > > +       if (skb->dev->features & NETIF_F_GRO_UDP) {
> > > +               if (skb->dev->features & NETIF_F_GRO_FRAGLIST)
> > > +                       flist = !sk || !udp_sk(sk)->gro_enabled;
> > >
> > > -       if ((sk && udp_sk(sk)->gro_enabled) || NAPI_GRO_CB(skb)->is_flist) {
> >
> > I would almost rename NETIF_F_GRO_FRAGLIST to NETIF_F_UDP_GRO_FWD.
> > Then this could be a !NETIF_F_UDP_GRO_FWD_FRAGLIST toggle on top of
> > that. If it wasn't for this fraglist option also enabling UDP GRO to
> > local sockets if set.
> >
> > That is, if the performance difference is significant enough to
> > require supporting both types of forwarding, under admin control.
> >
> > Perhaps the simplest alternative is to add the new feature without
> > making fraglist dependent on it:
> >
> >   if ((sk && udp_sk(sk)->gro_enabled) ||
> >       (skb->dev->features & NETIF_F_GRO_FRAGLIST) ||
> >       (!sk && skb->dev->features & NETIF_F_GRO_UDP_FWD))
>
> Yep, this will be the exact code if we end up with that
> NETIF_F_GRO_FRAGLIST should not depends on new netdev feature.
> But again, I wanted to protect TCP GRO if fraglisted TCP GRO will
> ever land the kernel. May be it's too much for the feature that
> currently doesn't exists even as a draft or plan, not sure.

If a protocol lands an fraglist implementation, I think the
expectation is that it will respond to the fraglist bit. I don't
understand why to preemptively block this. Then we would need yet
another feature bit for "forward <protocol> with fraglist".

>
> So, I'd stick to this variant (NETIF_F_UDP_GRO_FWD for plain,
> NETIF_F_GRO_FRAGLIST without changes for fraglisted) if preferred.
>
> > > +               gro_by_feat = !sk || flist;
> > > +       }
> > > +
> > > +       NAPI_GRO_CB(skb)->is_flist = flist;
> > > +
> > > +       if (gro_by_feat || (sk && udp_sk(sk)->gro_enabled)) {
> > >                 pp = call_gro_receive(udp_gro_receive_segment, head, skb);
> > >                 return pp;
> > >         }
> > > --
> > > 2.30.0
>
> [0] https://lore.kernel.org/netdev/1611235479-39399-1-git-send-email-dseok.yi@samsung.com
>
> Thanks,
> Al
>
