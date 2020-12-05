Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C605A2CFDE4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgLESpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:45:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbgLEQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607186761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YrtBHn1LjYKXSExOc2Ie11/hAw2WMlJB5mkp17GAe1M=;
        b=fjlMEOxPJKtcAwhIcz/MYmpdqRK6AhjCP9Sm1KB3mIZy9Zi0a4IgQBxsmXnpzoTXqfT39f
        5+3g+jqnGTqFhyd7e06WHIHhUhT6aGMLSaQddkqgMT16N11XHr3gg8Q570gyztC7v67H6P
        SyfaLWJSM8qHUknJoG6lB3TUFIVgb/w=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-fGG7ktpnNVGORd_fpceiMg-1; Sat, 05 Dec 2020 11:13:55 -0500
X-MC-Unique: fGG7ktpnNVGORd_fpceiMg-1
Received: by mail-oi1-f197.google.com with SMTP id x4so2368888oia.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 08:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrtBHn1LjYKXSExOc2Ie11/hAw2WMlJB5mkp17GAe1M=;
        b=RX/KHCa/1u2J+Ua43jNuV0G3PhFSZg1s2DetT5ZayDpLH7kI3FiyhC+sgUVByQfAfw
         mqvYBmnqs+nB8ybNqO8RBM5IVYSM+hy9Lw1xhFDi+PR+DeabsrDZmUUWgPTc9+Ugwo8v
         4XsFit8zqNdnoaFWmbzF7jO0r4EelBTp15dLysw3EkoIqDUCyRvtYuBk/+KN3ptkCKdY
         e8PM8lgybA2x0GdZiR6wY/NXc0tYom5Ub0C2Hx9frs7/ylOKdlyE9Uq7RBSG53NPURPN
         wgzpM3DiakXyyT02RTwNpsw8/XyAVdiRK4nt8EZuuIYguD69Pk5Dm90F9uKoqtumS9Yf
         XpAA==
X-Gm-Message-State: AOAM532bPQYCBszh8uM8LUuJuqoEfsllLWIeqBijTI/VYgFAAm3antUB
        1hMyaKx0lSWZMaqCk1foWFLWbvKZCjFSQmljqIG4KRp8B6jHLQ7Q0QUCV3DPlC1cuneJYnP8pNI
        BtVmYud3nAmO/aalbmjhXGv+BqQPnKqDVgkQQUAB0
X-Received: by 2002:a9d:4788:: with SMTP id b8mr7438690otf.172.1607184834912;
        Sat, 05 Dec 2020 08:13:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzc8cYc7H87HUf+4XQz9+YFAods9n+maBIW2DnAtya/G39bBE8eQkAoHwnqQfNfSdqtbf9UHRFH4GtdVCGc26U=
X-Received: by 2002:a9d:4788:: with SMTP id b8mr7438669otf.172.1607184834697;
 Sat, 05 Dec 2020 08:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20201202173053.13800-1-jarod@redhat.com> <20201203004357.3125-1-jarod@redhat.com>
 <20201203084525.7f1a8e93@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201203084525.7f1a8e93@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Sat, 5 Dec 2020 11:13:45 -0500
Message-ID: <CAKfmpSdrG9x24TZQ2M2xV_e7CFedE9WWUmtD2Vz8c2H5roneOA@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 11:45 AM Jakub Kicinski <kuba@kernel.org> wrote:
...
> nit: let's narrow down the ifdef-enery
>
> no need for the ifdef here, if the helper looks like this:
>
> +static void bond_set_xfrm_features(struct net_device *bond_dev, u64 mode)
> +{
> +#ifdef CONFIG_XFRM_OFFLOAD
> +       if (mode == BOND_MODE_ACTIVEBACKUP)
> +               bond_dev->wanted_features |= BOND_XFRM_FEATURES;
> +       else
> +               bond_dev->wanted_features &= ~BOND_XFRM_FEATURES;
> +
> +       netdev_update_features(bond_dev);
> +#endif /* CONFIG_XFRM_OFFLOAD */
> +}
>
> Even better:
>
> +static void bond_set_xfrm_features(struct net_device *bond_dev, u64 mode)
> +{
> +       if (!IS_ENABLED(CONFIG_XFRM_OFFLOAD))
> +               return;
> +
> +       if (mode == BOND_MODE_ACTIVEBACKUP)
> +               bond_dev->wanted_features |= BOND_XFRM_FEATURES;
> +       else
> +               bond_dev->wanted_features &= ~BOND_XFRM_FEATURES;
> +
> +       netdev_update_features(bond_dev);
> +}
>
> (Assuming BOND_XFRM_FEATURES doesn't itself hide under an ifdef.)

It is, but doesn't need to be. I can mix these changes in as well.

-- 
Jarod Wilson
jarod@redhat.com

