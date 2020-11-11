Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9712AF761
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgKKR3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKKR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:29:02 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C1C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:29:01 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id m16so1590790vsl.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qb778JtBBre4THwiC7AFi5cBHs6XpQkr216/S4N/Bdg=;
        b=o3BGAQ7AB4acOXOGTtGt4biBH/BIOd6tdT301QMU1CbRTr7BaYBqODN+wRs/jUsK7Z
         F5LikMeBMEInQp0rW5/RUU0WYGhUhf7va9nkS+5lCsjPI5MvWUfZcsuTAUdymXplJ2tY
         sIrtZWt12LbCfqMYrSNfj2XwXyY/Zerv+9jpza1v3V4Pt+TPrhCNVuvJfR30xOzkEiIJ
         NHjUIp9j3I1HoRICQZ9uYSIrhySu2Suanp9TspDU8FDVHmCjThak/CKPSdGG2OHKiMmY
         JzSiBnvxXdwJf0LbMnaHWYfHs1kMub6RpMPErXaMF9FXKg8770Cww7eeUhUBIYFt6gSq
         ignA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qb778JtBBre4THwiC7AFi5cBHs6XpQkr216/S4N/Bdg=;
        b=bqTbCnBzxwBlcNN/NIwx6odKO91abrhqdY0WLFqAqTqatxHQ+dY9cr+QXNEsyxZCfT
         TG1vli+b4LEgUS/nd+cdvXhlI13TnpttKP2T2VBoajAh/6E5U2eK/tiBzQhTgw5K7YKv
         OTIzztAqWXxzuoCAPcgpTWguWui7PegWPDND9AamTBP9BakiNiFsL9kT2FvuIaoP903c
         6cm73Ydvl6M/WioS6jlyb345hcX0KjSOdtcTIJsicwGCHexG6Tr7lRYbADkbVgSJFCRE
         tIIS+PDDFNHGq/UchaVOPDUtyKzf2YkcbFzHUAmCRu5THkGbqcFJ44MDqmXEL61pQ9da
         ZmBw==
X-Gm-Message-State: AOAM532JYleaxez7v3yi8BdNpERmeZAQceukuh9XlNpG4ZVJXsAZyNCT
        ceym8uU2DpHlkzuyapM371+wv+8bpeQ=
X-Google-Smtp-Source: ABdhPJzEsOmoCgjC9lVkYix+tpdMZEMxBuurZVsdllTMCjETnMubeN2vjjzoY8WLlWc1ut+zV/cI+g==
X-Received: by 2002:a67:e088:: with SMTP id f8mr16188492vsl.27.1605115740422;
        Wed, 11 Nov 2020 09:29:00 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id h1sm303926vsa.12.2020.11.11.09.28.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 09:28:59 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id u24so1592880vsl.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:28:59 -0800 (PST)
X-Received: by 2002:a67:7704:: with SMTP id s4mr15557777vsc.51.1605115738887;
 Wed, 11 Nov 2020 09:28:58 -0800 (PST)
MIME-Version: 1.0
References: <bEm19mEHLokLGc5HrEiEKEUgpZfmDYPoFtoLAAEnIUE@cp3-web-033.plabs.ch>
 <CA+FuTScriNKLu=q+xmBGjtBB06SbErZK26M+FPiJBRN-c8gVLw@mail.gmail.com>
 <zlsylwLJr9o9nP9fcmUnMBxSNs5tLc6rw2181IgE@cp7-web-041.plabs.ch> <20201111082658.4cd3bb1d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201111082658.4cd3bb1d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:21 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfnRJF4_SoMtJz+B7Y5hePoA1OzA797zkmzJ0cYQ99iVw@mail.gmail.com>
Message-ID: <CA+FuTSfnRJF4_SoMtJz+B7Y5hePoA1OzA797zkmzJ0cYQ99iVw@mail.gmail.com>
Subject: Re: [PATCH v4 net] net: udp: fix Fast/frag0 UDP GRO
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:27 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 11 Nov 2020 11:29:06 +0000 Alexander Lobakin wrote:
> > >>> +     sk = static_branch_unlikely(&udp_encap_needed_key) ?
> > >>> +          udp4_gro_lookup_skb(skb, uh->source, uh->dest) :
> > >>> +          NULL;
> > >
> > > Does this indentation pass checkpatch?
> >
> > Sure, I always check my changes with checkpatch --strict.
> >
> > > Else, the line limit is no longer strict,a and this only shortens the
> > > line, so a single line is fine.
> >
> > These single lines is about 120 chars, don't find them eye-pleasant.
> > But, as with "u32" above, they're pure cosmetics and can be changed.
>
> let me chime in on the perhaps least important aspect of the patch :)
>
> Is there are reason to use a ternary operator here at all?
> Isn't this cleaner when written with an if statement?
>
>         sk = NULL;
>         if (static_branch_unlikely(&udp_encap_needed_key))
>                 sk = udp4_gro_lookup_skb(skb, uh->source, uh->dest);

Ah indeed :)

One other thing I missed before. The socket lookup is actually an
independent issue, introduced on commit a6024562ffd7 ("udp: Add GRO
functions to UDP socket"). Should be a separate Fixes tag, perhaps
even a separate patch.
