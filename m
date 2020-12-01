Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F18B2C952C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgLAC15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgLAC14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:27:56 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EBCC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 18:27:16 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id l23so295231pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 18:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ta9y/swT35VtKhxTfZV2j6YXFZIC2RzBuLf4MvgxmWk=;
        b=n3Q9N9syDD99I9uMqSd4m6kqwfHlg75lSW91G78qkQaPPx0atgYLB6Vs0DbSN/aZI6
         vz5Dn8Bjq2PzEp8ZmNafPVuogag0nn53yzndVWqzFxCchapnWE/ne3fdTVF6xroUkKzG
         PeYIspFeDjko2NhKQoWY1JmxFay2+Exd3c/aGRT0y5IGYDF2sxI1z1xBioW7kLWfc+lL
         2fTtyCiTcr8g4SyvAX9LG+xKNSHL6sZqGQ+0lgt/MLWIbM+x6q5Fbn6rDQvnfP0axApZ
         DtcBHGIhyCDufsuba1lJedrP3xbD6/j8P/Fi1vV82OXi90S1zrmNIMEVIo/8rhDUosWk
         EaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ta9y/swT35VtKhxTfZV2j6YXFZIC2RzBuLf4MvgxmWk=;
        b=Qy6Ry8676ONuXVllOfKZ5uESclx7TEXCDCgPlr6eYePpivHXtN6tR7oFt0N/IiUP6M
         qb3PHGPgKGFrOwbES9VBSu3A9Mxtw7W4vAM5LbH/7fZwhw4gmafyMdY0M5vTbVrUXtS+
         aQLtoGaP0OOyqahEGBsimdjrf94Le6aU82j+w90N4RBjqKlI45M4oS0TFY0O+k/tnJvs
         u/3atRVzw8FFNrOKCnfqq8Dxg6fnEW1tTGKgyhXd8/6bexQ/CyKVoqnV+WrK2KOBWnik
         KbfIOtnmbG47p1eJQWT+8e8UXWL9Uccr55y6uIBcj/tejTqBd48jJMclREi3YGf6g5v5
         dluA==
X-Gm-Message-State: AOAM531mYai56E3Y5fR/Wb9bIL3fzKEqPPk0fs9Chirqwt2Puj7oxJT4
        rai8VXnk5qgcsi5tb4PszmAmCw==
X-Google-Smtp-Source: ABdhPJy+qtSYBcbF8raBn9CjNSKugPUMhxwhxbhTHo9RabT/9zqd/PA2T2T2Mwq4sDchSmvcphYAzg==
X-Received: by 2002:a17:90b:4b0a:: with SMTP id lx10mr414148pjb.128.1606789636094;
        Mon, 30 Nov 2020 18:27:16 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id q24sm257447pjd.30.2020.11.30.18.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 18:27:15 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:27:11 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 18/27] mmc: sdhci-uhs2: add clock operations
Message-ID: <20201201022711.GB43403@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-19-takahiro.akashi@linaro.org>
 <14ad8c85-0dbb-b023-6a0d-7805cc6f0ab8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ad8c85-0dbb-b023-6a0d-7805cc6f0ab8@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 10:17:59AM +0200, Adrian Hunter wrote:
> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> > This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 41 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 994dff967e85..55362ace1857 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -11,6 +11,7 @@
> >   */
> >  
> >  #include <linux/delay.h>
> > +#include <linux/ktime.h>
> >  #include <linux/module.h>
> >  
> >  #include "sdhci.h"
> > @@ -385,6 +386,42 @@ void sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  	__sdhci_uhs2_set_ios(mmc, ios);
> >  }
> >  
> > +static void sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> > +{
> > +        struct sdhci_host *host = mmc_priv(mmc);
> > +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +
> > +	clk &= ~SDHCI_CLOCK_CARD_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +}
> > +
> > +static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> > +{
> > +        struct sdhci_host *host = mmc_priv(mmc);
> > +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +	ktime_t timeout;
> > +
> > +	clk |= SDHCI_CLOCK_CARD_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +	/* Wait max 20 ms */
> > +	timeout = ktime_add_ms(ktime_get(), 20);
> > +	while (1) {
> > +		bool timedout = ktime_after(ktime_get(), timeout);
> > +
> > +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> 
> Can use read_poll_timeout(sdhci_readw,..., host, SDHCI_CLOCK_CONTROL)

Okay.

-Takahiro Akashi

> > +		if (clk & SDHCI_CLOCK_INT_STABLE)
> > +			break;
> > +		if (timedout) {
> > +			pr_err("%s: Internal clock never stabilised.\n",
> > +			       mmc_hostname(host->mmc));
> > +			sdhci_dumpregs(host);
> > +			return;
> > +		}
> > +		udelay(10);
> > +	}
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > @@ -556,6 +593,10 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  
> >  	if (!host->mmc_host_ops.uhs2_detect_init)
> >  		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> > +	if (!host->mmc_host_ops.uhs2_disable_clk)
> > +		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
> > +	if (!host->mmc_host_ops.uhs2_enable_clk)
> > +		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
> >  
> >  	return 0;
> >  }
> > 
> 
