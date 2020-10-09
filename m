Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F2F288311
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgJIG5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJIG5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:57:03 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADABC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 23:57:02 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id a16so1908733vke.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGENbSiXdikY8xCk7QudCEfpCSH3xLb69flirnqNdy4=;
        b=TgRXC0FUg6KEW5490gN8X1zXIVYQBz/tRAOYnl/r/vgFNlWGr89/stPbRQHS686j0p
         QoX1qklFHDIcZetPd/9CYaJ/pMZk59uI3XI3RJ4Hw8ouKg4q4IMo0iaZJ+8xF1YTg7Jq
         8ZJyICYcntXRuEOkNYbkHeENuY1MB5Tx5BaZHcBQ5PKSDjFlgDuSOf8146CfXXXSNtMF
         +qoNrnFZrUeqelNEPwYK6x8jwcXdxR3PFNwYV0eZX745T5ICjuNFWCjZU6R7odS+/Ita
         6gYHF/KhETs0fUFoHAObF6Xf4Af6gqWOmtfXTXD2kW2eGJT6opwRwR69Ryzzx2V0oBxc
         QkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGENbSiXdikY8xCk7QudCEfpCSH3xLb69flirnqNdy4=;
        b=ZjeG6mWDImUlL1kKyvF5I1hrUj+skVZWt2fWw3+DTur/5V14pcXs3+kidBLekcYE2r
         5DvAHiqw7BdVdD7NtI9LZJVZ9m7+vLXgvSxyOL55SaGlSkMmuIi0ccjxy+KtGDR7plbV
         dtm16qxUr+sZs1V2jBDpQGa6wwv+w62o4ZFN8UkYUTY5YYYvMdvB+Iu+n/PHgj3nvGtc
         TW8wi3+SfmxSt3/X0VJi+XKSgjibJhvNxKqN9OhiPaPK9wjIGDd8U4qkONQI00akhmy0
         cMJPutVstnCDY6Iy6g1m3uXG/TZoDMcZulhZBWk3Pbp/3smp58v2Vujrjv5VBHOnRIkE
         7KHw==
X-Gm-Message-State: AOAM531/ZkjT0jLHsbueN9YjiDmnLbf/fwIvugPYWL7KHBqWNm07LJud
        LNMFx8Yxe9vXlqTRq3Ayp4gaYiKyZKqMpXhyMw3vzg==
X-Google-Smtp-Source: ABdhPJzQO9FaAisEUKbsmsOPNfFLCZj/d3nFhE4e2c7GFcN+t7H8jAV0+K5z16Im53nCot1UHwHufPKqaC4YdTanis8=
X-Received: by 2002:a1f:e186:: with SMTP id y128mr7082055vkg.6.1602226621987;
 Thu, 08 Oct 2020 23:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
 <DM6PR11MB28764EC5E1F89D417D700F29B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFptgKG8uvKUkN56sooFL4xqaBcNdbpo645xRQqPOH4BkQ@mail.gmail.com> <DM6PR11MB28761F10936FF0D2695FAF19B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB28761F10936FF0D2695FAF19B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Oct 2020 08:56:25 +0200
Message-ID: <CAPDyKFoRHsOiz9BFJ5jWyKqvdmNW9eeEmCGKYn0Q1jUzNwJZNg@mail.gmail.com>
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

On Thu, 8 Oct 2020 at 19:21, Zulkifli, Muhammad Husaini
<muhammad.husaini.zulkifli@intel.com> wrote:
>
> Hi,
>
> >-----Original Message-----
> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >Sent: Thursday, October 8, 2020 11:19 PM
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
> >On Thu, 8 Oct 2020 at 12:54, Zulkifli, Muhammad Husaini
> ><muhammad.husaini.zulkifli@intel.com> wrote:
> >>
> >> Hi,
> >>
> >> >-----Original Message-----
> >> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >> >Sent: Thursday, October 8, 2020 5:28 PM
> >> >To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> >> >Cc: Hunter, Adrian <adrian.hunter@intel.com>; Michal Simek
> >> ><michal.simek@xilinx.com>; Shevchenko, Andriy
> >> ><andriy.shevchenko@intel.com>; linux-mmc@vger.kernel.org; Linux ARM
> >> ><linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> >> ><linux- kernel@vger.kernel.org>; Raja Subramanian, Lakshmi Bai
> >> ><lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
> >> >Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Arnd Bergmann
> >> ><arnd@arndb.de>
> >> >Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1
> >> >support for Keem Bay SOC
> >> >
> >> >On Thu, 8 Oct 2020 at 04:12, <muhammad.husaini.zulkifli@intel.com>
> >wrote:
> >> >>
> >> >> From: Muhammad Husaini Zulkifli
> >> >> <muhammad.husaini.zulkifli@intel.com>
> >> >>
> >> >> Voltage switching sequence is needed to support UHS-1 interface.
> >> >> There are 2 places to control the voltage.
> >> >> 1) By setting the AON register using firmware driver calling
> >> >> system-level platform management layer (SMC) to set the register.
> >> >> 2) By controlling the GPIO expander value to drive either 1.8V or
> >> >> 3.3V for power mux input.
> >> >>
> >> >> Signed-off-by: Muhammad Husaini Zulkifli
> >> >> <muhammad.husaini.zulkifli@intel.com>
> >> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> >> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> >> >> ---
> >> >>  drivers/mmc/host/sdhci-of-arasan.c | 126
> >> >> +++++++++++++++++++++++++++++
> >> >>  1 file changed, 126 insertions(+)
> >> >>
> >> >> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> >> >> b/drivers/mmc/host/sdhci-of-arasan.c
> >> >> index 46aea6516133..ea2467b0073d 100644
> >> >> --- a/drivers/mmc/host/sdhci-of-arasan.c
> >> >> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> >> >> @@ -16,6 +16,7 @@
> >> >>   */
> >> >>
> >> >>  #include <linux/clk-provider.h>
> >> >> +#include <linux/gpio/consumer.h>
> >> >>  #include <linux/mfd/syscon.h>
> >> >>  #include <linux/module.h>
> >> >>  #include <linux/of_device.h>
> >> >> @@ -23,6 +24,7 @@
> >> >>  #include <linux/regmap.h>
> >> >>  #include <linux/of.h>
> >> >>  #include <linux/firmware/xlnx-zynqmp.h>
> >> >> +#include <linux/firmware/intel/keembay_firmware.h>
> >> >>
> >> >>  #include "cqhci.h"
> >> >>  #include "sdhci-pltfm.h"
> >> >> @@ -136,6 +138,7 @@ struct sdhci_arasan_clk_data {
> >> >>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
> >> >>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
> >> >>   * @quirks:            Arasan deviations from spec.
> >> >> + * @uhs_gpio:          Pointer to the uhs gpio.
> >> >>   */
> >> >>  struct sdhci_arasan_data {
> >> >>         struct sdhci_host *host;
> >> >> @@ -150,6 +153,7 @@ struct sdhci_arasan_data {
> >> >>         struct regmap   *soc_ctl_base;
> >> >>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> >> >>         unsigned int    quirks;
> >> >> +       struct gpio_desc *uhs_gpio;
> >> >>
> >> >>  /* Controller does not have CD wired and will not function
> >> >> normally without
> >> >*/
> >> >>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST        BIT(0)
> >> >> @@ -361,6 +365,112 @@ static int sdhci_arasan_voltage_switch(struct
> >> >mmc_host *mmc,
> >> >>         return -EINVAL;
> >> >>  }
> >> >>
> >> >> +static int sdhci_arasan_keembay_voltage_switch(struct mmc_host
> >*mmc,
> >> >> +                                      struct mmc_ios *ios) {
> >> >> +       struct sdhci_host *host = mmc_priv(mmc);
> >> >> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >> >> +       struct sdhci_arasan_data *sdhci_arasan =
> >sdhci_pltfm_priv(pltfm_host);
> >> >> +       u16 ctrl_2, clk;
> >> >> +       int ret;
> >> >> +
> >> >> +       switch (ios->signal_voltage) {
> >> >> +       case MMC_SIGNAL_VOLTAGE_180:
> >> >> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> >> +               clk &= ~SDHCI_CLOCK_CARD_EN;
> >> >> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> >> >> +
> >> >> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> >> +               if (clk & SDHCI_CLOCK_CARD_EN)
> >> >> +                       return -EAGAIN;
> >> >> +
> >> >> +               sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
> >> >> +                                  SDHCI_POWER_CONTROL);
> >> >> +
> >> >> +               /*
> >> >> +                * Set VDDIO_B voltage to Low for 1.8V
> >> >> +                * which is controlling by GPIO Expander.
> >> >> +                */
> >> >> +               gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio,
> >> >> + 0);
> >> >> +
> >> >> +               /*
> >> >> +                * This is like a final gatekeeper. Need to ensure changed
> >voltage
> >> >> +                * is settled before and after turn on this bit.
> >> >> +                */
> >> >> +               usleep_range(1000, 1100);
> >> >> +
> >> >> +               ret =
> >keembay_sd_voltage_selection(KEEMBAY_SET_1V8_VOLT);
> >> >> +               if (ret)
> >> >> +                       return ret;
> >> >> +
> >> >> +               usleep_range(1000, 1100);
> >> >
> >> >No, sorry, but I don't like this.
> >> >
> >> >This looks like a GPIO regulator with an extension of using the
> >> >keembay_sd_voltage_selection() thingy. I think you can model these
> >> >things behind a regulator and hook it up as a vqmmc supply in DT
> >> >instead. BTW, this is the common way we deal with these things for mmc
> >host drivers.
> >>
> >> The SDcard for Keem Bay SOC does not have its own voltage regulator.
> >> There are 2 places to control the voltage.
> >> 1) By setting the AON register calling system-level platform management
> >layer (SMC)
> >>    to set the I/O pads voltage for particular GPIOs line for clk,data and cmd.
> >>    The reason why I use this keembay_sd_voltage_selection() via smccc
> >interface it because during voltage switching
> >>    I need to access to AON register. On a secure system, we could not
> >directly access to AON register due to some security concern from driver side,
> >thus
> >>    cannot exposed any register or address.
> >> 2) By controlling the GPIO expander value to drive either 1.8V or 3.3V for
> >power mux input.
> >
> >I see, thanks for clarifying.
> >
> >To me, it sounds like the best fit is to implement a pinctrl (to manage the I/O
> >pads) and a GPIO regulator.
> >
> Even with pinctrl, i still need to use the keembay_sd_voltage_selection() thingy for AON register.

Yes, I am fine by that.

Although, as it's really a pinctrl, it deserves to be modelled like
that. Not as a soc specific hack in a mmc host driver.

> Plus, the GPIO pin that control the sd-voltage is in GPIO Expander not using Keembay SOC GPIO Pin.
> The best option is using the gpio consumer function to toggle the pin.

As I said, please no.

The common way to model this is as a GPIO regulator. In this way, you
can even rely on existing mmc DT bindings. All you have to do is to
hook up a vqmmc supply to the mmc node.

To be clear, as long as there are no arguments for why a pinctrl and
GPIO regulator can't be used - I am not going to pick up the patches.

Kind regards
Uffe
