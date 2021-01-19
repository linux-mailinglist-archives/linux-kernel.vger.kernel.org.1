Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8D2FB3E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbhASITf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbhASISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:18:43 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8BCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:18:02 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o13so27856285lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bex7COrdJ/07+iU2EYVxWE5mtZ00AfCIkhn7mqzRkwQ=;
        b=Sgy4vEIxGxOZvbB0AyDKeuqwfz/6V6aXNblu7uZ5cg7SaUuH8ICezC0KLXM1Q5kLr/
         NiIc4bRWnjBbprMMa8osrRXVoebxfEO2rSliTgXU6ct47WpOnO/VAn8Vj6xTwVwKiYJO
         sOQzNAidTzRAb4jQ5ksO6JvwbjlHIgerkFd/mAr8eFocesTIa6rJO2AXlST/aMJPSTgW
         3rvob0OQvjDg5JTCYjJpgpafHGFyVclpCOa1mzGJbydEuuMeqyBbeFiANi7TvT8FgZyl
         urVA0VXipjl+FKLtGefVHCiAQB03hhgugYHH5Fnn5GfFEjyVFlSxNzpV1ASfECgIIQKe
         zbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bex7COrdJ/07+iU2EYVxWE5mtZ00AfCIkhn7mqzRkwQ=;
        b=irZH4hiVYB+ihLKNDkAVn6GAE9oVg9Up9TK60pZenpZd/v2b08qmXQfB21dM5kBYwX
         GQtFI0v/9ERoYTOuPQwK/+6Q1NupRmlB+fHRjrqJUQBfYPpgKJWKq9zzI/+jOpH2q14Q
         1pDGnPU0p4tAoUo07jngjgGucevVSqDEHGv/W7x0uVgGgumTIP9SCCuszaxvUnOouaJL
         EaAFJRKqmoUfWOuBPLuyvMFJnuhicHjwSpNFTtdq0Troi0XQyVJaSq3YJ4gVOkLKFrGO
         83dHcm7JdzvCQlXhvYs4X+hG2ugA1VmGnNjf8vk/fJLyIAL/TEhyc9JA8a2OGdIHoJIl
         SYAw==
X-Gm-Message-State: AOAM530yMtpSd2Li9qyQp28TXsAPmRsYQ8LnCwz8c4VzxVGxk3SJHieh
        aDqDK+myZpfHp5+Dzp8GsSGowkYFBdoGFDvDGDmUDQaZzekQlc+7
X-Google-Smtp-Source: ABdhPJwMoFMQkXJv8+k3HuexsPpIdE6JBDv/cvZETT+bzC6wWwKKKfJL1Y27gtSD+KcJe4tpj3GeOHICWb8qtoxWEeI=
X-Received: by 2002:a05:6512:3222:: with SMTP id f2mr1404944lfe.25.1611044280842;
 Tue, 19 Jan 2021 00:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20210119080938.1832733-1-geert@linux-m68k.org>
In-Reply-To: <20210119080938.1832733-1-geert@linux-m68k.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 19 Jan 2021 13:47:49 +0530
Message-ID: <CAAhSdy3woKdo1=sZRO3ua=hK6M8NM7dp3nMFX99dKoUOC6+W5Q@mail.gmail.com>
Subject: Re: [PATCH v4] drivers/soc/litex: Add restart handler
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 19, 2021 at 1:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Let the LiteX SoC Controller register a restart handler, which resets
> the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

We have SBI System Reset Extension (SRST) in upcoming
SBI v0.3 spec. Using this SBI extension, you will not require a
dedicated reboot driver for various projects such as Linux kernel,
U-Boot, EDK2, FreeBSD kernel, etc.

The OpenSBI v0.9 (released yesterday) already has SBI SRST
extension implemented so we will just need platform hooks for
LiteX.

The Linux support for SRST extension is already available on
LKML so far no comments: https://lkml.org/lkml/2020/11/25/6

Regards,
Anup


> ---
> v4:
>   - Drop bogus "a" from description,
>   - Get rid of static litex_soc_ctrl_device and litex_reset_nb
>     instances,
>   - Unregister handler on driver unbind,
>
> v3:
>   - Rebase on top of openrisc/for-next,
>
> v2:
>   - Rebase on top of v5.11-rc1,
>   - Change reset handler priority to recommended default value of 128
>     (was 192).
>
> (v1 was not sent to a mailing list)
> ---
>  drivers/soc/litex/litex_soc_ctrl.c | 42 +++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> index da17ba56b7956c84..a7dd5be9fd5bd8ad 100644
> --- a/drivers/soc/litex/litex_soc_ctrl.c
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -15,6 +15,11 @@
>  #include <linux/module.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> +#include <linux/reboot.h>
> +
> +/* reset register located at the base address */
> +#define RESET_REG_OFF           0x00
> +#define RESET_REG_VALUE         0x00000001
>
>  #define SCRATCH_REG_OFF         0x04
>  #define SCRATCH_REG_VALUE       0x12345678
> @@ -66,8 +71,19 @@ static int litex_check_csr_access(void __iomem *reg_addr)
>
>  struct litex_soc_ctrl_device {
>         void __iomem *base;
> +       struct notifier_block reset_nb;
>  };
>
> +static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
> +                              void *cmd)
> +{
> +       struct litex_soc_ctrl_device *soc_ctrl_dev =
> +               container_of(this, struct litex_soc_ctrl_device, reset_nb);
> +
> +       litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
> +       return NOTIFY_DONE;
> +}
> +
>  static const struct of_device_id litex_soc_ctrl_of_match[] = {
>         {.compatible = "litex,soc-controller"},
>         {},
> @@ -78,6 +94,7 @@ MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
>  static int litex_soc_ctrl_probe(struct platform_device *pdev)
>  {
>         struct litex_soc_ctrl_device *soc_ctrl_dev;
> +       int error;
>
>         soc_ctrl_dev = devm_kzalloc(&pdev->dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
>         if (!soc_ctrl_dev)
> @@ -87,7 +104,29 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
>         if (IS_ERR(soc_ctrl_dev->base))
>                 return PTR_ERR(soc_ctrl_dev->base);
>
> -       return litex_check_csr_access(soc_ctrl_dev->base);
> +       error = litex_check_csr_access(soc_ctrl_dev->base);
> +       if (error)
> +               return error;
> +
> +       platform_set_drvdata(pdev, soc_ctrl_dev);
> +
> +       soc_ctrl_dev->reset_nb.notifier_call = litex_reset_handler;
> +       soc_ctrl_dev->reset_nb.priority = 128;
> +       error = register_restart_handler(&soc_ctrl_dev->reset_nb);
> +       if (error) {
> +               dev_warn(&pdev->dev, "cannot register restart handler: %d\n",
> +                        error);
> +       }
> +
> +       return 0;
> +}
> +
> +static int litex_soc_ctrl_remove(struct platform_device *pdev)
> +{
> +       struct litex_soc_ctrl_device *soc_ctrl_dev = platform_get_drvdata(pdev);
> +
> +       unregister_restart_handler(&soc_ctrl_dev->reset_nb);
> +       return 0;
>  }
>
>  static struct platform_driver litex_soc_ctrl_driver = {
> @@ -96,6 +135,7 @@ static struct platform_driver litex_soc_ctrl_driver = {
>                 .of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
>         },
>         .probe = litex_soc_ctrl_probe,
> +       .remove = litex_soc_ctrl_remove,
>  };
>
>  module_platform_driver(litex_soc_ctrl_driver);
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
