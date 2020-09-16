Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96D926CE77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 00:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIPWPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 18:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgIPWPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 18:15:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3EFC061221
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 15:15:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m6so8488196wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IlLynDXWA6Vc4pTOIis0zeNUkdqOrDALjwAKQG96ef8=;
        b=fjNCRpgiw1wF0DlArdhGUWN0Gqp+4eDdasszz1aF/djnRfDMSTGkiNehtea3PWQtNW
         FTAAyaHj/BJy54q54TzKHBYX0EOs+LQrQ40j4pZzmMRkWR7oDRyYSZdGmKJyu1zMW9pf
         bgpW67hhcILamTuCvbbtpVZsb5bTbaX62q5WwzgE1NTAT6bwk2EutAjW9CHPrxhmn3ep
         qy0GuOcY/wcFm9aw2LIaDNuMZrvH/I0gXvk0a4N90kFdSBuKyATGniIVqCcdgJB2pV0B
         GhMBDDDgtAKxLhyu67kLkx+gyLIvoUMLEDrvrXkZwZZd59fYQLAOL9y2R9KIEvBl4SC9
         7nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IlLynDXWA6Vc4pTOIis0zeNUkdqOrDALjwAKQG96ef8=;
        b=hwsEgKvb+AhVQIi52BPmBJTZp21BrQhjoweZX7uD4sYoWeV/w5mGGjR5gm6nL33O16
         apAWF0/O1zvlJAd8lDoPuNmLNhjDLIV/JWsGSQO4/iPKObRoHtAY5dHE6IFz2OXuKXuZ
         9xAaGsAMSMOA+vh55Bv8Rq/4C4ljyGoTAfMcYi9xk3g2sQuUcwNnsnVyyP9jRp6PrgPm
         axAK1Bxj6ZyL1ZYUtWsBPI/erGIMilUhF5QQHg5EHXM/4cTEXIpZhwaJb62epLyR/WX8
         NIHbwssMUwgURy9AZZ8BJx7tk7li0EBNkuurxTosV85X7m8XNCVrzPGihPSzhnVqXK99
         ifuw==
X-Gm-Message-State: AOAM532S92ayMlbvh8a/KxRg8agSxZi1AMNaEdde8A1+MFcQ+ZWDg+pw
        1BDzovIdKr74RjR9pucq2xvoTRjhrIU/5uZC8GwCDX/J
X-Google-Smtp-Source: ABdhPJxqDyjKYgfkcdQI0ldqigFZMkhmwzjMkAJCz+IuLc9Rc/7DzvhzDdfCDjlE6Zj5pF0pXWy3mqLaQFOjFpPZ8Zo=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr30599444wrl.419.1600294532001;
 Wed, 16 Sep 2020 15:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
 <20200109141436.GA22111@lst.de> <9ad75215-3ff1-ee76-9985-12fd78d6aa5f@amd.com>
 <801e4196-5e22-e805-4d45-0245efdaa508@mageia.org>
In-Reply-To: <801e4196-5e22-e805-4d45-0245efdaa508@mageia.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 16 Sep 2020 18:15:21 -0400
Message-ID: <CADnq5_PgQq4U86sSvpXSP6d9LUQHhohi4u2d6TjAPRA--1vM5A@mail.gmail.com>
Subject: Re: Regression in 5.4 kernel on 32-bit Radeon IBM T40
To:     Thomas Backlund <tmb@mageia.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Woody Suwalski <terraluna977@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 4:20 AM Thomas Backlund <tmb@mageia.org> wrote:
>
> Den 09-01-2020 kl. 17:12, skrev Christian K=C3=B6nig:
> > Hi Christoph,
> >
> > Am 09.01.20 um 15:14 schrieb Christoph Hellwig:
> >> Hi Woody,
> >>
> >> sorry for the late reply, I've been off to a vacation over the holiday=
s.
> >>
> >> On Sat, Dec 14, 2019 at 10:17:15PM -0500, Woody Suwalski wrote:
> >>> Regression in 5.4 kernel on 32-bit Radeon IBM T40
> >>> triggered by
> >>> commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713
> >>> Author: Christoph Hellwig <hch@lst.de>
> >>> Date:   Thu Aug 15 09:27:00 2019 +0200
> >>>
> >>> Howdy,
> >>> The above patch has triggered a display problem on IBM Thinkpad T40,
> >>> where
> >>> the screen is covered with a lots of random short black horizontal
> >>> lines,
> >>> or distorted letters in X terms.
> >>>
> >>> The culprit seems to be that the dma_get_required_mask() is returning=
 a
> >>> value 0x3fffffff
> >>> which is smaller than dma_get_mask()0xffffffff.That results in
> >>> dma_addressing_limited()=3D=3D0 in ttm_bo_device(), and using 40-bits=
 dma
> >>> instead of 32-bits.
> >> Which is the intended behavior assuming your system has 1GB of memory.
> >> Does it?
> >
> > Assuming the system doesn't have the 1GB split up somehow crazy over th=
e
> > address space that should indeed work as intended.
> >
> >>
> >>> If I hardcode "1" as the last parameter to ttm_bo_device_init() in
> >>> place of
> >>> a call to dma_addressing_limited(),the problem goes away.
> >> I'll need some help from the drm / radeon / TTM maintainers if there a=
re
> >> any other side effects from not passing the need_dma32 paramters.
> >> Obviously if the device doesn't have more than 32-bits worth of dram a=
nd
> >> no DMA offset we can't feed unaddressable memory to the device.
> >> Unfortunately I have a very hard time following the implementation of
> >> the TTM pool if it does anything else in this case.
> >
> > The only other thing which comes to mind is using huge pages. Can you
> > try a kernel with CONFIG_TRANSPARENT_HUGEPAGE disabled?
> >
>
>
> Any progress on this ?
>
> We have a bugreport in Mageia with the hw:
> Dell Inspiron 5100, 32-bit P4 processor, 2GB of RAM, Radeon Mobility
> 7500 (RV200) graphics
>
> that gets display issues too and reverting the offending commit restores
> normal behaviour.
>
> and the same issue is still there with 5.5 series kernels.

Does disabling HIMEM or setting radeon.agpmode=3D-1 on the kernel
command line in grub fix the issue?

Alex
