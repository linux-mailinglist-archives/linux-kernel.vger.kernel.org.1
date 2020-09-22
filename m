Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED1274B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIVVtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:49:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CDDC0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:49:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so15376335ljp.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YyT3Cqj49TWLOGm0xlbDdLx8xJJ2VmHIBnxNCQNfr+8=;
        b=ijq884l+tRHc9b5yBCIKcy0PdJF9gVxr67m+oS3g/jGEcajKNEV+yzDDuII6GBXNA2
         kdmrCv0CNxj4TwKLPpuE9QxdokL09sjjdjxsLfRMvhTRLfkMTcYYuq0QdpLHPT+0tm/B
         AI0vaXE5w7flwhZc+x5QTFyrPzzrBNhgmfCTdKI/asZTclqF/e1EtDJQ3GvMNCTxpjeI
         aBIclP8F1DROshY06R/q7EmeHDclZkhTf0t2dYsrxMW6gPdtbA5am/V5BmWVj6W0D/VW
         3wa7SpX0jOzn7Zx3nea0GzfsrHnvZgdjjdzKvbm/Fq0pGEtXuANpkFRd1BuNiYq4lCoj
         Hgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YyT3Cqj49TWLOGm0xlbDdLx8xJJ2VmHIBnxNCQNfr+8=;
        b=qBFKIyurAy8ApTJOyJPIB8laOwKkepq2h7jAJ8ZNLp72DkiiT1MaXjLmtYA5nfmbco
         2L8EQ4/Lm4f42pCKYBAgfpre2W85lpPHqwSAHtFnPoTLuADhVu8dQbPvJQiFU02Vh+An
         4ZbO7ydgYEiV7tQ7nyAGhlpbzRZaT9GQG6gJHbmq4oCXeNx9qNohd/UnlOf1mfy27e21
         8Fb0OTq4Ea/02UWhJh/mfGp/W9sT7OL5uuOK57NkJVNRnls/noNyk9pgjP1qoihxzPuz
         GybuNwI8C9G2QKKGLSH2XOyLMADWd5OxPprtBJRK/mFbucKKIU/2vEM41U0CR7XgOMnw
         BIdw==
X-Gm-Message-State: AOAM5315YTFLvTX2dTouZ79Th4m7w8fb9lUKQdD+afKZeTiNxO5WCGzK
        h8vDeNcbEdDk8oURPiWENXPDQXPibjV1vg==
X-Google-Smtp-Source: ABdhPJx8yNE+u6mtpmZmCr8b6V1cSsLYwrxMiPnor/XnMrQIT/t+7IrzJ2/xbJK1Rufl7QO60iXY5Q==
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr2304219ljj.368.1600811354955;
        Tue, 22 Sep 2020 14:49:14 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.186])
        by smtp.gmail.com with ESMTPSA id w30sm664526lfn.102.2020.09.22.14.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 14:49:14 -0700 (PDT)
Subject: Re: [PATCH 3/4] clk: qcom: Add support to LPASS AUDIO_CC Glitch Free
 Mux clocks
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200917132850.7730-1-srinivas.kandagatla@linaro.org>
 <20200917132850.7730-4-srinivas.kandagatla@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <fd524c82-592c-fa41-f9bb-8693b68e4caf@linaro.org>
Date:   Wed, 23 Sep 2020 00:49:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200917132850.7730-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2020 16:28, Srinivas Kandagatla wrote:
> GFM Muxes in AUDIO_CC control clocks to LPASS WSA and RX Codec Macros.
> This patch adds support to these muxes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/clk/qcom/Kconfig            |   7 +
>   drivers/clk/qcom/Makefile           |   1 +
>   drivers/clk/qcom/lpass-gfm-sm8250.c | 235 ++++++++++++++++++++++++++++
>   3 files changed, 243 insertions(+)
>   create mode 100644 drivers/clk/qcom/lpass-gfm-sm8250.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 2eda63b7c46c..4e46fd339e62 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -494,4 +494,11 @@ config KRAITCC
>   	  Support for the Krait CPU clocks on Qualcomm devices.
>   	  Say Y if you want to support CPU frequency scaling.
>   
> +config CLK_GFM_LPASS_SM8250
> +	tristate "GFM LPASS Clocks"

Since this driver can be built as module, few things are missing (see 
below).

> +	depends on SND_SOC_QDSP6_COMMON
> +	help
> +	  Support for the GFM Glitch Free Mux LPASS clock. Say Y
> +	  if you want to support GFM Clocks on LPASS for SM8250 SoC.
> +

[skipped]

> +
> +static const struct of_device_id lpass_gfm_clk_match_table[] = {
> +	{
> +		.compatible = "qcom,sm8250-lpass-audiocc",
> +		.data = &audiocc_data,
> +	},
> +	{ }
> +};

MODULE_DEVICE_TABLE(of, lpass_gfm_clk_match_table);

> +
> +static struct platform_driver lpass_gfm_clk_driver = {
> +	.probe		= lpass_gfm_clk_driver_probe,
> +	.driver		= {
> +		.name	= "lpass-gfm-clk",
> +		.of_match_table = lpass_gfm_clk_match_table,
> +	},
> +};
> +builtin_platform_driver(lpass_gfm_clk_driver);


Wouldn't you like to use module_platform_driver() here, like other LPASS 
CC drivers do?

Also MODULE_LICENSE is missing.


-- 
With best wishes
Dmitry
