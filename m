Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7A1B6EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 09:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgDXHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726056AbgDXHS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:18:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D497C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 00:18:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so9451430wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TJ5Xz/v3Hc30cuvJyJGs5IX6MWAAzYb1YSZtC9xjqEU=;
        b=B5WpYfbHEkVWSsubr3ytIZmD80f2ymgSmPsDIYveL2XaNgSqwjVg5HE8672wb26WCH
         ECVm0dw6k8PO+Y/V5FsXQV8XS4lSIPRCd6CR/5NdYaRb8YnZqtTQPatj64L7nf1H/fgQ
         eUnEGsco0MLm8U9RSEkbxlGD9jBW24n36keMWvdFdlksYoRfLey0bg+tNasdD4S3pSYL
         zJAaeLOY7kK2T7V2eCM+Xk/GBkYjTDuJUIAHBrE+9rsSbdAIi2y4Z+Rpb035FFHwfAJR
         SgWOPRSUbfiqy9uAesl+JOMXd4T+WTBArO2sOyKM4itUEtm+Yza1E8ldJeypF8m06lym
         hzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TJ5Xz/v3Hc30cuvJyJGs5IX6MWAAzYb1YSZtC9xjqEU=;
        b=VagZYi5mP7ZgUTV4S3MFOdeH1Us0IEI7MKvcXHTsFR6az4qLd13a+ilmQ+bWn/I/GO
         OJO7Z70xz2nNAY+bDj2iXBibjRNSN4P6KZB8zAyMtUi82K+hof2EuwRdd5Rd9fuiVgVC
         h9Yflg8zrOOguEPhhsvojOlE/zjiSBFMSm53eMTSrMhmsZ2z2D8iAOf3SZE3rliAoMfo
         E99XuzBU8W+R05w2loj55M6XwhaWzZ+9USqhy4fGGENMiUGbewq2F6bT7l95R/MOdk+v
         fA9JWVipRWPMtjk6jnpH1s0t/PNl+FU9ak4JDVnAenIaUMNhgj+08WksiSIC7syCbFct
         1KfQ==
X-Gm-Message-State: AGi0PuZc1EaW8I6kxiTeWYzGssgC1MfruLzHXyhlStiRyvPT8IY2PzaE
        B1HNKGaKSc4BnKgZQnmdoICzdA==
X-Google-Smtp-Source: APiQypLwPG8ELo0NdJrmqJobPxrMbsP0hvOgYGuVOmP8pw5UhAZiBUyKPCJyFd2ve2lS88LTSoWcsw==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr9941757wrr.247.1587712705585;
        Fri, 24 Apr 2020 00:18:25 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id t20sm1578651wmi.2.2020.04.24.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 00:18:24 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:18:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200424071822.GM3612@dell>
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415162030.16414-3-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, Saravanan Sekar wrote:

> mp2629 is a highly-integrated switching-mode battery charge management
> device for single-cell Li-ion or Li-polymer battery.
> 
> Add MFD core enables chip access for ADC driver for battery readings,
> and a power supply battery-charger driver
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/mfd/Kconfig        |  9 ++++
>  drivers/mfd/Makefile       |  2 +
>  drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mp2629.h | 19 +++++++++
>  4 files changed, 116 insertions(+)
>  create mode 100644 drivers/mfd/mp2629.c
>  create mode 100644 include/linux/mfd/mp2629.h

How is this driver registered?

Looks like it has device tree support.  Is there another way?

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3c547ed575e6..85be799795aa 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
>  
> +config MFD_MP2629
> +	tristate "Monolithic power system MP2629 ADC and Battery charger"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Select this option to enable support for monolithic power system
> +	  battery charger. This provides ADC, thermal, battery charger power
> +	  management functions on the systems.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
