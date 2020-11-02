Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C632A34DD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgKBUGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgKBUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:05:18 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C6FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 12:05:18 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id e3so8165848vsr.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 12:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2IVMowfbqKKUzrL12c02A/SfsiLLJUjZ9rRbpPh21U=;
        b=qPebbXEEdo3NGJQKQOqe8mVzflazVESbXBdlpN5WnTbvvtBh8duuNo4JUucHN2K71P
         qTghfWs5nRjb4dyCK2OdUGeMMZwjLGA97W4egpGeMMx2V4Lt8ryvYkBvOt4s8CBYODpD
         a8JZtvEzqWX6alXIB/dT/ZWf0L8qCxP7evNgxXNJKDyY7goBJIxsaKFnVV3MofZ9BSOh
         vvuHWblS5foxbcZ2kOgyvUAtyGb3dV5hjcXT8ZN23jwKW4tLAfibT0cJxXGrdtYz78Jv
         UKgGkEHmj8PdDvPIrIDMycBy1FvEW3cFs6mBgznq0aEOVc2afGifnYZDVEtX2wJRChCq
         WuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2IVMowfbqKKUzrL12c02A/SfsiLLJUjZ9rRbpPh21U=;
        b=COo0X/7hJmTNXwkXWPEYmkKqHbsSgR0WqRK4YOno6QgREn7hEoplBDWxeX7c9SnH/F
         W4iXfFYyYnbGBXmUQhF5N0fSbKAvRt5cc6EBtHrpzVd9NEPpQ8bMc9aNQTVoRhseY6a0
         IAMTLz4E+ecSAe5gjZb4Xl4ks+qTRGZ0M18fQHupCTzwKqnAEQy02q565h8wgfSEAV1f
         juHDU9mPih1tXuHoVGP5P0i3zb8eSWBcKFLyOWVOSiBq9S6/i5vOqAcUVLe77pBL1Ife
         8rZi4we0w9kx01a6eVy/lnf9xjoKVQ7DuF00/n9QCMNXoiawYxVqwarp1Au3IhAX0+z7
         ObIw==
X-Gm-Message-State: AOAM532vSQrKjfZKYV9YfFo54cInCsm88JZThOdPjkFOip6cNamge0QB
        8Ye5jf2jy7q9wVKrfinhoKrd9AKm12g=
X-Google-Smtp-Source: ABdhPJweUUzhMgXzv4ohTc6oEEe1wb8Oy/r2evuDa9AvuSiuzN4nle8rspHnjBkeiKnMWrNwavmacQ==
X-Received: by 2002:a67:f157:: with SMTP id t23mr16128682vsm.12.1604347516604;
        Mon, 02 Nov 2020 12:05:16 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 14sm1719336uaf.15.2020.11.02.12.05.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 12:05:15 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id u7so8138921vsq.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 12:05:14 -0800 (PST)
X-Received: by 2002:a05:6102:240f:: with SMTP id j15mr6241145vsi.22.1604347514191;
 Mon, 02 Nov 2020 12:05:14 -0800 (PST)
MIME-Version: 1.0
References: <GtgHtyGO5jHKHT6zGMAzg3TDejXZT0HMQVoqNERZRdM@cp3-web-024.plabs.ch>
 <CA+FuTSd1H6+NjSDcin6KQo9y1KEsDACeAvyr0p5JuDWc-aEh+A@mail.gmail.com> <4e2CSI69yKQIvZp3Wwo9pC9lHNAz4osj7w8OdhYUdE@cp7-web-042.plabs.ch>
In-Reply-To: <4e2CSI69yKQIvZp3Wwo9pC9lHNAz4osj7w8OdhYUdE@cp7-web-042.plabs.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 2 Nov 2020 15:04:37 -0500
X-Gmail-Original-Message-ID: <CA+FuTSeY7cMKqU_KGoxGJGp1vSiLJ9vUxrh9hoJHQg31W6fYtA@mail.gmail.com>
Message-ID: <CA+FuTSeY7cMKqU_KGoxGJGp1vSiLJ9vUxrh9hoJHQg31W6fYtA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] net: bonding, dummy, ifb, team: advertise NETIF_F_GSO_SOFTWARE
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Antoine Tenart <atenart@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 2:26 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Mon, 2 Nov 2020 11:30:17 -0500
>
> Hi!
> Thanks for the Ack.
>
> > On Sun, Nov 1, 2020 at 8:17 AM Alexander Lobakin <alobakin@pm.me> wrote:
> >>
> >> Virtual netdevs should use NETIF_F_GSO_SOFTWARE to forward GSO skbs
> >> as-is and let the final drivers deal with them when supported.
> >> Also remove NETIF_F_GSO_UDP_L4 from bonding and team drivers as it's
> >> now included in the "software" list.
> >
> > The rationale is that it is okay to advertise these features with
> > software fallback as bonding/teaming "hardware" features, because
> > there will always be a downstream device for which they will be
> > implemented, possibly in the software fallback, correct?
> >
> > That does not apply to dummy or IFB. I guess dummy is fine, because
> > xmit is a black hole, and IFB because ingress can safely handle these
> > packets? How did you arrive at the choice of changing these two, of
> > all virtual devices?
>
> Two points:
> 1. Exactly, dummy is just dummy, while ifb is an intermediate netdev to
>    share resources, so it should be as fine as with other virtual devs.
> 2. They both advertise NETIF_F_ALL_TSO | NETIF_F_GSO_ENCAP_ALL, which
>    assumes that they handle all GSO skbs just like the others (pass
>    them as is to the real drivers in case with ifb).

There is no real driver in the case of ifb if it forwards to the
ingress path. But as discussed before, that can handle gso packets for
all these protocols, too.

> >>
> >> Suggested-by: Willem de Bruijn <willemb@google.com>
> >> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Acked-by: Willem de Bruijn <willemb@google.com>
