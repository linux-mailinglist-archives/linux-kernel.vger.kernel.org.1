Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28FF26BCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIPGYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgIPGYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:24:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AECC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:24:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x123so3360931pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/rie8zyej25CbUTYCdPK5j8vwc82yIBnMTMl6LA2cg=;
        b=hvqULrDzJgs3+S0aooJPntAUUTdb7qS0wXqh6JH/i3Q/oT+uxIkisvHUgEloogcuRS
         I8jOXjkVFy073MPIgmd78q1L01Oo08RwX8aiWtAnI99pN1o6dg8IcitHgZN7Fps4xh/Z
         nUpMkEEnQKnFxdqAPI9MMsCPuMf4ll/zFhhgIBGcc3SBLD453gGuWsRermU4Rsfh/qZo
         B63D1scuSqfycQPi08MY/syE65dzagDY9/zq4oVwAaaoftMWrdeF/MVm5pWjnXbCq2De
         HGd2WgvXTaJLJUfZtBdz1qh8+j5cGZArVW7vf/OG8/d+K9J03C1AUavVLDiJ+HNHriLI
         ExlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=e/rie8zyej25CbUTYCdPK5j8vwc82yIBnMTMl6LA2cg=;
        b=aQjVsmd1dY7HT96f3I09RF1iBp0hSZ9rmiIiPPQOq7swsd3QpaOIGOh4iAKKT3W7fc
         TDlhiMPUBgSRkFsaWMdMmX28cs3IzyoqCuzKWbogJPt/h/nDwqOATzXJuhSZeenQSflm
         oqvjxq2pebvI+Siru7zje2BNz52wQBa0zQvG75vuTVFdF3i/qulMxDn7AmG71NAHjtDT
         CEcHiqv1PUg1CQP9jErfzrYQhV/Nwcw4rV5S9yCFEUcDiYtCNyLMK1IsNdPfMYZjiTmC
         aFwP2jmtbCyiM46F/zv6uFhxgAcRq7Fi/59GEx+vCMFzbDKBFONgKiOGH4EMMzB6mi6d
         35wA==
X-Gm-Message-State: AOAM532Evo6rSU8xOE2K0OjcW7ApIYtAAU3ej9tUNwpFqANKqbkyIJFY
        7Tqn5Ih5vE5jV+0MJd0BXmd2KKiHTbYekvac
X-Google-Smtp-Source: ABdhPJx80lZ+ebjCtowHmPJHVbcebgd7ex72HmIYT0DYhenEKqlJMTnmKk39aYGv+3sTgnHhPlPZbg==
X-Received: by 2002:a63:d506:: with SMTP id c6mr17104277pgg.396.1600237457446;
        Tue, 15 Sep 2020 23:24:17 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id l5sm12885088pgm.80.2020.09.15.23.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 23:24:16 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:24:12 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 13/21] mmc: sdhci: UHS-II support, skip
 signal_voltage_switch()
Message-ID: <20200916062412.GA2972302@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111104.29616-1-benchuanggli@gmail.com>
 <9ab64a9d-cd78-785c-b48f-561048cfe2ed@intel.com>
 <20200914064001.GA2743583@laputa>
 <a0000661-a0e1-8813-0672-c0eb73184079@intel.com>
 <20200915060306.GA2860208@laputa>
 <bd394015-abb7-f134-c883-ec28b42f1fc5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd394015-abb7-f134-c883-ec28b42f1fc5@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:01:20AM +0300, Adrian Hunter wrote:
> On 15/09/20 9:03 am, AKASHI Takahiro wrote:
> > Ben, Adrian,
> > 
> > On Mon, Sep 14, 2020 at 11:08:14AM +0300, Adrian Hunter wrote:
> >> On 14/09/20 9:40 am, AKASHI Takahiro wrote:
> >>> Adrian,
> >>>
> >>> On Fri, Aug 21, 2020 at 05:09:01PM +0300, Adrian Hunter wrote:
> >>>> On 10/07/20 2:11 pm, Ben Chuang wrote:
> >>>>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>>
> >>>>> sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
> >>>>> and not for UHS-II mode.
> >>>>>
> >>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>> ---
> >>>>>  drivers/mmc/host/sdhci.c | 7 ++++++-
> >>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>>>> index 5511649946b9..7f2537648a08 100644
> >>>>> --- a/drivers/mmc/host/sdhci.c
> >>>>> +++ b/drivers/mmc/host/sdhci.c
> >>>>> @@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >>>>>  	/*
> >>>>>  	 * Signal Voltage Switching is only applicable for Host Controllers
> >>>>>  	 * v3.00 and above.
> >>>>> +	 * But for UHS2, the signal voltage is supplied by vdd2 which is
> >>>>> +	 * already 1.8v so no voltage switch required.
> >>>>>  	 */
> >>>>> -	if (host->version < SDHCI_SPEC_300)
> >>>>> +	if (host->version < SDHCI_SPEC_300 ||
> >>>>> +	    (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> >>>>> +	     host->version >= SDHCI_SPEC_400 &&
> >>>>> +	     host->mmc->flags & MMC_UHS2_SUPPORT))
> >>>> Please look at hooking ->start_signal_voltage_switch() instead
> >>>
> >>> Do you mean that you want every platform driver who wants to support UHS-II
> >>> to set NULL to start_signal_voltage_switch hook even if this hack is
> >>> platform agnostic?
> >>
> >> No, I see UHS-II as a separate layer i.e.
> >>
> >>  UHS-II host controller driver
> >>   |   |
> >>   |   v
> >>   |   sdhci-uhs2 e.g. sdhci_uhs2_start_signal_voltage_switch
> >>   |   |
> >>   v   v
> >>   sdhci e.g. sdhci_start_signal_voltage_switch
> >>
> >> Most things should go through sdhci-uhs2 but not nessarily everything.
> > 
> > What I meant by my previous comment is that we don't have to
> > call any function, sdhci_uhs2_start_signal_voltage_switch in above example,
> > for UHS-II cards in any case since it is always simply empty.
> 
> Please treat the sdhci_uhs2_... host ops as functions for a UHS-II host
> controller in either UHS-II or legacy mode. i.e. it is up to sdhci-uhs2.c to
> call through to sdhci.c not the other way around.  e.g.
>
> int sdhci_uhs2_start_signal_voltage_switch(blah)
> {
> 	if (sdhci_uhs2_mode(host))
> 		return 0;
> 	return sdhci_start_signal_valtage_switch(blah);
> }

Okay, the remaining issue is to clarify the meaning of MMC_UHS2_SUPPORT.

-Takhiro Akashi
