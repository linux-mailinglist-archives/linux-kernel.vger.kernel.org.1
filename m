Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5F229F41C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgJ2Scc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:32:32 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46198 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJ2Scc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:32:32 -0400
Received: by mail-ej1-f66.google.com with SMTP id t25so5111636ejd.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sNpdWdbf1Gb7IielAE6DIst8APsqhk3ElFLJYpdio5M=;
        b=PLkCDawNwD1VRxEcvWZxhSoiRE+UHoPaRoavkl+cm8x8W8HdbsossPwLyejKMy1p2J
         ksH4HoR7NDRnGuDUPZNJqz4hUWejaJ8RtqKYjoslbSWjpF766JmuBLYqauvS9lCUq+zM
         rfErGVDe5CXFIt/TBX6ZrUkT31RbdKNsbYbEWo0j4ADZ/9XcTGlwONYcISPDkPMeDAtw
         ou8usVbUMW31TWnTVLfun2b6vhsXYgxCuJEzImtmg1MXSwosBlDsYspUxQVODzIHhDQT
         FZJNOuXOqWaGsdI94jZD1AeZUO/akwdIAnCgdpjbXOYRZx0FNmQouENyo0JjDoL3oknH
         lH6Q==
X-Gm-Message-State: AOAM530McdQ1nBlx5HaFLWGLAMJR8yz/LVhk9Dw1NMw+R/ubEEWFTwiu
        WETp7ZGjgU2Kx7ou+DrPH78=
X-Google-Smtp-Source: ABdhPJwnbTXnLLkyVrr0gQpxi08cex3bPm6yVMlY3XvxpGku1WdNYCqpxYZGwDFKu7D2s4nsZ8pG3w==
X-Received: by 2002:a17:906:8688:: with SMTP id g8mr5506981ejx.535.1603996350538;
        Thu, 29 Oct 2020 11:32:30 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c3sm1957996edl.60.2020.10.29.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 11:32:29 -0700 (PDT)
Date:   Thu, 29 Oct 2020 19:32:26 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BO..." 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] mfd: maxim: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201029183226.GA88922@kozik-lap>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201029100647.233361-1-coiby.xu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 06:06:39PM +0800, Coiby Xu wrote:
> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

I don't quite get what did you mean by "took good care". This should
cause warnings of unused structure.  Comment applies to other patches as
well.

Also, the title prefix is: "mfd: max77686:"

Best regards,
Krzysztof


> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  drivers/mfd/max77686.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
> index 71faf503844b..8c701f8a9dd5 100644
> --- a/drivers/mfd/max77686.c
> +++ b/drivers/mfd/max77686.c
> @@ -227,7 +227,6 @@ static int max77686_i2c_probe(struct i2c_client *i2c)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int max77686_suspend(struct device *dev)
>  {
>  	struct i2c_client *i2c = to_i2c_client(dev);
> @@ -262,7 +261,6 @@ static int max77686_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>  
>  static SIMPLE_DEV_PM_OPS(max77686_pm, max77686_suspend, max77686_resume);
>  
> -- 
> 2.28.0
> 
