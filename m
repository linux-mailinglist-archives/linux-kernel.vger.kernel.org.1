Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9228726F5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIRGiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgIRGit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:38:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905C0C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 23:38:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s65so2898332pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 23:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vl6jNoOplI86V62k3aLjP+X1+cXsvJOTqcdV8LtO++E=;
        b=XGf1OxO8Spx6wBdop0Fb5o8Yt8lcdLCALFBWJeKtDcszm+84YDUFBCnha2coa4emAJ
         DshYC3htBRarytp7JbZOvUiJE0rft3nE35mVSWB4r4EcHxHnXF/TCtZSK+QU5LnRHPgh
         q1sUOg2XTA/ILQIsb9rosD20ZG/q6Rt91+MPKd4cEivb3Q1E1TbBlRvN4MlSBLwXA/RG
         QBlKX2ph1cKd0RbRxOoMgHJc46CL+bz8lkQWq1MsQCgg22T6r6hXL8PTGA7kDlubOXdI
         SMzT9Zz4VmHAMlQ05tpESSqQOAXIuKFQHsZnNhSdTLIHId0KAqGNFWvbNM7jHxP+GJ/U
         wouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Vl6jNoOplI86V62k3aLjP+X1+cXsvJOTqcdV8LtO++E=;
        b=rrY1mnidRjCIkVG5ADbvtBPY0SG7LW+2LTrdkygxLLYpBw+EsinyXFzYYYXdsFcUbD
         i2LK+BcRDo6TqRdg1xNu+YtBTCVR6wz6fVinqKUIn4BcalGxpmW94kdPZDGxcVOaof3s
         RtCkTkgdqlPtbnQXPY99i/ULWm8oGUqy9flOwwaWR3FUcGG+W+HQfwFwS5FXODz3WwlX
         2afdb4RGdMV5NzSA5EpwxtW9Wmlw2D/uKtVwcHVXwnYR3BGM6xKFKhz2w4EdcOn+wMYo
         uYdcMCEouxgUfhLvI0WeyxuQRrbS/RxMxdBzW0MCFXBeJTTm2Ydv0blRdCqPdTotq8Dn
         QbPg==
X-Gm-Message-State: AOAM531vSoYCuF4J13gp8A8YpM+4VBeDJ6yCya2s2aatWKx0OK2GVIhq
        n1snUhiAbvUVrObPWn1N/24EHg==
X-Google-Smtp-Source: ABdhPJymxPAcjmEyJ7McVWYRUU7G9HylU5c8RCkdiLgdzmc/bDSrgFT1SY+OH/zmOtZkHEkfP/sejQ==
X-Received: by 2002:a63:c9:: with SMTP id 192mr26237011pga.37.1600411128917;
        Thu, 17 Sep 2020 23:38:48 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id 203sm1832822pfz.131.2020.09.17.23.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 23:38:48 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:38:43 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
Message-ID: <20200918063843.GA46229@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111054.29562-1-benchuanggli@gmail.com>
 <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian, Ben,

Regarding _set_ios() function,

On Fri, Aug 21, 2020 at 05:08:32PM +0300, Adrian Hunter wrote:
> On 10/07/20 2:10 pm, Ben Chuang wrote:
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > 
> > In this commit, UHS-II related operations will be called via a function
> > pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
> > a kernel module.
> > This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
> > and when the UHS-II module is loaded. Otherwise, all the functions
> > stay void.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

  (snip)

> > @@ -2261,6 +2324,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >  	struct sdhci_host *host = mmc_priv(mmc);
> >  	u8 ctrl;
> > +	u16 ctrl_2;
> >  
> >  	if (ios->power_mode == MMC_POWER_UNDEFINED)
> >  		return;
> > @@ -2287,6 +2351,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  		sdhci_enable_preset_value(host, false);
> >  
> >  	if (!ios->clock || ios->clock != host->clock) {
> > +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +		    ios->timing == MMC_TIMING_UHS2)
> > +			host->timing = ios->timing;
> > +
> >  		host->ops->set_clock(host, ios->clock);
> >  		host->clock = ios->clock;
> >  
> > @@ -2308,6 +2376,18 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  	else
> >  		sdhci_set_power(host, ios->power_mode, ios->vdd);
> >  
> > +	/* 4.0 host support */
> > +	if (host->version >= SDHCI_SPEC_400) {
> > +		/* UHS2 Support */
> > +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +		    host->mmc->flags & MMC_UHS2_SUPPORT &&
> > +		    host->mmc->caps & MMC_CAP_UHS2) {
> > +			if (sdhci_uhs2_ops.do_set_ios)
> > +				sdhci_uhs2_ops.do_set_ios(host, ios);
> > +			return;
> > +		}
> > +	}
> > +
> 
> Please look at using existing callbacks instead, maybe creating uhs2_set_ios(), uhs2_set_clock(), uhs2_set_power()

I think that we will create uhs2_set_ios() (and uhs2_set_power()
as we discussed on patch#15/21), but not uhs_set_clock().

Since we have a hook only in struct mmc_host_ops, but not in struct
sdhci_ops, all the drivers who want to support UHS-II need to
set host->mmc_host_ops->set_ios to sdhci_uhs2_set_ios explicitly
in their own init (or probe) function.
(Again, sdhci_uhs2_set_ios() seems to be generic though.)

Is this okay for you?
        -> Adrian

During refactoring the code, I found that sdhci_set_power() is called
twice in sdhci_set_ios():
        sdhci_set_ios(host, power_mode, vdd1, -1); in sdhci_set_ios(), and
        sdhci_set_ios(host, power_mode, vdd1, vdd2) in ush2_do_set_ios()

Can you please confirm that those are redundant?
        -> Ben

I also wonder why we need spin locks in uhs2_do_set_ios() while
not in sdhci_set_ios().

        -> Ben

-Takahiro Akashi
