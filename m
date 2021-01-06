Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BBD2EC06C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbhAFPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:32:48 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:45695 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbhAFPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:32:47 -0500
Received: by mail-io1-f41.google.com with SMTP id n4so3061694iow.12;
        Wed, 06 Jan 2021 07:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t80RrQIP9pcWO65dqznFuyn9d1RG+MW1J0H6Xs08o5Q=;
        b=VgebxhUgSIFbPZXPTVu7VCAaeN8Fp/HAOY37qvMM26MC67knywFbrGPV/th8wUQGs1
         itL2skiAy0u8a7XM2KsD7dO22eXytekojEziQl4C2TYNva8qAc7H3gsDvjN2yLjS2miv
         Z3c7iawVoPeL0okCisZsoNd/Mgq6nQY5zZdJczX/iSspZL8MXT3D4h5vJa4/97vVCqRP
         ERYD5E0R1+18n3mgN/DwhYBlN7C5eqojkM6ey5tt4gPwgyrxtDG97k0BPPWsDMgdBQD0
         nyG9jfgW4kETyL8GlGc3Jc3hXb5jBL1QM9OS0Lfyy6I28/zUwUl+mXACGxU34xm9uQY2
         IE3g==
X-Gm-Message-State: AOAM532umtMvBSC4U2hSBBtBREOFlWGomVZ9uWN81fmBTf9g1iAQ8jK8
        b1Raf2kV8/ioSmN1OdICow==
X-Google-Smtp-Source: ABdhPJyz6kf7fccUgN42Q21kf9oT8emUqUG0qvmMQDGTyBYyMTKFCZbUVC4pPwY/vKQfpxrz6D+Cnw==
X-Received: by 2002:a02:b709:: with SMTP id g9mr4250778jam.90.1609947126638;
        Wed, 06 Jan 2021 07:32:06 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id n10sm2371751ila.69.2021.01.06.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 07:32:05 -0800 (PST)
Received: (nullmailer pid 2267272 invoked by uid 1000);
        Wed, 06 Jan 2021 15:32:02 -0000
Date:   Wed, 6 Jan 2021 08:32:02 -0700
From:   Rob Herring <robh@kernel.org>
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH 5/6] soc: aspeed: Add eSPI driver
Message-ID: <20210106153202.GA2258036@robh.at.kernel.org>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
 <20210106055939.19386-6-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106055939.19386-6-chiawei_wang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 01:59:38PM +0800, Chia-Wei, Wang wrote:
> The Aspeed eSPI controller is slave device to communicate with
> the master through the Enhanced Serial Peripheral Interface (eSPI).
> All of the four eSPI channels, namely peripheral, virtual wire,
> out-of-band, and flash are supported.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/soc/aspeed/Kconfig                  |  49 ++
>  drivers/soc/aspeed/Makefile                 |   5 +
>  drivers/soc/aspeed/aspeed-espi-ctrl.c       | 197 ++++++
>  drivers/soc/aspeed/aspeed-espi-flash.c      | 490 ++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-oob.c        | 706 ++++++++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-peripheral.c | 613 +++++++++++++++++
>  drivers/soc/aspeed/aspeed-espi-vw.c         | 211 ++++++
>  include/uapi/linux/aspeed-espi.h            | 160 +++++
>  8 files changed, 2431 insertions(+)
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.c
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.c
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-peripheral.c
>  create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.c

drivers/spi/ is the correct location for a SPI controller.

>  create mode 100644 include/uapi/linux/aspeed-espi.h

This userspace interface is not going to be accepted upstream.

I'd suggest you look at similar SPI flash capable SPI controller drivers 
upstream and model your driver after them. This looks like it needs 
major reworking.

Rob
