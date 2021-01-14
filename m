Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEAC2F6205
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbhANNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbhANNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:30:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F324DC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:29:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c124so4533411wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0bL5QZTB5DHl9yslUNyQ5zVL5BNzW8OLBdt1dFBWcOw=;
        b=MtruYu4ndCuoNcrrnBRmGm87UgDBpI+9cBZv2EsKf9xPrZgSFyd8LTNTyCnNYmc2u3
         vVAuGDRid8pHeMI89DqkqcpcLcdzeQRPGxDfpXE3lQto+GECGDZ/+XZ0GAB9MW+/0ZD7
         Gnrf8g+dWvjH67Ltk8RlPeBZxAKJs/gpI1MxL5a/nAZ5xJ94IxRKD2o/chy4oVUHTV82
         0tzupLnGjwEecusxa/4axTEPn25J00IaweRVW82LTeCaltrxehRUu5YOLhLXddOpB8hI
         6KoqT8DE27P8hTarH1QFdxohYC9t0ASufqWF0T3NNd5bxQnRkLAA8YydDAa5oUacNYZS
         Lh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0bL5QZTB5DHl9yslUNyQ5zVL5BNzW8OLBdt1dFBWcOw=;
        b=bnoyfOHm/hlZWrxyU2HC8nnK1X7j0Sc4Hs0DaNA9EVXt00WouH+TSqmKy/wQy4yBQ2
         ILAecD+1j0cHgHhqeJ14VPDEofhyl0ooS679C4rksbIPOHP4AxF1+KImNYVjylAXJZ4y
         /Vj+2tSsmYeA41rOWqZU0ZK+zyIwl74reEpUnShyKG4E1+VBQ6O5/Xhbj6vAO6s4XbE+
         wC0I6WCXOhqEcFrmo+13oQjTDgJaAJou5YZIdW5ifRs6/hBCVaa1r4uNFbq/yD3QdZv9
         pCdOyfD9W/CvRogGofQqiFMwD4eLA8uPwKjunNxz5/H+B9a0FZvyHYa5SzwAyk5Q0lu4
         Gdig==
X-Gm-Message-State: AOAM533vrqEeTnaaTD8rua44PIZMaMYyTh+NIK2eai5OktcwGkalBl47
        FFbrVZuTOp6Cq8sDH1Ocvj4tihwMijFokJn1
X-Google-Smtp-Source: ABdhPJxeBa81AORK3CZqm4fRo6L9eGK62uXqPIYwIyrk8PIOGYFft/iK7dW3WvILEMmrZshEyw2Acw==
X-Received: by 2002:a1c:9ccd:: with SMTP id f196mr4045624wme.82.1610630987723;
        Thu, 14 Jan 2021 05:29:47 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id b10sm8640359wmj.5.2021.01.14.05.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 05:29:47 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:29:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Meng.Li@windriver.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        Kexin.Hao@windriver.com
Subject: Re: [PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Message-ID: <20210114132945.GX3975472@dell>
References: <20201228020624.4821-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201228020624.4821-1-Meng.Li@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020, Meng.Li@windriver.com wrote:

> From: Limeng <Meng.Li@windriver.com>
> 
> This reverts commit 529a1101212a785c5df92c314b0e718287150c3b.

But you haven't Cc:ed the author of that commit.

You need to do that, please re-send.

> The reverted patch moves the memory free to error path, but introduce
> a memory leak. There is another commit 94cc89eb8fa5("regmap: debugfs:
> Fix handling of name string for debugfs init delays") fixing this
> debugfs init issue from root cause. With this fixing, the name field
> in struct regmap_debugfs_node is removed. When initialize debugfs
> for syscon driver, the name field of struct regmap_config is not
> used anymore. So, revert this patch directly to avoid memory leak.
> 
> Fixes: 529a1101212a("mfd: syscon: Don't free allocated name for regmap_config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/mfd/syscon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index ca465794ea9c..df5cebb372a5 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -108,6 +108,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
>  
>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
> +	kfree(syscon_config.name);
>  	if (IS_ERR(regmap)) {
>  		pr_err("regmap init failed\n");
>  		ret = PTR_ERR(regmap);
> @@ -144,7 +145,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	regmap_exit(regmap);
>  err_regmap:
>  	iounmap(base);
> -	kfree(syscon_config.name);
>  err_map:
>  	kfree(syscon);
>  	return ERR_PTR(ret);

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
