Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAD62A27FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgKBKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgKBKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:14:23 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F968C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:14:23 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k10so12529973wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t1K0NwlSDb4++OllbH1h9aaEG4tdnBfR2XD4G2HdxPs=;
        b=trYgFDTQak6WcxQiw32NmN3mw+gKSInrqOFdT+jMG2NIWp7hcgj5oHXFeLs/YHoufj
         7gCVSIMIX5hD0IgibN2wTKv/oM2o+7NhjEu5m6T1ZmNVgD6BLb7V627ux56Ig7Fv6byS
         Pu1bYCMTBr9uiGDk0VHCUMGuBLlp/bOc6dOHWpL8PyWeHQ39i2cmZTCD6+nwKGfzi+Q7
         oELd5uHpk5RmRQG1t/yrvv6J7rzq5WSaM68tDqaew6t6YAmMRQlo8QMba8R45jDQzmGC
         DrzYRwUsnZhuWzOaorE0zYY5IdiHf8XTYLR1T8yWyur5NDxwMzXXHVY6n2TOlZR0dYjW
         AXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t1K0NwlSDb4++OllbH1h9aaEG4tdnBfR2XD4G2HdxPs=;
        b=YfOJ5PpKhQsHaEkhJP25ZiNERVxd2V4XOaYyymF+2CUFHfEq/i/Tlsj0igAQWjkRQS
         CdAvjZf2uklxFdFFqEpo//G7dR497CEfQLfawt/h5k+bpSuL0det6SmpxENuNYMtHqjU
         B1YNpVRiXWQZHgFRJ2YDAR1zDo3FefQJIJEK0c5eE+MDBWMtHStnnB2MEP9lot1YUoUf
         InyWg7h9XzWABG0+B8xicQx95klcpO8rf5wwNLDZ/jO7+4GOUdl2tKARJAlDlCW1FLee
         +c+COSW6gAyojXsI4c1oetdzgYcU5qfAChqr50fJIygjpJ6PO6CCzKcBgbEFQso7yqNp
         HeTw==
X-Gm-Message-State: AOAM531VDUsWIe4gA/DrtJOwUkxmX9Hn2dosqEnzf57sm/88wsAuEu89
        +VEAib8lN/qXaZacou66d+3SMQ==
X-Google-Smtp-Source: ABdhPJxWAwlYcJo5f5G4ksFvQH+/FvBMet+9BoaiMgahkLH5FFiF4dE/eVH9LV70XI4WzVU6vDgxow==
X-Received: by 2002:adf:e5c1:: with SMTP id a1mr13889466wrn.12.1604312061862;
        Mon, 02 Nov 2020 02:14:21 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id h4sm21487621wrp.52.2020.11.02.02.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:14:21 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:14:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Shihlun.Lin" <Shihlun.Lin@advantech.com.tw>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Campion.Kang" <Campion.Kang@advantech.com.tw>,
        AceLan Kao <chia-lin.kao@canonical.com>
Subject: Re: [PATCH v3 5/6] mfd: ahc1ec0-hwmon: Add sub-device hwmon for
 Advantech embedded controller
Message-ID: <20201102101419.GI4127@dell>
References: <20201029100613.25789-1-shihlun.lin@advantech.com.tw>
 <20201029100613.25789-5-shihlun.lin@advantech.com.tw>
 <20201029131419.GA4127@dell>
 <1e5710f4214b4e8b84f761a260d9dd5b@taipei09.ADVANTECH.CORP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e5710f4214b4e8b84f761a260d9dd5b@taipei09.ADVANTECH.CORP>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, Shihlun.Lin wrote:

> Hi Lee,
> 
> Thank you for your time for checking my submission.
> 
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
> 
> When I submitted the driver first time, LKP reported some warning to me and ask me to add the tag.
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@xxxxxxxxx>
> 
> Link: https://www.spinics.net/lists/kernel/msg3698194.html

That would only be for the fix.

Having a test robot report a missing driver seems odd.

> > > ---
> > >  drivers/mfd/Kconfig         |    8 +
> > >  drivers/mfd/Makefile        |    1 +
> > >  drivers/mfd/ahc1ec0-hwmon.c | 1514
> > +++++++++++++++++++++++++++++++++++
> > 
> > This obviously belongs in drivers/hwmon.
> > 
> 
> Thank you so much, I will do it.
> 
> > >  3 files changed, 1523 insertions(+)
> > >  create mode 100644 drivers/mfd/ahc1ec0-hwmon.c
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 965bcafbe5b2..52ca49b211fc 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -2175,5 +2175,13 @@ config MFD_AHC1EC0
> > >  	  provides expose functions for sub-devices to read/write the value
> > >  	  to embedded controller.
> > >
> > > +config MFD_AHC1EC0_HWMON
> > > +	tristate "Advantech EC Hareware Monitor Function"
> > > +	depends on MFD_AHC1EC0
> > > +	help
> > > +	  This is sub-device for Advantech embedded controller AHC1EC0. This
> > > +	  driver provides the sysfs attribues for applications to monitor
> > > +	  the system status.
> > > +
> > >  endmenu
> > >  endif
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index 80a9a2bdc3ba..eb645db817b5 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -269,3 +269,4 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+=
> > simple-mfd-i2c.o
> > >  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> > >
> > >  obj-$(CONFIG_MFD_AHC1EC0)	+= ahc1ec0.o
> > > +obj-$(CONFIG_MFD_AHC1EC0_HWMON)	+= ahc1ec0-hwmon.o
> > > diff --git a/drivers/mfd/ahc1ec0-hwmon.c b/drivers/mfd/ahc1ec0-hwmon.c
> > > new file mode 100644
> > > index 000000000000..3e493b040b4a
> > > --- /dev/null
> > > +++ b/drivers/mfd/ahc1ec0-hwmon.c
> > > @@ -0,0 +1,1514 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > >
> > +/**************************************************************
> > ***************
> > > + * Copyright (c) 2018, Advantech Automation Corp.
> > 
> > You can't just lift a whole driver from downstream code and send it to
> > the mailing list as-is.
> > 
> 
> Could you give me more advice about how to submit the whole driver?
> Is there any website to guide me?

There is lots of documentation on how to upstream code/drivers in
the /Documentation folder.

Start here:

 https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Note, this online document, along with all of the others you will
required are actually contained in /Documentation, in the kernel
source tree.

> Thank you so much.
> 
> > > + * THIS IS AN UNPUBLISHED WORK CONTAINING CONFIDENTIAL AND
> > PROPRIETARY
> > > + * INFORMATION WHICH IS THE PROPERTY OF ADVANTECH AUTOMATION
> > CORP.
> > > + *
> > > + * ANY DISCLOSURE, USE, OR REPRODUCTION, WITHOUT WRITTEN
> > AUTHORIZATION FROM
> > > + * ADVANTECH AUTOMATION CORP., IS STRICTLY PROHIBITED.
> > > +
> > ****************************************************************
> > *************
> > 
> > This warning is in contradiction to the licence you are proposing.
> 
> Thank you so much, I will remove it.

You'd better seek proper permission from your legal department before
doing so.  Subverting licence agreements can land you in heaps of
trouble if you're not careful.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
