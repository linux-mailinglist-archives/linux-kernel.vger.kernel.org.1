Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F702CC625
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgLBTFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731056AbgLBTFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606935849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZgI58oXHnLe7xcVyIIW1J7sjpmZ6zrQ31yH/5NDy4s=;
        b=V9QE3qJ5gKyDc0Hvk1CbA7pJJV258rqXlf/9COUu2258gxUalSAqMZorypJLAjm5Vptbmz
        kmRlKXUF+Tr7nt13cTCnN3AzZAHty5EXmFQVPJ9QpJ30Hhh3eN/ozRB6O8xygMDFvXkKcD
        woWOlzzi8iqetEiIvpNeOdW5Eu2ozlw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-VFkwusEqOMm0bv4DWisLqg-1; Wed, 02 Dec 2020 14:04:05 -0500
X-MC-Unique: VFkwusEqOMm0bv4DWisLqg-1
Received: by mail-ot1-f71.google.com with SMTP id w1so1404599otp.21
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZgI58oXHnLe7xcVyIIW1J7sjpmZ6zrQ31yH/5NDy4s=;
        b=HfnAmq7+6gKHLQulSbndN1np4pKQJChyLgv6tHZB6gHQEoJYD2dwZ3gxIoHvDKFy35
         LviEIa5rlQ9tCMCnbbCbnabTdBngEC9fcGL8ICZfVT+ORTDnKUOASMJ0KZyMuTHEhhTb
         rUzPnbGucEyLvlTfv/qGdoVajGiMz6IguKZzIuL7m9l/9uL5XxCmE6/1SL7jTZRrOmwK
         Od8FhoEz91NAy4618UE2aq/Dc6/nrwrFdxhjHivf2wS04H/GILdtdXCCgzIeRpwk34UW
         MBII3vnf2auvjBqLbl6U7qo3zQE+Qz/jL0v1bQ6WEqfRShWQkyYoc9EFMLNPQ5P3KgeZ
         kKVw==
X-Gm-Message-State: AOAM533bMNq0RUAgnFTDxNDdUqw0+Vnv4KLEdBG6MDiuxPkgx6BJlprP
        5da3Xcsr3pbv8PFu8Ml/VpnrDsXRVKUdDwG6VZK8w7GDauoVDrBQymw9rTwfoMO3uTCxxCVNta0
        OE6R374z9pqdOOBd9CLrbLceiiR/CkrUppFjpeTP7
X-Received: by 2002:a05:6830:1348:: with SMTP id r8mr3038191otq.277.1606935844833;
        Wed, 02 Dec 2020 11:04:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUH+ZXAQb+AdM8CiBQehYvNzfMgjhkJV49Ixz42Onq7ltupuKx5k2d8ROb0C8KzlRxRwOoBUc8VMgMH+BcTuM=
X-Received: by 2002:a05:6830:1348:: with SMTP id r8mr3038119otq.277.1606935843969;
 Wed, 02 Dec 2020 11:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20201123031716.6179-1-jarod@redhat.com> <20201202173053.13800-1-jarod@redhat.com>
 <20201202095320.7768b5b3@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201202095320.7768b5b3@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 2 Dec 2020 14:03:53 -0500
Message-ID: <CAKfmpSeGEpjVxw5J=tNBYc2bZEY-z7DbQeb2TcekbqkiBe7O6g@mail.gmail.com>
Subject: Re: [PATCH net v2] bonding: fix feature flag setting at init time
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

On Wed, Dec 2, 2020 at 12:53 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  2 Dec 2020 12:30:53 -0500 Jarod Wilson wrote:
> > +     if (bond->dev->reg_state != NETREG_REGISTERED)
> > +             goto noreg;
> > +
> >       if (newval->value == BOND_MODE_ACTIVEBACKUP)
> >               bond->dev->wanted_features |= BOND_XFRM_FEATURES;
> >       else
> >               bond->dev->wanted_features &= ~BOND_XFRM_FEATURES;
> > -     netdev_change_features(bond->dev);
> > +     netdev_update_features(bond->dev);
> > +noreg:
>
> Why the goto?

Seemed cleaner to prevent an extra level of indentation of the code
following the goto and before the label, but I'm not that attached to
it if it's not wanted for coding style reasons.

-- 
Jarod Wilson
jarod@redhat.com

