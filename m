Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D722C6970
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgK0QcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730786AbgK0QcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:32:14 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90990C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:32:14 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id l206so6401092oif.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoNHFIpJxAfCNwHv1SmanaFdgxZUkmi7Q2RLHPIcLMM=;
        b=mQgAv8AQ6moiNBtlZmoV2B11KQwi49AaRZV/zUBwOG8ga92FBlmA0mPje0jzCM6uNj
         6TU6HAsXDurpuQg/8Yt1iGFxgZvfDHIz/FWkrCZrhMoc7RSYoPTC29rvYZaeLRWvUrgQ
         pBOBISmGXP0CRZykE7o1TU4EHCRMC1cDh4NUTDcTLX3VOfK1WBnv9bczc3Z263QO3/6e
         LHXKzcWuRUkmKjeu5FWXdDmi1JcUOlO/4bH3ZYMG1rgVHDhF3yKvj5uWGUbuU+RZ9pUk
         1UQN+zKyCY0dVjSWfOWrkL1Vxtkh/tFA5k3KnNkdHQnQ+zVMWsxpAQtjgQVAuu92m8k8
         f4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoNHFIpJxAfCNwHv1SmanaFdgxZUkmi7Q2RLHPIcLMM=;
        b=M62srf1KnikQ/mcUVRQ/mZzFA/wABEQlqoaTvuXjUvWUuOwg0lUQNn+ULm38kF1ZYa
         ilDAM9UaXdis/Ur0MfLBIQ6dg2kjYp5A/YJ9yUQmsqybZntVMNm6bERJpzwfLcXvlfQR
         41BhUQqsm4nO2Hk6H3SmUdp0GSuIouIjvE4UBj8YqDG8E4ahZ435e6JTvv9yFIopkq+2
         xT0DTJ/xxZmPGTxKPPV6nEnP6ljYoCJBkvgUOIeFAZxy1qCG4545FOkvnXLyZRvZN/U7
         ENdXXcQZEdM0VT0AKOCR2M6WnDHb1zHHeXRo/ze1Im7MSLKNEYqwZGip1l+i0hfwJbW2
         bZCQ==
X-Gm-Message-State: AOAM533J+ovNtCfdkKXiXE8jrGcaUa/ZPvVPwvC2DBY4/jihhl5I+FUO
        bsPh3TQbMVLOszg+Os6u/tAmEkToFJKoj/2J4D8=
X-Google-Smtp-Source: ABdhPJw+YDZAAdv/S+pZxHAJMSGhPXsOjhnu/Ldl7txaFIOBqFsvCVsUmwYLyzg8j/Oi3vnwzq3NgSe7Bwkt2tKwViI=
X-Received: by 2002:a05:6808:d:: with SMTP id u13mr6115814oic.49.1606494733974;
 Fri, 27 Nov 2020 08:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20200429165347.48909-1-rminnich@google.com> <7171837.EvYhyI6sBW@sven-edge>
In-Reply-To: <7171837.EvYhyI6sBW@sven-edge>
From:   ron minnich <rminnich@gmail.com>
Date:   Fri, 27 Nov 2020 08:32:02 -0800
Message-ID: <CAP6exYKEN-sQXGxTC1CSzfyuYmbbMPHKEosCP7DciFTLOhAFCQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or
 more colons
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-mtd@lists.infradead.org, John Audia <graysky@archlinux.us>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        jstefek@datto.com,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a bit worried about how tricky this starts to get. I'm inclined to
go back to an earlier implementation which used a character that had
not yet been used (iirc I used [] around the PCI ID in a very early
version). What if we used, e.g, a single ! and searched for that? It
need not be !; pick a character. Just something not already in use, as
the ambiguity around which ':' delimits the device has become an
issue, as you show.

Almost nothing in the original patch would change, save the character
being searched for. By using a character we'd never used, we'd avoid
breaking existing usage.

Comments?

On Sat, Nov 21, 2020 at 4:14 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Wednesday, 29 April 2020 18:53:47 CET Ronald G. Minnich wrote:
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > Looks like some drivers define MTD names with a colon in it, thus
> > making mtdpart= parsing impossible. Let's fix the parser to gracefully
> > handle that case: the last ':' in a partition definition sequence is
> > considered instead of the first one.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Ron Minnich <rminnich@google.com>
> > Tested-by: Ron Minnich <rminnich@google.com>
> > ---
> >  drivers/mtd/parsers/cmdlinepart.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
>
> This change broke OpenWrt booting on some IPQ40xx devices. Here for example
> the parts of the cmdline which the u-boot on an OpenMesh A62 sets
> automatically:
>
>     root=31:11 mtdparts=spi0.0:256k(0:SBL1),128k(0:MIBIB),384k(0:QSEE),64k(0:CDT),64k(0:DDRPARAMS),64k(0:APPSBLENV),512k(0:APPSBL),64k(0:ART),64k(custom),64k(0:KEYS),0x002b0000(kernel),0x00c80000(rootfs),15552k(inactive) rootfsname=rootfs rootwait
>
> This is then parsed by newpart as: KEYS),0x002b0000(kernel),0x00c80000(rootfs),15552k(inactive)
>
> And of course, this results in:
>
>     mtd: partition has size 0
>     [...]
>     /dev/root: Can't open blockdev
>     VFS: Cannot open root device "31:11" or unknown-block(31,11): error -6
>     Please append a correct "root=" boot option; here are the available partitions:
>     1f00           32768 mtdblock0
>     (driver?)
>     Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(31,11)
>     CPU1: stopping
>     CPU: 1 PID: 0 Comm:
>
> This affects OpenWrt since the commit d6a9a92e3217 ("kernel: bump 5.4 to
> 5.4.69") because this change was backported to Linux v5.4.69. Reverting
> this change fixes the problem for me.
>
> And if I see it correctly, this is also affecting the kernel (4.14) for
> the OpenWrt 18.06.x + 19.07.x branch because it can also be found in
> there as part of the v4.14.200 release.
>
> Another workaround is to replace the first "(" with a NULL too. See the
> attached patch for the one which I used to fix the OpenWrt bootup.
>
> Kind regards,
>         Sven
