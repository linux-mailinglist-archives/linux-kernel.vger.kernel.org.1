Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D880267CEE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 01:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgILXVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 19:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgILXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 19:21:13 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABC9C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 16:21:13 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 185so13508643oie.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 16:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/dMaaDBanDfYWzJHUtA1zu6QC3dcL1hIJu0fjtyjUYk=;
        b=pW8a2zZ7S2E+NpS33bjr+N9ScS0sROEfh+yK/EZ1WcdV6xkmmEshW0+IlNi2NpsTps
         22NtzGYYqJGjdtjf8azrlzkkvI6m3PKicwoxYxMIcrVmMjXKQ7jMNoJeNtMlDKAGdCaY
         CgHzvTtTXaXD3DEcZViXEkbKrev/qJjhW0dM50Bhs3bG3hbZzzxV4Nu/MeCqvqyDkt0x
         X1PzGu9WDGla5NdV1vcB9p5PYh2yO+a6Npu2ww9eB9Cnew9IBpPIBro4dBNnVcNpESzA
         +aQlR7OsYpKDvXsRzEpkyyKcVjikPOowLGuLqXrT17zdoTaupZta4Ytqy1zullJOUPVb
         aYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dMaaDBanDfYWzJHUtA1zu6QC3dcL1hIJu0fjtyjUYk=;
        b=CLowmK52zU/RZvLS8VcFzcNOuaLRhOJQWu1O/LWY27zicpTfCytq01zTQJ2O6Y40sK
         EqzbPJ27ha5uuA5dD4eWC5x4bnQm2dXKCPOIUCsh9X5bwNR6pcxH75weiTQCpoYltlg7
         sQEfA/pe05StEKv6wPPfQj/vL2PrJ+iRakkZTrPY5h/W/OEp6eNUlTnuTnmkIjHU4Iu5
         SyCDZYGLgQgwc/+OPB/VhVpjpH12uSeNjlgOfO62694F9G+55xkEiaQOOpWNTgV49gzS
         01L/T4/fJWEUEY9jXOeGvSJcIgHvK3EgvFNHGPnvijIpYyxwzDWzKvGSQ5i96xfRbKBl
         8qAg==
X-Gm-Message-State: AOAM531+Gxq1IJ4TV68eKrIFsabvy4kgDviXyZzd154Tf3GpbvPmEPe4
        3HQ5/sDmONPs4+Jhc1bIaDKshQ==
X-Google-Smtp-Source: ABdhPJwFEbDp90twCYghn5oLUkLCFVun6uZCt6miEtgAklE+YknNQn1Yr84/GZogs9w3ATYtK2Llbg==
X-Received: by 2002:aca:af94:: with SMTP id y142mr4617393oie.89.1599952872450;
        Sat, 12 Sep 2020 16:21:12 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id h10sm1028981otq.32.2020.09.12.16.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 16:21:11 -0700 (PDT)
Date:   Sat, 12 Sep 2020 18:21:09 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Stultz <john.stultz@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH 3/6] irqchip: Introduce IRQCHIP_HYBRID_DRIVER_{BEGIN,END}
 macros
Message-ID: <20200912232109.GG3715@yoga>
References: <20200912125148.1271481-1-maz@kernel.org>
 <20200912125148.1271481-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912125148.1271481-4-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12 Sep 07:51 CDT 2020, Marc Zyngier wrote:

> Although we are trying to move to a world where a large number
> of irqchip drivers can safely be built as platform drivers
> the reality is that most endpoint drivers are not ready for that,
> and will fail to probe as they expect their interrupt controller
> to be up and running.
> 
> A halfway house solution is to let the driver indicate that if
> it is built-in (i.e. not a module), then it must use the earily
> probe mechanism, IRQCHIP_DECLARE() style. Otherwise, it is a
> normal module implemenenting a platform driver, and we can
> fallback to the existing code.
> 
> Hopefully we'll one day be able to drop this code altogether,
> but that's not for tomorrow.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/irqchip.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
> index f8f25e9f8200..31fc9d00101f 100644
> --- a/include/linux/irqchip.h
> +++ b/include/linux/irqchip.h
> @@ -50,6 +50,18 @@ static struct platform_driver drv_name##_driver = {		\
>  };									\
>  builtin_platform_driver(drv_name##_driver)
>  
> +#ifdef MODULE
> +#define IRQCHIP_HYBRID_DRIVER_BEGIN(drv)	\
> +	IRQCHIP_PLATFORM_DRIVER_BEGIN(drv)
> +#define IRQCHIP_HYBRID_DRIVER_END(drv)		\
> +	IRQCHIP_PLATFORM_DRIVER_END(drv)
> +#else
> +#define IRQCHIP_HYBRID_DRIVER_BEGIN(drv)	\
> +	_OF_DECLARE_ARRAY_START(irqchip, drv)
> +#define IRQCHIP_HYBRID_DRIVER_END(drv)		\
> +	_OF_DECLARE_ARRAY_END;
> +#endif
> +
>  /*
>   * This macro must be used by the different irqchip drivers to declare
>   * the association between their version and their initialization function.
> -- 
> 2.28.0
> 
