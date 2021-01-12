Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD02F3405
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbhALPPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbhALPPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:15:04 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C453C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:14:24 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id b9so1725472qtr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ubgNEw825FrbLHK3XbjKTaqdsDgDn1UL9KKHEbYwXw=;
        b=N7AARsi0cCqe2+rnkYFdhiGCWq4BKtdpZhnNdzGPP8lIQT4o5Vkxz2siawSopKclvZ
         Lj3s57imeE+lz9lew3uq+tQc9ky7F7ethT8fUr64qEXGghGN6OriKaWs3FqOTAdHrCXD
         7HMBTL/YTE5SBgITvPaDZI9qCRh09Y13oZFvyP8lstIKNwct51L89Q1B8Ick47vvw3/p
         idDm6HK+9c8KQSonx2pXxWkKa7554iCJ5gcdvqHuQu97D+atW4m4STlcVZRsIAdomUxs
         CZv+JlfHkkkHRAWAZMB4xrpSS2LMFDmuzC3bpd4tgelSoWp5d/1x3mEho48DEj7Nj+T7
         zoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ubgNEw825FrbLHK3XbjKTaqdsDgDn1UL9KKHEbYwXw=;
        b=LSCaO64v/oHPusql96f+dhtM+Za4Py1EXJ4nydifGvwtYnyJh24ACMzAkjsV/DAYjk
         9At8k80PEQCOTaMDLOxF9BmS9yarxfGKrkYzLYVCTPMeT4LmDD2AHMYt85HWnGFPYKft
         GIUW9CmIcrEdSsMEwSvoEWuGNMraT6MG6UFC+02pzHLTAcuhmmckPepiJ+1a1Y4hSIi6
         ltZMfTGIjBeSNUSyaTwL07YSptcnDwl/lSq4LjQZfaImVzTM4RQtjMhUW+LNj0Dcpynd
         mCXfwOizfTdvwzdfdSJ5YSf66sTF9TuzgB2VLmki8+We4fIV9pSsHXrQ3NcIKGw5V+8W
         1rxA==
X-Gm-Message-State: AOAM533h/yJcDjKh3gf6L3yDuliOTz69HA+kO2bt+e5f01VYpIqrrDoA
        wi1shZSb0V7nhEN2nWs8X2u06ldiY54=
X-Google-Smtp-Source: ABdhPJxFyP2Ci3y3eyQfjHpsQas00gf+JZezw0RL6QfeamLHA+XtbhkJKw9SE19Ub7GcAuYurAOugg==
X-Received: by 2002:ac8:4c99:: with SMTP id j25mr5113385qtv.390.1610464463188;
        Tue, 12 Jan 2021 07:14:23 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-255-32.pitbpa.fios.verizon.net. [108.39.255.32])
        by smtp.gmail.com with ESMTPSA id x25sm1380602qkx.88.2021.01.12.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:14:22 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:14:20 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     f.kermarrec@gmail.com, gregkh@linuxfoundation.org,
        kgugala@antmicro.com, linux-kernel@vger.kernel.org,
        pczarnecki@internships.antmicro.com, shorne@gmail.com
Subject: Re: [PATCH v5 3/4] drivers/soc/litex: support 32-bit subregisters,
 64-bit CPUs
Message-ID: <20210112151420.GL2094049@errol.ini.cmu.edu>
References: <CAPk366Tyj13foMsdTk-Mkp-7jrkfnba8spAHm14uUMtH0GLOwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPk366Tyj13foMsdTk-Mkp-7jrkfnba8spAHm14uUMtH0GLOwQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz,

On Tue, Jan 12, 2021 at 03:31:59PM +0100, Mateusz Holenko wrote:
> > Upstream LiteX now defaults to using 32-bit CSR subregisters
> > (see https://github.com/enjoy-digital/litex/commit/a2b71fde).
> >
> > This patch expands on commit 22447a99c97e ("drivers/soc/litex: add
> > LiteX SoC Controller driver"), adding support for handling both 8-
> > and 32-bit LiteX CSR (MMIO) subregisters, as determined by the
> > LITEX_SUBREG_SIZE Kconfig option.
> 
> This sounds like a great feature!

Thanks for the feedback! Replies inline, below.

> > NOTE that while LITEX_SUBREG_SIZE could theoretically be a device
> > tree property, defining it as a compile-time constant allows for
> > much better optimization of the resulting code. This is further
> > supported by the low expected usefulness of deploying the same
> > kernel across LiteX SoCs built with different CSR-Bus data widths.
> >
> > The constant LITEX_REG_SIZE is renamed to the more descriptive
> > LITEX_SUBREG_ALIGN (LiteX CSR subregisters are located at 32-bit
> > aligned MMIO addresses).
> 
> Should it go to a separate commit? I have no strong opinions about that,
> but it looks like an independent change.

I can do that in v6.
 
> > Finally, the litex_[read|write][8|16|32|64]() accessors are
> > redefined in terms of litex_[get|set]_reg(), which, after compiler
> > optimization, will result in code as efficient as hardcoded shifts,
> > but with the added benefit of automatically matching the appropriate
> > LITEX_SUBREG_SIZE.
> >
> > NOTE that litex_[get|set]_reg() nominally operate on 64-bit data,
> > but that will also be optimized by the compiler in situations where
> > narrower data is used from a call site.
> >
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > ---
> >
> > Changes since v4:
> >     - tighter, more optimized implementation of 'litex_set_reg()'
> >
> > Changes since v3:
> >     - improved legibility, fixed typos in commit blurb
> >     - fixed instance of "disgusting" commit style :)
> >     - litex_[get|set]_reg() now using size_t for 'reg_size' argument
> >     - slightly tighter shift calculation in litex_set_reg()
> >
> > Changes since v2:
> >     - more detailed comomit blurb
> 
> Just a nitpick - there is a typo.

Fortunately, this wouldn't have made it into the final upstream commit
(but I'll fix it when I send out the revision history with v6... :)

> >     - eliminate compiler warning caused by shift in litex_set_reg()
> >
> > Changes since v1:
> >     - fix typo (s/u32/u64/) in litex_read64().
> >
> >  drivers/soc/litex/Kconfig          |  12 +++
> >  drivers/soc/litex/litex_soc_ctrl.c |   3 +-
> >  include/linux/litex.h              | 139 ++++++++++++-----------------
> >  3 files changed, 70 insertions(+), 84 deletions(-)
> >
> > diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> > index 7c6b009b6f6c..973f8d2fe1a7 100644
> > --- a/drivers/soc/litex/Kconfig
> > +++ b/drivers/soc/litex/Kconfig
> > @@ -16,4 +16,16 @@ config LITEX_SOC_CONTROLLER
> >       All drivers that use functions from litex.h must depend on
> >       LITEX.
> >
> > +config LITEX_SUBREG_SIZE
> > +   int "Size of a LiteX CSR subregister, in bytes"
> > +   depends on LITEX
> > +   range 1 4
> > +   default 4
> > +   help
> > +   LiteX MMIO registers (referred to as Configuration and Status
> > +   registers, or CSRs) are spread across adjacent 8- or 32-bit
> > +   subregisters, located at 32-bit aligned MMIO addresses. Use
> > +   this to select the appropriate size (1 or 4 bytes) matching
> > +   your particular LiteX build.
> > +
> >  endmenu
> > diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> > index 65977526d68e..da17ba56b795 100644
> > --- a/drivers/soc/litex/litex_soc_ctrl.c
> > +++ b/drivers/soc/litex/litex_soc_ctrl.c
> > @@ -58,7 +58,8 @@ static int litex_check_csr_access(void __iomem *reg_addr)
> >     /* restore original value of the SCRATCH register */
> >     litex_write32(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_VALUE);
> >
> > -   pr_info("LiteX SoC Controller driver initialized");
> > +   pr_info("LiteX SoC Controller driver initialized: subreg:%d, align:%d",
> > +       LITEX_SUBREG_SIZE, LITEX_SUBREG_ALIGN);
> >
> >     return 0;
> >  }
> > diff --git a/include/linux/litex.h b/include/linux/litex.h
> > index 918bab45243c..3456d527f644 100644
> > --- a/include/linux/litex.h
> > +++ b/include/linux/litex.h
> > @@ -10,20 +10,19 @@
> >  #define _LINUX_LITEX_H
> >
> >  #include <linux/io.h>
> > -#include <linux/types.h>
> > -#include <linux/compiler_types.h>
> >
> > -/*
> > - * The parameters below are true for LiteX SoCs configured for 8-bit CSR Bus,
> > - * 32-bit aligned.
> > - *
> > - * Supporting other configurations will require extending the logic in this
> > - * header and in the LiteX SoC controller driver.
> > - */
> > -#define LITEX_REG_SIZE   0x4
> > -#define LITEX_SUBREG_SIZE  0x1
> > +/* LiteX SoCs support 8- or 32-bit CSR Bus data width (i.e., subreg. size) */
> > +#if defined(CONFIG_LITEX_SUBREG_SIZE) && \
> > +   (CONFIG_LITEX_SUBREG_SIZE == 1 || CONFIG_LITEX_SUBREG_SIZE == 4)
> > +#define LITEX_SUBREG_SIZE      CONFIG_LITEX_SUBREG_SIZE
> > +#else
> > +#error LiteX subregister size (LITEX_SUBREG_SIZE) must be 4 or 1!
> > +#endif
> >  #define LITEX_SUBREG_SIZE_BIT   (LITEX_SUBREG_SIZE * 8)
> >
> > +/* LiteX subregisters of any width are always aligned on a 4-byte boundary */
> > +#define LITEX_SUBREG_ALIGN   0x4
> > +
> >  static inline void _write_litex_subregister(u32 val, void __iomem *addr)
> >  {
> >     writel((u32 __force)cpu_to_le32(val), addr);
> > @@ -34,25 +33,32 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
> >     return le32_to_cpu((__le32 __force)readl(addr));
> >  }
> >
> > -#define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
> > -   _write_litex_subregister(val, (base_offset) + \
> > -                   LITEX_REG_SIZE * (subreg_id))
> > -
> > -#define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
> > -   _read_litex_subregister((base_offset) + \
> > -                   LITEX_REG_SIZE * (subreg_id))
> > -
> >  /*
> >   * LiteX SoC Generator, depending on the configuration, can split a single
> >   * logical CSR (Control&Status Register) into a series of consecutive physical
> >   * registers.
> >   *
> > - * For example, in the configuration with 8-bit CSR Bus, 32-bit aligned (the
> > - * default one for 32-bit CPUs) a 32-bit logical CSR will be generated as four
> > - * 32-bit physical registers, each one containing one byte of meaningful data.
> > + * For example, in the configuration with 8-bit CSR Bus, a 32-bit aligned,
> > + * 32-bit wide logical CSR will be laid out as four 32-bit physical
> > + * subregisters, each one containing one byte of meaningful data.
> >   *
> >   * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
> > - *
> > + */
> > +
> > +/* number of LiteX subregisters needed to store a register of given reg_size */
> > +#define _litex_num_subregs(reg_size) \
> > +   (((reg_size) - 1) / LITEX_SUBREG_SIZE + 1)
> > +
> > +/*
> > + * since the number of 4-byte aligned subregisters required to store a single
> > + * LiteX CSR (MMIO) register varies with LITEX_SUBREG_SIZE, the offset of the
> > + * next adjacent LiteX CSR register w.r.t. the offset of the current one also
> > + * depends on how many subregisters the latter is spread across
> > + */
> > +#define _next_reg_off(off, size) \
> > +   ((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)
> 
> This could be used in the LiteX UART driver (but in a separate patch ofc).

As luck would have it, the registers in liteuart.c are all 8-bit wide
and 32-bit aligned, so the current hard-coded values just happen to work
regardless of the subregister width. We can formally adopt the
`_next_reg_off()` macro to serve as a public example, but it's mostly
intended for not-yet-upstream drivers that have wider registers (which
"stretch across" subregisters differently on 8- vs. 32-bit subregister
widths).

> > +/*
> >   * The purpose of `litex_set_reg`/`litex_get_reg` is to implement the logic
> >   * of writing to/reading from the LiteX CSR in a single place that can be
> >   * then reused by all LiteX drivers.
> > @@ -64,22 +70,17 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
> >   * @reg_size: The width of the CSR expressed in the number of bytes
> >   * @val: Value to be written to the CSR
> >   *
> > - * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
> > - * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
> > - * each one containing one byte of meaningful data.
> > - *
> > - * This function splits a single possibly multi-byte write into a series of
> > - * single-byte writes with a proper offset.
> > + * This function splits a single (possibly multi-byte) LiteX CSR write into
> > + * a series of subregister writes with a proper offset.
> >   */
> > -static inline void litex_set_reg(void __iomem *reg, ulong reg_size, ulong val)
> > +static inline void litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
> >  {
> > -   ulong shifted_data, shift, i;
> > +   u8 shift = _litex_num_subregs(reg_size) * LITEX_SUBREG_SIZE_BIT;
> >
> > -   for (i = 0; i < reg_size; ++i) {
> > -       shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > -       shifted_data = val >> shift;
> > -
> > -       WRITE_LITEX_SUBREGISTER(shifted_data, reg, i);
> > +   while (shift > 0) {
> > +       shift -= LITEX_SUBREG_SIZE_BIT;
> > +       _write_litex_subregister(val >> shift, reg);
> > +       reg += LITEX_SUBREG_ALIGN;
> >     }
> >  }
> >
> > @@ -90,89 +91,61 @@ static inline void litex_set_reg(void __iomem *reg, ulong reg_size, ulong val)
> >   *
> >   * Return: Value read from the CSR
> >   *
> > - * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
> > - * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
> > - * each one containing one byte of meaningful data.
> > - *
> > - * This function generates a series of single-byte reads with a proper offset
> > - * and joins their results into a single multi-byte value.
> > + * This function generates a series of subregister reads with a proper offset
> > + * and joins their results into a single (possibly multi-byte) LiteX CSR value.
> >   */
> > -static inline ulong litex_get_reg(void __iomem *reg, ulong reg_size)
> > +static inline u64 litex_get_reg(void __iomem *reg, size_t reg_size)
> >  {
> > -   ulong shifted_data, shift, i;
> > -   ulong result = 0;
> > +   u64 r;
> > +   u8 i;
> >
> > -   for (i = 0; i < reg_size; ++i) {
> > -       shifted_data = READ_LITEX_SUBREGISTER(reg, i);
> > -
> > -       shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > -       result |= (shifted_data << shift);
> > +   r = _read_litex_subregister(reg);
> > +   for (i = 1; i < _litex_num_subregs(reg_size); i++) {
> > +       r <<= LITEX_SUBREG_SIZE_BIT;
> > +       reg += LITEX_SUBREG_ALIGN;
> > +       r |= _read_litex_subregister(reg);
> >     }
> > -
> > -   return result;
> > +   return r;
> >  }
> >
> > -
> >  static inline void litex_write8(void __iomem *reg, u8 val)
> >  {
> > -   WRITE_LITEX_SUBREGISTER(val, reg, 0);
> > +   litex_set_reg(reg, sizeof(u8), val);
> >  }
> >
> >  static inline void litex_write16(void __iomem *reg, u16 val)
> >  {
> > -   WRITE_LITEX_SUBREGISTER(val >> 8, reg, 0);
> > -   WRITE_LITEX_SUBREGISTER(val, reg, 1);
> > +   litex_set_reg(reg, sizeof(u16), val);
> >  }
> >
> >  static inline void litex_write32(void __iomem *reg, u32 val)
> >  {
> > -   WRITE_LITEX_SUBREGISTER(val >> 24, reg, 0);
> > -   WRITE_LITEX_SUBREGISTER(val >> 16, reg, 1);
> > -   WRITE_LITEX_SUBREGISTER(val >> 8, reg, 2);
> > -   WRITE_LITEX_SUBREGISTER(val, reg, 3);
> > +   litex_set_reg(reg, sizeof(u32), val);
> >  }
> >
> >  static inline void litex_write64(void __iomem *reg, u64 val)
> >  {
> > -   WRITE_LITEX_SUBREGISTER(val >> 56, reg, 0);
> > -   WRITE_LITEX_SUBREGISTER(val >> 48, reg, 1);
> > -   WRITE_LITEX_SUBREGISTER(val >> 40, reg, 2);
> > -   WRITE_LITEX_SUBREGISTER(val >> 32, reg, 3);
> > -   WRITE_LITEX_SUBREGISTER(val >> 24, reg, 4);
> > -   WRITE_LITEX_SUBREGISTER(val >> 16, reg, 5);
> > -   WRITE_LITEX_SUBREGISTER(val >> 8, reg, 6);
> > -   WRITE_LITEX_SUBREGISTER(val, reg, 7);
> > +   litex_set_reg(reg, sizeof(u64), val);
> >  }
> 
> I'm wondering about the CPU optimization here.
> litex_set_reg() contains a loop - will it be unfolded during the compilation?
> I see that all important arguments are constant and known at the compilation
> time, so there is a chance, but I have no experience in this field.

As an experiment (using 32-bit subregister width on a kernel built for
rv64gc / rocket), I wrote:

	...
	void __iomem *ptr = host->sdreader + LITEX_MMC_SDBLK2MEM_BASE_OFF;
	u64 val = host->dma_handle;
	...
	__asm__ volatile("addi x0, x0, 42");
	litex_write64(ptr, val);
	__asm__ volatile("addi x0, x0, 43");
	...

(not how I'd normally call the accessor, but just to see what it looks
like when compiled :)

The output from objdump corresponding to the inlined litex_write64() is:

	...
	02a00013                li      zero,42
	0140000f                fence   w,o
	02075693                srli    a3,a4,0x20
	c394                    sw      a3,0(a5)
	0140000f                fence   w,o
	0791                    addi    a5,a5,4
	c398                    sw      a4,0(a5)
	02b00013                li      zero,43
	...

I've done this experiment in the past on 32-bit kernels and the results
were similar. On 8-bit subregisters, you'd just end up with 8x "sw"
instructions, etc. So everything seems to work as expected.

Thanks,
--Gabriel

> >
> >  static inline u8 litex_read8(void __iomem *reg)
> >  {
> > -   return READ_LITEX_SUBREGISTER(reg, 0);
> > +   return litex_get_reg(reg, sizeof(u8));
> >  }
> >
> >  static inline u16 litex_read16(void __iomem *reg)
> >  {
> > -   return (READ_LITEX_SUBREGISTER(reg, 0) << 8)
> > -       | (READ_LITEX_SUBREGISTER(reg, 1));
> > +   return litex_get_reg(reg, sizeof(u16));
> >  }
> >
> >  static inline u32 litex_read32(void __iomem *reg)
> >  {
> > -   return (READ_LITEX_SUBREGISTER(reg, 0) << 24)
> > -       | (READ_LITEX_SUBREGISTER(reg, 1) << 16)
> > -       | (READ_LITEX_SUBREGISTER(reg, 2) << 8)
> > -       | (READ_LITEX_SUBREGISTER(reg, 3));
> > +   return litex_get_reg(reg, sizeof(u32));
> >  }
> >
> >  static inline u64 litex_read64(void __iomem *reg)
> >  {
> > -   return ((u64)READ_LITEX_SUBREGISTER(reg, 0) << 56)
> > -       | ((u64)READ_LITEX_SUBREGISTER(reg, 1) << 48)
> > -       | ((u64)READ_LITEX_SUBREGISTER(reg, 2) << 40)
> > -       | ((u64)READ_LITEX_SUBREGISTER(reg, 3) << 32)
> > -       | ((u64)READ_LITEX_SUBREGISTER(reg, 4) << 24)
> > -       | ((u64)READ_LITEX_SUBREGISTER(reg, 5) << 16)
> > -       | ((u64)READ_LITEX_SUBREGISTER(reg, 6) << 8)
> > -       | ((u64)READ_LITEX_SUBREGISTER(reg, 7));
> > +   return litex_get_reg(reg, sizeof(u64));
> >  }
> >
> >  #endif /* _LINUX_LITEX_H */
> > --
> > 2.26.2
> 
> Best,
> Mateusz
> 
> -- 
> Mateusz Holenko
> Antmicro Ltd | www.antmicro.com
> Roosevelta 22, 60-829 Poznan, Poland
