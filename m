Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8F2F32FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbhALOcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhALOcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:32:53 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A501C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:32:12 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 23so3634285lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xpCveEKXq//QXL4c5UmcBDGbJR1Teqb+RM7TzhErMoc=;
        b=Vuc3tdhchFhahccdMZj8X8qcoec9tYBH3eeIeIiipY6k1YWd4Ds0b+dbk6Lu9jMD5A
         eJIv1poaTSwOqrFYoxNb0aMujTSB4JXPMmZgdop8mczviptjIFHvqEPePsCo7zrfHD8L
         B4fZ49u4BJhh3OcnPDYItQSPsZJiqz5+246V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xpCveEKXq//QXL4c5UmcBDGbJR1Teqb+RM7TzhErMoc=;
        b=eU1eUedjPVkq0QjTC2knMNC6JN+/2h6HLcnM1G0xKMo/ts3R0Pjgiorwl0UZODr4bd
         TIZvcvyeZSo+7PEGpFEcVP19DtFOo0zQJFKAhltu1oaPHAPR7JKutfdffshsZh4Tk5e2
         kczhoG11vfXs2Qw0eO7wQrmCZSB7tM+LAJtGrVO0H6fF2l9MNYo78M5r7zRnMxzkEJJn
         5yMLRradd5VUfy4qnxzgmh84CK0T+/11Jhk8HIDsDKGHOwdbNNsaiGlRuU1ZxRLvSnkm
         92xtXjmpiWGMLfORrw+1pcfUuCgqSF0VGxE4URpr2iTJcaWx1p1y0+vZyH/cgXrpqpcN
         DhJw==
X-Gm-Message-State: AOAM532Pa6itOQIN1mZ3rPamkQgQxWgVyH1hBvedPs3XtW1K73dAq1Gj
        7R8Ko60ziWXk3b//SNyTI3SsWNKDi1zsJh7XdXThbA==
X-Google-Smtp-Source: ABdhPJyjGy53QDhTQ0az5hIuTqEIE2Qu9d8FiJU+mT8UFH+/+VqFknRsZfEkxc/wytet/gwIb56huMJP0FJyrQeqCA0=
X-Received: by 2002:a19:5058:: with SMTP id z24mr2167898lfj.603.1610461930660;
 Tue, 12 Jan 2021 06:32:10 -0800 (PST)
MIME-Version: 1.0
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 12 Jan 2021 15:31:59 +0100
Message-ID: <CAPk366Tyj13foMsdTk-Mkp-7jrkfnba8spAHm14uUMtH0GLOwQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] drivers/soc/litex: support 32-bit subregisters,
 64-bit CPUs
To:     gsomlo@gmail.com
Cc:     f.kermarrec@gmail.com, gregkh@linuxfoundation.org,
        kgugala@antmicro.com, linux-kernel@vger.kernel.org,
        mholenko@antmicro.com, pczarnecki@internships.antmicro.com,
        shorne@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Upstream LiteX now defaults to using 32-bit CSR subregisters
> (see https://github.com/enjoy-digital/litex/commit/a2b71fde).
>
> This patch expands on commit 22447a99c97e ("drivers/soc/litex: add
> LiteX SoC Controller driver"), adding support for handling both 8-
> and 32-bit LiteX CSR (MMIO) subregisters, as determined by the
> LITEX_SUBREG_SIZE Kconfig option.

This sounds like a great feature!

> NOTE that while LITEX_SUBREG_SIZE could theoretically be a device
> tree property, defining it as a compile-time constant allows for
> much better optimization of the resulting code. This is further
> supported by the low expected usefulness of deploying the same
> kernel across LiteX SoCs built with different CSR-Bus data widths.
>
> The constant LITEX_REG_SIZE is renamed to the more descriptive
> LITEX_SUBREG_ALIGN (LiteX CSR subregisters are located at 32-bit
> aligned MMIO addresses).

Should it go to a separate commit? I have no strong opinions about that,
but it looks like an independent change.

> Finally, the litex_[read|write][8|16|32|64]() accessors are
> redefined in terms of litex_[get|set]_reg(), which, after compiler
> optimization, will result in code as efficient as hardcoded shifts,
> but with the added benefit of automatically matching the appropriate
> LITEX_SUBREG_SIZE.
>
> NOTE that litex_[get|set]_reg() nominally operate on 64-bit data,
> but that will also be optimized by the compiler in situations where
> narrower data is used from a call site.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>
> Changes since v4:
>     - tighter, more optimized implementation of 'litex_set_reg()'
>
> Changes since v3:
>     - improved legibility, fixed typos in commit blurb
>     - fixed instance of "disgusting" commit style :)
>     - litex_[get|set]_reg() now using size_t for 'reg_size' argument
>     - slightly tighter shift calculation in litex_set_reg()
>
> Changes since v2:
>     - more detailed comomit blurb

Just a nitpick - there is a typo.

>     - eliminate compiler warning caused by shift in litex_set_reg()
>
> Changes since v1:
>     - fix typo (s/u32/u64/) in litex_read64().
>
>  drivers/soc/litex/Kconfig          |  12 +++
>  drivers/soc/litex/litex_soc_ctrl.c |   3 +-
>  include/linux/litex.h              | 139 ++++++++++++-----------------
>  3 files changed, 70 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> index 7c6b009b6f6c..973f8d2fe1a7 100644
> --- a/drivers/soc/litex/Kconfig
> +++ b/drivers/soc/litex/Kconfig
> @@ -16,4 +16,16 @@ config LITEX_SOC_CONTROLLER
>       All drivers that use functions from litex.h must depend on
>       LITEX.
>
> +config LITEX_SUBREG_SIZE
> +   int "Size of a LiteX CSR subregister, in bytes"
> +   depends on LITEX
> +   range 1 4
> +   default 4
> +   help
> +   LiteX MMIO registers (referred to as Configuration and Status
> +   registers, or CSRs) are spread across adjacent 8- or 32-bit
> +   subregisters, located at 32-bit aligned MMIO addresses. Use
> +   this to select the appropriate size (1 or 4 bytes) matching
> +   your particular LiteX build.
> +
>  endmenu
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> index 65977526d68e..da17ba56b795 100644
> --- a/drivers/soc/litex/litex_soc_ctrl.c
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -58,7 +58,8 @@ static int litex_check_csr_access(void __iomem *reg_addr)
>     /* restore original value of the SCRATCH register */
>     litex_write32(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_VALUE);
>
> -   pr_info("LiteX SoC Controller driver initialized");
> +   pr_info("LiteX SoC Controller driver initialized: subreg:%d, align:%d",
> +       LITEX_SUBREG_SIZE, LITEX_SUBREG_ALIGN);
>
>     return 0;
>  }
> diff --git a/include/linux/litex.h b/include/linux/litex.h
> index 918bab45243c..3456d527f644 100644
> --- a/include/linux/litex.h
> +++ b/include/linux/litex.h
> @@ -10,20 +10,19 @@
>  #define _LINUX_LITEX_H
>
>  #include <linux/io.h>
> -#include <linux/types.h>
> -#include <linux/compiler_types.h>
>
> -/*
> - * The parameters below are true for LiteX SoCs configured for 8-bit CSR Bus,
> - * 32-bit aligned.
> - *
> - * Supporting other configurations will require extending the logic in this
> - * header and in the LiteX SoC controller driver.
> - */
> -#define LITEX_REG_SIZE   0x4
> -#define LITEX_SUBREG_SIZE  0x1
> +/* LiteX SoCs support 8- or 32-bit CSR Bus data width (i.e., subreg. size) */
> +#if defined(CONFIG_LITEX_SUBREG_SIZE) && \
> +   (CONFIG_LITEX_SUBREG_SIZE == 1 || CONFIG_LITEX_SUBREG_SIZE == 4)
> +#define LITEX_SUBREG_SIZE      CONFIG_LITEX_SUBREG_SIZE
> +#else
> +#error LiteX subregister size (LITEX_SUBREG_SIZE) must be 4 or 1!
> +#endif
>  #define LITEX_SUBREG_SIZE_BIT   (LITEX_SUBREG_SIZE * 8)
>
> +/* LiteX subregisters of any width are always aligned on a 4-byte boundary */
> +#define LITEX_SUBREG_ALIGN   0x4
> +
>  static inline void _write_litex_subregister(u32 val, void __iomem *addr)
>  {
>     writel((u32 __force)cpu_to_le32(val), addr);
> @@ -34,25 +33,32 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
>     return le32_to_cpu((__le32 __force)readl(addr));
>  }
>
> -#define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
> -   _write_litex_subregister(val, (base_offset) + \
> -                   LITEX_REG_SIZE * (subreg_id))
> -
> -#define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
> -   _read_litex_subregister((base_offset) + \
> -                   LITEX_REG_SIZE * (subreg_id))
> -
>  /*
>   * LiteX SoC Generator, depending on the configuration, can split a single
>   * logical CSR (Control&Status Register) into a series of consecutive physical
>   * registers.
>   *
> - * For example, in the configuration with 8-bit CSR Bus, 32-bit aligned (the
> - * default one for 32-bit CPUs) a 32-bit logical CSR will be generated as four
> - * 32-bit physical registers, each one containing one byte of meaningful data.
> + * For example, in the configuration with 8-bit CSR Bus, a 32-bit aligned,
> + * 32-bit wide logical CSR will be laid out as four 32-bit physical
> + * subregisters, each one containing one byte of meaningful data.
>   *
>   * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
> - *
> + */
> +
> +/* number of LiteX subregisters needed to store a register of given reg_size */
> +#define _litex_num_subregs(reg_size) \
> +   (((reg_size) - 1) / LITEX_SUBREG_SIZE + 1)
> +
> +/*
> + * since the number of 4-byte aligned subregisters required to store a single
> + * LiteX CSR (MMIO) register varies with LITEX_SUBREG_SIZE, the offset of the
> + * next adjacent LiteX CSR register w.r.t. the offset of the current one also
> + * depends on how many subregisters the latter is spread across
> + */
> +#define _next_reg_off(off, size) \
> +   ((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)

This could be used in the LiteX UART driver (but in a separate patch ofc).

> +/*
>   * The purpose of `litex_set_reg`/`litex_get_reg` is to implement the logic
>   * of writing to/reading from the LiteX CSR in a single place that can be
>   * then reused by all LiteX drivers.
> @@ -64,22 +70,17 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
>   * @reg_size: The width of the CSR expressed in the number of bytes
>   * @val: Value to be written to the CSR
>   *
> - * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
> - * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
> - * each one containing one byte of meaningful data.
> - *
> - * This function splits a single possibly multi-byte write into a series of
> - * single-byte writes with a proper offset.
> + * This function splits a single (possibly multi-byte) LiteX CSR write into
> + * a series of subregister writes with a proper offset.
>   */
> -static inline void litex_set_reg(void __iomem *reg, ulong reg_size, ulong val)
> +static inline void litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
>  {
> -   ulong shifted_data, shift, i;
> +   u8 shift = _litex_num_subregs(reg_size) * LITEX_SUBREG_SIZE_BIT;
>
> -   for (i = 0; i < reg_size; ++i) {
> -       shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> -       shifted_data = val >> shift;
> -
> -       WRITE_LITEX_SUBREGISTER(shifted_data, reg, i);
> +   while (shift > 0) {
> +       shift -= LITEX_SUBREG_SIZE_BIT;
> +       _write_litex_subregister(val >> shift, reg);
> +       reg += LITEX_SUBREG_ALIGN;
>     }
>  }
>
> @@ -90,89 +91,61 @@ static inline void litex_set_reg(void __iomem *reg, ulong reg_size, ulong val)
>   *
>   * Return: Value read from the CSR
>   *
> - * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
> - * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
> - * each one containing one byte of meaningful data.
> - *
> - * This function generates a series of single-byte reads with a proper offset
> - * and joins their results into a single multi-byte value.
> + * This function generates a series of subregister reads with a proper offset
> + * and joins their results into a single (possibly multi-byte) LiteX CSR value.
>   */
> -static inline ulong litex_get_reg(void __iomem *reg, ulong reg_size)
> +static inline u64 litex_get_reg(void __iomem *reg, size_t reg_size)
>  {
> -   ulong shifted_data, shift, i;
> -   ulong result = 0;
> +   u64 r;
> +   u8 i;
>
> -   for (i = 0; i < reg_size; ++i) {
> -       shifted_data = READ_LITEX_SUBREGISTER(reg, i);
> -
> -       shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> -       result |= (shifted_data << shift);
> +   r = _read_litex_subregister(reg);
> +   for (i = 1; i < _litex_num_subregs(reg_size); i++) {
> +       r <<= LITEX_SUBREG_SIZE_BIT;
> +       reg += LITEX_SUBREG_ALIGN;
> +       r |= _read_litex_subregister(reg);
>     }
> -
> -   return result;
> +   return r;
>  }
>
> -
>  static inline void litex_write8(void __iomem *reg, u8 val)
>  {
> -   WRITE_LITEX_SUBREGISTER(val, reg, 0);
> +   litex_set_reg(reg, sizeof(u8), val);
>  }
>
>  static inline void litex_write16(void __iomem *reg, u16 val)
>  {
> -   WRITE_LITEX_SUBREGISTER(val >> 8, reg, 0);
> -   WRITE_LITEX_SUBREGISTER(val, reg, 1);
> +   litex_set_reg(reg, sizeof(u16), val);
>  }
>
>  static inline void litex_write32(void __iomem *reg, u32 val)
>  {
> -   WRITE_LITEX_SUBREGISTER(val >> 24, reg, 0);
> -   WRITE_LITEX_SUBREGISTER(val >> 16, reg, 1);
> -   WRITE_LITEX_SUBREGISTER(val >> 8, reg, 2);
> -   WRITE_LITEX_SUBREGISTER(val, reg, 3);
> +   litex_set_reg(reg, sizeof(u32), val);
>  }
>
>  static inline void litex_write64(void __iomem *reg, u64 val)
>  {
> -   WRITE_LITEX_SUBREGISTER(val >> 56, reg, 0);
> -   WRITE_LITEX_SUBREGISTER(val >> 48, reg, 1);
> -   WRITE_LITEX_SUBREGISTER(val >> 40, reg, 2);
> -   WRITE_LITEX_SUBREGISTER(val >> 32, reg, 3);
> -   WRITE_LITEX_SUBREGISTER(val >> 24, reg, 4);
> -   WRITE_LITEX_SUBREGISTER(val >> 16, reg, 5);
> -   WRITE_LITEX_SUBREGISTER(val >> 8, reg, 6);
> -   WRITE_LITEX_SUBREGISTER(val, reg, 7);
> +   litex_set_reg(reg, sizeof(u64), val);
>  }

I'm wondering about the CPU optimization here.
litex_set_reg() contains a loop - will it be unfolded during the compilation?
I see that all important arguments are constant and known at the compilation
time, so there is a chance, but I have no experience in this field.

>
>  static inline u8 litex_read8(void __iomem *reg)
>  {
> -   return READ_LITEX_SUBREGISTER(reg, 0);
> +   return litex_get_reg(reg, sizeof(u8));
>  }
>
>  static inline u16 litex_read16(void __iomem *reg)
>  {
> -   return (READ_LITEX_SUBREGISTER(reg, 0) << 8)
> -       | (READ_LITEX_SUBREGISTER(reg, 1));
> +   return litex_get_reg(reg, sizeof(u16));
>  }
>
>  static inline u32 litex_read32(void __iomem *reg)
>  {
> -   return (READ_LITEX_SUBREGISTER(reg, 0) << 24)
> -       | (READ_LITEX_SUBREGISTER(reg, 1) << 16)
> -       | (READ_LITEX_SUBREGISTER(reg, 2) << 8)
> -       | (READ_LITEX_SUBREGISTER(reg, 3));
> +   return litex_get_reg(reg, sizeof(u32));
>  }
>
>  static inline u64 litex_read64(void __iomem *reg)
>  {
> -   return ((u64)READ_LITEX_SUBREGISTER(reg, 0) << 56)
> -       | ((u64)READ_LITEX_SUBREGISTER(reg, 1) << 48)
> -       | ((u64)READ_LITEX_SUBREGISTER(reg, 2) << 40)
> -       | ((u64)READ_LITEX_SUBREGISTER(reg, 3) << 32)
> -       | ((u64)READ_LITEX_SUBREGISTER(reg, 4) << 24)
> -       | ((u64)READ_LITEX_SUBREGISTER(reg, 5) << 16)
> -       | ((u64)READ_LITEX_SUBREGISTER(reg, 6) << 8)
> -       | ((u64)READ_LITEX_SUBREGISTER(reg, 7));
> +   return litex_get_reg(reg, sizeof(u64));
>  }
>
>  #endif /* _LINUX_LITEX_H */
> --
> 2.26.2

Best,
Mateusz

-- 
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
