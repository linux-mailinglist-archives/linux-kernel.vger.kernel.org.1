Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486242754E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgIWJ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 05:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWJ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:57:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37984C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 02:57:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md22so2501028pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSAESAZtXdV+inlDZ3bQZ1Wu5AZsA9EKLFqkWoHt7bg=;
        b=QnlzZsFF3lh3iXl4mnEfTokDFubr2IqWXde8AgthjCrwOr0sJRG8KmZ7njPvVpuI1G
         NNINDn2yAkG5bwdme1KhJvjG6PyXwzbjTDU22NXLXFfzPhorA91j6tIlkjegIfIjOj0s
         ixUy0qRSZ3vDTKAJ7HUcTIAxYy/srsjQ6FprSiE/038u6Fa5pu7mTaKny+H19P7hcCU5
         PR1axTPkzICXSkRI6UiSOayXsSL544sjK+rpCpWoyzBvpUJ0lfHmj9ymOdHWkUNXwbAz
         TVnQWTDpC22yZIJAixXlV1SAJbG2RnldQA3iKftNUnzKEvVfykdez2/62QKsLalTfSp6
         /GCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSAESAZtXdV+inlDZ3bQZ1Wu5AZsA9EKLFqkWoHt7bg=;
        b=Yf6Kh0P2AbgQ5T7YWJH+BEvb/zyEMBLZ1dm1/a5AQftJ32lcMOWy5tMFokB002QGsu
         Q7qXwJVD8dhtt/cPw9aHDhnmKTA3i+Z6mH3G0vgThaxLLoV3vqgIP0ZjhObcmFPWLqLU
         vjOK3w/9KgZUHBiU2Uv1EZetI1qwh58Vr+ah441PPBGpEigFMRsyHVtzVjm1NqM13VeG
         18uxlj6ZHv2PCrU7qrfOQCaDnECTTB+ziV6mH+ke4tYiWExfH5y+2rwdI9Qk6I4xrnTj
         4kjDEA9VjYOEaIENO7TPrX3fqG7cafvkZ9nYpLt+HyeCe8e9Apjq0u3y1n3NHQWs9trv
         q05w==
X-Gm-Message-State: AOAM5316xC+Z6y3zPbKT3312rCgnvQkB/Znd+FZV2mJ0VaVm3t+NykoK
        bVnNN3mofnl6HMbar+azRvdDdegV67jYyszCirY=
X-Google-Smtp-Source: ABdhPJzjnBIUFNafdHt2U9Z8HLafwWrGAUWQK1/FUYQS03PUwGhfjnP+CpaqxBzPlp2ytWMQhvwtNqL9YOWzun5UPAk=
X-Received: by 2002:a17:902:c14c:b029:d2:4345:5a9 with SMTP id
 12-20020a170902c14cb02900d2434505a9mr6172490plj.0.1600855037663; Wed, 23 Sep
 2020 02:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com> <20200922192659.14535-3-rikard.falkeborn@gmail.com>
In-Reply-To: <20200922192659.14535-3-rikard.falkeborn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Sep 2020 12:56:59 +0300
Message-ID: <CAHp75Ve-Kwcc9FK8f52jiQZBaS6grxiwWG-RnmWij+RWB=kxuQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] mfd: intel: Constify static struct resource
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:32 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Constify a number of static struct resource. The only usage of the
> structs are to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.

Okay, I have briefly checked the code and the patch seems correct (we
don't use those structures to update data in them). FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/mfd/intel_msic.c              | 18 +++++++++---------
>  drivers/mfd/intel_soc_pmic_bxtwc.c    | 14 +++++++-------
>  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 10 +++++-----
>  drivers/mfd/intel_soc_pmic_chtwc.c    |  4 ++--
>  drivers/mfd/intel_soc_pmic_crc.c      | 10 +++++-----
>  5 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mfd/intel_msic.c b/drivers/mfd/intel_msic.c
> index bb24c2a07900..daa772f8146b 100644
> --- a/drivers/mfd/intel_msic.c
> +++ b/drivers/mfd/intel_msic.c
> @@ -50,23 +50,23 @@ struct intel_msic {
>         void __iomem                    *irq_base;
>  };
>
> -static struct resource msic_touch_resources[] = {
> +static const struct resource msic_touch_resources[] = {
>         DEFINE_RES_IRQ(0),
>  };
>
> -static struct resource msic_adc_resources[] = {
> +static const struct resource msic_adc_resources[] = {
>         DEFINE_RES_IRQ(0),
>  };
>
> -static struct resource msic_battery_resources[] = {
> +static const struct resource msic_battery_resources[] = {
>         DEFINE_RES_IRQ(0),
>  };
>
> -static struct resource msic_gpio_resources[] = {
> +static const struct resource msic_gpio_resources[] = {
>         DEFINE_RES_IRQ(0),
>  };
>
> -static struct resource msic_audio_resources[] = {
> +static const struct resource msic_audio_resources[] = {
>         DEFINE_RES_IRQ_NAMED(0, "IRQ"),
>         /*
>          * We will pass IRQ_BASE to the driver now but this can be removed
> @@ -75,19 +75,19 @@ static struct resource msic_audio_resources[] = {
>         DEFINE_RES_MEM_NAMED(MSIC_IRQ_STATUS_ACCDET, 1, "IRQ_BASE"),
>  };
>
> -static struct resource msic_hdmi_resources[] = {
> +static const struct resource msic_hdmi_resources[] = {
>         DEFINE_RES_IRQ(0),
>  };
>
> -static struct resource msic_thermal_resources[] = {
> +static const struct resource msic_thermal_resources[] = {
>         DEFINE_RES_IRQ(0),
>  };
>
> -static struct resource msic_power_btn_resources[] = {
> +static const struct resource msic_power_btn_resources[] = {
>         DEFINE_RES_IRQ(0),
>  };
>
> -static struct resource msic_ocd_resources[] = {
> +static const struct resource msic_ocd_resources[] = {
>         DEFINE_RES_IRQ(0),
>  };
>
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index eba89780dbe7..47d0d3a69a58 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -200,32 +200,32 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip_crit = {
>         .num_regs = 1,
>  };
>
> -static struct resource gpio_resources[] = {
> +static const struct resource gpio_resources[] = {
>         DEFINE_RES_IRQ_NAMED(BXTWC_GPIO_LVL1_IRQ, "GPIO"),
>  };
>
> -static struct resource adc_resources[] = {
> +static const struct resource adc_resources[] = {
>         DEFINE_RES_IRQ_NAMED(BXTWC_ADC_IRQ, "ADC"),
>  };
>
> -static struct resource usbc_resources[] = {
> +static const struct resource usbc_resources[] = {
>         DEFINE_RES_IRQ(BXTWC_USBC_IRQ),
>  };
>
> -static struct resource charger_resources[] = {
> +static const struct resource charger_resources[] = {
>         DEFINE_RES_IRQ_NAMED(BXTWC_CHGR0_IRQ, "CHARGER"),
>         DEFINE_RES_IRQ_NAMED(BXTWC_CHGR1_IRQ, "CHARGER1"),
>  };
>
> -static struct resource thermal_resources[] = {
> +static const struct resource thermal_resources[] = {
>         DEFINE_RES_IRQ(BXTWC_THRM_LVL1_IRQ),
>  };
>
> -static struct resource bcu_resources[] = {
> +static const struct resource bcu_resources[] = {
>         DEFINE_RES_IRQ_NAMED(BXTWC_BCU_IRQ, "BCU"),
>  };
>
> -static struct resource tmu_resources[] = {
> +static const struct resource tmu_resources[] = {
>         DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
>  };
>
> diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
> index 64b5c3cc30e7..1c7577b881ff 100644
> --- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
> +++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
> @@ -32,23 +32,23 @@ enum {
>         CHTDC_TI_CCEOCAL = 7,   /* battery */
>  };
>
> -static struct resource power_button_resources[] = {
> +static const struct resource power_button_resources[] = {
>         DEFINE_RES_IRQ(CHTDC_TI_PWRBTN),
>  };
>
> -static struct resource thermal_resources[] = {
> +static const struct resource thermal_resources[] = {
>         DEFINE_RES_IRQ(CHTDC_TI_DIETMPWARN),
>  };
>
> -static struct resource adc_resources[] = {
> +static const struct resource adc_resources[] = {
>         DEFINE_RES_IRQ(CHTDC_TI_ADCCMPL),
>  };
>
> -static struct resource pwrsrc_resources[] = {
> +static const struct resource pwrsrc_resources[] = {
>         DEFINE_RES_IRQ(CHTDC_TI_VBUSDET),
>  };
>
> -static struct resource battery_resources[] = {
> +static const struct resource battery_resources[] = {
>         DEFINE_RES_IRQ(CHTDC_TI_VBATLOW),
>         DEFINE_RES_IRQ(CHTDC_TI_CCEOCAL),
>  };
> diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
> index be84bb2aa837..49c5f71664bc 100644
> --- a/drivers/mfd/intel_soc_pmic_chtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_chtwc.c
> @@ -41,11 +41,11 @@ enum {
>         CHT_WC_CRIT_IRQ = 7,
>  };
>
> -static struct resource cht_wc_pwrsrc_resources[] = {
> +static const struct resource cht_wc_pwrsrc_resources[] = {
>         DEFINE_RES_IRQ(CHT_WC_PWRSRC_IRQ),
>  };
>
> -static struct resource cht_wc_ext_charger_resources[] = {
> +static const struct resource cht_wc_ext_charger_resources[] = {
>         DEFINE_RES_IRQ(CHT_WC_EXT_CHGR_IRQ),
>  };
>
> diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
> index 429efa1f8e55..38acb20e2d60 100644
> --- a/drivers/mfd/intel_soc_pmic_crc.c
> +++ b/drivers/mfd/intel_soc_pmic_crc.c
> @@ -28,23 +28,23 @@
>  #define CRYSTAL_COVE_IRQ_GPIO          5
>  #define CRYSTAL_COVE_IRQ_VHDMIOCP      6
>
> -static struct resource gpio_resources[] = {
> +static const struct resource gpio_resources[] = {
>         DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_GPIO, "GPIO"),
>  };
>
> -static struct resource pwrsrc_resources[] = {
> +static const struct resource pwrsrc_resources[] = {
>         DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_PWRSRC, "PWRSRC"),
>  };
>
> -static struct resource adc_resources[] = {
> +static const struct resource adc_resources[] = {
>         DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_ADC, "ADC"),
>  };
>
> -static struct resource thermal_resources[] = {
> +static const struct resource thermal_resources[] = {
>         DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_THRM, "THERMAL"),
>  };
>
> -static struct resource bcu_resources[] = {
> +static const struct resource bcu_resources[] = {
>         DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_BCU, "BCU"),
>  };
>
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
