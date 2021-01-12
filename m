Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D182F39EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406769AbhALTUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406471AbhALTUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:20:08 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6FFC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:19:27 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 81so6379096ioc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLy0xq7ELrD0STDo2NgYg2AFasbCsB9i1uOCD1YMdOg=;
        b=eluIOJneUynVQdxqn0U6eBr+TxXjKsaXXjGqQ4qk7t8ATs4oVLWuFAfoQI1ie3oUah
         h3NDoU8fweqLlJ8k/j1wIgX5MiZslNNsdh14sWuYRahrsIG+MDH1FeQz7rzbRhgE1FHP
         4XRb4WRKlQm77QKyh0R0leaHxrDn0D0fWZWLTpyk2kgd7HyUh7sGViCYPmCuiQEQg/+n
         j/J/1K1jKt/utDC/tPwIPWXjtiXQMXerFZaA6ZuFBzVhsFe03G6XcnaXXdVTnnlRzOVg
         MiJNOyma+CPDLvupZksJir4LJLTK34s3oy2+0bPFd+mE+mAHLccIOdEpfPTheQk3HCeG
         zgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLy0xq7ELrD0STDo2NgYg2AFasbCsB9i1uOCD1YMdOg=;
        b=YU333boKc7bC5Wz1rJlrwmF14eqyRjqAJHVIXMu0LjE131wT3sIgi7mzZvXjtE+eAO
         HwEYuq7WKP1CvWBMjdfLJbS7YGwWV4jCTtrXqhfSSvurNxdsTG33nvZmScGY8nomKBnw
         s/x2DRClJw0j04wVHlHG6xaI7G5GJgTpBkuA8NlgfyTsDF5mB1EDd0kcv34D9xTNmkLf
         sGwLS6kGr7sZ3KR+VY35TkjZJUv8T3EfaB15i4HfAlqm/mQ/ZXf6rfQXjqabESavRR4c
         TD7KUie7OmTg3Ud4fMLeq4k82mS9uTDWx/txFEVK2ohtP4Jhw/kKmoGghMpl0ykxj1DJ
         VZXA==
X-Gm-Message-State: AOAM5325Koiy2GITbz6pIIpzD/MzzZYAXABM6dI2cwgzUar1UFzv9OwE
        dMtSb4xZsR3oIIDQGMogppEvuplkHUSww/0IojoW2Q==
X-Google-Smtp-Source: ABdhPJzY67ylLkBYEK/nHYwVkMPX6mGJuvbZOLzEKJsdyo56FwNk7JvWupQygIJVPPOIABD20DxM9yA7w/Rk7XSvEYE=
X-Received: by 2002:a05:6e02:42:: with SMTP id i2mr606833ilr.68.1610479166918;
 Tue, 12 Jan 2021 11:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20210111182655.12159-1-alobakin@pm.me> <CANn89iKceTG_Mm4RrF+WVg-EEoFBD48gwpWX=GQiNdNnj2R8+A@mail.gmail.com>
 <20210112105529.3592-1-alobakin@pm.me> <CANn89i+2VC3ZH5_fyWZvJA_6QrJLzaSupusQ1rXe8CqVffCB1Q@mail.gmail.com>
 <20210112182601.154198-1-alobakin@pm.me>
In-Reply-To: <20210112182601.154198-1-alobakin@pm.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Jan 2021 20:19:14 +0100
Message-ID: <CANn89iKfjSTU7ucXj7xwVdVi1ic4pvEDFNkVuMYsJERqva42ag@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] skbuff: introduce skbuff_heads bulking and reusing
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
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

On Tue, Jan 12, 2021 at 7:26 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 12 Jan 2021 13:32:56 +0100
>
> > On Tue, Jan 12, 2021 at 11:56 AM Alexander Lobakin <alobakin@pm.me> wrote:
> >>
> >
> >>
> >> Ah, I should've mentioned that I use UDP GRO Fraglists, so these
> >> numbers are for GRO.
> >>
> >
> > Right, this suggests UDP GRO fraglist is a pathological case of GRO,
> > not saving memory.
> >
> > Real GRO (TCP in most cases) will consume one skb, and have page
> > fragments for each segment.
> >
> > Having skbs linked together is not cache friendly.
>
> OK, so I rebased test setup a bit to clarify the things out.
>
> I disabled fraglists and GRO/GSO fraglists support advertisement
> in driver to exclude any "pathological" cases and switched it
> from napi_get_frags() + napi_gro_frags() to napi_alloc_skb() +
> napi_gro_receive() to disable local skb reusing (napi_reuse_skb()).
> I also enabled GSO UDP L4 ("classic" one: one skbuff_head + frags)
> for forwarding, not only local traffic, and disabled NF flow offload
> to increase CPU loading and drop performance below link speed so I
> could see the changes.
>
> So, the traffic flows looked like:
>  - TCP GRO (one head + frags) -> NAT -> hardware TSO;
>  - UDP GRO (one head + frags) -> NAT -> driver-side GSO.
>
> Baseline 5.11-rc3:
>  - 865 Mbps TCP, 866 Mbps UDP.
>
> This patch (both separate caches and Edward's unified cache):
>  - 899 Mbps TCP, 893 Mbps UDP.
>
> So that's cleary *not* only "pathological" UDP GRO Fraglists
> "problem" as TCP also got ~35 Mbps from this, as well as
> non-fraglisted UDP.
>
> Regarding latencies: I remember there were talks about latencies when
> Edward introduced batched GRO (using linked lists to pass skbs from
> GRO layer to core stack instead of passing one by one), so I think
> it's a perennial question when it comes to batching/caching.
>
> Thanks for the feedback, will post v2 soon.
> The question about if this caching is reasonable isn't closed anyway,
> but I don't see significant "cons" for now.
>

Also it would be nice to have KASAN support.

We do not want to unconditionally to recycle stuff, since this might
hide use-after-free.
