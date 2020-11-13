Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D52B18C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgKMKJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgKMKJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:09:24 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E842FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:09:23 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so9168686wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OETRCzwRxEH0WVz90jhYLPds2AFkgQsQG0z89o37SRA=;
        b=YWgnbQASlUTQjWNWTmFgr8RiYMx/W4+rBQTcKwzjJeFb3i0rLJQ6tv+YQJ+HAsBeyr
         xG5K8fMPqyXcxDguJ6OKoAjzAIZkobWOF+m/QUU2mKjf6poODacFoHyGXKLAqUku6tKd
         KX0goflE1QSOKF1FIwTllrnF1dn/oXlC9iQEy8jDLrie8dnfgOmA0+Sz7ruEhNWwXNvb
         D3lNMjMZTJLUwnMAQiVVqFtKwQzTtj6W5SwsLykBeNMVglhegCmAkFoue1YF4PXIcm8q
         X2s2G/CzbdXWlZcxoME56Q5jVm5oTOUrbfvSxEQB05Xc7fUuHtwpN74NkZg+1e8OVCHu
         zMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OETRCzwRxEH0WVz90jhYLPds2AFkgQsQG0z89o37SRA=;
        b=E45YcgOgzNDYd7hyJ7zyme+QD5zKImo/INPNyyI5vu3bEd7fqeRwEpBS2dT3IbSWMs
         6ojsveCyYxoiXykk63+wTmJ7i5UXYhbSOZzxvDkA46S9W9a2AGrbHc9Am2cZJnHUju0l
         sTGJfd+Jzc6aePEFGwTbEGhmOEgQDWb0ECDihdP5BkOH7Ms2w5P9N5QbpnyKPC5Haimt
         5nHQQo5MEEjzflQllJ9YXO8S12ULMt1dCMmEeC8xx8+FgzmZweTQoONQeCFhfs1RaFga
         +JQozick1YgTOxHdg2g5zID8V3rQjfqfc8UxJ+h/l6qlnOt6miRHBlyA+dyVe00sJwyV
         E7xQ==
X-Gm-Message-State: AOAM531TyePYXTR8QAq+xzPnpLNgNDrMPQnFCDBIJZSDBY2vSnLJG31t
        5ZPdmnxRgoELZ85Ml9kz/CZ/mA==
X-Google-Smtp-Source: ABdhPJzpiNtAsMRhnqL5zdvoHbBm++WPqoCYlSzfGBr8Be3NDq3tGFfNkdYAW1qy6eaU3D3OAB2JEQ==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr2395767wrs.129.1605262162695;
        Fri, 13 Nov 2020 02:09:22 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id s9sm11848119wrf.90.2020.11.13.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:09:21 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:09:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mfd: stmfx: fix dev_err_probe call in stmfx_chip_init
Message-ID: <20201113100919.GC3718728@dell>
References: <20201110080400.7207-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110080400.7207-1-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Amelie Delaunay wrote:

> ret may be 0 so, dev_err_probe should be called only when ret is an error
> code.
> 
> Fixes: 41c9c06c491a ("mfd: stmfx: Simplify with dev_err_probe()")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/mfd/stmfx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
> index 5e680bfdf5c9..360fb4646688 100644
> --- a/drivers/mfd/stmfx.c
> +++ b/drivers/mfd/stmfx.c
> @@ -329,12 +329,11 @@ static int stmfx_chip_init(struct i2c_client *client)
>  
>  	stmfx->vdd = devm_regulator_get_optional(&client->dev, "vdd");
>  	ret = PTR_ERR_OR_ZERO(stmfx->vdd);
> -	if (ret == -ENODEV) {
> +	if (ret == -ENODEV)
>  		stmfx->vdd = NULL;
> -	} else {
> +	else if (ret)
>  		return dev_err_probe(&client->dev, ret,
>  				     "Failed to get VDD regulator\n");
> -	}

Probably nicer to keep all of the error handing in one area, like:

	if (ret) {
		if (ret == -ENODEV)
			stmfx->vdd = NULL;
		else
			return dev_err_probe(&client->dev, ret,
					     "Failed to get VDD regulator\n");
	}

I'll let you make the call though.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
