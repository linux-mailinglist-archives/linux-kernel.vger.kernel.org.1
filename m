Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE542FDD96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbhAUAEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732597AbhATVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:47:08 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F75C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:46:28 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b64so26873089qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8NzCUdMQMvN88u/fqxqFMGHYAw7U6x8lsT5MGWH9Hc=;
        b=Mmyvs9MlyfnrDINk81HyfAnsbRaFbIBGDIcca4EOSKkbAOJXgUuEVD9DyT5RtUR3TE
         K0sGViTJkkvPUdy2vtZtp549g8+fypsnJwHYAlUkbCTmpIXjYECA9A4vobKDiZL8GlL8
         F9OPFb8gEbQmzW5h8LnjmnZAnjhOU1ND9kroE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8NzCUdMQMvN88u/fqxqFMGHYAw7U6x8lsT5MGWH9Hc=;
        b=XljmeG8DkXkkRV62zjgWbw3kq+1ShDsqADgBjzzo54JvwU40es211kwoTjyFKtbUmb
         C89lgfPc7QDjFp8rOIUi6KO4v0zJltfjPBOe4q/ZMhWT2IoA/wRTYvh37UArrgvaHd4r
         meIxsZeSFOTJaBk/XVKDtDm3ILSOfoi3KWEelmleubHt5/Cz+3PqZBYk769I3y2h9rnU
         yb06C7RTVx3mZ3izJtUQ9hZ6vIES7YDNvdw5WzIXGZdMbsXGH6e+L5D/TMrCpbhlIKhl
         qfKpDp79e7MWD3eFL6y7jpj6IOQ6fx3Rsf89oe6CIUR5gPK9UhoSBzJOmcEf6EbJVDgK
         PuYQ==
X-Gm-Message-State: AOAM530qJhSSZnwKgrvIRg/Zid61RInUX+TREMxuIrEPqJinXTIreCw6
        hKBp9ac4MLn0zwhrlNo8ZqOIq5IQpwn96aG0KPU=
X-Google-Smtp-Source: ABdhPJwq7n8HIc4iAe9C7OhO9ciCYj36dR+LJel/pZ6W5RZVHThTDrnRjqUpeMxvfVJOibIL82cHVk8QgXQVfJlhEjE=
X-Received: by 2002:a37:a085:: with SMTP id j127mr11405768qke.273.1611179186264;
 Wed, 20 Jan 2021 13:46:26 -0800 (PST)
MIME-Version: 1.0
References: <20210119080938.1832733-1-geert@linux-m68k.org>
In-Reply-To: <20210119080938.1832733-1-geert@linux-m68k.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 20 Jan 2021 21:46:13 +0000
Message-ID: <CACPK8Xcj6L7StcBayPVV8QH7DbE+1oQBojfHviAmzaSq_xo7Uw@mail.gmail.com>
Subject: Re: [PATCH v4] drivers/soc/litex: Add restart handler
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 at 08:14, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Let the LiteX SoC Controller register a restart handler, which resets
> the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

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
