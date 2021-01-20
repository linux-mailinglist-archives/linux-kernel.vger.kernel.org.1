Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B22FDC19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbhATVt6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jan 2021 16:49:58 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45175 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbhATVXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:23:54 -0500
Received: by mail-ed1-f43.google.com with SMTP id f1so13356524edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cbDUMeEtw544lOujMKMEV/4eHaRUypyOCpdnS+J8w0A=;
        b=Xrd56/VxPCTU1gAyGDJHOviNfw79an/GgRNqor1G6KHr8pQX3dMH7LdInvA7KgALRa
         aikyy3tb4BLLnavSdGDLX9uCfn7XhrBu5h6pQiu44jGpcUfNVZwS9mVrGpWlzoBvCILc
         JCCCVaEurJIPUj9IpL8juN75cD0q5tZ0ugueFVMVyd+Kf0rFBI1WrZKXzckoGrcp4Ujg
         /FPnaMSbiyGBdocN6s+4XlggRDpwJKXwJ5MOeKMvGZG1vEhaQQAtg3E7PPUeanI8eL/v
         leQY7jfV3ruNBFwdDEzUAz2jWwDf5+El/zR+uG1CCTd2RYLFz6j5bgwcPizSDnlA5aaI
         9DfA==
X-Gm-Message-State: AOAM531DAW2A9IbPa0rn3SPikHv05wlLitXthilmtJ16T0+1B/TcBDJH
        aoZhbtRwx9bj9M8Wg1CaPJIWi2pCygDn0wmI8d1kWc3Au0zy0A==
X-Google-Smtp-Source: ABdhPJxF/Bim4+TU7hCkQBq4fPNX320E5ib+1vSQmMCLiXo7PnXlgaMUZqFgiGdOCgcauNIp0e2+r0M8SLVctNSTJ5U=
X-Received: by 2002:a05:6402:510f:: with SMTP id m15mr8824975edd.267.1611177791518;
 Wed, 20 Jan 2021 13:23:11 -0800 (PST)
MIME-Version: 1.0
References: <20210120133057.2470873-1-arnd@kernel.org>
In-Reply-To: <20210120133057.2470873-1-arnd@kernel.org>
From:   Barry Song <baohua@kernel.org>
Date:   Thu, 21 Jan 2021 10:23:00 +1300
Message-ID: <CAGsJ_4zaAi1RX0JPYngXKckCsC7Mznyp7H_M=kgi+qKiWgGE5Q@mail.gmail.com>
Subject: Re: [PATCH] Input: remove sirfsoc power button driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> 于2021年1月21日周四 上午2:31写道：
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The CSR SiRF prima2/atlas platforms are getting removed, so this driver
> is no longer needed.
>
> Cc: Barry Song <baohua@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  drivers/input/misc/Kconfig         |  10 --
>  drivers/input/misc/Makefile        |   1 -
>  drivers/input/misc/sirfsoc-onkey.c | 207 -----------------------------
>  3 files changed, 218 deletions(-)
>  delete mode 100644 drivers/input/misc/sirfsoc-onkey.c
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ad1b6c90bc4d..f824e3435a8e 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -789,16 +789,6 @@ config INPUT_XEN_KBDDEV_FRONTEND
>           To compile this driver as a module, choose M here: the
>           module will be called xen-kbdfront.
>
> -config INPUT_SIRFSOC_ONKEY
> -       tristate "CSR SiRFSoC power on/off/suspend key support"
> -       depends on ARCH_SIRF && OF
> -       default y
> -       help
> -         Say Y here if you want to support for the SiRFSoC power on/off/suspend key
> -         in Linux, after you press the onkey, system will suspend.
> -
> -         If unsure, say N.
> -
>  config INPUT_IDEAPAD_SLIDEBAR
>         tristate "IdeaPad Laptop Slidebar"
>         depends on INPUT
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 7f202ba8f775..0b5871e1bb76 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -72,7 +72,6 @@ obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)       += rotary_encoder.o
>  obj-$(CONFIG_INPUT_RK805_PWRKEY)       += rk805-pwrkey.o
>  obj-$(CONFIG_INPUT_SC27XX_VIBRA)       += sc27xx-vibra.o
>  obj-$(CONFIG_INPUT_SGI_BTNS)           += sgi_btns.o
> -obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)      += sirfsoc-onkey.o
>  obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)   += soc_button_array.o
>  obj-$(CONFIG_INPUT_SPARCSPKR)          += sparcspkr.o
>  obj-$(CONFIG_INPUT_STPMIC1_ONKEY)      += stpmic1_onkey.o
> diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
> deleted file mode 100644
> index 7982bf8fb839..000000000000
> --- a/drivers/input/misc/sirfsoc-onkey.c
> +++ /dev/null
> @@ -1,207 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Power key driver for SiRF PrimaII
> - *
> - * Copyright (c) 2013 - 2014 Cambridge Silicon Radio Limited, a CSR plc group
> - * company.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/delay.h>
> -#include <linux/platform_device.h>
> -#include <linux/input.h>
> -#include <linux/rtc/sirfsoc_rtciobrg.h>
> -#include <linux/of.h>
> -#include <linux/workqueue.h>
> -
> -struct sirfsoc_pwrc_drvdata {
> -       u32                     pwrc_base;
> -       struct input_dev        *input;
> -       struct delayed_work     work;
> -};
> -
> -#define PWRC_ON_KEY_BIT                        (1 << 0)
> -
> -#define PWRC_INT_STATUS                        0xc
> -#define PWRC_INT_MASK                  0x10
> -#define PWRC_PIN_STATUS                        0x14
> -#define PWRC_KEY_DETECT_UP_TIME                20      /* ms*/
> -
> -static int sirfsoc_pwrc_is_on_key_down(struct sirfsoc_pwrc_drvdata *pwrcdrv)
> -{
> -       u32 state = sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base +
> -                                                       PWRC_PIN_STATUS);
> -       return !(state & PWRC_ON_KEY_BIT); /* ON_KEY is active low */
> -}
> -
> -static void sirfsoc_pwrc_report_event(struct work_struct *work)
> -{
> -       struct sirfsoc_pwrc_drvdata *pwrcdrv =
> -               container_of(work, struct sirfsoc_pwrc_drvdata, work.work);
> -
> -       if (sirfsoc_pwrc_is_on_key_down(pwrcdrv)) {
> -               schedule_delayed_work(&pwrcdrv->work,
> -                       msecs_to_jiffies(PWRC_KEY_DETECT_UP_TIME));
> -       } else {
> -               input_event(pwrcdrv->input, EV_KEY, KEY_POWER, 0);
> -               input_sync(pwrcdrv->input);
> -       }
> -}
> -
> -static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
> -{
> -       struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_id;
> -       u32 int_status;
> -
> -       int_status = sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base +
> -                                                       PWRC_INT_STATUS);
> -       sirfsoc_rtc_iobrg_writel(int_status & ~PWRC_ON_KEY_BIT,
> -                                pwrcdrv->pwrc_base + PWRC_INT_STATUS);
> -
> -       input_event(pwrcdrv->input, EV_KEY, KEY_POWER, 1);
> -       input_sync(pwrcdrv->input);
> -       schedule_delayed_work(&pwrcdrv->work,
> -                             msecs_to_jiffies(PWRC_KEY_DETECT_UP_TIME));
> -
> -       return IRQ_HANDLED;
> -}
> -
> -static void sirfsoc_pwrc_toggle_interrupts(struct sirfsoc_pwrc_drvdata *pwrcdrv,
> -                                          bool enable)
> -{
> -       u32 int_mask;
> -
> -       int_mask = sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base + PWRC_INT_MASK);
> -       if (enable)
> -               int_mask |= PWRC_ON_KEY_BIT;
> -       else
> -               int_mask &= ~PWRC_ON_KEY_BIT;
> -       sirfsoc_rtc_iobrg_writel(int_mask, pwrcdrv->pwrc_base + PWRC_INT_MASK);
> -}
> -
> -static int sirfsoc_pwrc_open(struct input_dev *input)
> -{
> -       struct sirfsoc_pwrc_drvdata *pwrcdrv = input_get_drvdata(input);
> -
> -       sirfsoc_pwrc_toggle_interrupts(pwrcdrv, true);
> -
> -       return 0;
> -}
> -
> -static void sirfsoc_pwrc_close(struct input_dev *input)
> -{
> -       struct sirfsoc_pwrc_drvdata *pwrcdrv = input_get_drvdata(input);
> -
> -       sirfsoc_pwrc_toggle_interrupts(pwrcdrv, false);
> -       cancel_delayed_work_sync(&pwrcdrv->work);
> -}
> -
> -static const struct of_device_id sirfsoc_pwrc_of_match[] = {
> -       { .compatible = "sirf,prima2-pwrc" },
> -       {},
> -};
> -MODULE_DEVICE_TABLE(of, sirfsoc_pwrc_of_match);
> -
> -static int sirfsoc_pwrc_probe(struct platform_device *pdev)
> -{
> -       struct device_node *np = pdev->dev.of_node;
> -       struct sirfsoc_pwrc_drvdata *pwrcdrv;
> -       int irq;
> -       int error;
> -
> -       pwrcdrv = devm_kzalloc(&pdev->dev, sizeof(struct sirfsoc_pwrc_drvdata),
> -                              GFP_KERNEL);
> -       if (!pwrcdrv) {
> -               dev_info(&pdev->dev, "Not enough memory for the device data\n");
> -               return -ENOMEM;
> -       }
> -
> -       /*
> -        * We can't use of_iomap because pwrc is not mapped in memory,
> -        * the so-called base address is only offset in rtciobrg
> -        */
> -       error = of_property_read_u32(np, "reg", &pwrcdrv->pwrc_base);
> -       if (error) {
> -               dev_err(&pdev->dev,
> -                       "unable to find base address of pwrc node in dtb\n");
> -               return error;
> -       }
> -
> -       pwrcdrv->input = devm_input_allocate_device(&pdev->dev);
> -       if (!pwrcdrv->input)
> -               return -ENOMEM;
> -
> -       pwrcdrv->input->name = "sirfsoc pwrckey";
> -       pwrcdrv->input->phys = "pwrc/input0";
> -       pwrcdrv->input->evbit[0] = BIT_MASK(EV_KEY);
> -       input_set_capability(pwrcdrv->input, EV_KEY, KEY_POWER);
> -
> -       INIT_DELAYED_WORK(&pwrcdrv->work, sirfsoc_pwrc_report_event);
> -
> -       pwrcdrv->input->open = sirfsoc_pwrc_open;
> -       pwrcdrv->input->close = sirfsoc_pwrc_close;
> -
> -       input_set_drvdata(pwrcdrv->input, pwrcdrv);
> -
> -       /* Make sure the device is quiesced */
> -       sirfsoc_pwrc_toggle_interrupts(pwrcdrv, false);
> -
> -       irq = platform_get_irq(pdev, 0);
> -       error = devm_request_irq(&pdev->dev, irq,
> -                                sirfsoc_pwrc_isr, 0,
> -                                "sirfsoc_pwrc_int", pwrcdrv);
> -       if (error) {
> -               dev_err(&pdev->dev, "unable to claim irq %d, error: %d\n",
> -                       irq, error);
> -               return error;
> -       }
> -
> -       error = input_register_device(pwrcdrv->input);
> -       if (error) {
> -               dev_err(&pdev->dev,
> -                       "unable to register input device, error: %d\n",
> -                       error);
> -               return error;
> -       }
> -
> -       dev_set_drvdata(&pdev->dev, pwrcdrv);
> -       device_init_wakeup(&pdev->dev, 1);
> -
> -       return 0;
> -}
> -
> -static int __maybe_unused sirfsoc_pwrc_resume(struct device *dev)
> -{
> -       struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(dev);
> -       struct input_dev *input = pwrcdrv->input;
> -
> -       /*
> -        * Do not mask pwrc interrupt as we want pwrc work as a wakeup source
> -        * if users touch X_ONKEY_B, see arch/arm/mach-prima2/pm.c
> -        */
> -       mutex_lock(&input->mutex);
> -       if (input_device_enabled(input))
> -               sirfsoc_pwrc_toggle_interrupts(pwrcdrv, true);
> -       mutex_unlock(&input->mutex);
> -
> -       return 0;
> -}
> -
> -static SIMPLE_DEV_PM_OPS(sirfsoc_pwrc_pm_ops, NULL, sirfsoc_pwrc_resume);
> -
> -static struct platform_driver sirfsoc_pwrc_driver = {
> -       .probe          = sirfsoc_pwrc_probe,
> -       .driver         = {
> -               .name   = "sirfsoc-pwrc",
> -               .pm     = &sirfsoc_pwrc_pm_ops,
> -               .of_match_table = sirfsoc_pwrc_of_match,
> -       }
> -};
> -
> -module_platform_driver(sirfsoc_pwrc_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_AUTHOR("Binghua Duan <Binghua.Duan@csr.com>, Xianglong Du <Xianglong.Du@csr.com>");
> -MODULE_DESCRIPTION("CSR Prima2 PWRC Driver");
> -MODULE_ALIAS("platform:sirfsoc-pwrc");
> --
> 2.29.2
>
