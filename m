Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80B2A2FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgKBQbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKBQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:31:02 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7499CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:31:02 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id r14so2838825vsa.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pu8FIeJV4rlrNV+22AWAXIDB3DCIgFbox4KaoLIuU8Y=;
        b=nlTs+LdLOAmEFe1W02NG68TMBDrrqudsAe5zbVfNsOlKWhFCIBcc2uYXudsFeFXzCC
         bOwrGROpugmVtqwat4VqhbNoliPEHLEntl07e6dHagR++JLzQos3YM8HmaVq6kdFPC9+
         4nkMOR82wrQEgiPnNZsPgeiZSWIqTi6o+tzYTynzPqfCwgDifs12VpYBqa3b7L+bD3KJ
         vH9J96nq/+eeGVGdeEiEOpxxrVayXKFsXLnwwxlsvHVwr3TwWYpzn/POGMusQrX2+6Ov
         qnF+jF795k4qOQQZmuzsq2DofB80dK+WxVounFktuglsUb2hPpBoAm/V84gy4WQRzYCR
         ox1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pu8FIeJV4rlrNV+22AWAXIDB3DCIgFbox4KaoLIuU8Y=;
        b=ub6OicemFzHddQibaADN2l1pfDxw3d+e3EzoaHIpHofOx6JgL4vJg65nuiOznb54zd
         NwLG7+R7hWn9mLgFI5Pxw9dWj9ek2iZR2uRUlvoKnxjVBScE4EZHHhYWHRLMpmSs1GF4
         rGASWBXR26tGHZr7RB9oQ/6qP9N7J5mscLWuKDckVAMakCfKVlyeu31JsPQ47XdHr1Ds
         H7S5QweExHXD7jaSPjZq6eyoKaPE9gYfmQaY0UriYLneLSrF0kwOvzkTvMEbmDmHSlUl
         cTj2VK2Pledmu2LAVdEl/TboDeHrhcxc3l8+9yrWlEyQ+EDvnkZTfW155KaJtAA8MMd/
         EuxA==
X-Gm-Message-State: AOAM532NqqZCcZCp8hmWAxxiCyayH6Fo4AQLzwTgTL4HcgIsZfyleSmL
        8Txxp6noSV/LCplEWohos+LlilUtg8k=
X-Google-Smtp-Source: ABdhPJxZivx4zCbTNmdIxK86N+3667djEomv1z35aDOTIzF1Kgifij8FjfrRH0WOchUZixSqk0Kp/Q==
X-Received: by 2002:a67:5e42:: with SMTP id s63mr10610767vsb.31.1604334659828;
        Mon, 02 Nov 2020 08:30:59 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id h12sm2215771vsg.23.2020.11.02.08.30.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:30:55 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id b3so7782805vsc.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:30:54 -0800 (PST)
X-Received: by 2002:a67:db8b:: with SMTP id f11mr3364274vsk.28.1604334654157;
 Mon, 02 Nov 2020 08:30:54 -0800 (PST)
MIME-Version: 1.0
References: <GtgHtyGO5jHKHT6zGMAzg3TDejXZT0HMQVoqNERZRdM@cp3-web-024.plabs.ch>
In-Reply-To: <GtgHtyGO5jHKHT6zGMAzg3TDejXZT0HMQVoqNERZRdM@cp3-web-024.plabs.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 2 Nov 2020 11:30:17 -0500
X-Gmail-Original-Message-ID: <CA+FuTSd1H6+NjSDcin6KQo9y1KEsDACeAvyr0p5JuDWc-aEh+A@mail.gmail.com>
Message-ID: <CA+FuTSd1H6+NjSDcin6KQo9y1KEsDACeAvyr0p5JuDWc-aEh+A@mail.gmail.com>
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

On Sun, Nov 1, 2020 at 8:17 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> Virtual netdevs should use NETIF_F_GSO_SOFTWARE to forward GSO skbs
> as-is and let the final drivers deal with them when supported.
> Also remove NETIF_F_GSO_UDP_L4 from bonding and team drivers as it's
> now included in the "software" list.

The rationale is that it is okay to advertise these features with
software fallback as bonding/teaming "hardware" features, because
there will always be a downstream device for which they will be
implemented, possibly in the software fallback, correct?

That does not apply to dummy or IFB. I guess dummy is fine, because
xmit is a black hole, and IFB because ingress can safely handle these
packets? How did you arrive at the choice of changing these two, of
all virtual devices?

>
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  drivers/net/bonding/bond_main.c | 11 +++++------
>  drivers/net/dummy.c             |  2 +-
>  drivers/net/ifb.c               |  3 +--
>  drivers/net/team/team.c         |  9 ++++-----
>  4 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 84ecbc6fa0ff..71c9677d135f 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1228,14 +1228,14 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
>  }
>
>  #define BOND_VLAN_FEATURES     (NETIF_F_HW_CSUM | NETIF_F_SG | \
> -                                NETIF_F_FRAGLIST | NETIF_F_ALL_TSO | \
> +                                NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
>                                  NETIF_F_HIGHDMA | NETIF_F_LRO)
>
>  #define BOND_ENC_FEATURES      (NETIF_F_HW_CSUM | NETIF_F_SG | \
> -                                NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
> +                                NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
>
>  #define BOND_MPLS_FEATURES     (NETIF_F_HW_CSUM | NETIF_F_SG | \
> -                                NETIF_F_ALL_TSO)
> +                                NETIF_F_GSO_SOFTWARE)
>
>
>  static void bond_compute_features(struct bonding *bond)
> @@ -1291,8 +1291,7 @@ static void bond_compute_features(struct bonding *bond)
>         bond_dev->vlan_features = vlan_features;
>         bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
>                                     NETIF_F_HW_VLAN_CTAG_TX |
> -                                   NETIF_F_HW_VLAN_STAG_TX |
> -                                   NETIF_F_GSO_UDP_L4;
> +                                   NETIF_F_HW_VLAN_STAG_TX;
>  #ifdef CONFIG_XFRM_OFFLOAD
>         bond_dev->hw_enc_features |= xfrm_features;
>  #endif /* CONFIG_XFRM_OFFLOAD */
> @@ -4721,7 +4720,7 @@ void bond_setup(struct net_device *bond_dev)
>                                 NETIF_F_HW_VLAN_CTAG_RX |
>                                 NETIF_F_HW_VLAN_CTAG_FILTER;
>
> -       bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
> +       bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
>  #ifdef CONFIG_XFRM_OFFLOAD
>         bond_dev->hw_features |= BOND_XFRM_FEATURES;
>  #endif /* CONFIG_XFRM_OFFLOAD */
> diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
> index bab3a9bb5e6f..f82ad7419508 100644
> --- a/drivers/net/dummy.c
> +++ b/drivers/net/dummy.c
> @@ -124,7 +124,7 @@ static void dummy_setup(struct net_device *dev)
>         dev->flags &= ~IFF_MULTICAST;
>         dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
>         dev->features   |= NETIF_F_SG | NETIF_F_FRAGLIST;
> -       dev->features   |= NETIF_F_ALL_TSO;
> +       dev->features   |= NETIF_F_GSO_SOFTWARE;
>         dev->features   |= NETIF_F_HW_CSUM | NETIF_F_HIGHDMA | NETIF_F_LLTX;
>         dev->features   |= NETIF_F_GSO_ENCAP_ALL;
>         dev->hw_features |= dev->features;
> diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
> index 7fe306e76281..fa63d4dee0ba 100644
> --- a/drivers/net/ifb.c
> +++ b/drivers/net/ifb.c
> @@ -187,8 +187,7 @@ static const struct net_device_ops ifb_netdev_ops = {
>  };
>
>  #define IFB_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG  | NETIF_F_FRAGLIST | \
> -                     NETIF_F_TSO_ECN | NETIF_F_TSO | NETIF_F_TSO6      | \
> -                     NETIF_F_GSO_ENCAP_ALL                             | \
> +                     NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL      | \
>                       NETIF_F_HIGHDMA | NETIF_F_HW_VLAN_CTAG_TX         | \
>                       NETIF_F_HW_VLAN_STAG_TX)
>
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index 07f1f3933927..b4092127a92c 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -975,11 +975,11 @@ static void team_port_disable(struct team *team,
>  }
>
>  #define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
> -                           NETIF_F_FRAGLIST | NETIF_F_ALL_TSO | \
> +                           NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
>                             NETIF_F_HIGHDMA | NETIF_F_LRO)
>
>  #define TEAM_ENC_FEATURES      (NETIF_F_HW_CSUM | NETIF_F_SG | \
> -                                NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
> +                                NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
>
>  static void __team_compute_features(struct team *team)
>  {
> @@ -1009,8 +1009,7 @@ static void __team_compute_features(struct team *team)
>         team->dev->vlan_features = vlan_features;
>         team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
>                                      NETIF_F_HW_VLAN_CTAG_TX |
> -                                    NETIF_F_HW_VLAN_STAG_TX |
> -                                    NETIF_F_GSO_UDP_L4;
> +                                    NETIF_F_HW_VLAN_STAG_TX;
>         team->dev->hard_header_len = max_hard_header_len;
>
>         team->dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
> @@ -2175,7 +2174,7 @@ static void team_setup(struct net_device *dev)
>                            NETIF_F_HW_VLAN_CTAG_RX |
>                            NETIF_F_HW_VLAN_CTAG_FILTER;
>
> -       dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
> +       dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
>         dev->features |= dev->hw_features;
>         dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
>  }
> --
> 2.29.2
>
>
