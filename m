Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156AC2C6620
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgK0Mz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0Mz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:55:56 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8910CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:55:56 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id z188so4189748qke.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SR0buUf6DCzAWU92G2HBvARJg34ZQtaAQdyvkGxwmHw=;
        b=d3pQARZQzne4lvGIbtpPxP1Ngz44mhbQTwiD+ZRXLPeJlCrbsx/rqcKMN7q40lL6Jp
         rX3akTMtl362x5JpWgDsx3FO2TPOX0t0UDcHtzZ0QXHQnog4WT2ngj77dN1Ig+hqWn7C
         1bxyhC7h6M2Jm6j/R20590QYxRf6OjD2PTULAV8g1T8g189/6tmWPm9aJt3RYZnLh3k8
         AwStSiFhWqXULNGbCsRfds/wnW0smGj2jqOcYiMr3/EffTZICkHU6q9EnmJAMQZrrm15
         HQjsj0e8sjSKDPBMklC/aDJBq2Cs2RiCmvb/ZA7jullaZOG87K2iHBT3OsXBhd5d+63z
         hg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SR0buUf6DCzAWU92G2HBvARJg34ZQtaAQdyvkGxwmHw=;
        b=AJwTvqCyBRcYYpjYV1LYq5iNgN4IPvEYe+G9nQaYst6FVlY0o699xTFfbKKGmSQ470
         IXwUYgwuoSvC6if21ABzPnlLzxq0fjiPt1l/ciJXUF3FTMqG7VUP8FteoODahH+spGZ/
         bNgG0PceGtc80qZD7VIIu7Zj2dTTpoHN6mEes/36LynAFeb1ucc6AC7Xi612edeGpxgt
         TJW7Cqh/CqMUA5YRCRBtrSEAMsRoepqeSXsHhWmStMcXX45/XR3FiVrUiRoks3jL8cRX
         5ijqwaWT7D5ktUGW2Kyn5osT2TkZ7PbRaKb8QYXvA87faXAgyDO+lt2p0cgLBpaOr7V0
         kW9Q==
X-Gm-Message-State: AOAM531HKU+fxbTC+ZH9dVkb/Inv7dOjH/3rIx/aFFivOb2RraUMZ9r5
        jJ3rKY4YwngVWwvBaERFtTbRJxH9P2/XlpGmUKA=
X-Google-Smtp-Source: ABdhPJz5XCY1HfjEjxSS3/+367IzKVw/fV+zyn+EUUOMXGBy667vJRPqWlzmQV7b5DHfXf9Lz5glKhf8p4fS9WuxwiU=
X-Received: by 2002:a37:991:: with SMTP id 139mr8297156qkj.185.1606481755664;
 Fri, 27 Nov 2020 04:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20201118182459.18197-1-p.yadav@ti.com> <20201124134619.2pbg7zejbvwc3e2w@ti.com>
In-Reply-To: <20201124134619.2pbg7zejbvwc3e2w@ti.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 27 Nov 2020 13:55:44 +0100
Message-ID: <CAFLxGvx=pKeLxq1yaruSK8qtodivX8TOFVyjF8sLrJQjdVT8Dw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 2:58 PM Pratyush Yadav <p.yadav@ti.com> wrote:
>
> Hi,
>
> On 18/11/20 11:54PM, Pratyush Yadav wrote:
> > Hi,
> >
> > The Cypress Semper S28 flash family uses 2-bit ECC by default. Under
> > this ECC scheme, multi-pass page programs result in a program error.
> > This means that unlike many other SPI NOR flashes, bit-walking cannot be
> > done. In other words, once a page is programmed, its bits cannot then be
> > flipped to 0 without an erase in between.
> >
> > This causes problems with UBIFS because it uses bit-walking to clear EC
> > and VID magic numbers from a PEB before issuing an erase to preserve the
> > file system correctness in case of power cuts.
> >
> > This series fixes that by setting mtd->writesize to the ECC block size
> > (16) and making sure UBIFS does not try to do a multi-pass write on
> > flashes with writesize > 1.
> >
> > It is based on the xSPI/8D series that adds support for Cypress S28
> > flash [0] (it is in next now). The patches themselves are independent of
> > that series in the sense that they don't rely on 8D support. But since
> > S28 flash is not supported without that series, these patches don't make
> > much sense without it.
> >
> > Tested on Cypress S28HS512T and MT35XU512ABA on J7200 and J721E
> > respectively.
> >
> > [0] https://lore.kernel.org/linux-mtd/20201005153138.6437-1-p.yadav@ti.com/
>
> Any comments on the series? If not, can it be picked up?
>
> > Pratyush Yadav (3):
> >   UBI: Do not zero out EC and VID on ECC-ed NOR flashes
> >   mtd: spi-nor: core: Allow flashes to specify MTD writesize
> >   mtd: spi-nor: spansion: Set ECC block size
> >
> >  drivers/mtd/spi-nor/core.c     | 4 +++-
> >  drivers/mtd/spi-nor/core.h     | 3 +++
> >  drivers/mtd/spi-nor/spansion.c | 1 +
> >  drivers/mtd/ubi/build.c        | 4 +---
> >  drivers/mtd/ubi/io.c           | 9 ++++++++-
> >  5 files changed, 16 insertions(+), 5 deletions(-)

Can we please have am ACK from NOR folks? :-)

-- 
Thanks,
//richard
