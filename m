Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE65B2C7ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 08:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgK3Hi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 02:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgK3Hi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:38:56 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8FC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 23:38:10 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so9585844pgb.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 23:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zqORJcmDJ1AgWtgYHspX89LdBHo9lEgPh4buKMK9tNA=;
        b=nXNPFdReGMplPYFRYLM9zyj5bz9NOclZxuBJBgH9kqYsSm/QrO7Qlq7mHNr43bnpzg
         uydFzMU0xScp+zIBuDWwXoTdaCaqK1pFpQLPACcDRcgQ/z+CCHu2wrFNi9lr8ceHiEJr
         ZhuykA6wQo3gw18MzNZEfblzB57H/8Ttajk6Qi0EPM5Id1fjLx99KIHjvD8BbjVr/zf2
         8xIgme0QJcIFoc4QlQQluFpnICyOERwhh9iD6f1XrPHPpk254HU4fU70bnaEB2lMENZq
         ywZfrdpuGmVw9b/uD9f1koM/SJ1fgKuUL8mwg7BUgMX1ubLRiUPeVAn8CjAEHozY7A0F
         e7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zqORJcmDJ1AgWtgYHspX89LdBHo9lEgPh4buKMK9tNA=;
        b=DIKpxh6V7m49YuVLoUTvOACmAQC0op8EzO85+pxxGxNJjOn9BVibQOWWxfdtU9dx91
         3Oczd8g6f6YWFkDdWPcjoIB8ainhl5I1z5Rp8uWKFZE9zuLSpVZ84YTbE7wnwnXnP65g
         kBNaJPvt77eluFUmHywQfLCMcET/ivyztQw8Meqxzfwr4PoIy5VX5M+Bf6qsr8ogdwlj
         AqBX79L8JKqqPn0ypQehaYiRXHPU2nNAzu8tOFcy8OZoMCpRmsw9C5NtB6KPInsmepL4
         Oph3wTYgF2+Dvb48MhsbfJe5jq2EySZH8vm46cP9xMm/qA1Zg/eF2XBmu6jtEwOMA6s8
         8auw==
X-Gm-Message-State: AOAM53224SU59mp4HzcbVZ2uTBqVR7S6SPmdbBsN6vhl9itWIkzEdWbD
        Tri0kjiizZGNjK19k0J8Q1hw4w==
X-Google-Smtp-Source: ABdhPJwpW5f8HJAe/CejgytJa4+dQsLWTHgHgm7Um98KNJ1Olm/bXXSQN7cSXEGPVOpiXCKNVHNLKg==
X-Received: by 2002:aa7:8e84:0:b029:197:c748:7a0f with SMTP id a4-20020aa78e840000b0290197c7487a0fmr17889497pfr.31.1606721889953;
        Sun, 29 Nov 2020 23:38:09 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id gz2sm543443pjb.2.2020.11.29.23.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 23:38:09 -0800 (PST)
Date:   Mon, 30 Nov 2020 16:38:05 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 14/27] mmc: sdhci-uhs2: skip
 signal_voltage_switch()
Message-ID: <20201130073805.GE48535@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-15-takahiro.akashi@linaro.org>
 <d2bb08b8-b3d0-3956-70ff-a21ab8a0fe30@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2bb08b8-b3d0-3956-70ff-a21ab8a0fe30@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 10:16:44AM +0200, Adrian Hunter wrote:
> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> > For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
> > so no voltage switch required.
> > 
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 2bf78cc4e9ed..1eca89359351 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -178,6 +178,29 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
> >  
> > +/*****************************************************************************\
> > + *                                                                           *
> > + * MMC callbacks                                                             *
> > + *                                                                           *
> > +\*****************************************************************************/
> > +
> > +static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
> > +						  struct mmc_ios *ios)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +	/*
> > +	 * For UHS2, the signal voltage is supplied by vdd2 which is
> > +	 * already 1.8v so no voltage switch required.
> > +	 */
> > +        if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> > +             host->version >= SDHCI_SPEC_400 &&
> > +             host->mmc->flags & MMC_UHS2_SUPPORT)
> 
> Could this be the same helper function suggested elsewhere i.e.
> 
> 	if (!sdhci_uhs2_mode(host))


ditto. I'd defer the change until some time later.

-Takahiro Akashi

> 
> > +                return 0;
> > +
> > +	return sdhci_start_signal_voltage_switch(mmc, ios);
> > +}
> > +
> >  /*****************************************************************************\
> >   *                                                                           *
> >   * Driver init/exit                                                          *
> > @@ -186,6 +209,9 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
> >  
> >  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  {
> > +	host->mmc_host_ops.start_signal_voltage_switch =
> > +		sdhci_uhs2_start_signal_voltage_switch;
> > +
> >  	return 0;
> >  }
> >  
> > 
> 
