Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE92A3F16
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgKCIk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCIk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:40:58 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE48C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:40:57 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w1so17559891wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 00:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n6axZ3iHP/I9X6zde0t6fRwwASoVhPTt/aoyun6aVLg=;
        b=MXLUtD+2v+X3jyoDpovc1noJ6ID2onsZ/zl+oh7F6o98QyqcNPezYEINAhhfXQI5K3
         9pxpLVorBayUt1kCNCMQ7EU377fo6BPqYT9XTxxeBuXzRoqhkD/WdnLGS38mqi/sOZem
         YCDkb7S+OTRGhWX0QKXPuP1p/F4UgwtU8VyKcPfeKAK3M+XZLSnGFpexx8dU9UzqN8Az
         4li2dtc/g0z33pDOPEaOk5OeRxu9ZzzE8kmAVNPWWvJDtbY0XVjPDhqzrR36sS6lmdyM
         /Sc79foBBP7rMPt2AUT/m87eR+70OCzjtqXQwlUdOOdXCoUFbWupmJmmYGRGGKjYyofI
         X2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n6axZ3iHP/I9X6zde0t6fRwwASoVhPTt/aoyun6aVLg=;
        b=UKiT4i/qhcxayaEq3Op/6pepj4GuZLmZsB1bJb/ORspBoHlBlFMLsdIFUVoBDVQgGW
         PGsddRSmRj0bbg9Eh/3VI/oVmV4lFHnJVp98hOzp8FbOM0jdRYIFkkhgk2fYk3ckMCf7
         YKKVo9PN43ldPsvNh0eBmahU8SuBHCkVFH8RXZFTL60UgE5eJ5Aj1Lt9+NsYwUVsUFPS
         3WLXWtjFVeg5fY18IrSq1qn1PwLualH58Q2vLpSb0qi5UqAWhm1XOJQQ+l5lYMyk1iLR
         M0AcX2ZJWglFDQGJQXmsjeTjUv6h/XPA4mFaWo1UwefpUuzndEJPMO7ggjPBiNmbmeOf
         I69Q==
X-Gm-Message-State: AOAM530bZg0ilH2XR+cL2a4OFnlGHXL6qqoxO06Pu9udMFcB/fsMQewM
        CdYvHVX1hNcYYSECe8YnCb3g6A==
X-Google-Smtp-Source: ABdhPJw6PnP2+bLkXHVjNvjeI6EXcpq7E23UgBuQd7RvTkec8T1MJNS2S9wd4IVNf/3BV72bH2Nk4A==
X-Received: by 2002:adf:de91:: with SMTP id w17mr24325209wrl.84.1604392855689;
        Tue, 03 Nov 2020 00:40:55 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v9sm12120980wrp.11.2020.11.03.00.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 00:40:55 -0800 (PST)
Date:   Tue, 3 Nov 2020 08:40:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     AceLan Kao <chia-lin.kao@canonical.com>
Cc:     Shihlun Lin <shihlun.lin@advantech.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Campion Kang <campion.kang@advantech.com.tw>
Subject: Re: [PATCH v3 5/6] mfd: ahc1ec0-hwmon: Add sub-device hwmon for
 Advantech embedded controller
Message-ID: <20201103084053.GH4488@dell>
References: <20201029100613.25789-1-shihlun.lin@advantech.com.tw>
 <20201029100613.25789-5-shihlun.lin@advantech.com.tw>
 <20201029131419.GA4127@dell>
 <CAFv23Q=EwE=S7U9-NzRfy8CxM+bFX32HHMfZXS1UsPd8dMqzYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFv23Q=EwE=S7U9-NzRfy8CxM+bFX32HHMfZXS1UsPd8dMqzYQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020, AceLan Kao wrote:

> Hi Lee,
> 
> One question for you.
> 
> Lee Jones <lee.jones@linaro.org> 於 2020年10月29日 週四 下午9:14寫道：
> >
> > On Thu, 29 Oct 2020, Shihlun Lin wrote:
> >
> > > This is one of sub-device driver for Advantech embedded controller
> > > AHC1EC0. This driver provides sysfs ABI for Advantech related
> > > applications to monitor the system status.
> > >
> > > Signed-off-by: Shihlun Lin <shihlun.lin@advantech.com.tw>
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > LKP reported that your driver needed upstreaming?
> >
> > I'm confused!
> >
> > > ---
> > >  drivers/mfd/Kconfig         |    8 +
> > >  drivers/mfd/Makefile        |    1 +
> > >  drivers/mfd/ahc1ec0-hwmon.c | 1514 +++++++++++++++++++++++++++++++++++
> >
> > This obviously belongs in drivers/hwmon.
> >
> > >  3 files changed, 1523 insertions(+)
> > >  create mode 100644 drivers/mfd/ahc1ec0-hwmon.c
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 965bcafbe5b2..52ca49b211fc 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -2175,5 +2175,13 @@ config MFD_AHC1EC0
> > >         provides expose functions for sub-devices to read/write the value
> > >         to embedded controller.
> > >
> > > +config MFD_AHC1EC0_HWMON
> > > +     tristate "Advantech EC Hareware Monitor Function"
> > > +     depends on MFD_AHC1EC0
> > > +     help
> > > +       This is sub-device for Advantech embedded controller AHC1EC0. This
> > > +       driver provides the sysfs attribues for applications to monitor
> > > +       the system status.
> > > +
> > >  endmenu
> > >  endif
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 80a9a2bdc3ba..eb645db817b5 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -269,3 +269,4 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)  += simple-mfd-i2c.o
> > >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> > >
> > >  obj-$(CONFIG_MFD_AHC1EC0)    += ahc1ec0.o
> > > +obj-$(CONFIG_MFD_AHC1EC0_HWMON)      += ahc1ec0-hwmon.o
> > > diff --git a/drivers/mfd/ahc1ec0-hwmon.c b/drivers/mfd/ahc1ec0-hwmon.c
> > > new file mode 100644
> > > index 000000000000..3e493b040b4a
> > > --- /dev/null
> > > +++ b/drivers/mfd/ahc1ec0-hwmon.c
> > > @@ -0,0 +1,1514 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*****************************************************************************
> > > + * Copyright (c) 2018, Advantech Automation Corp.
> >
> > You can't just lift a whole driver from downstream code and send it to
> > the mailing list as-is.
> Could you elaborate more about which part should be fixed, and how it
> should look like?

Frankly, no.

I would expect a contributor of a several thousand line patch-set to
at least read the documentation and adhere to it prior to anyone
conducting a full review.  Simply plucking a very old driver set from
a BSP kernel and dumping it on the upstream mailing list is not the
way to gain the right kind of attention.

At the very least (this is not an exhaustive list);

- all of the copyrights need to be up-to-date
- the drivers need to be located in their correct subsystems
- any internal references/comment headers need to be removed
- licences should be compatible with upstreaming
- hacks removed
- builds without errors or warnings
- checkpatch.pl passed
- submission should tick all of the boxes in SubmittingPatches
- removal of changelogs/versions
  - this is the first version as far as the kernel is concerned

> > > + * THIS IS AN UNPUBLISHED WORK CONTAINING CONFIDENTIAL AND PROPRIETARY
> > > + * INFORMATION WHICH IS THE PROPERTY OF ADVANTECH AUTOMATION CORP.
> > > + *
> > > + * ANY DISCLOSURE, USE, OR REPRODUCTION, WITHOUT WRITTEN AUTHORIZATION FROM
> > > + * ADVANTECH AUTOMATION CORP., IS STRICTLY PROHIBITED.
> > > + *****************************************************************************
> >
> > This warning is in contradiction to the licence you are proposing.
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
