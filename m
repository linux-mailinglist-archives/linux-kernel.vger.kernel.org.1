Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337DE2EEB94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 04:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbhAHDA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 22:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbhAHDA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 22:00:27 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD38C0612F4;
        Thu,  7 Jan 2021 18:59:40 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z9so5740766qtn.4;
        Thu, 07 Jan 2021 18:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1UOnZQlSUpnf6aKPwE+X4haOuAWzcolUyB8HXclKZk=;
        b=hXyKJvBWO47USxHNP91v+gMyjfU65MiJCuufIGMJTAK222NvZmZlCtJt1Rzl/mycDM
         Nf6XnQh73y7OiZqLNySBMgSDSqzmV+j7kIbNHCajVDqQnY13pPqMEIuFKjq67rTQq0xj
         F5eNNsi3tEDYhNIFGi/ztmmRfOHrQty8CJ3/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1UOnZQlSUpnf6aKPwE+X4haOuAWzcolUyB8HXclKZk=;
        b=pqq5WwSYnO45Xby/UhYdNTxv41IMgrc0u55rr+Stz+mG/0hSHJVuM38K+zENUhW2Qk
         ztaqCO9JHaZcsU/laPjHJ9nN+KKayezGW/rI1hyfNJHEuwO+NyXvoUxQnZ3tbKoOCt8K
         wactqjZQkA3UOpAo2taYt+OETdHin55pLH1y/zU71+oYedoaVAb4IyaoysvALoaFBW/K
         QT2SYS1TiGRHIsKAjLKmdgDvORk/rxZ6jGX85FDZ/vb2DcgfhQLsuIKEw9ds8b0mZP16
         d3NpV1n19dC48TSpyaHd3vBpgmq5n/BgeQ2t36Avm8RBeH0LC5NNPsuTbjkxa1aKE1oh
         Hpxg==
X-Gm-Message-State: AOAM530MB8Yiyh8IiZtHPV6Ph3jGgwkMkRCt6V9aEivJoM+aIEs4tZNk
        rRa4dSXOIPrCpJq3sbGOgP2kSl2oC1IermqD0oA=
X-Google-Smtp-Source: ABdhPJzgwxO1QYsS1AD103dGGMwHdDtcECTAh5zBmhiw0tIxXUY3pxQQ/nGQO979T5rDAeRPM0TxIO3GFuCFkyqwz0M=
X-Received: by 2002:aed:2d65:: with SMTP id h92mr1632947qtd.263.1610074779999;
 Thu, 07 Jan 2021 18:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
 <20210106055939.19386-6-chiawei_wang@aspeedtech.com> <20210106153202.GA2258036@robh.at.kernel.org>
 <HK0PR06MB377987E19F57E53CC4F32FF991AF0@HK0PR06MB3779.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB377987E19F57E53CC4F32FF991AF0@HK0PR06MB3779.apcprd06.prod.outlook.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 8 Jan 2021 02:59:28 +0000
Message-ID: <CACPK8XfCpUDXi-e1Sh1t+wm_-vXNihRchkmQby7fUXi0mCdMwA@mail.gmail.com>
Subject: Re: [PATCH 5/6] soc: aspeed: Add eSPI driver
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Rob Herring <robh@kernel.org>, "andrew@aj.id.au" <andrew@aj.id.au>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 at 02:39, ChiaWei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Hi Rob,
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Wednesday, January 6, 2021 11:32 PM
> > To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> > Subject: Re: [PATCH 5/6] soc: aspeed: Add eSPI driver
> >
> > On Wed, Jan 06, 2021 at 01:59:38PM +0800, Chia-Wei, Wang wrote:
> > > The Aspeed eSPI controller is slave device to communicate with the
> > > master through the Enhanced Serial Peripheral Interface (eSPI).
> > > All of the four eSPI channels, namely peripheral, virtual wire,
> > > out-of-band, and flash are supported.
> > >
> > > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> > > ---
> > >  drivers/soc/aspeed/Kconfig                  |  49 ++
> > >  drivers/soc/aspeed/Makefile                 |   5 +
> > >  drivers/soc/aspeed/aspeed-espi-ctrl.c       | 197 ++++++
> > >  drivers/soc/aspeed/aspeed-espi-flash.c      | 490 ++++++++++++++
> > >  drivers/soc/aspeed/aspeed-espi-oob.c        | 706
> > ++++++++++++++++++++
> > >  drivers/soc/aspeed/aspeed-espi-peripheral.c | 613 +++++++++++++++++
> > >  drivers/soc/aspeed/aspeed-espi-vw.c         | 211 ++++++
> > >  include/uapi/linux/aspeed-espi.h            | 160 +++++
> > >  8 files changed, 2431 insertions(+)
> > >  create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
> > >  create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.c
> > >  create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.c
> > >  create mode 100644 drivers/soc/aspeed/aspeed-espi-peripheral.c
> > >  create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.c
> >
> > drivers/spi/ is the correct location for a SPI controller.
> >
> > >  create mode 100644 include/uapi/linux/aspeed-espi.h
> >
> > This userspace interface is not going to be accepted upstream.
> >
> > I'd suggest you look at similar SPI flash capable SPI controller drivers upstream
> > and model your driver after them. This looks like it needs major reworking.
> >
> eSPI resues the timing and electrical specification of SPI but runs completely different protocol.
> Only the flash channel is related to SPI and the other 3 channels are for EC/BMC/SIO.
> Therefore, an eSPI driver might not fit into the SPI model.

I agree, the naming is confusing but eSPI doesn't belong in drivers/spi.

As it is a bus that is common to more than just the Aspeed BMC, we may
want to implement it as a new bus type that has devices hanging off
it, similar to FSI.

Cheers,

Joel
