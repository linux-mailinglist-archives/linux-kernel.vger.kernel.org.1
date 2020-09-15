Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13C626B27A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgIOWsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbgIOPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:45:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8BDC061797
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:44:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 16so4684102qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jr9FyPebxkKqG5Q+7PXT2kwXR4HeYkXnIjay9uV7M3A=;
        b=rFHVNAT/L/p+uTassh8kWHyPPmM6zU7jhMji4JUNPpHOH6vp7+SknoNXEUaxITlZJo
         C47l3vrn5M1foQsDyM7MD13TTYbOSoz+k3xxYu2RBF/1DXBmgX5hCizpgqmu7GxO2Qn7
         t+UA0UhrW0z+v7akhpkjQXmNzcd1NdyF9egZIXmLbC6cB5UgKlerScIbcv3AVVTn3Fsc
         SIOsbC7nIY+6OOkvdDsfHVxDKHqeJrx5J2v8OoZnq5BvJ7UDU5nXuKIkPxIn3QTCEXTN
         jo8hO5NeFIqIKE2GyopxS/cZDkUROZKl0oZCNrBm7aRWQrRt7F4pkll8G1GT259vH8V6
         gV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jr9FyPebxkKqG5Q+7PXT2kwXR4HeYkXnIjay9uV7M3A=;
        b=c7bCQx2eJqZeFI1SPjZwPF90cuvhv64BRYUnw9IhO1wFeQ6qY+IpUTtWUGdh89uEYD
         7+r/uIpjbSbOKArEz5p/LqPMCqHT6DO3cKdj9eOhvThEJUle/z+tKnNsNHqt6Rm0QqL4
         Q46uJSNl+F2xn6JZs+gGEoVRtWTokJVMZ4LWFkCkLpVvHUZPj5/kj9nDrrEv9MvoEqup
         ll7hoJf8iWWc/35ie1jGlxkuNIYTqh4hWzQQyUumtRLBuSoedCiedrh75MfCHe6kJoeZ
         AuxzbxIstBuf7E1CeiTt3p9TonBzwsvgPr01qmLEgMJqYZqLizkaNWfuh/P8azRlGhLn
         X7ug==
X-Gm-Message-State: AOAM530v2anTxDFtnQm0XMU/4MyYQ2a4CH++s249YwpQx7a8Mt/wG9Sx
        YGGvs1XbsT8kY3amz9bXGulUeA==
X-Google-Smtp-Source: ABdhPJy/FgcqpjL803/QUt6DpehETtocnf+0DIjdU+tNjllUdMmC353O7wtD73sn2n4/M/TjNpyT2Q==
X-Received: by 2002:a37:a054:: with SMTP id j81mr17048838qke.23.1600184697935;
        Tue, 15 Sep 2020 08:44:57 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id n136sm15988518qkn.14.2020.09.15.08.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:44:57 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:44:55 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH] irqchip/qcom-pdc: Allow QCOM_PDC to be loadable as a
 permanent module
Message-ID: <20200915154455.GG478@uller>
References: <20200912125148.1271481-7-maz@kernel.org>
 <20200914210423.67579-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914210423.67579-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Sep 21:04 UTC 2020, John Stultz wrote:

> Allows qcom-pdc driver to be loaded as a permanent module.
> 
> An earlier version of this patch was merged in a larger patchset
> but was reverted entirely when issues were found with other
> drivers, so now that Marc has provided a better solution in his
> Hybrid probing patch set, I wanted to re-submit this change.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/irqchip/Kconfig    | 2 +-
>  drivers/irqchip/qcom-pdc.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index bfc9719dbcdc..bb70b7177f94 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -425,7 +425,7 @@ config GOLDFISH_PIC
>           for Goldfish based virtual platforms.
>  
>  config QCOM_PDC
> -	bool "QCOM PDC"
> +	tristate "QCOM PDC"
>  	depends on ARCH_QCOM
>  	select IRQ_DOMAIN_HIERARCHY
>  	help
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index 8543fa23da10..59eb3c8473b0 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -433,3 +433,5 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>  IRQCHIP_HYBRID_DRIVER_BEGIN(qcom_pdc)
>  IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
>  IRQCHIP_HYBRID_DRIVER_END(qcom_pdc)
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
