Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AD72E34A0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 08:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgL1HBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 02:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgL1HBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 02:01:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75015221F0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 07:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609138835;
        bh=bSXg7RHm7u3Znyw1k3FKLph//gAChgLwpvW706SNkQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mujrZ4E8fsQE7rQf+NJWYMBhB0JrZAJpcvJT7XkSALJgnPfO3y/oytFww0Qq4hCIE
         uVfCMSldF1iknEWogQBOkEKrVjY4N3jTZBzHrR9odao6cKN0uSwtkgGuQYJXtZHtA3
         HBwHXcdz8yj2Cw16INwnpR97Lbgbzbg+YTswTFN8P2Bdas/iv4hJKZCsULOVnt0QXQ
         g31sYBiO8FZtGBymVLpgAvn7OgC1qW7T5gOECo33gHEaS/nH0QtnPZPXrw1nDxTtn7
         BhP5pebWpa9J+EoZKF6b5foeKwi+dZhrgLgLJGDq4lqJGTJlZ9qyBbNemGXa5e5Hbc
         /D4A+umCU+uaw==
Received: by mail-oi1-f174.google.com with SMTP id 9so10691250oiq.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 23:00:35 -0800 (PST)
X-Gm-Message-State: AOAM531lycO+H9G74gNL8bqMoa6a03OzONvS5aEEJ8vtljmAR0Nfv+NT
        rfrkuBCM6Y0DbkgGfHHYYc9C8325np09Ou6a+Xo=
X-Google-Smtp-Source: ABdhPJy19H8ee/BWya0jA1dYcrbEw7gnzfamcai0Ywm13COPmfE6738raifgksUZ1VzDbgv2pXel29FZjTMQsyz/Fyw=
X-Received: by 2002:aca:e103:: with SMTP id y3mr10679587oig.11.1609138834791;
 Sun, 27 Dec 2020 23:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20201225114458.1334-1-thunder.leizhen@huawei.com>
In-Reply-To: <20201225114458.1334-1-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 28 Dec 2020 08:00:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1-zTyd9WoWxaqZ3s1ye44t1CUuZaU0a5w9bE+krk2cBA@mail.gmail.com>
Message-ID: <CAK8P3a1-zTyd9WoWxaqZ3s1ye44t1CUuZaU0a5w9bE+krk2cBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: LPAE: use phys_addr_t instead of unsigned long
 in outercache hooks
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 12:48 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> The outercache of some Hisilicon SOCs support physical addresses wider
> than 32-bits. The unsigned long datatype is not sufficient for mapping
> physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
> use phys_addr_t instead of unsigned long in outercache functions") has
> already modified the outercache functions. But the parameters of the
> outercache hooks are not changed. This patch use phys_addr_t instead of
> unsigned long in outercache hooks: inv_range, clean_range, flush_range.
>
> To ensure the outercache that does not support LPAE works properly, do
> cast phys_addr_t to unsigned long by adding a middle-tier function.
> For example:
> -static void l2c220_inv_range(unsigned long start, unsigned long end)
> +static void __l2c220_inv_range(unsigned long start, unsigned long end)
>  {
>         ...
>  }
> +static void l2c220_inv_range(phys_addr_t start, phys_addr_t end)
> +{
> +  __l2c220_inv_range(start, end);
> +}
>
> Note that the outercache functions have been doing this cast before this
> patch. So now, the cast is just moved to the middle-tier function.
>
> No functional change.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

This looks reasonable in principle, but it would be helpful to
understand better which SoCs are affected. In which way is
this specific to Hisilicon implementations, and why would others
not need this?

Wouldn't this also be needed by an Armada XP that supports
more than 4GB of RAM but has an outer cache?

I suppose those SoCs using off-the-shelf Arm cores are either
pre-LPAE and cannot address memory above 4GB, or they do
not need the outer_cache interfaces.

> diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
> index 5c1b7a7b9af6300..ab1d8051bf832c9 100644
> --- a/arch/arm/mm/cache-feroceon-l2.c
> +++ b/arch/arm/mm/cache-feroceon-l2.c
> @@ -168,7 +168,7 @@ static unsigned long calc_range_end(unsigned long start, unsigned long end)
>         return range_end;
>  }
>
> -static void feroceon_l2_inv_range(unsigned long start, unsigned long end)
> +static void __feroceon_l2_inv_range(unsigned long start, unsigned long end)
>  {
>         /*
>          * Clean and invalidate partial first cache line.
> @@ -198,7 +198,12 @@ static void feroceon_l2_inv_range(unsigned long start, unsigned long end)
>         dsb();
>  }
>
> -static void feroceon_l2_clean_range(unsigned long start, unsigned long end)
> +static void feroceon_l2_inv_range(phys_addr_t start, phys_addr_t end)
> +{
> +       __feroceon_l2_inv_range(start, end);
> +}
> +

What is this indirection for? It looks like you do this for all implementations,
so the actual address gets truncated here.

       Arnd
