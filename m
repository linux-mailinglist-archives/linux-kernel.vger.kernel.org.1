Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D55303F92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405663AbhAZODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392686AbhAZOCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:02:14 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C652C061A31
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:01:34 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id s2so14047867otp.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NHa1jl4XStlNfdm47A2wF7pRtMVv0tqg694ijeAKGgo=;
        b=g48UNgtY8ZF9l+UqD4BTLmVeRhst8Pa1/qJsYTnCprsve24Bn1PuxRDF408fhTOAbc
         RDSGqwKhkI0m1sWgZpdMYR6G5g9COhZWbrxvhynGVEkweBtuS61qb3dshLM7n5vLNFEl
         fZ1z/YV7IUR6SItFyy7ksH/+qhQrj25o0ximz3dvVuIPI/SMDHFRMMU6h1aj+vPqkkOD
         JfJrNIoGO3a2bkNf/RH/rke1zU+HKGnW9yR8ycGO7PicvIQMNM1yl9JFLdHL8Kn1nh4B
         55bCIPhPhTBpY5aZPfU3eJNmbZoF2df8+bRnUnw9M3OuMtmZCcTf1lvedvRh6J7lxehw
         zy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NHa1jl4XStlNfdm47A2wF7pRtMVv0tqg694ijeAKGgo=;
        b=SIo5Oxa/95fxagARt+7nUPj47nGYsVWjODvHTCJ1GWI6EugBHBRSqASRmqvlLrxJGd
         QdQ4/FwoyIzOZFSmDuLiETSB5yZriCcnO1ScvYZSfWsH0M9waslDikA/dzZDMq67Fv/o
         GgetPWikhQHZwp+HaA7esRE0A+7f4ZmaGd1Y1opO8hRIQ3/4IilJX6mBp5N3+/E71tvw
         VElX2d9KMRxGA5zC0RuOgMPSeGa4eEIMSnx9D3aFv1Xj6Bkl4IdE7Fm3vp+yTY+WktXW
         Do2khS45hWdf9WT20ttyKUyaAlzBeg3qB40rU1amWN0Ibyi22oPklMaAB3m7WxZseybu
         SdVQ==
X-Gm-Message-State: AOAM532uNfPd3Y9RHmBKFlGRDapkF/kH5y7R43WNl7WUFHD4CUyw6Uwk
        8Bfb41FTWrJFvnekfaJ9i6VW3w==
X-Google-Smtp-Source: ABdhPJx8qKP3uJzg1vWvJWHFk8p3ugyjVEg/omR7n0I6N2mia7sWVH4kq6wxy0T3NTsKCzKM1uieYw==
X-Received: by 2002:a05:6830:1041:: with SMTP id b1mr3997810otp.335.1611669692143;
        Tue, 26 Jan 2021 06:01:32 -0800 (PST)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z8sm3858515oon.10.2021.01.26.06.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 06:01:31 -0800 (PST)
Date:   Tue, 26 Jan 2021 08:01:29 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 13/21] clk: qcom: gcc-ipq4019: Remove unused variable
 'ret'
Message-ID: <20210126140129.GD1241218@yoga>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-14-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126124540.3320214-14-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Jan 06:45 CST 2021, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/clk/qcom/gcc-ipq4019.c: In function ‘clk_cpu_div_set_rate’:
>  drivers/clk/qcom/gcc-ipq4019.c:1279:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-clk@vger.kernel.org

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/clk/qcom/gcc-ipq4019.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
> index ef5137fd50f3f..8abad4032de71 100644
> --- a/drivers/clk/qcom/gcc-ipq4019.c
> +++ b/drivers/clk/qcom/gcc-ipq4019.c
> @@ -1276,16 +1276,15 @@ static int clk_cpu_div_set_rate(struct clk_hw *hw, unsigned long rate,
>  	struct clk_fepll *pll = to_clk_fepll(hw);
>  	const struct freq_tbl *f;
>  	u32 mask;
> -	int ret;
>  
>  	f = qcom_find_freq(pll->freq_tbl, rate);
>  	if (!f)
>  		return -EINVAL;
>  
>  	mask = (BIT(pll->cdiv.width) - 1) << pll->cdiv.shift;
> -	ret = regmap_update_bits(pll->cdiv.clkr.regmap,
> -				 pll->cdiv.reg, mask,
> -				 f->pre_div << pll->cdiv.shift);
> +	regmap_update_bits(pll->cdiv.clkr.regmap,
> +			   pll->cdiv.reg, mask,
> +			   f->pre_div << pll->cdiv.shift);
>  	/*
>  	 * There is no status bit which can be checked for successful CPU
>  	 * divider update operation so using delay for the same.
> -- 
> 2.25.1
> 
