Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99EE2B7524
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgKRD7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgKRD7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:59:52 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6769C061A52
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:59:51 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id 123so79817ooi.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AYUDfsjz/BiPdriQRvZgCzt0EKnDewedXAzX2qb1/N8=;
        b=ZeWlVK12FMlxSle4OgP3joqmV7i1gWw/cOqbXjFBDI7BZN2qdX6GoWCFFGjcrfOobN
         +c1smv+vIDCFf3NLdkduY2Gqm10hQDi1a3RRrW/DWlDnd1LMh4/Ca62uX3fKp0Rw6y8m
         5ZJbDcwQ3e4qLRsUqSQ2NiQGSTFMey1YnJNhUyqccPfTLMV40UiQjGE6ARZ9Y/7LTnv7
         WZpwDS7iI90DCfbW72QdN7amTrHRRkNDa54wUEYkZ5rAw4IucLQbtqwL0m/K9yJtJrWB
         njfHe4XYyLMSPy2DRqrvzJv/PlxeZFmodepGNI1fGc2pWO+DeXhqwyMnU372QlZXoG6u
         cMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AYUDfsjz/BiPdriQRvZgCzt0EKnDewedXAzX2qb1/N8=;
        b=oYqpGv6MiziCYEvrCf2u/h/T6jDdxjGyxaLnxxuxWETSbChdWl14FyzXuGUmg8f9Ru
         cc3YDg6cnF+gkaf7uEkvwGzyv7pcrG4t1igTiSj7daUGg527izc43xvwyrT++gLkaHti
         y7bhLE0fZQls3nNE3fglYkLjCA0is5Jmmtv/GLSZDzvK2F6zzRzB90KFJOjqTY8Wa37D
         ZbYu+GvN02B4DfFJfjPrOpg3c2Kyzr/aldEyjhJJlQ/lq8eVHsENfz1GCYinKnM+Bp+o
         joZ0WkASyUUD774BqhZzGS6TD2F053ADXIgApRloplsfRySJbP1DeEBQE3FFsh8X+JSD
         rifw==
X-Gm-Message-State: AOAM530vlB/Sh+mjMyn1ontk9Ekt8djRyYXorZVabE8SeSCx8nnEa+5f
        glXSoLDDxzyupP+EzHOcFQ+6AwV9UOaWuQ==
X-Google-Smtp-Source: ABdhPJxSGvTwJcqUsn9umVLb9zsdDT5WaMv2VN0KIZqNoStysEXnmPXdZdWB2GDVBCnKwkKKqFBpQw==
X-Received: by 2002:a4a:c4c7:: with SMTP id g7mr5106094ooq.50.1605671991154;
        Tue, 17 Nov 2020 19:59:51 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c18sm6159529oob.45.2020.11.17.19.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 19:59:50 -0800 (PST)
Date:   Tue, 17 Nov 2020 21:59:48 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/6] clk:qcom:rpmh: Add CE clock on sdm845.
Message-ID: <20201118035948.GB8532@builder.lan>
References: <20201117134714.3456446-1-thara.gopinath@linaro.org>
 <20201117134714.3456446-3-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117134714.3456446-3-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17 Nov 07:47 CST 2020, Thara Gopinath wrote:

> Qualcomm CE clock resource that is managed by BCM is required
> by crypto driver to access the core clock.
> 

' ' after ':' in $subject

With that
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
bjorn

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index e2c669b08aff..7e2a4a9b9bf6 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -349,6 +349,7 @@ DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 1);
>  DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 1);
>  DEFINE_CLK_RPMH_VRM(sm8150, rf_clk3, rf_clk3_ao, "rfclka3", 1);
>  DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
> +DEFINE_CLK_RPMH_BCM(sdm845, ce, "CE0");
>  
>  static struct clk_hw *sdm845_rpmh_clocks[] = {
>  	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
> @@ -364,6 +365,7 @@ static struct clk_hw *sdm845_rpmh_clocks[] = {
>  	[RPMH_RF_CLK3]		= &sdm845_rf_clk3.hw,
>  	[RPMH_RF_CLK3_A]	= &sdm845_rf_clk3_ao.hw,
>  	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
> +	[RPMH_CE_CLK]		= &sdm845_ce.hw,
>  };
>  
>  static const struct clk_rpmh_desc clk_rpmh_sdm845 = {
> -- 
> 2.25.1
> 
