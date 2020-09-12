Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DD8267CF2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 01:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgILXWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 19:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgILXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 19:22:33 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C805FC061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 16:22:32 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o8so3876433otl.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 16:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aREu7IoGf48piw+KAC6LJw9YBjm0H1wUXbsHOBWfqAI=;
        b=JAXzNNoa7etdTGwo6+TqUO1Ws/CpDHFVQHf1iiSgH+Brb3fM/o8kM2YDWEDlux/7oK
         o641aurGR2Dr3YBintlZS5kRjFIzhrNuCIJ57gZP777NV1YrHbB0P2z142Ng3K8jQ0bL
         Dt0nfg3z7xKlyIiUgyHoDFN8U5PzdNFLugHKkVQtF9hCoOxsG0zPCe95hxtCTMFH7wZa
         UxZo8lHxHrZecmZDyRjVx64t2kKeBrpkIqMyWdYkt8sMOHt2G/xylStqq8fvW84l/A2S
         BuGo2sjzWjADtM90uQ89ULjAUKXouGm8z8PrSQHsA9T4Iv8Op/d0uPNBCsESjWcanr1M
         uoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aREu7IoGf48piw+KAC6LJw9YBjm0H1wUXbsHOBWfqAI=;
        b=jioWvRrqohc7PHbLCFaUr3ZfxOLAoGYpKL3aD+xVgnH/hOedrww8gWk1dZP0fM1/oC
         GlqoaCYBJEtOc6KP762oRxDNbxY4YFm1FG5pPWA5XyGQBRyAkWg0LjuiOkca4MJ0Ntmb
         TBuaVv1OyDlvIDdBhX2CyM7KKL7Zv115gklPIsu6MlzaG35UIWkbODccvmsOF7/v6JlC
         z3VRjlf9eAJ7ijC8Mn8exCKnfcCplDDidbz81kScoldZcynOpO82GGvRt+HQGcc1lQEi
         y9s4/jfvHK4GuTDNJJRogzrdExMswyNnCol88QSrQwcQZvwsuqcP86MzzQecG2nskKqI
         /FDA==
X-Gm-Message-State: AOAM532Bgobmrvb+5Ln4GC3H5VEhrTnInOf9Eq0BJ8neU3QTAh8zGJv4
        jMOQFo6VHyyghXTREaqQuNJdJg==
X-Google-Smtp-Source: ABdhPJwrzTXwGcHEh+V2vk0qTGrm7hOLM9p0O72DoCOhg4kHP0vMbM68pUI73Ww9XO3p7yGyZXf0FQ==
X-Received: by 2002:a05:6830:124d:: with SMTP id s13mr5057471otp.12.1599952951969;
        Sat, 12 Sep 2020 16:22:31 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id a6sm1027181otf.51.2020.09.12.16.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 16:22:31 -0700 (PDT)
Date:   Sat, 12 Sep 2020 18:22:28 -0500
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
Subject: Re: [PATCH 5/6] irqchip/mtk-sysirq: Allow modular build
Message-ID: <20200912232228.GI3715@yoga>
References: <20200912125148.1271481-1-maz@kernel.org>
 <20200912125148.1271481-6-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912125148.1271481-6-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12 Sep 07:51 CDT 2020, Marc Zyngier wrote:

> Switch the driver to a "hybrid probe" model which preserves the
> built-in behaviour while allowing the driver to be optionnally
> built as a module for development purposes.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-mtk-sysirq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> index 6ff98b87e5c0..ee45d8f71ec3 100644
> --- a/drivers/irqchip/irq-mtk-sysirq.c
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> @@ -231,4 +231,6 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
>  	kfree(chip_data);
>  	return ret;
>  }
> -IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init);
> +IRQCHIP_HYBRID_DRIVER_BEGIN(mtk_sysirq)
> +IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
> +IRQCHIP_HYBRID_DRIVER_END(mtk_sysirq)
> -- 
> 2.28.0
> 
