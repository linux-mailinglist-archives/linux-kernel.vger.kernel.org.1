Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774781DEDD7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 19:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgEVREU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 13:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgEVRET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:04:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97537C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:04:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cx22so5191824pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7A6iyO2k2fi02P/NzWp7Gyx0jmN7Am3f02P31ob4Wmc=;
        b=fyFyhTTB5I3oZm7mqgoPivDGwIHsZVBXT7hlfCm1r17aWGihsF/7DzUE5n5ymXQadM
         Xx7DrNWzGZ8CyhoaXlFFGJv4Oa5KZ7s/Q8m408B5BoJdeHhdrZBTAwyVTP7kr5IyJpuV
         w5tRGrTNGRg8OAoytmEfTBcbZw1jsQEQJuRQFji1Duza9xdS03AnksIM3/IJmpPXjaWw
         eQVpxkrKEW4TLCEU/bnHxLoQhSp/fgQlpSUFe4ZBPeZY6GHb+sAE9F77v17eOefUQpBn
         UEPGPMh9UQbyS1c0m0F9/SOY5TuPERV6crAQsDYa0+XtQJ8LoglkV1BKAPWzGgPeDRkT
         Qhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7A6iyO2k2fi02P/NzWp7Gyx0jmN7Am3f02P31ob4Wmc=;
        b=ebVFrJPIXgDd07UYSe15niq1Gx84IxxlSNnuPF4jXWkl4NMGISCb/vPYStaFwbYbQY
         tJ7293HOVQ7Xeyk+HkHbvYQNMvCOk+ScEwEVHiQRljNP3Nkl5U8Cpg0wfB6agPkSpLYM
         Le4kSoTukmIwm2LQQdFLAX/3iy4b+6zgh0Ye3dJPcxrHvHGXAlxZalLwKPI2gybWVKMR
         g+6Re19hIomkyuZyNA69iCn+0JQRDSfzG9FndK5waCQXCh4Cos/Fio8J3Bb1xODPADJz
         oOXmjnBb45YbsLhL3sswKdbvMt494uS/kb3DNdh4U62iyEJoHJ6KYT6G1xF3/XQfrEPA
         9YRA==
X-Gm-Message-State: AOAM533rp9YJ/XzqE9JwpVeNzIWg4TnlTbcAL9vel7Bw1oy9hxpK0uLr
        L8bUwe7bw8wbswEKEfbideTwzw==
X-Google-Smtp-Source: ABdhPJw1bAIOwqeWNM4uyzvNWma2h1I8Plu3ZI448K7S2XdchrZ8hmvPUwbAWaJPRNGNAtIMnEEsqQ==
X-Received: by 2002:a17:90a:2242:: with SMTP id c60mr5861928pje.224.1590167058911;
        Fri, 22 May 2020 10:04:18 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l9sm7757804pfd.5.2020.05.22.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:04:18 -0700 (PDT)
Date:   Fri, 22 May 2020 10:04:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V2 2/3] mmc: sdhci-msm: Use internal voltage control
Message-ID: <20200522170415.GI11847@yoga>
References: <1589541535-8523-1-git-send-email-vbadigan@codeaurora.org>
 <1590074615-10787-1-git-send-email-vbadigan@codeaurora.org>
 <1590074615-10787-3-git-send-email-vbadigan@codeaurora.org>
 <20200521190739.GC1331782@builder.lan>
 <08d11687-7aee-2c62-9435-670be1afb21e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08d11687-7aee-2c62-9435-670be1afb21e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 May 06:27 PDT 2020, Veerabhadrarao Badiganti wrote:

> Hi Bjorn,
> 
> On 5/22/2020 12:37 AM, Bjorn Andersson wrote:
> > On Thu 21 May 08:23 PDT 2020, Veerabhadrarao Badiganti wrote:
> > 
> > > On qcom SD host controllers voltage switching be done after the HW
> > > is ready for it. The HW informs its readiness through power irq.
> > > The voltage switching should happen only then.
> > > 
> > > Use the internal voltage switching and then control the voltage
> > > switching using power irq.
> > > 
> > > Set the regulator load as well so that regulator can be configured
> > > in LPM mode when in is not being used.
> > > 
> > > Co-developed-by: Asutosh Das <asutoshd@codeaurora.org>
> > > Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> > > Co-developed-by: Vijay Viswanath <vviswana@codeaurora.org>
> > > Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> > > Co-developed-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> > > Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> > Looks better, thanks.
> > 
> > > ---
> > >   drivers/mmc/host/sdhci-msm.c | 207 +++++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 198 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > [..]
> > >   static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> > > @@ -1298,6 +1302,71 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
> > >   		sdhci_msm_hs400(host, &mmc->ios);
> > >   }
> > > +static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (IS_ERR(mmc->supply.vmmc))
> > > +		return 0;
> > > +
> > > +	ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);
> > > +	if (ret)
> > > +		dev_err(mmc_dev(mmc), "%s: vmmc set ocr with vdd=%d failed: %d\n",
> > > +			mmc_hostname(mmc), mmc->ios.vdd, ret);
> > Missed this one on v1, in the event that mmc_regulator_set_ocr() return
> > a non-zero value it has already printed an error message. So please
> > replace the tail with just:
> > 
> > 	return mmc_regulator_set_ocr(...);
> > 
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int sdhci_msm_set_vqmmc(struct sdhci_msm_host *msm_host,
> > > +			      struct mmc_host *mmc, bool level)
> > > +{
> > > +	int load, ret;
> > > +	struct mmc_ios ios;
> > > +
> > > +	if (IS_ERR(mmc->supply.vqmmc)			 ||
> > > +	    (mmc->ios.power_mode == MMC_POWER_UNDEFINED) ||
> > > +	    (msm_host->vqmmc_enabled == level))
> > > +		return 0;
> > > +
> > > +	if (msm_host->vqmmc_load) {
> > > +		load = level ? msm_host->vqmmc_load : 0;
> > > +		ret = regulator_set_load(mmc->supply.vqmmc, load);
> > Sorry for the late reply on v1, but please see my explanation regarding
> > load and always-on regulators there.
> 
> <Merging your comment from V1 here>
> 
> >> You should still call regulator_enable()/regulator_disable() on your
> >> consumer regulator in this driver. When you do this the regulator core
> >> will conclude that the regulator_dev (i.e. the part that represents the
> >> hardware) is marked always_on and will not enable/disable the regulator.
> 
> >> But it will still invoke _regulator_handle_consumer_enable() and
> >> _regulator_handle_consumer_disable(), which will aggregate the "load" of
> >> all client regulators and update the regulator's load.
> 
> >> So this will apply the load as you expect regardless of it being
> >> supplied by a regulator marked as always_on.
> 
> Since I'm not turning off this regulator for eMMC, I wanted to keep it in
> LPM mode
> to save some power.
> When the regulator configured in auto mode (RPMH_REGULATOR_MODE_AUTO) it
> switches to LPM/HPM mode based on the active load.
> So i have to minimize my driver load requirement so that I can let this
> regulator
> in LPM mode.
> So i need to set load every-time I disable/enable the regulator.
> 

You call regulator_enable(vqmmc) and regulator_disable() below, so you
are telling the regulator framework that your struct regulator should be
"on" or "off".

This will cause the sum of all struct regulator's for the underlying
struct regulator_dev to be recalculated. So after calling
regulator_disable() below your effective addition to the load
calculation is 0, regardless of which load you have specified.

Independent of this the property regulator-always-on (always_on in
struct regulator_dev) will determine if the enable/disable request will
actually be sent to the RPMh.


So, if you where to not call regulator_disable() for eMMC your argument
is correct, but as far as I can see you are and you're relying on the
regulator core to keep it always-on - and then the load logic is in
effect still.

Regards,
Bjorn

> > > +		if (ret) {
> > > +			dev_err(mmc_dev(mmc), "%s: vqmmc set load failed: %d\n",
> > > +				mmc_hostname(mmc), ret);
> > > +			goto out;
> > > +		}
> > > +	}
> > > +
> > > +	if (level) {
> > > +		/* Set the IO voltage regulator to default voltage level */
> > > +		if (msm_host->caps_0 & CORE_3_0V_SUPPORT)
> > > +			ios.signal_voltage = MMC_SIGNAL_VOLTAGE_330;
> > > +		else if (msm_host->caps_0 & CORE_1_8V_SUPPORT)
> > > +			ios.signal_voltage = MMC_SIGNAL_VOLTAGE_180;
> > > +
> > > +		if (msm_host->caps_0 & CORE_VOLT_SUPPORT) {
> > > +			ret = mmc_regulator_set_vqmmc(mmc, &ios);
> > > +			if (ret < 0) {
> > > +				dev_err(mmc_dev(mmc), "%s: vqmmc set volgate failed: %d\n",
> > > +					mmc_hostname(mmc), ret);
> > > +				goto out;
> > > +			}
> > > +		}
> > > +		ret = regulator_enable(mmc->supply.vqmmc);
> > > +	} else {
> > > +		ret = regulator_disable(mmc->supply.vqmmc);
> > > +	}
> > > +
> > > +	if (ret)
> > > +		dev_err(mmc_dev(mmc), "%s: vqmm %sable failed: %d\n",
> > > +			mmc_hostname(mmc), level ? "en":"dis", ret);
> > > +	else
> > > +		msm_host->vqmmc_enabled = level;
> > > +out:
> > > +	return ret;
> > > +}
