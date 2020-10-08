Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB72287703
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgJHPT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbgJHPT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:19:56 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4CDC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:19:56 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id z19so2003331uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSNHNnjnwW5HIpb5AcDU4F3mK+e5nO0jR+KUVma3HaU=;
        b=mXaU/NV5QqWEm8WCH1SJCEl4v1cf/Nj9ObmhZOh5+zqrC8F19kEg8ZFOJ8KiQZ0fG2
         FFJPFtI7kPGw95A+a9CnoiLjVsh0H/PNEjOMmrkViNA6HVwP20QrGmdnyCPQoVLN6Ucg
         X8A3lif9iQU5ZzwHSV+w3ItiZ8XJscK2pVGkTh42ThHuVorvYc+wuKZmXiH1eCGZkG0a
         ERYrl/YEhS6PfzOLFXPriA8YZQ1W92FRjWbr4WVdRX+xM8tc+OY5JXH5PvSuCAy/k7fD
         PKBuiExyGVeYa8Hs5hZbe61mDqEP5xyeRdNvNIW2AFFq2o4PKpIwNmENFV0NR+WNZtUY
         EKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSNHNnjnwW5HIpb5AcDU4F3mK+e5nO0jR+KUVma3HaU=;
        b=rrvuJ9i2MhbXQrbXRzOj2BK4nzcc+z6d0sFCkFoZ9lX6uh+5VkCmuyLOmx7FVUweyL
         l+oXuqpPOh2B0aI+ieg6DKAoDiujd7EqmUHhzyevQPWnp1ZTrGhOQXX93IrIL0vB6+Ca
         STeSvttKy33IHU2lq9AnyBAt26bbDskqHfTdZ046VM4n1GG+0rNTAv94QRPojl3Llr5A
         qUyZKJTyEkh99aGYw5m2sVJHsTeaDZbSs0zCcnNAVm5LKNIBk/YWBsEICgsKOVHPpDLC
         8jv8BDgF+T2g0UlVTctHh16TRL+zvKhgbE/CHeVAlxcObYcnGf3se29yUmCf3xI+6ht+
         Yaww==
X-Gm-Message-State: AOAM532Eb4r90MPgH5fjiFGA7h1RoYoBk7eYYl3KIHLZ9TAqZV4Crd4L
        LmmFI2PjVg020jgHNhHoh8kV9qmAfjvjI0HEHvtX6Q==
X-Google-Smtp-Source: ABdhPJyCOCepTDaFd6P37/FAjk8/iu35ntCC5qXytD11zsKYZhOVM3fzXQWx9imFFF06uFVwuqtLRfbJAezjHzM4yuc=
X-Received: by 2002:ab0:4425:: with SMTP id m34mr4718452uam.19.1602170395303;
 Thu, 08 Oct 2020 08:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com> <DM6PR11MB28764EC5E1F89D417D700F29B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB28764EC5E1F89D417D700F29B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Oct 2020 17:19:18 +0200
Message-ID: <CAPDyKFptgKG8uvKUkN56sooFL4xqaBcNdbpo645xRQqPOH4BkQ@mail.gmail.com>
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

On Thu, 8 Oct 2020 at 12:54, Zulkifli, Muhammad Husaini
<muhammad.husaini.zulkifli@intel.com> wrote:
>
> Hi,
>
> >-----Original Message-----
> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >Sent: Thursday, October 8, 2020 5:28 PM
> >To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> >Cc: Hunter, Adrian <adrian.hunter@intel.com>; Michal Simek
> ><michal.simek@xilinx.com>; Shevchenko, Andriy
> ><andriy.shevchenko@intel.com>; linux-mmc@vger.kernel.org; Linux ARM
> ><linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> >kernel@vger.kernel.org>; Raja Subramanian, Lakshmi Bai
> ><lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
> >Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Arnd Bergmann
> ><arnd@arndb.de>
> >Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
> >Keem Bay SOC
> >
> >On Thu, 8 Oct 2020 at 04:12, <muhammad.husaini.zulkifli@intel.com> wrote:
> >>
> >> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> >>
> >> Voltage switching sequence is needed to support UHS-1 interface.
> >> There are 2 places to control the voltage.
> >> 1) By setting the AON register using firmware driver calling
> >> system-level platform management layer (SMC) to set the register.
> >> 2) By controlling the GPIO expander value to drive either 1.8V or 3.3V
> >> for power mux input.
> >>
> >> Signed-off-by: Muhammad Husaini Zulkifli
> >> <muhammad.husaini.zulkifli@intel.com>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  drivers/mmc/host/sdhci-of-arasan.c | 126
> >> +++++++++++++++++++++++++++++
> >>  1 file changed, 126 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> >> b/drivers/mmc/host/sdhci-of-arasan.c
> >> index 46aea6516133..ea2467b0073d 100644
> >> --- a/drivers/mmc/host/sdhci-of-arasan.c
> >> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> >> @@ -16,6 +16,7 @@
> >>   */
> >>
> >>  #include <linux/clk-provider.h>
> >> +#include <linux/gpio/consumer.h>
> >>  #include <linux/mfd/syscon.h>
> >>  #include <linux/module.h>
> >>  #include <linux/of_device.h>
> >> @@ -23,6 +24,7 @@
> >>  #include <linux/regmap.h>
> >>  #include <linux/of.h>
> >>  #include <linux/firmware/xlnx-zynqmp.h>
> >> +#include <linux/firmware/intel/keembay_firmware.h>
> >>
> >>  #include "cqhci.h"
> >>  #include "sdhci-pltfm.h"
> >> @@ -136,6 +138,7 @@ struct sdhci_arasan_clk_data {
> >>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
> >>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
> >>   * @quirks:            Arasan deviations from spec.
> >> + * @uhs_gpio:          Pointer to the uhs gpio.
> >>   */
> >>  struct sdhci_arasan_data {
> >>         struct sdhci_host *host;
> >> @@ -150,6 +153,7 @@ struct sdhci_arasan_data {
> >>         struct regmap   *soc_ctl_base;
> >>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> >>         unsigned int    quirks;
> >> +       struct gpio_desc *uhs_gpio;
> >>
> >>  /* Controller does not have CD wired and will not function normally without
> >*/
> >>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST        BIT(0)
> >> @@ -361,6 +365,112 @@ static int sdhci_arasan_voltage_switch(struct
> >mmc_host *mmc,
> >>         return -EINVAL;
> >>  }
> >>
> >> +static int sdhci_arasan_keembay_voltage_switch(struct mmc_host *mmc,
> >> +                                      struct mmc_ios *ios) {
> >> +       struct sdhci_host *host = mmc_priv(mmc);
> >> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> >> +       u16 ctrl_2, clk;
> >> +       int ret;
> >> +
> >> +       switch (ios->signal_voltage) {
> >> +       case MMC_SIGNAL_VOLTAGE_180:
> >> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> +               clk &= ~SDHCI_CLOCK_CARD_EN;
> >> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> >> +
> >> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> +               if (clk & SDHCI_CLOCK_CARD_EN)
> >> +                       return -EAGAIN;
> >> +
> >> +               sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
> >> +                                  SDHCI_POWER_CONTROL);
> >> +
> >> +               /*
> >> +                * Set VDDIO_B voltage to Low for 1.8V
> >> +                * which is controlling by GPIO Expander.
> >> +                */
> >> +               gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 0);
> >> +
> >> +               /*
> >> +                * This is like a final gatekeeper. Need to ensure changed voltage
> >> +                * is settled before and after turn on this bit.
> >> +                */
> >> +               usleep_range(1000, 1100);
> >> +
> >> +               ret = keembay_sd_voltage_selection(KEEMBAY_SET_1V8_VOLT);
> >> +               if (ret)
> >> +                       return ret;
> >> +
> >> +               usleep_range(1000, 1100);
> >
> >No, sorry, but I don't like this.
> >
> >This looks like a GPIO regulator with an extension of using the
> >keembay_sd_voltage_selection() thingy. I think you can model these things
> >behind a regulator and hook it up as a vqmmc supply in DT instead. BTW, this is
> >the common way we deal with these things for mmc host drivers.
>
> The SDcard for Keem Bay SOC does not have its own voltage regulator.
> There are 2 places to control the voltage.
> 1) By setting the AON register calling system-level platform management layer (SMC)
>    to set the I/O pads voltage for particular GPIOs line for clk,data and cmd.
>    The reason why I use this keembay_sd_voltage_selection() via smccc interface it because during voltage switching
>    I need to access to AON register. On a secure system, we could not directly access to AON register due to some security concern from driver side, thus
>    cannot exposed any register or address.
> 2) By controlling the GPIO expander value to drive either 1.8V or 3.3V for power mux input.

I see, thanks for clarifying.

To me, it sounds like the best fit is to implement a pinctrl (to
manage the I/O pads) and a GPIO regulator.

Kind regards
Uffe
