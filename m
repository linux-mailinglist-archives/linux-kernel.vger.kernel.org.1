Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8381F29037F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 12:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395503AbgJPKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 06:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395496AbgJPKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 06:51:12 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA8DC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 03:51:12 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id r1so1151241vsi.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xbxr9IqhfBSHOTINIDRRrGXVvLUBIFjfiaN+PDTjgRQ=;
        b=h1/x/JENjlGBAxLp90NlmELvg20nyWnLhe2fPvUUCrFFVnqXuUlUOdB1tYjeFXV1OL
         shCcv+r8YSU5nl0KeCt5njRSbPdhMTTKptboeoNGClrKyPbkeHleS/BcWp0PqH+vHvFV
         O8XdDZF1hPr7i+XLHFrvchx2HkX9wcqYCJhM2T21/JxBmDEj/zBEKC5wgiytnrywvT1a
         xQLa4WlrL5Q1fznU2MFAXKDIBpbyW900vANTpc8eZ/S+f1MpmR+jgCPQUon0b7WVqAQb
         fK3Z9ItWOzBAm/gLaVsRynTakRWof4rgR9dRWV+7mxFY9gHLmRQIgJr4j4oWhCk0QOJ0
         2lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xbxr9IqhfBSHOTINIDRRrGXVvLUBIFjfiaN+PDTjgRQ=;
        b=Utv3+tLVzC+3udY7DFfH+hO70oazcUbfR2sJZzzX2fnMHBwY9QMkI/i6ACt8IekG6T
         Yo/qo03VCpK13U3kYBMpcnsOkPpyK4QI+G1RouGA8Xv2KRN1AOYGCwcoDtbJnIX1KysI
         9J9cIfLhagRkf6Mu1q8RH1ClUL9eQtR8uFi2utn9gIWApDzuow1Cfm/2URzc0J9EBR7g
         ZX4emYtDZRkrQ/xBfO9ZLfQldRdkm7+fGkbQfjMEYUTkly4CImqstKhuZS3agR1Tmcdc
         eFI72hw+lbTIbu3GYrkhLyr1oIAB8Prioo79b92wb20Pg1vL5pkq43GIVf9gIJcmpPpd
         M9RA==
X-Gm-Message-State: AOAM530Px2RRds71x0Ie9PndA7GqFjsOkXDZY4pv4qa2L2uQFRB9I8K3
        58MSd3eIyLQgwnRTGt1vJVy9rxwE/e4nVZ+ssKLgNg==
X-Google-Smtp-Source: ABdhPJxaHgzUhpedWRcsJOLXZxBTwLRwdu9IeczL62z9Gp1yOoyKgss0MK1ty0S0xi2z3ujakcbAn7IalKgFlkEbFuY=
X-Received: by 2002:a67:6c86:: with SMTP id h128mr1407272vsc.42.1602845470789;
 Fri, 16 Oct 2020 03:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
 <DM6PR11MB28764EC5E1F89D417D700F29B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFptgKG8uvKUkN56sooFL4xqaBcNdbpo645xRQqPOH4BkQ@mail.gmail.com>
 <DM6PR11MB28761F10936FF0D2695FAF19B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFoRHsOiz9BFJ5jWyKqvdmNW9eeEmCGKYn0Q1jUzNwJZNg@mail.gmail.com>
 <DM6PR11MB2876DF701740F70FFD2B2D17B8080@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFqB5SCfNWumhDjvH+mQxMi6bYcHSg-vBV+gWEgDee0m1Q@mail.gmail.com> <DM6PR11MB2876F5F9A801E449B266011CB8030@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB2876F5F9A801E449B266011CB8030@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Oct 2020 12:50:34 +0200
Message-ID: <CAPDyKFq52myX+i=uRg4-mEyRYo=Pn2YkWUk94AbnzgG3-CTS7Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >> >> >> The SDcard for Keem Bay SOC does not have its own voltage regulator.
> >> >> >> There are 2 places to control the voltage.
> >> >> >> 1) By setting the AON register calling system-level platform
> >> >> >> management
> >> >> >layer (SMC)
> >> >> >>    to set the I/O pads voltage for particular GPIOs line for clk,data and
> >cmd.
> >> >> >>    The reason why I use this keembay_sd_voltage_selection() via
> >> >> >> smccc
> >> >> >interface it because during voltage switching
> >> >> >>    I need to access to AON register. On a secure system, we
> >> >> >> could not
> >> >> >directly access to AON register due to some security concern from
> >> >> >driver side, thus
> >> >> >>    cannot exposed any register or address.
> >> >> >> 2) By controlling the GPIO expander value to drive either 1.8V
> >> >> >> or 3.3V for
> >> >> >power mux input.
> >> >> >
> >> >> >I see, thanks for clarifying.
> >> >> >
> >> >> >To me, it sounds like the best fit is to implement a pinctrl (to
> >> >> >manage the I/O
> >> >> >pads) and a GPIO regulator.
> >> >> >
> >> >> Even with pinctrl, i still need to use the
> >> >> keembay_sd_voltage_selection()
> >> >thingy for AON register.
> >> >
> >> >Yes, I am fine by that.
> >> >
> >> >Although, as it's really a pinctrl, it deserves to be modelled like
> >> >that. Not as a soc specific hack in a mmc host driver.
> >> >
> >> >> Plus, the GPIO pin that control the sd-voltage is in GPIO Expander
> >> >> not using
> >> >Keembay SOC GPIO Pin.
> >> >> The best option is using the gpio consumer function to toggle the pin.
> >> >
> >> >As I said, please no.
> >> >
> >> >The common way to model this is as a GPIO regulator. In this way, you
> >> >can even rely on existing mmc DT bindings. All you have to do is to
> >> >hook up a vqmmc supply to the mmc node.
> >> >
> >> >To be clear, as long as there are no arguments for why a pinctrl and
> >> >GPIO regulator can't be used - I am not going to pick up the patches.
> >> As I mentioned The SDcard does not have its own voltage regulator.
> >> It only uses the voltage rails on the mux input.
> >>
> >> There are 2 things need to be configured before getting the output voltage:
> >>
> >> 1) V_VDDIO_B :
> >> Supplied voltage applied to I/O Rail which is controlled from the Always on
> >domain using specific bits in AON_CFG1 register.
> >> This is where we set for V_VDDIO_B using the
> >keembay_sd_voltage_selection() to set either 1.8v or 3.3v depending on the bit
> >value.
> >> IMHO, we do not pinctrl to do this.
> >>
> >> 2) V_VDDIO_B_MAIN:
> >> The output V_VDDIO_B_MAIN (OUT1) will be either V_3P3_MAIN (IN1) or
> >> V_1P8_MAIN (IN2), depending on the state of GPIO expander Pin value. There
> >is a POWER MUX involving here.
> >> IMHO, we do not need any gpio regulator/regulator api hook up for this.
> >> Most important thing, there is no regulator ic at all.
> >> We still need to manually control and toggle the pin value.
> >>
> >> The final IO voltage is set by V_VDDIO_B (= V_VDDIO_B_MAIN after passing
> >through voltage sense resistor).
> >>
> >> Hope this will clarify.
> >
> >I think I get it, thanks.
> >
> >Again, I haven't seen any reasons for why this can't be modelled as a pinctrl and
> >a gpio-regulator. So, please convert it to that.
> For gpio-regulator, I believe I could not use the current gpio-regulator.c framework as there is no consumer API for me to change the state of gpio pin during voltage switching.

The consumer API you want to use, is the regulator consumer API,
regulator_enable|disable(), for example.

Although, as I stated earlier, the mmc core already provides helper
functions for this. I suggest you have a look at
mmc_regulator_set_vqmmc() and how it's used by other mmc host drivers.

> Do I need to create a specific gpio-regulator driver under drivers/regulator for keem bay?
> >

I don't think so. Please have a look at
Documentation/devicetree/bindings/regulator/gpio-regulator.yaml. This
allows you to specify your GPIO regulator in DT.

Then from the mmc node you add a "vqmmc-supply" specifier with the
phandle to the regulator - that should be it.

Kind regards
Uffe
