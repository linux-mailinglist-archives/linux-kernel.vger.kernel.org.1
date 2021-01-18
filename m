Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457D02F9C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388724AbhARJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388396AbhARJKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:10:49 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F342C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:10:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id p22so16662028edu.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEgteQ67RbjTMAwvPZis8M4j9IGYHXIhSxdTHCm7e6Y=;
        b=znpM9cqzm5Ln6b3VgkdhlO8qAGfjcdtnRjxmpGW+BYNOlcMy12I2ngj7lV6nYTV+6Y
         KCRFIP6LKRjSuW9sPVUgQQi3d92zUUYVM/UJ08ICNB5RbJdLHWv23IPvfLQqWR8jOImW
         dmBoPBu5StGeMXug6wcaB0p4VO/Fg00zPyBvGFsnf4d0EvRiIdiLfWCCwQOfWeomK+J9
         P38hS14PCPaP7dxrVV6X+wEAX6D2aCka5brGNwx9dYdQq0ofLVVSRj7QjCIVKRkhpu9E
         rPiKYswlTIxCTAh4xqbNR+E6p+A9e0knHLwwHCGsc6oRzojjc9bgcDpRlN+qEo4WDhB7
         B0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEgteQ67RbjTMAwvPZis8M4j9IGYHXIhSxdTHCm7e6Y=;
        b=GvHlp3c+wEYyATV6G7hU408fpS2hvOs9tcaBl6kQ7RIA6dH2bDCwPQ+pd7965eEKFO
         BEZ2IDjy6ttJ/ke8S8M5HZZvHi7er3y42fssg0rk7OJq87cKizesIcwPj3XhUDbn+zIa
         J6n5ZIo12to22Uk3NuAk+Lqlxil45q5mAgYSy1Frb2w0n3KIws+ZFkVQyOF6jRhuWMVA
         p6cc6VPXBqhGV7qDpiPM6ZDlwGvmfTaf7XqMqIc4KdqEwvcJT1L6QBZG0kuTdbvG/2RE
         lDm++txulYEluLWTVnwHoI93dJ6AZbiqk2B9QLeSONOFM8Myxex7TaS3ob+eCWUvU5zP
         CAOQ==
X-Gm-Message-State: AOAM530zlF67weu62ik0lhrwozRngrEmqq5rNQfTYHC3NbCln581f7kf
        PNbe6tRKaTrH3GAJ/Lkm+rfA4tTU+7T+E6hnW/p0kA==
X-Google-Smtp-Source: ABdhPJzIE7pHVXSn1UEAbEfauN/Yrum/Eotado2jWfYFm3YB4uQhlpWBbU7Xbh37KpoPHUvKfqbFqtjsX3BMMMVrcEU=
X-Received: by 2002:aa7:dacf:: with SMTP id x15mr18121907eds.134.1610961007258;
 Mon, 18 Jan 2021 01:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20201130142759.28216-1-brgl@bgdev.pl> <20201130202110.62e7f989@archlinux>
 <BY5PR02MB6916FD4844C5471C635DAD1AA9CA0@BY5PR02MB6916.namprd02.prod.outlook.com>
 <20201213120442.3f98814a@archlinux>
In-Reply-To: <20201213120442.3f98814a@archlinux>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 18 Jan 2021 10:09:56 +0100
Message-ID: <CAMRc=MfJec9cM8Y7MDux-kd1cuFxy_OiZHU7v-FH3A96H0LHGg@mail.gmail.com>
Subject: Re: [PATH v3 0/3] iio: adc: xilinx: use even more devres
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 1:04 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 11 Dec 2020 12:15:15 +0000
> Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:
>
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Monday 30 November 2020 8:21 PM
> > > To: Bartosz Golaszewski <brgl@bgdev.pl>
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> > > <pmeerw@pmeerw.net>; Michal Simek <michals@xilinx.com>; linux-
> > > iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > > kernel@vger.kernel.org; Bartosz Golaszewski
> > > <bgolaszewski@baylibre.com>; Anand Ashok Dumbre
> > > <ANANDASH@xilinx.com>
> > > Subject: Re: [PATH v3 0/3] iio: adc: xilinx: use even more devres
> > >
> > > On Mon, 30 Nov 2020 15:27:56 +0100
> > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > This is a follow-up to commit 750628c79bb1 ("iio: adc: xilinx-xadc:
> > > > use devm_krealloc()"). I noticed we can use even more devres helpers
> > > > and entirely drop the remove() callback.
> > > >
> > > > v1 -> v2:
> > > > - squash three patches adding more devres calls into one for easier
> > > > review
> > > > - don't insist on the 80 characters limit
> > > > - add a new helper: devm_krealloc_array() and use it
> > > >
> > > > v2 -> v3:
> > > > - drop the devm_krealloc_array() helper
> > > >
> > > > Bartosz Golaszewski (3):
> > > >   iio: adc: xilinx: use helper variable for &pdev->dev
> > > >   iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
> > > >   iio: adc: xilinx: use more devres helpers and remove remove()
> > > >
> > > >  drivers/iio/adc/xilinx-xadc-core.c | 157
> > > > ++++++++++++++---------------
> > > >  1 file changed, 74 insertions(+), 83 deletions(-)
> > > >
> > >
> > > Series looks good to me but would like to leave it a little longer to let others
> > > take a look at it. That will probably mean it falls into next cycle now.
> > >
> > > +CC Anand who is looking at another series touching this driver and
> > > +might
> > > give this one a spin as well.
> > >
> > > Thanks,
> > >
> > > Jonathan
> >
> > Hi Jonathan, Bartosz,
> >
> > I have tested and reviewed the patch and everything looks good.
> > I have another patch series on the same files that might cause conflicts.
> >
> > Reviewed-by: Anand Ashok Dumbre <anandash@xilinx.com>
> > Tested-by: Anand Ashok Dumbre <anandash@xilinx.com>
> Thanks,
>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
>
> There was a small amount of fuzz.
>
> Thanks,
>
> Jonathan
>

Hi Jonathan,

I still don't see these patches in next - is any action required of me
to get this in for the next release?

Bartosz
