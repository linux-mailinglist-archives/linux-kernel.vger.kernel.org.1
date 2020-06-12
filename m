Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68F1F795D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFLOPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 10:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:15:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0AEC03E96F;
        Fri, 12 Jun 2020 07:15:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so11241958ljv.5;
        Fri, 12 Jun 2020 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jUPXON52cqSIobsRf11C/vw7kKmTCd4Mw6QenfguMkk=;
        b=b+BVs5SQ7G5VNUx71IxUn2irlrb6TLlJrqmq9kpPo7doYjO2oxcEL4LdhbftEOzPA5
         fsvD+fFo5Us0Xk3YfdX8V2d1ppm3m+9EPgmm5+9YM9PlxL1z72PL1MLknlHPV5MkTsq8
         gKwilzuByG4/ujfUfIQ/MpVXdKlMMz90Sd4Q2Q0Yd3FCQHTnzKMEmRxJ3qIyDI+k5pUG
         MG0U/hb7zRwtkZkOyRTckulVRMsMo7lOoL0jBqrFj8DKuycpdi38zaNvS8DKd74Q2m2T
         +KVG1njga0oxFp/iTo+ejngKZdZBiDbnWDMCBzC7D8IeKijY9FDzTvut922J+sqn/JLK
         2dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUPXON52cqSIobsRf11C/vw7kKmTCd4Mw6QenfguMkk=;
        b=Q3nVhIixMFRgBc3HNTDSgY2HEgfT7zWIglX8+Es5b8ibjUkrbpaiLBLuvVRUW0E6LN
         44jpuV+FdTtNX+0+GimEr23l3CtNuwQqnUk06Y1B1L61ucLej9+/yhET/WFEbDnBatY/
         GUjmGvD2BW7NLJEhSirenS5UykSGGARop+VUalupuBqgrMHb57oRtBqzVVw8hhdqgLKJ
         Sb9HlyHjdz9wjJlmsPhSpdMycLaxvn9EtWR6lcNvYsgtMcObad6Af97aZqsXOSopnv0T
         N+RXRhFWhIgFQPXraVDT5m3V4NYdQSM2gcWidLbGSJfHZTOdFrEAtGR2wxMNGkVi+tiF
         0dIA==
X-Gm-Message-State: AOAM531HfvoSRkI5P4DsSZqxel0U4363CusB1iB+Cp0WtQ7ksmPbFRs1
        OepctCqUmY589huN6Fzrla/otw1J
X-Google-Smtp-Source: ABdhPJwSG1HU8X+Y3fxojFr7FuVJjUzgWfMr+hqPDTSPnE+xia2Tebtekt1zoCQQ4YJCr1d7qPZBbQ==
X-Received: by 2002:a2e:8e82:: with SMTP id z2mr6645322ljk.71.1591971340899;
        Fri, 12 Jun 2020 07:15:40 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id k7sm1925629lfd.53.2020.06.12.07.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 07:15:40 -0700 (PDT)
Subject: Re: [PATCH] memory: tegra: Avoid double error messaging when IRQ
 absent
To:     Keyur Patel <iamkeyur96@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200611190758.172605-1-iamkeyur96@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2707086c-e604-d0d6-66fa-072e5844e923@gmail.com>
Date:   Fri, 12 Jun 2020 17:15:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200611190758.172605-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.06.2020 22:07, Keyur Patel пишет:
> Since the commit 7723f4c ("driver core: platform: Add an error message
> to platform_get_irq*()") platform_get_irq() started issuing an error message.
> Thus, there is no need to have the same in the driver.
> 
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index ec8403557ed4..f519c0987485 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -659,10 +659,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
>  	}
>  
>  	mc->irq = platform_get_irq(pdev, 0);
> -	if (mc->irq < 0) {
> -		dev_err(&pdev->dev, "interrupt not specified\n");
> +	if (mc->irq < 0)
>  		return mc->irq;
> -	}
>  
>  	WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
>  
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
