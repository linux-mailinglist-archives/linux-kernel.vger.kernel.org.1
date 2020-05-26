Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8E1C5DB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 18:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgEEQiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 12:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbgEEQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:38:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B10C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:38:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so1406615pje.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=luCcYzibiHAqsrwgIRj3POtmDDa35yugcUIsAAOot40=;
        b=MAyGVAMZyJo/oMcQG84PQl4YbqtAG2c7SWxWjvlORg+zAKlaMVkPh6jZcKqjxiiqkU
         j1EpVWllG9hKR0QcAtWtOnnDl6jHvEDz8IvUsJp+pNyztK/bEj93JS0MtKNqcbf8rnA8
         TdQN3YzhjTKjkOKPPsrx9bObDHOZ9LsGAto+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=luCcYzibiHAqsrwgIRj3POtmDDa35yugcUIsAAOot40=;
        b=RJZoQ2VfmI23Tujzh55Cl8eeK0HvTjlVATmNMuC1uJKOKrrvOdTC2CSyUd607i1hCC
         X4W4smaT4DMXvyaNszetASRx0Q7xPC0ja6QE926yZ5xistx837n0NYNA6SvsSDbyX6LD
         89rLI2tAWaBTcD7dSZ40F8dn6aIajvv35wxkquqhAVGUoL7SGqpEtlFV8JBt/M7H8PpE
         l+WKbze4StzVzJrSKSA4WE+3kzMYibrLAJZ/f8ln11+g+TLlBQtDimTYEmZvgn1VV/F+
         eAQ3eCoee9p94TcBoNlOHKCH+JlawniTUAXo3+5G1sx/wE0KPX0e+Azf6pBMG1QYyynK
         v3sQ==
X-Gm-Message-State: AGi0PuaLAAGCGtwYKBjQComZ2MetcNcoQFmyTMIAyXzLOoiHJfVYKiYr
        drZrBKfzE8wSk1Zu1tDkpIeN4Q==
X-Google-Smtp-Source: APiQypLHwVgFzIc6p5rvaNU2w6BbNNq4RXORPRe2429s/tVbdXYceAvmwdEyYfv4yP/+tX8H/T5eCA==
X-Received: by 2002:a17:90b:1111:: with SMTP id gi17mr4096115pjb.121.1588696693595;
        Tue, 05 May 2020 09:38:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id p190sm2522949pfp.207.2020.05.05.09.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 09:38:12 -0700 (PDT)
Date:   Tue, 5 May 2020 09:38:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200505163811.GW4525@google.com>
References: <1588507469-31889-1-git-send-email-rnayak@codeaurora.org>
 <1588507469-31889-7-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588507469-31889-7-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajendra,

On Sun, May 03, 2020 at 05:34:29PM +0530, Rajendra Nayak wrote:
> QSPI needs to vote on a performance state of a power domain depending on
> the clock rate. Add support for it by specifying the perf state/clock rate
> as an OPP table in device tree.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Cc: linux-spi@vger.kernel.org
> ---
>  drivers/spi/spi-qcom-qspi.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 3c4f83b..eb53c00 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -8,6 +8,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_opp.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
>  
> @@ -139,6 +140,8 @@ struct qcom_qspi {
>  	struct device *dev;
>  	struct clk_bulk_data *clks;
>  	struct qspi_xfer xfer;
> +	struct opp_table *opp_table;
> +	bool has_opp_table;
>  	/* Lock to protect xfer and IRQ accessed registers */
>  	spinlock_t lock;
>  };
> @@ -235,7 +238,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
>  		speed_hz = xfer->speed_hz;
>  
>  	/* In regular operation (SBL_EN=1) core must be 4x transfer clock */
> -	ret = clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);
> +	ret = dev_pm_opp_set_rate(ctrl->dev, speed_hz * 4);
>  	if (ret) {
>  		dev_err(ctrl->dev, "Failed to set core clk %d\n", ret);
>  		return ret;
> @@ -481,6 +484,20 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  	master->handle_err = qcom_qspi_handle_err;
>  	master->auto_runtime_pm = true;
>  
> +	ctrl->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
> +	if (IS_ERR(ctrl->opp_table)) {
> +		ret = PTR_ERR(ctrl->opp_table);
> +		goto exit_probe_master_put;
> +	}
> +	/* OPP table is optional */
> +	ret = dev_pm_opp_of_add_table(&pdev->dev);
> +	if (!ret) {
> +		ctrl->has_opp_table = true;
> +	} else if (ret != -ENODEV) {
> +		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
> +		goto exit_probe_master_put;
> +	}
> +
>  	pm_runtime_enable(dev);
>  
>  	ret = spi_register_master(master);
> @@ -488,6 +505,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  		return 0;
>  
>  	pm_runtime_disable(dev);
> +	if (ctrl->has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(ctrl->opp_table);
>  
>  exit_probe_master_put:
>  	spi_master_put(master);
> @@ -498,6 +518,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>  static int qcom_qspi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
> +
> +	if (ctrl->has_opp_table)
> +		dev_pm_opp_of_remove_table(&pdev->dev);
> +	dev_pm_opp_put_clkname(ctrl->opp_table);

IIUC there can still be active transfers before the controller is
unregistered. If that is correct the above should be done after the
spi_unregister_master() call below.

>  
>  	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
>  	spi_unregister_master(master);
> @@ -512,6 +537,8 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
>  
> +	/* Drop the performance state vote */
> +	dev_pm_opp_set_rate(dev, 0);
>  	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);
>  
>  	return 0;
