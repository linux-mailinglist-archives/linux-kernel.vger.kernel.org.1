Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EA92CE64F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgLDDPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbgLDDPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607051665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ZZBwHUlkAo2mQlf/omWRQ3U/VftHPedEX4GpVFBakM=;
        b=Adl2DmBruljD8/IcVOV0N46HT/F9H/U3qSGSpzhy2Cf/Py19dSYggw12MV6wVlw/a/o0+m
        dmdOv3hwLZbKiNHe3C4bYugYdNC/dazGkSgEa9h2L4ns7mQecmiWClsh4hX6veTLLNZS5/
        r+r+Ct7T0b+lApUZQ0D1Bw6Gi5dNXdA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-e-A_F7tzMVCGzm_jojPYxw-1; Thu, 03 Dec 2020 22:14:23 -0500
X-MC-Unique: e-A_F7tzMVCGzm_jojPYxw-1
Received: by mail-oo1-f69.google.com with SMTP id y4so2004224oou.15
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 19:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZZBwHUlkAo2mQlf/omWRQ3U/VftHPedEX4GpVFBakM=;
        b=ezMkAEUrjsxuMcDq0oecL6paXy3vXPKyhEb/cHO6AWXVfa18TIa8Ay65gnNfPdVZTj
         PhczDRovDN4CijwB5puU3oiAK16ija9ZXrW4dI0ee7HFYdYIummGIWBv2m/bz0oTNCWr
         ZC/tZPXd0a3wsggcDHNxa9kexOv7tpZh98nXV5CXQa/F0kSc756BaPyIsz+dH3hlZwtp
         scidt6X1CgwEHp8nLexOG/4dckpUluWE932qnWOb2MOffLXxkS3vemKgPR4WCeWCsdDt
         9NPmo8tiDeROJvi5pDbMXnpQld7nrRiLTgDwQN+/+JYLJLnopAid1CIWxLcii7cTkjkU
         C4qA==
X-Gm-Message-State: AOAM532lpuKFu+eoY4TEufLS43fsjWdxreTm3UrE7VxQBMeWkMZH9m1r
        i90fTZcaPXoy+Yklp9gcQqQLobly3OGA9g0Pn3VurUGB0zxKLaN1XIQM3SZmllmuT/HAgneZHtH
        Mx7EGgUYb/jkPiD49PHvCFr/o9FkU0NPoSoj5gHAx
X-Received: by 2002:aca:6255:: with SMTP id w82mr1659239oib.5.1607051663226;
        Thu, 03 Dec 2020 19:14:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzN78hUw/JrQhIanA7/trcLFQiN483Vjgq0gjfKP4OUu5Z+B+wiDa39AEa3lTF8AmmP9mJgTqDbGW6a6i4SCMM=
X-Received: by 2002:aca:6255:: with SMTP id w82mr1659227oib.5.1607051663014;
 Thu, 03 Dec 2020 19:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20201202173053.13800-1-jarod@redhat.com> <20201203004357.3125-1-jarod@redhat.com>
 <20201203085001.4901c97f@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201203085001.4901c97f@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Thu, 3 Dec 2020 22:14:12 -0500
Message-ID: <CAKfmpSd7JH4Y--z=8iPxekzSeAr0AVmQFPHaOYX71dcRoJouXQ@mail.gmail.com>
Subject: Re: [PATCH net v3] bonding: fix feature flag setting at init time
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ivan Vecera <ivecera@redhat.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 11:50 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  2 Dec 2020 19:43:57 -0500 Jarod Wilson wrote:
> >       bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
> > -#ifdef CONFIG_XFRM_OFFLOAD
> > -     bond_dev->hw_features |= BOND_XFRM_FEATURES;
> > -#endif /* CONFIG_XFRM_OFFLOAD */
> >       bond_dev->features |= bond_dev->hw_features;
> >       bond_dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
> >  #ifdef CONFIG_XFRM_OFFLOAD
> > -     /* Disable XFRM features if this isn't an active-backup config */
> > -     if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
> > -             bond_dev->features &= ~BOND_XFRM_FEATURES;
> > +     bond_dev->hw_features |= BOND_XFRM_FEATURES;
> > +     /* Only enable XFRM features if this is an active-backup config */
> > +     if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP)
> > +             bond_dev->features |= BOND_XFRM_FEATURES;
> >  #endif /* CONFIG_XFRM_OFFLOAD */
>
> This makes no functional change, or am I reading it wrong?

You are correct, there's ultimately no functional change there, it
primarily just condenses the code down to a single #ifdef block, and
doesn't add and then remove BOND_XFRM_FEATURES from
bond_dev->features, instead omitting it initially and only adding it
when in AB mode. I'd poked at the code in that area while trying to
get to the bottom of this, thought it made it more understandable, so
I left it in, but ultimately, it's not necessary to fix the problem
here.

-- 
Jarod Wilson
jarod@redhat.com

