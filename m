Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA26F2FDF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404247AbhATXxt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jan 2021 18:53:49 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:41196 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbhATVaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:30:13 -0500
Received: by mail-ej1-f48.google.com with SMTP id g12so35583180ejf.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+o6HGPiViAIr2DHqFpPeY8IyCTAEuh1zYRN4P/Gv+oA=;
        b=ErDiHtUjHVcJxIp/w7LHGAe3ucD8dwyoZyliRXppefAM8i3s8LaxOOyJeYty6YgE3i
         G+E5z8fOJ+ijk3h38h8SX47icNzdZNaAkOD5DniAmxeKQJNDC3y0Sm4Bsi2yZjQgCRA9
         k8ip1fz0gWmOwa7KyLIkkGj0Bfjc6mB7NFCgdOfydzx14SkjnBXXM8M2YyhYyaFxC+nZ
         J5UTnzZhpX9AihapF+U0TDmPEMH01+zMsHomf8X7ZYGbGhETV5Wsa76v7wpDTgciRp1r
         9Wav/Vy91NWLFdQIBgMVYHRi9NTNIHr5jIBlHgh0buoRSOwNz5LUJ4fkUQ7L3HVAMIt1
         cygA==
X-Gm-Message-State: AOAM532QlgQ+tdq+iNgzmZL+2lmq+tAKJ7fqE5Ldnb8XRTj041bYR9nk
        OGvQfkhETfWPKJIxep3sKK+TgVjwprQngvv8os0=
X-Google-Smtp-Source: ABdhPJwiB/VWZ6JORvmRLQFPRZBmSUGUCt7cPC/ZHWAKXd56+Nsr1sclzsMg11gZw/R4r5oHNFr1yvxEXnrlcLrHga0=
X-Received: by 2002:a17:906:32d6:: with SMTP id k22mr7321402ejk.457.1611178170937;
 Wed, 20 Jan 2021 13:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20210120132154.2224550-1-arnd@kernel.org>
In-Reply-To: <20210120132154.2224550-1-arnd@kernel.org>
From:   Barry Song <baohua@kernel.org>
Date:   Thu, 21 Jan 2021 10:29:19 +1300
Message-ID: <CAGsJ_4x0KuKp1CtK8oOgMwjmikb5sAjyJtqax2a-CA7phi63zw@mail.gmail.com>
Subject: Re: [PATCH] hwspinlock: remove sirf driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> 于2021年1月21日周四 上午2:22写道：
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The CSR SiRF prima2/atlas platforms are getting removed, so this driver
> is no longer needed.
>
> Cc: Barry Song <baohua@kernel.org>
> Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  .../bindings/hwlock/sirf,hwspinlock.txt       |  28 -----
>  drivers/hwspinlock/Kconfig                    |  11 --
>  drivers/hwspinlock/Makefile                   |   1 -
>  drivers/hwspinlock/sirf_hwspinlock.c          | 105 ------------------
>  4 files changed, 145 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwlock/sirf,hwspinlock.txt
>  delete mode 100644 drivers/hwspinlock/sirf_hwspinlock.c
>
> diff --git a/Documentation/devicetree/bindings/hwlock/sirf,hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/sirf,hwspinlock.txt
> deleted file mode 100644
> index 9bb1240a68e0..000000000000
> --- a/Documentation/devicetree/bindings/hwlock/sirf,hwspinlock.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -SIRF Hardware spinlock device Binding
> ------------------------------------------------
> -
> -Required properties :
> -- compatible : shall contain only one of the following:
> -       "sirf,hwspinlock"
> -
> -- reg : the register address of hwspinlock
> -
> -- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
> -       hwlock, so the number of cells should be <1> here.
> -
> -Please look at the generic hwlock binding for usage information for consumers,
> -"Documentation/devicetree/bindings/hwlock/hwlock.txt"
> -
> -Example of hwlock provider:
> -       hwlock {
> -               compatible = "sirf,hwspinlock";
> -               reg = <0x13240000 0x00010000>;
> -               #hwlock-cells = <1>;
> -       };
> -
> -Example of hwlock users:
> -       node {
> -               ...
> -               hwlocks = <&hwlock 2>;
> -               ...
> -       };
> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> index 32cd26352f38..53e13476e831 100644
> --- a/drivers/hwspinlock/Kconfig
> +++ b/drivers/hwspinlock/Kconfig
> @@ -28,17 +28,6 @@ config HWSPINLOCK_QCOM
>
>           If unsure, say N.
>
> -config HWSPINLOCK_SIRF
> -       tristate "SIRF Hardware Spinlock device"
> -       depends on ARCH_SIRF || COMPILE_TEST
> -       help
> -         Say y here to support the SIRF Hardware Spinlock device, which
> -         provides a synchronisation mechanism for the various processors
> -         on the SoC.
> -
> -         It's safe to say n here if you're not interested in SIRF hardware
> -         spinlock or just want a bare minimum kernel.
> -
>  config HWSPINLOCK_SPRD
>         tristate "SPRD Hardware Spinlock device"
>         depends on ARCH_SPRD || COMPILE_TEST
> diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
> index ed053e3f02be..1f8dd6f5814f 100644
> --- a/drivers/hwspinlock/Makefile
> +++ b/drivers/hwspinlock/Makefile
> @@ -6,7 +6,6 @@
>  obj-$(CONFIG_HWSPINLOCK)               += hwspinlock_core.o
>  obj-$(CONFIG_HWSPINLOCK_OMAP)          += omap_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_QCOM)          += qcom_hwspinlock.o
> -obj-$(CONFIG_HWSPINLOCK_SIRF)          += sirf_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_SPRD)          += sprd_hwspinlock.o
>  obj-$(CONFIG_HWSPINLOCK_STM32)         += stm32_hwspinlock.o
>  obj-$(CONFIG_HSEM_U8500)               += u8500_hsem.o
> diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
> deleted file mode 100644
> index a3f77120bad7..000000000000
> --- a/drivers/hwspinlock/sirf_hwspinlock.c
> +++ /dev/null
> @@ -1,105 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * SIRF hardware spinlock driver
> - *
> - * Copyright (c) 2015 Cambridge Silicon Radio Limited, a CSR plc group company.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/device.h>
> -#include <linux/io.h>
> -#include <linux/slab.h>
> -#include <linux/spinlock.h>
> -#include <linux/hwspinlock.h>
> -#include <linux/platform_device.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -
> -#include "hwspinlock_internal.h"
> -
> -struct sirf_hwspinlock {
> -       void __iomem *io_base;
> -       struct hwspinlock_device bank;
> -};
> -
> -/* Number of Hardware Spinlocks*/
> -#define        HW_SPINLOCK_NUMBER      30
> -
> -/* Hardware spinlock register offsets */
> -#define HW_SPINLOCK_BASE       0x404
> -#define HW_SPINLOCK_OFFSET(x)  (HW_SPINLOCK_BASE + 0x4 * (x))
> -
> -static int sirf_hwspinlock_trylock(struct hwspinlock *lock)
> -{
> -       void __iomem *lock_addr = lock->priv;
> -
> -       /* attempt to acquire the lock by reading value == 1 from it */
> -       return !!readl(lock_addr);
> -}
> -
> -static void sirf_hwspinlock_unlock(struct hwspinlock *lock)
> -{
> -       void __iomem *lock_addr = lock->priv;
> -
> -       /* release the lock by writing 0 to it */
> -       writel(0, lock_addr);
> -}
> -
> -static const struct hwspinlock_ops sirf_hwspinlock_ops = {
> -       .trylock = sirf_hwspinlock_trylock,
> -       .unlock = sirf_hwspinlock_unlock,
> -};
> -
> -static int sirf_hwspinlock_probe(struct platform_device *pdev)
> -{
> -       struct sirf_hwspinlock *hwspin;
> -       struct hwspinlock *hwlock;
> -       int idx;
> -
> -       if (!pdev->dev.of_node)
> -               return -ENODEV;
> -
> -       hwspin = devm_kzalloc(&pdev->dev,
> -                             struct_size(hwspin, bank.lock,
> -                                         HW_SPINLOCK_NUMBER),
> -                             GFP_KERNEL);
> -       if (!hwspin)
> -               return -ENOMEM;
> -
> -       /* retrieve io base */
> -       hwspin->io_base = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(hwspin->io_base))
> -               return PTR_ERR(hwspin->io_base);
> -
> -       for (idx = 0; idx < HW_SPINLOCK_NUMBER; idx++) {
> -               hwlock = &hwspin->bank.lock[idx];
> -               hwlock->priv = hwspin->io_base + HW_SPINLOCK_OFFSET(idx);
> -       }
> -
> -       platform_set_drvdata(pdev, hwspin);
> -
> -       return devm_hwspin_lock_register(&pdev->dev, &hwspin->bank,
> -                                        &sirf_hwspinlock_ops, 0,
> -                                        HW_SPINLOCK_NUMBER);
> -}
> -
> -static const struct of_device_id sirf_hwpinlock_ids[] = {
> -       { .compatible = "sirf,hwspinlock", },
> -       {},
> -};
> -MODULE_DEVICE_TABLE(of, sirf_hwpinlock_ids);
> -
> -static struct platform_driver sirf_hwspinlock_driver = {
> -       .probe = sirf_hwspinlock_probe,
> -       .driver = {
> -               .name = "atlas7_hwspinlock",
> -               .of_match_table = sirf_hwpinlock_ids,
> -       },
> -};
> -
> -module_platform_driver(sirf_hwspinlock_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("SIRF Hardware spinlock driver");
> -MODULE_AUTHOR("Wei Chen <wei.chen@csr.com>");
> --
> 2.29.2
>
