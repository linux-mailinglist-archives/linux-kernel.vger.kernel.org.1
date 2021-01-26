Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785AF303F96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405681AbhAZODe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405655AbhAZODI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:03:08 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C53C061D73
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:02:20 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id m13so10593778oig.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iCgywgUomaAnl88OTPiAxB3oreK05N2B2YVxS1nEzMQ=;
        b=Wk6YedfYeIdh3B/aXqkiWd6jXJC/L9Xs3uQZxUwft+3BQ/Peu2TtUYn/LXjc3bmDOI
         eQcZRP7RseyuMJItspflzmBA6VeOCkUF1Q+3HpVlWu4sMQLZk9zh3qShDXc67Z9ohYdD
         146HJSTmJhzeeSVorlgOGJ84lTurhdCK+koPVctLPOysU3HzWAL6H+hYO8H+iS3cQ/wN
         3hriQJkXOT2X6hv6fC5DUj9sfTGWcnU9HEMU7plJuNsOGFtPmkwxWa/qR9oxzfzlaskd
         OPb4GIERodd0JzJ9Amq9lYVV4WychNCeruHndm8LtHuciHoNnYEFdrKYBaIIAxL0ulGs
         e6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iCgywgUomaAnl88OTPiAxB3oreK05N2B2YVxS1nEzMQ=;
        b=RmoZlA+cl6M1ZMJRuVbforhO1Vh/++j/qmC3LvjWTbnpYtoVC1IoEhsCb/OKMHbC9x
         hIPhqs6eiyMKDQiHlbATSRg9Nzjm5/ZTRwNf+/WlZ2/crppwLOlyM8Eet/HX6Np6dTTM
         og+g7M66I4Yoiq1PtNzNRvdcStVS4SuO0jZ2KKOdKpmtsw3MVEY9w+ChIpCaOPiAdnzo
         uUwC+w4VcMhNu4UpA2Z/kFa86o7Y/xawqZNuG4GIKZTPiLGbT1nwdPzYHIGT7Tun4xMk
         7LBzTOkRo0nzfvI6sUnIAJwOMo+3H2WLwcCT8BmI78Uxx4kBAXbyDCFzW2APDN4bB45E
         29Jg==
X-Gm-Message-State: AOAM533EV8Aso/EYl8ARkg8Zf4ntyvEg78Y4IWDOg1RJpwXwG97JNnGF
        6/w3eWNC19entwKJNCuDNMwxkA==
X-Google-Smtp-Source: ABdhPJzDn0bV0+wpWfja0pZ8iNnsNPS2Q3XwgFVEL9ZYwqbfqGSwQGCMQiH9Kc8zeSchbksBkWNR+A==
X-Received: by 2002:aca:4e4f:: with SMTP id c76mr3280084oib.167.1611669739503;
        Tue, 26 Jan 2021 06:02:19 -0800 (PST)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a188sm1902234oif.11.2021.01.26.06.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 06:02:18 -0800 (PST)
Date:   Tue, 26 Jan 2021 08:02:17 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 16/21] clk: qcom: mmcc-msm8974: Remove unused static
 const tables 'mmcc_xo_mmpll0_1_2_gpll0{map}'
Message-ID: <20210126140217.GE1241218@yoga>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-17-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126124540.3320214-17-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Jan 06:45 CST 2021, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/clk/qcom/mmcc-msm8974.c:85:27: warning: ‘mmcc_xo_mmpll0_1_2_gpll0’ defined but not used [-Wunused-const-variable=]
>  drivers/clk/qcom/mmcc-msm8974.c:77:32: warning: ‘mmcc_xo_mmpll0_1_2_gpll0_map’ defined but not used [-Wunused-const-variable=]
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
>  drivers/clk/qcom/mmcc-msm8974.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
> index 015426262d080..a1552b6771bc6 100644
> --- a/drivers/clk/qcom/mmcc-msm8974.c
> +++ b/drivers/clk/qcom/mmcc-msm8974.c
> @@ -74,22 +74,6 @@ static const char * const mmcc_xo_mmpll0_dsi_hdmi_gpll0[] = {
>  	"dsi1pll",
>  };
>  
> -static const struct parent_map mmcc_xo_mmpll0_1_2_gpll0_map[] = {
> -	{ P_XO, 0 },
> -	{ P_MMPLL0, 1 },
> -	{ P_MMPLL1, 2 },
> -	{ P_GPLL0, 5 },
> -	{ P_MMPLL2, 3 }
> -};
> -
> -static const char * const mmcc_xo_mmpll0_1_2_gpll0[] = {
> -	"xo",
> -	"mmpll0_vote",
> -	"mmpll1_vote",
> -	"mmss_gpll0_vote",
> -	"mmpll2",
> -};
> -
>  static const struct parent_map mmcc_xo_mmpll0_1_3_gpll0_map[] = {
>  	{ P_XO, 0 },
>  	{ P_MMPLL0, 1 },
> -- 
> 2.25.1
> 
