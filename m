Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB5029EC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgJ2NOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2NOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:14:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E22C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:14:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t9so2684514wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9obAPEV8dEZ5dV9K3xznJ6LjVq/00BJ7H8Sv5LddX8E=;
        b=jzVlXEEB5wHxHJyULvUM42NCvTUEbuK845ME39oBPZNYg0IJBMecqYmh/KSkCCGVV8
         PbqwqNcQt3DaD/66WJqHXWtVhEWyY6ImvH/HFiZNsV8tcRxmRwSWJaSIUQXM5wiwBnSU
         0vl/CBawp327PcaNJm3L8fn8aWQ+vr4Bw6fgq77vmIUTwBqT+zYZf65RfwcKcdqYLMUS
         jDFb6rSCB0qTqbLUGvYZ/2W6xTBVF75Bb8YYDnUyr6fa6peEUgaR1W0ZSG5Fupqq1MbE
         Mq3qPD76Gqll6ZOL2ZQhpfIr2T56I//GMtkm/bhjasLApkuuoIJ/8xvW4bs8iunWSqEu
         5F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9obAPEV8dEZ5dV9K3xznJ6LjVq/00BJ7H8Sv5LddX8E=;
        b=T1Sx+02aCt0DI4RewraHZcflV27DlMv4sa72XBRL+AbGhdi6bvmSVMvDrg4IKZ6z7K
         9W+YbfyFCe8JeXcnWbxmjb+cEU3tL5h8kWOWasXJyw3faqnNhuUylN9qTddeipbIGB3J
         /j0VGIATlsqvFA1Xz95QvHozkWaoIS5zydySp3iH5S2wzFYZKSqBsNslYqpQYwyJe7Yk
         nX4BaXn3n9lBoTpP5n8PVe3h7KgM4B6CpHxpLBZB1pDYQAp5Rg4nuehNWtGC5/nilUyx
         ahHjGGJ69wODI8rnbPzdyg9vlLI5QB7WTq8Gjgpc38FlDU9Sq2HtD8L4/uetsCKgqkkp
         IkBg==
X-Gm-Message-State: AOAM531Bf095LABkNJeDvSpdsGtoc2PXaMr0ut4wuZPeWoRfzCq9JQtI
        aoP0TcZkROgbMhU9o9K68JlWdA==
X-Google-Smtp-Source: ABdhPJxH2GANAc8gVY+RbaHy7HfWpZhTky0wsa4s9YojOReeoSLAMEZ36RhnpquTaKqaa2soG3bIag==
X-Received: by 2002:adf:8bce:: with SMTP id w14mr5450324wra.242.1603977261907;
        Thu, 29 Oct 2020 06:14:21 -0700 (PDT)
Received: from dell ([91.110.221.160])
        by smtp.gmail.com with ESMTPSA id l11sm4601692wro.89.2020.10.29.06.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:14:21 -0700 (PDT)
Date:   Thu, 29 Oct 2020 13:14:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Shihlun Lin <shihlun.lin@advantech.com.tw>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Campion Kang <campion.kang@advantech.com.tw>,
        AceLan Kao <chia-lin.kao@canonical.com>
Subject: Re: [PATCH v3 5/6] mfd: ahc1ec0-hwmon: Add sub-device hwmon for
 Advantech embedded controller
Message-ID: <20201029131419.GA4127@dell>
References: <20201029100613.25789-1-shihlun.lin@advantech.com.tw>
 <20201029100613.25789-5-shihlun.lin@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029100613.25789-5-shihlun.lin@advantech.com.tw>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020, Shihlun Lin wrote:

> This is one of sub-device driver for Advantech embedded controller
> AHC1EC0. This driver provides sysfs ABI for Advantech related
> applications to monitor the system status.
> 
> Signed-off-by: Shihlun Lin <shihlun.lin@advantech.com.tw>
> Reported-by: kernel test robot <lkp@intel.com>

LKP reported that your driver needed upstreaming?

I'm confused!

> ---
>  drivers/mfd/Kconfig         |    8 +
>  drivers/mfd/Makefile        |    1 +
>  drivers/mfd/ahc1ec0-hwmon.c | 1514 +++++++++++++++++++++++++++++++++++

This obviously belongs in drivers/hwmon.

>  3 files changed, 1523 insertions(+)
>  create mode 100644 drivers/mfd/ahc1ec0-hwmon.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 965bcafbe5b2..52ca49b211fc 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2175,5 +2175,13 @@ config MFD_AHC1EC0
>  	  provides expose functions for sub-devices to read/write the value
>  	  to embedded controller.
>  
> +config MFD_AHC1EC0_HWMON
> +	tristate "Advantech EC Hareware Monitor Function"
> +	depends on MFD_AHC1EC0
> +	help
> +	  This is sub-device for Advantech embedded controller AHC1EC0. This
> +	  driver provides the sysfs attribues for applications to monitor
> +	  the system status.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 80a9a2bdc3ba..eb645db817b5 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -269,3 +269,4 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
>  
>  obj-$(CONFIG_MFD_AHC1EC0)	+= ahc1ec0.o
> +obj-$(CONFIG_MFD_AHC1EC0_HWMON)	+= ahc1ec0-hwmon.o
> diff --git a/drivers/mfd/ahc1ec0-hwmon.c b/drivers/mfd/ahc1ec0-hwmon.c
> new file mode 100644
> index 000000000000..3e493b040b4a
> --- /dev/null
> +++ b/drivers/mfd/ahc1ec0-hwmon.c
> @@ -0,0 +1,1514 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*****************************************************************************
> + * Copyright (c) 2018, Advantech Automation Corp.

You can't just lift a whole driver from downstream code and send it to
the mailing list as-is.

> + * THIS IS AN UNPUBLISHED WORK CONTAINING CONFIDENTIAL AND PROPRIETARY
> + * INFORMATION WHICH IS THE PROPERTY OF ADVANTECH AUTOMATION CORP.
> + *
> + * ANY DISCLOSURE, USE, OR REPRODUCTION, WITHOUT WRITTEN AUTHORIZATION FROM
> + * ADVANTECH AUTOMATION CORP., IS STRICTLY PROHIBITED.
> + *****************************************************************************

This warning is in contradiction to the licence you are proposing.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
