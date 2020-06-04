Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC061EDFA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 10:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgFDIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgFDIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:17:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A522C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:17:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l10so5030770wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H978+TCH9KpI3d6kLgIfkTRIeoHQ9QYkmJAH+I1E3Uw=;
        b=JgR95aeFS73ImGo0lkhvbo8ijFkoJFDRyZYS5gRZ5tBJdKnob4s6o0WYllRjm+AE6I
         55p0JAJeZAwe25Lz0ahYCrm72yaCv8L6Q6xf7CCik9yqY8UTpZoXKfpkYpy8XjkAj9FT
         RSrNrRhmz8mNbs8/XWZgU3vNagLX5xoHkorEwgmFKV2AowtYABOU48qI71fVsZSeZRzw
         BleZndamsaFaqc2oxSXapRYdnvadgYWIFmdfS6HmJuteM61VD3HPt4m7Ms18ka3PCvRp
         E2AdYGLnztkC6CZnWnhvvweTWgm5fxpYIyIUQTYjvWeYi4UuV97RJegeuWhZ9CedtnAl
         izRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H978+TCH9KpI3d6kLgIfkTRIeoHQ9QYkmJAH+I1E3Uw=;
        b=q7Q90eL1/fgZRv+++eUqYkvqVniIaHwJnAUnO83aLs12Aqx59tGmRnhlXXqeahtfVc
         W3ICIu6SiGsM/Wn97Nc6nTGywZcFFTPglRZylairMEei+O+Z0asrxQSleI4OD6yFnn6Y
         L3FUcAzCK2UoaF1KT0tPxvdsOum+FYCSlul8/JMp9IdU/qUiIuPkZo+4isvVrzeWnvK2
         zKIH5JcYE7RhpAt8hSLhiWSswB7T5IkbbiGLE/hkfVZB1HZpNJRi2/FzVf/YqfwdNiZL
         GeTL30VXDwOtz38ix2dQGMpVe7Clbh0ced5Ywdd//mGyaM+fW2Aknh6Q/T9U9VTLlWiL
         c4+g==
X-Gm-Message-State: AOAM532yJhXD/eIsnaCUaoxniUVI18j0lKCjRrbQE6R6sM2KjjFk+AFs
        MQ2N0GRa1bN4ovk1jHXgb4rq/oNYTQqn75q85No=
X-Google-Smtp-Source: ABdhPJzsTuXF4U1b4rt6o6WT2nkKwH+UkcH9IFb8+UQRRpcV0Vv7z5zECkpjTca5j+73+Qk879vi60ZCnHIflRVoyTA=
X-Received: by 2002:a5d:4385:: with SMTP id i5mr3138102wrq.420.1591258647809;
 Thu, 04 Jun 2020 01:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200527062147.680-1-zhang.lyra@gmail.com>
In-Reply-To: <20200527062147.680-1-zhang.lyra@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 4 Jun 2020 16:16:51 +0800
Message-ID: <CAAfSe-voe6as4VveyMt2pyJR1jytdzfRCp1z3s9AnS+QzTvPKA@mail.gmail.com>
Subject: Re: [PATCH V2] mfd: sprd: Add wakeup capability for PMIC irq
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Wed, 27 May 2020 at 14:21, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Baolin Wang <baolin.wang7@gmail.com>
>
> When changing to use suspend-to-idle to save power, the PMIC irq can not
> wakeup the system due to lack of wakeup capability, which will cause
> the sub-irqs (such as power key) of the PMIC can not wake up the system.
> Thus we can add the wakeup capability for PMIC irq to solve this issue,
> as well as removing the IRQF_NO_SUSPEND flag to allow PMIC irq to be
> a wakeup source.
>
> Reported-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> Tested-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> Changes from v1:
> * addressed comments from Lee;
> * added tested-by from Chunyan.
> (This patch is rebased on branch for-mfd-next)

Could you please pick up this patch if there's no more comments :)

Thanks,
Chunyan

> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index 33336cde4724..adb4a1b13332 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -256,7 +256,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
>         }
>
>         ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
> -                                      IRQF_ONESHOT | IRQF_NO_SUSPEND, 0,
> +                                      IRQF_ONESHOT, 0,
>                                        &ddata->irq_chip, &ddata->irq_data);
>         if (ret) {
>                 dev_err(&spi->dev, "Failed to add PMIC irq chip %d\n", ret);
> @@ -272,9 +272,34 @@ static int sprd_pmic_probe(struct spi_device *spi)
>                 return ret;
>         }
>
> +       device_init_wakeup(&spi->dev, true);
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sprd_pmic_suspend(struct device *dev)
> +{
> +       struct sprd_pmic *ddata = dev_get_drvdata(dev);
> +
> +       if (device_may_wakeup(dev))
> +               enable_irq_wake(ddata->irq);
> +
> +       return 0;
> +}
> +
> +static int sprd_pmic_resume(struct device *dev)
> +{
> +       struct sprd_pmic *ddata = dev_get_drvdata(dev);
> +
> +       if (device_may_wakeup(dev))
> +               disable_irq_wake(ddata->irq);
> +
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
> +
>  static const struct of_device_id sprd_pmic_match[] = {
>         { .compatible = "sprd,sc2731", .data = &sc2731_data },
>         {},
> @@ -285,6 +310,7 @@ static struct spi_driver sprd_pmic_driver = {
>         .driver = {
>                 .name = "sc27xx-pmic",
>                 .of_match_table = sprd_pmic_match,
> +               .pm = &sprd_pmic_pm_ops,
>         },
>         .probe = sprd_pmic_probe,
>  };
> --
> 2.20.1
>
