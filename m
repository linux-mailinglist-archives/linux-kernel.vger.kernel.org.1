Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D052D6B29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405132AbgLJWb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 17:31:56 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42742 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405125AbgLJWZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:25:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id l200so7561371oig.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SOuAnc72Sn7TZykeZYnfbLOqNMLPEGEBuVRgnJuNUHU=;
        b=Y1E0caM2MrEJIrcC6goyBRqXU3NareIzJLW/bqAaZTMx4B+XNRmbe2MeoHCy0vQ4HB
         9TPee98s3p9rWX2Em7ccZFOsteWqQf1JMCR/2uLQEWQ9l+NIfa7XhRjkYFY3m+cUc3X0
         MvsXQKf/3pYkKoZpmcJ3MXZyWyqKRwLJt9jtx/xn7qmDpghk3zcXw/QMtG13jd/orak3
         fhkDp3F9JWJDrsHg6wIzIr/fRI84+qb/pJOga9pJ1391GQElc3ag4QqPScUbrNjYOPhO
         OECU5rHqYs0tteGbo5F5I4b7b/SNgUO3+oy0c3yQb0Tc8KPuFbtSfSDj6BUJwuGyNjKM
         ys4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SOuAnc72Sn7TZykeZYnfbLOqNMLPEGEBuVRgnJuNUHU=;
        b=fUggcgqqjXyxWg5OlnmitSDXMdCiRYfVYaywLuF+F6+6+qhf4FOXMQ9VXFuauf8yAm
         rVMljsYkwiqecRc0zKTlXL/MIRTbXaey5t8YgU3s2AtLDS+cfZXnXNZxCPCHm3f8flHf
         8B5BRor77XNuqyuHsF9f+xKfAbFwH2eqnKfIkcbyjIJLb9pcU+xk3bXE5RcD74jSQrgE
         tAxhuJEPBXyQ07PKYVDc8UISPD1s+hc2yyzkVPkroAPohzlMrHyp8RsP7j97g5Yh0LTz
         hFdV/Cz2R8lheHf0xTaDH5xv+PXo7rG3HSK2cAExQNDyKVw+iRkXEHLVsOVGSEg/OIoQ
         SMUA==
X-Gm-Message-State: AOAM531seeSNWMIeHWY561WuoKcMW0/aoVoHOw6Bv496Z1RpmRvqPLSY
        YnnpJ9xNMOs6IMbZ6BdQ41Jz9w==
X-Google-Smtp-Source: ABdhPJy2pfrs1djxuegYy/7NozmqFhBderusUSEjO6fWI+c41iGCQs4pZPUO9/TDszSeI+3W+JMWxA==
X-Received: by 2002:aca:568f:: with SMTP id k137mr7114086oib.138.1607639014184;
        Thu, 10 Dec 2020 14:23:34 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h2sm1394492otn.15.2020.12.10.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 14:23:33 -0800 (PST)
Date:   Thu, 10 Dec 2020 16:23:31 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephen Boyd <swboyd@chromium.org>, vbadigan@codeaurora.org,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v3] mmc: sdhci-msm: Warn about overclocking SD/MMC
Message-ID: <X9Kf40VhaMTZjy9Q@builder.lan>
References: <20201210132745.v3.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210132745.v3.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Dec 15:27 CST 2020, Douglas Anderson wrote:

> As talked about in commit 5e4b7e82d497 ("clk: qcom: gcc-sdm845: Use
> floor ops for sdcc clks"), most clocks handled by the Qualcomm clock
> drivers are rounded _up_ by default instead of down.  We should make
> sure SD/MMC clocks are always rounded down in the clock drivers.
> Let's add a warning in the Qualcomm SDHCI driver to help catch the
> problem.
> 
> This would have saved a bunch of time [1].
> 
> [1] http://lore.kernel.org/r/20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v3:
> - Proper printf format code.
> 
> Changes in v2:
> - Store rate in unsigned long, not unsigned int.
> - Reuse the clk_get_rate() in the later print.
> 
>  drivers/mmc/host/sdhci-msm.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3451eb325513..50beb407dbe9 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -353,6 +353,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  	struct mmc_ios curr_ios = host->mmc->ios;
>  	struct clk *core_clk = msm_host->bulk_clks[0].clk;
> +	unsigned long achieved_rate;
>  	int rc;
>  
>  	clock = msm_get_clock_rate_for_bus_mode(host, clock);
> @@ -363,10 +364,20 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>  		       curr_ios.timing);
>  		return;
>  	}
> +
> +	/*
> +	 * Qualcomm clock drivers by default round clock _up_ if they can't
> +	 * make the requested rate.  This is not good for SD.  Yell if we
> +	 * encounter it.
> +	 */
> +	achieved_rate = clk_get_rate(core_clk);
> +	if (achieved_rate > clock)
> +		pr_warn("%s: Card appears overclocked; req %u Hz, actual %lu Hz\n",
> +			mmc_hostname(host->mmc), clock, achieved_rate);
> +
>  	msm_host->clk_rate = clock;
>  	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
> -		 mmc_hostname(host->mmc), clk_get_rate(core_clk),
> -		 curr_ios.timing);
> +		 mmc_hostname(host->mmc), achieved_rate, curr_ios.timing);
>  }
>  
>  /* Platform specific tuning */
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
