Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1744C2A3B10
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKCDbf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 22:31:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42205 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCDbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:31:34 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1kZn2h-0000le-Un
        for linux-kernel@vger.kernel.org; Tue, 03 Nov 2020 03:31:31 +0000
Received: by mail-wr1-f72.google.com with SMTP id b6so7218777wrn.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 19:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2rp7oMbIU1QVb+UrLA07q3LzyCG33ZauCVTuUDlnceA=;
        b=HqhElwQ5txHu6O8EbvNVirmpQATuSSkY8tobZAqyhaeLVcqMd7SUPu4ygpaJ9XK4tN
         ZK89xI4Z0mizAq6n7W4f+JrcgOcucflksy19eLX+ou8TTsoSUJVEYYGLgVqTEPrTqATp
         6zrYkymuEywnUcL+4qYHluPIBy4vH5dyE3AVA6I0ecEjUyTdLNEpUaQhe7dP5cFHXQ4l
         sWd2K8JEC52peSOosQjjcqaw2K5oHlXxjCwUDLszGetfV/mbmWdB4BLzfPIAaH7h2ZXV
         Uw6pbic+wG5fw0K+kvMy8h3urmns2jIsHtnkyGEbl3A4LASMZiEfBFz9MLeowXTGAx0a
         gYCQ==
X-Gm-Message-State: AOAM531yCZAeeTaLa5Mt5vI6h+Ou6j0gA23Cmssv1XA2nYiGxtfxnFTm
        IXSsrn1bLrOeItEzoS6Aj/ne+vIV6i57DsP/LM6XIZ+Bz4AAz6OtcozOOhhtmQ7ROoeeHFE/ng1
        2xKa8udutSxmPFT0GENOFnj+fiZpoIkJTtaQ/CNpSWFfs0VrT/GsVX1oL/A==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr23477034wrn.52.1604374291657;
        Mon, 02 Nov 2020 19:31:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIbzt/4neJn7QeRrdYenW8Dms4heXQRX7V8hpk6OPhdPtRu2UB72q1WZ1XgWeKMukJ5CsUp616CnSix8X92jM=
X-Received: by 2002:adf:ce12:: with SMTP id p18mr23477018wrn.52.1604374291444;
 Mon, 02 Nov 2020 19:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20201029100613.25789-1-shihlun.lin@advantech.com.tw>
 <20201029100613.25789-5-shihlun.lin@advantech.com.tw> <20201029131419.GA4127@dell>
In-Reply-To: <20201029131419.GA4127@dell>
From:   AceLan Kao <chia-lin.kao@canonical.com>
Date:   Tue, 3 Nov 2020 11:31:20 +0800
Message-ID: <CAFv23Q=EwE=S7U9-NzRfy8CxM+bFX32HHMfZXS1UsPd8dMqzYQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mfd: ahc1ec0-hwmon: Add sub-device hwmon for
 Advantech embedded controller
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Shihlun Lin <shihlun.lin@advantech.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Campion Kang <campion.kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

One question for you.

Lee Jones <lee.jones@linaro.org> 於 2020年10月29日 週四 下午9:14寫道：
>
> On Thu, 29 Oct 2020, Shihlun Lin wrote:
>
> > This is one of sub-device driver for Advantech embedded controller
> > AHC1EC0. This driver provides sysfs ABI for Advantech related
> > applications to monitor the system status.
> >
> > Signed-off-by: Shihlun Lin <shihlun.lin@advantech.com.tw>
> > Reported-by: kernel test robot <lkp@intel.com>
>
> LKP reported that your driver needed upstreaming?
>
> I'm confused!
>
> > ---
> >  drivers/mfd/Kconfig         |    8 +
> >  drivers/mfd/Makefile        |    1 +
> >  drivers/mfd/ahc1ec0-hwmon.c | 1514 +++++++++++++++++++++++++++++++++++
>
> This obviously belongs in drivers/hwmon.
>
> >  3 files changed, 1523 insertions(+)
> >  create mode 100644 drivers/mfd/ahc1ec0-hwmon.c
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 965bcafbe5b2..52ca49b211fc 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -2175,5 +2175,13 @@ config MFD_AHC1EC0
> >         provides expose functions for sub-devices to read/write the value
> >         to embedded controller.
> >
> > +config MFD_AHC1EC0_HWMON
> > +     tristate "Advantech EC Hareware Monitor Function"
> > +     depends on MFD_AHC1EC0
> > +     help
> > +       This is sub-device for Advantech embedded controller AHC1EC0. This
> > +       driver provides the sysfs attribues for applications to monitor
> > +       the system status.
> > +
> >  endmenu
> >  endif
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 80a9a2bdc3ba..eb645db817b5 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -269,3 +269,4 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)  += simple-mfd-i2c.o
> >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> >
> >  obj-$(CONFIG_MFD_AHC1EC0)    += ahc1ec0.o
> > +obj-$(CONFIG_MFD_AHC1EC0_HWMON)      += ahc1ec0-hwmon.o
> > diff --git a/drivers/mfd/ahc1ec0-hwmon.c b/drivers/mfd/ahc1ec0-hwmon.c
> > new file mode 100644
> > index 000000000000..3e493b040b4a
> > --- /dev/null
> > +++ b/drivers/mfd/ahc1ec0-hwmon.c
> > @@ -0,0 +1,1514 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*****************************************************************************
> > + * Copyright (c) 2018, Advantech Automation Corp.
>
> You can't just lift a whole driver from downstream code and send it to
> the mailing list as-is.
Could you elaborate more about which part should be fixed, and how it
should look like?

> > + * THIS IS AN UNPUBLISHED WORK CONTAINING CONFIDENTIAL AND PROPRIETARY
> > + * INFORMATION WHICH IS THE PROPERTY OF ADVANTECH AUTOMATION CORP.
> > + *
> > + * ANY DISCLOSURE, USE, OR REPRODUCTION, WITHOUT WRITTEN AUTHORIZATION FROM
> > + * ADVANTECH AUTOMATION CORP., IS STRICTLY PROHIBITED.
> > + *****************************************************************************
>
> This warning is in contradiction to the licence you are proposing.
>
> --
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
