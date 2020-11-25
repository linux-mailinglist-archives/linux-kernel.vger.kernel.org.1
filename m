Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120092C35B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 01:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgKYAo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 19:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgKYAoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:44:55 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B5EC0613D4;
        Tue, 24 Nov 2020 16:44:55 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id j23so437113iog.6;
        Tue, 24 Nov 2020 16:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEbPZRA+qbA9GxCy4DMkd08K0DrmAEkt9ORyM62O+P4=;
        b=NvNt69SwBMRCvVvcbLgi5zG5qsxloFTWGZtgABixeCvsD83mcKPoUNNb3P/YG19I0d
         zFlxHQjnG8M93znWM0HLEm15LFoQDlmPW0ZRfpkZFpgNpbsn0rCrg8ggRM4R/FWhZpc8
         18FmOtl9JAPsCo6ITc5pdLuk9cUxXF0HW9gLsKKY5Pzx9KgZysFmQhiVXFkwehqsB+yP
         iOGuJZcjWpd3PwvEA2tz64z/rW9ea/SwwqHw0/NO5Lke0TD+ShlMlarSBkxtHUH7Rfv3
         xGh9AQZHTvwJjMTI00v1V71hfrnXf9GjKxJN9Dfz56qOjvd9ckxSV5XA2xPBH2ejzsI1
         OxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEbPZRA+qbA9GxCy4DMkd08K0DrmAEkt9ORyM62O+P4=;
        b=lADZmeFokLMgkHoFJa4DSvdE1sF17yTdstvVduCvs0eUJ9b1G8hfm4mN2UrtafKsKB
         vnnH/FmstHxdiFqG9CGz2DOap4dW4JPJu/PyNuTXM32qXG7rCSH+qFlvTvvLgkZo+5r0
         tvlN9iEm2dOogqOiIS10q5OvQwB66xmsdCqsXKCYCk97AnOgP1I1Z+3sR4x5TICEkG3V
         +Jg+ulERu/wj8nUjhvVh4YDr8fK6WvSxn0jfNYR+GLoV9RO0dwRWcDd955wCHLgFlWbh
         dAldYx23S2OwKSpYttyhTBiHbt/mpJUnZaCqAeIRpYnOvWPNYyxiN1dXW3LkNHkaf74E
         ptsQ==
X-Gm-Message-State: AOAM531o4rZ0ovMwRWX0BSruG7fzTB07VrCZZi+s36NL+eKnMa8tOh3a
        wZIMzO20Q9uBUVIvQ0pBU0r4YU7lOaX7a1Qc0nw=
X-Google-Smtp-Source: ABdhPJzFSlV7OFBoJCCTpLJPhe96AEXVxmiJ1nXHUmbNH/Q7+3fPr10Cne6Y2te6J9EGKeTSubokyntzby4OcXfXLCE=
X-Received: by 2002:a02:6c09:: with SMTP id w9mr1092614jab.135.1606265094163;
 Tue, 24 Nov 2020 16:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20201124015949.29262-1-alice.guo@nxp.com> <20201124015949.29262-4-alice.guo@nxp.com>
In-Reply-To: <20201124015949.29262-4-alice.guo@nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 24 Nov 2020 18:44:42 -0600
Message-ID: <CAHCN7x+xRNZAEU0Y_nRSsKE5UtSvHT4E5WLx_NvLncbQMndnbw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] soc: imx8m: change to use platform driver
To:     Alice Guo <alice.guo@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 8:04 PM Alice Guo <alice.guo@nxp.com> wrote:
>
> Directly reading ocotp register depends on that bootloader enables ocotp
> clk, which is not always effective, so change to use nvmem API. Using
> nvmem API requires to support driver defer probe and thus change
> soc-imx8m.c to use platform driver.
>
> The other reason is that directly reading ocotp register causes kexec
> kernel hang because the 1st kernel running will disable unused clks
> after kernel boots up, and then ocotp clk will be disabled even if
> bootloader enables it. When kexec kernel, ocotp clk needs to be enabled
> before reading ocotp registers, and nvmem API with platform driver
> supported can accomplish this.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>
The patch reads V6, but the change log only shows V2.  Can you
elaborate on what has changed between V2 and V6?

adam

> v2: remove the subject prefix "LF-2571-4"
> v3: Keep the original way which uses device_initcall to read soc unique
>     ID, and add the other way which uses module_platform_driver and
>     nvmem API, so that it will not break the old version DTBs.
> v4: delete "__maybe_unused"
>     delete MODULE_DEVICE_TABLE(of, imx8m_soc_match);
>     rename match table, "fsl,imx8mm/n/q/p" is actually a machine
> compabile and "fsl,imx8mm/n/q/p-soc" is a compabile of soc@0
>     delete "flag" and change to determine whether the pointer is NULL
>     ues of_find_matching_node_and_match()
>     delete of_match_ptr()
> v5: add cleanup part "of_node_put"
>     add note to explain that why device_initcall still exists
> v6: none
>
>  drivers/soc/imx/soc-imx8m.c | 87 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 75 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index cc57a384d74d..250530177920 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -5,6 +5,8 @@
>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of_address.h>
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
> @@ -29,7 +31,7 @@
>
>  struct imx8_soc_data {
>         char *name;
> -       u32 (*soc_revision)(void);
> +       u32 (*soc_revision)(struct device *dev);
>  };
>
>  static u64 soc_uid;
> @@ -50,7 +52,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
>  static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
>  #endif
>
> -static u32 __init imx8mq_soc_revision(void)
> +static u32 __init imx8mq_soc_revision(struct device *dev)
>  {
>         struct device_node *np;
>         void __iomem *ocotp_base;
> @@ -75,9 +77,20 @@ static u32 __init imx8mq_soc_revision(void)
>                         rev = REV_B1;
>         }
>
> -       soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> -       soc_uid <<= 32;
> -       soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +       if (dev) {
> +               int ret = 0;
> +
> +               ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
> +               if (ret) {
> +                       iounmap(ocotp_base);
> +                       of_node_put(np);
> +                       return ret;
> +               }
> +       } else {
> +               soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> +               soc_uid <<= 32;
> +               soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +       }
>
>         iounmap(ocotp_base);
>         of_node_put(np);
> @@ -107,7 +120,7 @@ static void __init imx8mm_soc_uid(void)
>         of_node_put(np);
>  }
>
> -static u32 __init imx8mm_soc_revision(void)
> +static u32 __init imx8mm_soc_revision(struct device *dev)
>  {
>         struct device_node *np;
>         void __iomem *anatop_base;
> @@ -125,7 +138,15 @@ static u32 __init imx8mm_soc_revision(void)
>         iounmap(anatop_base);
>         of_node_put(np);
>
> -       imx8mm_soc_uid();
> +       if (dev) {
> +               int ret = 0;
> +
> +               ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               imx8mm_soc_uid();
> +       }
>
>         return rev;
>  }
> @@ -150,7 +171,7 @@ static const struct imx8_soc_data imx8mp_soc_data = {
>         .soc_revision = imx8mm_soc_revision,
>  };
>
> -static __maybe_unused const struct of_device_id imx8_soc_match[] = {
> +static const struct of_device_id imx8_machine_match[] = {
>         { .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
>         { .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
>         { .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
> @@ -158,12 +179,20 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
>         { }
>  };
>
> +static const struct of_device_id imx8_soc_match[] = {
> +       { .compatible = "fsl,imx8mq-soc", .data = &imx8mq_soc_data, },
> +       { .compatible = "fsl,imx8mm-soc", .data = &imx8mm_soc_data, },
> +       { .compatible = "fsl,imx8mn-soc", .data = &imx8mn_soc_data, },
> +       { .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
> +       { }
> +};
> +
>  #define imx8_revision(soc_rev) \
>         soc_rev ? \
>         kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
>         "unknown"
>
> -static int __init imx8_soc_init(void)
> +static int imx8_soc_info(struct platform_device *pdev)
>  {
>         struct soc_device_attribute *soc_dev_attr;
>         struct soc_device *soc_dev;
> @@ -182,7 +211,10 @@ static int __init imx8_soc_init(void)
>         if (ret)
>                 goto free_soc;
>
> -       id = of_match_node(imx8_soc_match, of_root);
> +       if (pdev)
> +               id = of_match_node(imx8_soc_match, pdev->dev.of_node);
> +       else
> +               id = of_match_node(imx8_machine_match, of_root);
>         if (!id) {
>                 ret = -ENODEV;
>                 goto free_soc;
> @@ -191,8 +223,16 @@ static int __init imx8_soc_init(void)
>         data = id->data;
>         if (data) {
>                 soc_dev_attr->soc_id = data->name;
> -               if (data->soc_revision)
> -                       soc_rev = data->soc_revision();
> +               if (data->soc_revision) {
> +                       if (pdev) {
> +                               soc_rev = data->soc_revision(&pdev->dev);
> +                               ret = soc_rev;
> +                               if (ret < 0)
> +                                       goto free_soc;
> +                       } else {
> +                               soc_rev = data->soc_revision(NULL);
> +                       }
> +               }
>         }
>
>         soc_dev_attr->revision = imx8_revision(soc_rev);
> @@ -230,4 +270,27 @@ static int __init imx8_soc_init(void)
>         kfree(soc_dev_attr);
>         return ret;
>  }
> +
> +/* Retain device_initcall is for backward compatibility with DTS. */
> +static int __init imx8_soc_init(void)
> +{
> +       int ret = 0;
> +
> +       if (of_find_matching_node_and_match(NULL, imx8_soc_match, NULL))
> +               return 0;
> +
> +       ret = imx8_soc_info(NULL);
> +       return ret;
> +}
>  device_initcall(imx8_soc_init);
> +
> +static struct platform_driver imx8_soc_info_driver = {
> +       .probe = imx8_soc_info,
> +       .driver = {
> +               .name = "imx8_soc_info",
> +               .of_match_table = imx8_soc_match,
> +       },
> +};
> +
> +module_platform_driver(imx8_soc_info_driver);
> +MODULE_LICENSE("GPL v2");
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
