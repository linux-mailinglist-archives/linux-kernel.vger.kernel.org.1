Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B22EAA89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbhAEMSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAEMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:18:16 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778D1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:17:35 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 22so26173715qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHVyppheAtUsYWey0/FRVVlGWEXQunaZTKwgRTn10C4=;
        b=PjXAeqXP4DYwIsAsQ2O4Wvyds0A/KBI/EsGeMQmaFHnc4wqH02GyXchj4HN8SUEolr
         PHK27WI1BXuqv8NgDGDFiQwm2P9lHa2Kd3MJQxJ9FTGfphPfl+Dwb9fKBbqo7I9+CpWg
         M+gOWEE/mSgmFe7pOxIwoo8FpAnQwxG+sDQXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHVyppheAtUsYWey0/FRVVlGWEXQunaZTKwgRTn10C4=;
        b=U07I4jM0oqM3LqHOaRuxIcZKLHY2hfv7q2WbHl0noFoZxekNs24DFHHG0KCWhlv87T
         Lv62s91/lqiV+jf2sb46TxH81ZNda5waP1yVJGZquJbEMsg7AowZNtYyRRsHdLcmdjlS
         CbRtYf2Ii7IFGktU9YZpo5suudOrBGn8Y/P0mLh0T0+q99myjh6pcA/rY4UFECiFmiFF
         +T+6QYbBJfKPHhXOa+Zu2NmMPSbx5KfMOgTiv6fvMX6sWYo1pcOAguNAf3FRcoP/l9d2
         3Wj3j14CQd/m3/tajVBM1jZDAETW0y3VrjlayaApC8RGn4J+lItyfRke9xrRkVUM74d2
         eclA==
X-Gm-Message-State: AOAM532BQjGufKUBYDD+rx7VQPfHwBS0hCpANkaBWA8gYFxkULsePbqy
        Cd3ocvCsqCCyzdSHNJTJEKi1CHEJBLdbQEh+qD8TNQ==
X-Google-Smtp-Source: ABdhPJy5tjzaibSH7lb3AbHXayPPYaReUKnA+qJZEoC40CBWlYyT/l9r2rHRDXectmH9clM8fVamvSEK+Fs2WH7cnQo=
X-Received: by 2002:a37:2742:: with SMTP id n63mr77678787qkn.390.1609849054700;
 Tue, 05 Jan 2021 04:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20201229055059.2255021-1-daniel@0x0f.com> <20201229055059.2255021-2-daniel@0x0f.com>
 <20210104151746.21cdde24@xps13>
In-Reply-To: <20210104151746.21cdde24@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 5 Jan 2021 21:18:21 +0900
Message-ID: <CAFr9PXmPEQ2poQUTtaBH4CZ-S+sJjoUjJ5D_qA5aHZj7AASg7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mtd: spinand: add support for Foresee FS35ND01G
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        richard@nod.at, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Mon, 4 Jan 2021 at 23:17, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Perhaps giving the link of the datasheet here makes sense.

Noted. I'll put that into v2.

> > +#define SPINAND_MFR_LONGSYS          0xcd
>
> Nitpick: I personally prefer uppercase hex numbers.
>

Noted.

> > +                  NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> > +                  NAND_ECCREQ(4, 512),
> > +                  SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > +                                           &write_cache_variants,
> > +                                           &update_cache_variants),
>
> This device probably supports more variants (especially dual/quad
> ones) but I guess it's not a problem to not have them here right now.

Right now I can't really test dual or quad because my SPI driver
doesn't know to do dual or quad io.
I plan to add those in once I can validate they work.

> > +                  SPINAND_HAS_QE_BIT,
> > +                  SPINAND_ECCINFO(NULL,
> > +                                  NULL)),
>
> You should define the ->ecc and ->free hooks of the
> mtd_ooblayout_ops structure and point to it here. It defines the free
> OOB bytes and bytes used by the on-die ECC engine. You should find this
> in the datasheet. You may look at other manufacturer drivers for
> examples of how it should be implemented. It is the way to tell the
> upper layers that eg. "byte 2 to 17 are ECC bytes, 18 until the end are
> free to use".

Ok I'll add those in. Is there a way I can test that my implementation is right?
I.e. is writing something, reading it back and checking if the data is
correct a good enough test here?
I don't really want to make it look like this flash is supported and
break someone's data. :)

Thanks,

Daniel
