Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF9269E68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIOGYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgIOGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:24:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B5DC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:24:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bg9so798930plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xx+DYmtyTSIZhYxsfIQQOAzj1/r5KgCbyv8qCw38bIE=;
        b=PK+B+js0SAYlHkir6fYgYnsY8/HuWG6ClReeFPeFGM/qS21JvE81YVsgpy8LuMdQpn
         g4XvUcsbmRH53GvXDa7/wNCQtDLOAyMylWi7WwvM0WDJH2NKBjp+oLCqdAtvG8MAIcfH
         qcdxYOYZBkim2lCl6jUSAynoZkw4vdZJLfXB3IoYp7Ur+oDTpcMupsyPBLu3YVItKzai
         GVSUW1G+/EGKUeibZgMRKEAzP9hEUlYJe1EFJyCFbpzW+Jjsgpz+SAhand42eY44chRr
         kPGYD4uAEK7v/F7L7TKp+ooi9XtQ2AmN6If80sbiFdIVA0juijyMvUM3gSq2XMgqQ8lg
         bbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Xx+DYmtyTSIZhYxsfIQQOAzj1/r5KgCbyv8qCw38bIE=;
        b=fKs/gWXrLZeHrLyj6XvQJbr1AtprUQRVqeDiOQe8Lyx1RD766v/LaoaLfLCqmwMuF/
         I/6GmegbdsK6TaVTqMo1/+jQDkuNwkqOH9C7yGACSXQD0MgT6qmzTVHNaP3EillM9kb9
         LcXRGQL4iPrIa9U6MQ7USj26NFnswOSF3XX597AExTA3tyFVfSV1Sgpbl9hCjrWUMJpL
         dxYMe5zxI/c1xMBMUJ/BlZtd+AoMBcsxR1c5lCpnyUJJ/vWgGhUXCpshyhgGcNFkAOU/
         IGpRk0EevqBOH7EqWQ2ClRM29sqDIQlJG8+dCRjBsgqcwCxCSQvuoF3yT7am30sCuyKb
         L6ig==
X-Gm-Message-State: AOAM531zXp5w87nX7fsTB24B4BGX2YzDPXjjAyDhQyQMm6Em0U8LYD8Y
        dH7Nj3Pq0Y3D7DD2WGbM1eEeag==
X-Google-Smtp-Source: ABdhPJyuVOS+QvY4sGm8R0WodlQtWrH1Znn9mdCe02LHy5dWveJlde6o2kiw14HFY/wvW3HohOTQ3g==
X-Received: by 2002:a17:902:7614:b029:d1:e603:1bf2 with SMTP id k20-20020a1709027614b02900d1e6031bf2mr149740pll.71.1600151088036;
        Mon, 14 Sep 2020 23:24:48 -0700 (PDT)
Received: from laputa (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id u14sm12315778pfm.80.2020.09.14.23.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 23:24:47 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:24:43 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH V3 15/21] mmc: sdhci: UHS-II support, modify
 set_power() to handle vdd2
Message-ID: <20200915062443.GB2860208@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20200710111140.29725-1-benchuanggli@gmail.com>
 <97c43596-a18f-4c7a-c226-5209772d91d1@intel.com>
 <20200914054537.GA2738017@laputa>
 <f0ff6c0a-4029-72a9-559c-8930ef0ea8bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0ff6c0a-4029-72a9-559c-8930ef0ea8bb@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrain,

On Mon, Sep 14, 2020 at 09:36:02AM +0300, Adrian Hunter wrote:
> On 14/09/20 8:45 am, AKASHI Takahiro wrote:
> > Adrian,
> > 
> > On Fri, Aug 21, 2020 at 05:11:18PM +0300, Adrian Hunter wrote:
> >> On 10/07/20 2:11 pm, Ben Chuang wrote:
> >>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>
> >>> VDD2 is used for powering UHS-II interface.
> >>> Modify sdhci_set_power_and_bus_voltage(), sdhci_set_power_noreg()
> >>> and sdhci_set_power_noreg() to handle VDD2.
> >>
> >> vdd2 is always 1.8 V and I suspect there may never be support for anything
> >> else, so we should start with 1.8 V only.
> > 
> > What do you mean here?
> > You don't want to add an extra argument, vdd2, to sdhci_set_power().
> > Correct?
> 
> Yes
> 
> > 
> >> Also can we create uhs2_set_power_reg() and uhs2_set_power_noreg() and use
> >> the existing ->set_power() callback
> > 
> > Again what do you expect here?
> > 
> > Do you want to see any platform-specific mmc driver who supports UHS-II
> > to implement its own call back like:
> 
> Not exactly.  I expect there to be a common implementation in sdhci-uhs2.c
> called sdhci_uhs2_set_power() for example, that drivers can use by setting
> their .set_power = sdhci_uhs2_set_power.  If they need platform-specific
> code as well then their platform-specific code can call
> sdhci_uhs2_set_power() if desired.
> 
> > 
> > void sdhci_foo_set_power(struct sdhci_host *host, unsigned char mode,
> >                                   unsigned short vdd)
> > {
> >         sdhci_set_power(host, mode,vdd);
> > 
> >         /* in case that sdhci_uhs2 module is not inserted */
> >         if (!(mmc->caps & MMC_CAP_UHS2))
> >                 return;
> > 
> >         /* vdd2 specific operation */
> >         if (IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> >                 sdhci_uhs2_set_power_noreg(host, mode);
> >         else
> >                 sdhci_uhs2_set_power_reg(host, mode);
> > 
> >         /* maybe more platform-specific initialization */
> > }
> > 
> > struct sdhci_ops sdhci_foo_ops = {
> >         .set_power = sdhci_foo_set_power,
> >         ...
> > }

What do you think about this logic in general?
(If necessary, read it replacing "foo" to "uhs2".)

What I'm concerned about is SDHCI_POWER_CONTROL register.
Vdd and vdd2 are controlled with corresponding bits in this register.
It seems to be "natural" to me that vdd and vdd2 are enabled
in a single function rather than putting them in separate ones.

In particular, in the case of sdhci_set_power_noreg(), there exist a couple
of "quirks" around writing the bits to SDHCI_POWER_CONTROL register.
I don't know how we should handle them if we have a separate function,
say, sdhci_uhs2_set_power_noreg().
Do you want to see a copy of the same logic in sdhci_uhs2_set_power_noreg()? 

-Takahiro Akashi


> > 
> > Is this what you mean?
> > (I'm not quite sure yet that sdhci_ush2_set_power_noreg() can be split off
> > from sdhci_set_power_noreg().)
> > 
> > -Takahiro Akashi
