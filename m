Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9DF2CC600
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbgLBSzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgLBSzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:55:55 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE977C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:55:08 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id q13so6366050lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vzG2Qs62vWfm1vJAAxBGqSFyWCTUKiSwUxDcB6FnM8Q=;
        b=zyxERiUfIb4p2VyYj9+PBQ24/X1CYU5XhqCl3Yb7BeQHErnbyqYgsA7ja2izHzaQFA
         V4M2QVxePKCQ2tCqUaqXwfHj+fWkTmsG72HTOfhQWf+dBv/4gMOgmUWTTY3LT18VqE8W
         Pefih5oKkCIWolEzBehURzVRAkudQEmkX24ElodiJsjgVrePMWMmm/tHDcgMAUcg6ypH
         UbUBgiV9SttwiOE1PhWGuz4D+MK2FZqTPufCfXl2qUFrwZrIqUcKQvCOZGoTHA+i3lKG
         Okc0oo+Z+l32JIXrXxrB0VtFkIDQfhF8JZQiDRavyK7tm3a070z5ykVY/78cvIOYBSSe
         P6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vzG2Qs62vWfm1vJAAxBGqSFyWCTUKiSwUxDcB6FnM8Q=;
        b=e9BHMN305aTBF3/BT7EVzY+lhrNxk5AiJgjsbZfyun1+l5pK8YsEgDWa8hXEvNRr0K
         PxeFQ0Lh36F4HQBY+K0L3ULV3J958KUdimDevTgNReru8Kl7OpLvi6YX3S48W+snsCyQ
         lbM8eLefyDp84ghqffoYT8Q/zhghusBo+TJDCZOrrZLwNypwykD4ymrqlA8Nl5Suv8nr
         lx/nCF1GQsIaJpennz7bqUX+D9lxnLnugNU+Bq39bQHpLtPUIJYUm4NcSXJxVMUrNn89
         kiBdyrqVwjgbr77uUWs/f9kIhfu7HfFrBZY3UxyjNS7tTnQkvqZ3YG4aOJe0w2WjyBcg
         1UuA==
X-Gm-Message-State: AOAM533sXeflospeFSjLzyz4jCjOQaIug4fDjV1/tc/hlNjfe3Hd1HTG
        Jx2yCRpfLsfrJltGzUQk16QQg4kZN1RPQYnaFOgjq46FIzROUv3T
X-Google-Smtp-Source: ABdhPJzGSGthLJFer5bdjetaiDawgFGOHxrXLLqcN3AxjL2icZa4z97A1k8ysIutWyR7VqHwv/C4HUUiX/4nutNQ4J0=
X-Received: by 2002:a19:ad41:: with SMTP id s1mr1495221lfd.571.1606935307302;
 Wed, 02 Dec 2020 10:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com> <20201202150205.20150-5-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201202150205.20150-5-muhammad.husaini.zulkifli@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Dec 2020 19:54:55 +0100
Message-ID: <CACRpkdZznKd4NYk8whBtq1sUAj9uhasn3+ykrh50A2XKokp=Aw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     muhammad.husaini.zulkifli@intel.com
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

thanks for your patch!

On Wed, Dec 2, 2020 at 8:04 AM <muhammad.husaini.zulkifli@intel.com> wrote:

> Keem Bay SOC can support dual voltage operations for GPIO SD Pins to
> either 1.8V or 3.3V for bus IO line power. In order to operate the GPIOs
> line for Clk,Cmd and Data on Keem Bay Hardware, it is important to
> configure the supplied voltage applied to their I/O Rail and the output
> of the i2c expander pin. Final Voltage applied on the GPIOs Line are
> dependent by both supplied voltage rail and expander pin output as it is
> been set after passing through the voltage sense resistor.

I think I understand this part.

> The Keem Bay HW is somewhat unique in the way of how IO bus line voltage
> are been controlled. Output of the Expander pins is been configured using
> regulator.

That much is clear.

> Voltage rail output is being configured using
> keembay_io_rail_supplied_voltage() API in the sdhci driver directly.

And that is an SMC call like that:

+static inline int keembay_io_rail_supplied_voltage(int volt)
+{
+       struct arm_smccc_res res;
+
+       arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE, volt, &r=
es);
+       if ((int)res.a0 < 0)
+               return -EINVAL;
+
+       return 0;

That can set the voltage by calling into the Arm secure world I guess?

> Pin control based implementation becomes problematic to control the
> voltage rail due to the base address of Always On Register is
> different fromThe driver does not have to be in the the base address of G=
PIO(Pinctrl). Thus, there is
> no way to control the I/O Rail using GPIO Pad configuration.

I don't see why this would be pin control related, and that is as
you point out leading to some confused discussions here.

We do have something like this generic pin config:

 * @PIN_CONFIG_POWER_SOURCE: if the pin can select between different power
 *      supplies, the argument to this parameter (on a custom format) tells
 *      the driver which alternative power source to use.

But it's ... yeah. It usually has a very specific purpose of selecting
one of two available voltage rails inside the SoC. And it needs to
apply to one pin or pin group. Also it kind of implies that those
voltages are always on.

As you say:

> From the Databook itself with additional confirmation from
> Keem Bay HW SOC Design Architect,
> there is no direct control of these AON register bits from
> GPIO pads.

The keembay_io_rail_supplied_voltage() more resembles a
selector (choose one on a menu) voltage regulator to me
if anything.

> On the other hand, using ARM SMC (Secure Monitor Call) directly from
> pin control driver for the sake of implement it as pin control model
> is not a good approach.

Yeah it has to be called from somewhere, if you want an abstraction
to make the driver neutral to any machine, then use a
selector regulator. It can be placed
anywhere in the kernel as long as you can reference it.

The register is called (according to the code) AON_CGF1
(really? not AON_CFG1?) and the "ON" part in "AON"  makes
it sound like "analog ON" implying this is something that can be
turned on/off and configured into two voltages and it has been
wrapped in these custom SMCCs by a secure world developer
(right?)

If it should use any abstraction it should be a selector regulator
IMO and while that may seem overengineered it adds something
because regulators are used in  the MMC subsystem for vdd
and vqmmc because we are handling the OCR mask with that
and it can support any amount of present and future
voltages for signal levels with that as well. Any future changes
to how the different signal voltages are set or which voltages
exist can then be done in that regulator driver.

Just my =E2=82=AC0.01...

Yours,
Linus Walleij
