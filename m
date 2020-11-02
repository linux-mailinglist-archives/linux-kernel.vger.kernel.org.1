Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891FF2A2DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKBPOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKBPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:14:46 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8196C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 07:14:46 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id f7so1855550vsh.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNQerxc/qedC0wC+tF3QpQvj0h2R4xLt0PpUVkepzP0=;
        b=hDytvYZ1jBaQm/8UzAKKD5kCuGe4Gq6Si8iXJ7s6JrfIz14Yz1odx4/5Wb6frOwLHr
         ruCvpXYEdm7XzZalJ6nfhmPPxetXBJsSGkv2Hl2FEaAcioU0wW+eJKb6GNfGFf/bU+nu
         5Q8wiGVjj+1nafnithF5K9+NUzbptO7hXKr5Uj1u517J8RSU4spZZDpa8l+iwCkpEKll
         o/AYBiyHHzdRbVMgDkkSF1w8agpTP1lqNjlu2o4CkPoTdVbwIzSzedCF9FO7a/OHYFP3
         pOaiPucWZE3PURQUM7TkUn+rCJLKNjuoptb3OQsKeT49/yli1OMcsxpk17KWpq2FWHwv
         Dm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNQerxc/qedC0wC+tF3QpQvj0h2R4xLt0PpUVkepzP0=;
        b=JfYqEAvzsPHTwv0bT8Dm8XVCvNDggva7jVibEEtsNCYhvSNp7+qW/Rv+4ATMhTc3It
         ATh182AbgeLcf5/737FmgjtBADSjyxx+m8jkHVYxwQEyZTemdSP0MYqWwwqInTwXfC2P
         uNItendN5lUrb3ro6WRVDx3HPecld9jQwfInCMATSBtO1l1/LczxKiblk3RYqvc7zFwu
         gHFTEXnKAeGJbbYUlJracXzvqFCkWIGf/4La6Tv/WzPMIxstzMsXoJm2TleZ9pPeNgNm
         hGIfr68f3jbBRvtAD/Q2mKwhPgg5qN5Bvads6TWl41hvEB39WRJyi30D9c/YUPyeiTb3
         tPzQ==
X-Gm-Message-State: AOAM532EO2zVsrc4v2nsDyAvY/RIvm4XpK0WdfnOnJZpk3fkVRrEc4sr
        ugrJ84demZlZlziY1Sz28sO9M/G3W2E=
X-Google-Smtp-Source: ABdhPJx+/9/CPeu/Mtc92DuT62ENxxrex59FC0yCbdEEAM54OU0QfSYm2oB1FxTIr58P6lqGDu/ltw==
X-Received: by 2002:a67:2783:: with SMTP id n125mr15449067vsn.47.1604330085281;
        Mon, 02 Nov 2020 07:14:45 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id u7sm1520254vsj.1.2020.11.02.07.14.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 07:14:41 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id b34so4018811uab.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:14:39 -0800 (PST)
X-Received: by 2002:ab0:3721:: with SMTP id s1mr5923580uag.92.1604330078711;
 Mon, 02 Nov 2020 07:14:38 -0800 (PST)
MIME-Version: 1.0
References: <Mx3BWGop6fGORN6Cpo4mHIHz2b1bb0eLxeMG8vsijnk@cp3-web-020.plabs.ch>
 <CA+FuTSdiqaZJ3HQHuEEMwKioWGKvGwZ42Oi7FpRf0hqWdZ27pQ@mail.gmail.com>
 <TSRRse4RkO_XW4DtdTkz4NeZPwzHXaPOEFU9-J4VlpLbUzlBzuhW8HYfHCfFJ1Ro6FwztEO652tbnSGOE-MjfKez1NvVPM3v3ResWtbK5Rk=@pm.me>
 <MX6AwRxaXyMi3FALeN1gpN8y4XgaktZM2MHxQMOM@cp4-web-036.plabs.ch>
 <CA+FuTSdKYVc3w9if5zB6WSWJ3M1XWNmXb-6VGJqKS0WndnPLhw@mail.gmail.com> <OBMm3ctve56m8utHeG4YjTDZzRKXChKzeQaMyS1EQE@cp7-web-043.plabs.ch>
In-Reply-To: <OBMm3ctve56m8utHeG4YjTDZzRKXChKzeQaMyS1EQE@cp7-web-043.plabs.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 2 Nov 2020 10:14:02 -0500
X-Gmail-Original-Message-ID: <CA+FuTSddfgGvHsi1LF=DM519UFdmLaw8besX-OfcgOPVLypnOQ@mail.gmail.com>
Message-ID: <CA+FuTSddfgGvHsi1LF=DM519UFdmLaw8besX-OfcgOPVLypnOQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: avoid unneeded UDP L4 and fraglist GSO resegmentation
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Antoine Tenart <atenart@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 11:56 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Sat, 31 Oct 2020 11:26:24 -0400
>
> >>>> I think it is fine to reenable this again, now that UDP sockets will
> >>>> segment unexpected UDP GSO packets that may have looped. We previously
> >>>> added general software support in commit 83aa025f535f ("udp: add gso
> >>>> support to virtual devices"). Then reduced its scope to egress only in
> >>>> 8eea1ca82be9 ("gso: limit udp gso to egress-only virtual devices") to
> >>>> handle that edge case.
> >>
> >> Regarding bonding and teaming: I think they should also use
> >> NETIF_F_GSO_SOFTWARE mask, not NETIF_F_ALL_TSO, as SCTP also has
> >> a software fallback. This way we could also remove a separate
> >> advertising of NETIF_F_GSO_UDP_L4, as it will be included in the first.
> >>
> >> So, if this one:
> >> 1. Add NETIF_F_GSO_UDP_L4 and NETIF_F_GSO_FRAGLIST to
> >>    NETIF_F_GSO_SOFTWARE;
> >> 2. Change bonding and teaming features mask from NETIF_F_ALL_TSO |
> >>    NETIF_F_GSO_UDP_L4 to NETIF_F_GSO_SOFTWARE;
> >> 3. Check that every virtual netdev has NETIF_F_GSO_SOFTWARE _or_
> >>    NETIF_F_GSO_MASK in its advertising.
> >>
> >> is fine for everyone, I'll publish more appropriate and polished v2 soon.
> >
> > I think we can revert 8eea1ca82be9. Except for the part where it
> > defines the feature in NETIF_F_GSO_ENCAP_ALL instead of
> > NETIF_F_GSO_SOFTWARE. That appears to have been a peculiar choice. I
> > can't recall exactly why I chose that. Most likely because that was
> > (at the time) the only macro that covered all the devices I wanted to
> > capture.
> >
> > As for SCTP: that has the same concern that prompted that commit for
> > UDP: is it safe to forward those packets to the ingress path today?
>
> Oh well. I just looked up into net/sctp/offload.c and see no GRO
> receiving callbacks, only GSO ones. On the other hand,
> NETIF_F_GSO_SOFTWARE includes GSO_SCTP and is used in almost every
> virtual netdev driver, including macvlan and veth mentioned earlier,
> so that seems to be fine.

To follow up: SCTP sockets can handle such packets. So both local
reception and forwarding are fine. This was expressly added to the
second revision of the SCTP GSO commit.
