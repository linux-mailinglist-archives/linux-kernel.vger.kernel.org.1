Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A742E2C73
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 22:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgLYVsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 16:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLYVsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 16:48:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21217C061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 13:47:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l23so2936337pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 13:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bOn2peLxybVNv2L/sNASMxI0JrIVIwOK9RTbWKK5xRM=;
        b=n6q4wVHju/EDHnomGkx10XtcZDGr/oNqcJo3YO8HsXnFowXMKtffFpo+4dnojd1U1S
         l1uX4xD8HfUthAt8TpTAhYB6RGDE/YhwYMGlObmiH4QlDeZpfGN33Cl6w5CuY3+z27vt
         9jiPySgG1MGv7MZsZv67vNLN7Ne50ZkKZFFL7F5tEaGA9Lv/AagG4pYdkYqxQzl5R2eY
         1x2WlsS8qRefUjoA/YhyEoZqTM3IvdPJx7RRd3c9935YTM/EJpczRKXDhVz5lnd2hwvV
         atAsM6EOmXmAcTB4SSAHqeqZJUOXLd3dSRMV2taiH4uEbpdFZc6zZAzZ5wmdcFwgSjGz
         DTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bOn2peLxybVNv2L/sNASMxI0JrIVIwOK9RTbWKK5xRM=;
        b=oGVDQ8HdhUlI/Ik7FZXnCx5JluJkBXE0J7yrll/JKWy59yyg/Vd1aleSZHyGj+sQ8a
         Ghlxm9WfyKNvrh7f0kCKlEAM1wHymA7hAdpsrxgGu6HXcMeX7A7BFLwdOqOLf9x9352Q
         h3OS4hAP2zwXJVXWLPZeFe2TqNJqHTkvNJPCSivZ6e+Ewnn76OX80cO2AviB8hu5tZUz
         Pr9ICqAWWbbJz52DX/dllZ9D5KfeE2GXmA68MhSGbkj9TnyWvKYJtDvySqDKEjj0XNG9
         m8C4hJzHrvWCRZKFj7TWN2XRsNJlCTp1YdweFXhi3QQfmkSBmsATaWIunb32KDoNzfnf
         YFHA==
X-Gm-Message-State: AOAM5300cNAGYv6zUSlrdVlFgN/4+CT2K3Of+K6GEBZ1hunuCpDqqpra
        czWO7PiwabPS0uVTPNcmkRY=
X-Google-Smtp-Source: ABdhPJyVoify3bAkXn40as4mO5PRDgrOHyEd4qUwm6XGaxkhFH+EYe98hcdS/yivVRFtcKw8iKAoFA==
X-Received: by 2002:a17:90a:d58c:: with SMTP id v12mr10209302pju.37.1608932859769;
        Fri, 25 Dec 2020 13:47:39 -0800 (PST)
Received: from localhost (g39.222-224-245.ppp.wakwak.ne.jp. [222.224.245.39])
        by smtp.gmail.com with ESMTPSA id u3sm6601756pjf.52.2020.12.25.13.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 13:47:38 -0800 (PST)
Date:   Sat, 26 Dec 2020 06:47:36 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     mholenko@antmicro.com, kgugala@antmicro.com,
        linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 3/3] drivers/soc/litex: support 32-bit subregisters,
 64-bit CPUs
Message-ID: <20201225214736.GN3168563@lianli.shorne-pla.net>
References: <20201225142120.2018222-1-gsomlo@gmail.com>
 <20201225142120.2018222-4-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225142120.2018222-4-gsomlo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 09:21:20AM -0500, Gabriel Somlo wrote:
> Upstream LiteX now defaults to using 32-bit CSR subregisters
> (see https://github.com/enjoy-digital/litex/commit/a2b71fde).
> 
> This patch expands on commit 22447a99c97e ("drivers/soc/litex: add
> LiteX SoC Controller driver"), adding support for handling both 8-
> and 32-bit LiteX CSR (MMIO) subregisters, as determined by the
> LITEX_SUBREG_SIZE Kconfig option.
> 
> NOTE that while LITEX_SUBREG_SIZE could theoretically be a device
> tree property, defining it as a compile-time constant allows for
> much better optimization of the resulting code. This is further
> supported by the low expected usefulness of deploying the same
> kernel across LiteX SoCs built with different CSR-Bus data widths.
> 
> The constant LITEX_SUBREG_SIZE is renamed to the more descriptive
> LITEX_SUBREG_ALIGN (LiteX CSR subregisters are located at 32-bit
> aligned MMIO addresses).
> 
> Finally, the litex_[read|write][8|16|32|64]() accessors are
> redefined in terms of litex_[get|set]_reg(), which, after compiler
> optimization, will result in code as efficient as hardcoded shifts,
> but with the added benefit of automatically matching the appropriate
> LITEX_SUBREG_SIZE.
> 
> NOTE that litex_[get|set]_reg() nominally operate 64-bit data, but
> that too will be optimized away by the compiler in situations where
> narrower data is used.

Hello, thank you for taking the time to split and expand on the commit
message it makes it a lot easier to review.

> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
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
>  	  All drivers that use functions from litex.h must depend on
>  	  LITEX.
>  
> +config LITEX_SUBREG_SIZE
> +	int "Size of a LiteX CSR subregister, in bytes"
> +	depends on LITEX
> +	range 1 4
> +	default 4
> +	help
> +	LiteX MMIO registers (referred to as Configuration and Status
> +	registers, or CSRs) are spread across adjacent 8- or 32-bit
> +	subregisters, located at 32-bit aligned MMIO addresses. Use
> +	this to select the appropriate size (1 or 4 bytes) matching
> +	your particular LiteX build.
> +
>  endmenu
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> index 65977526d68e..da17ba56b795 100644
> --- a/drivers/soc/litex/litex_soc_ctrl.c
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -58,7 +58,8 @@ static int litex_check_csr_access(void __iomem *reg_addr)
>  	/* restore original value of the SCRATCH register */
>  	litex_write32(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_VALUE);
>  
> -	pr_info("LiteX SoC Controller driver initialized");
> +	pr_info("LiteX SoC Controller driver initialized: subreg:%d, align:%d",
> +		LITEX_SUBREG_SIZE, LITEX_SUBREG_ALIGN);
>  
>  	return 0;
>  }
> diff --git a/include/linux/litex.h b/include/linux/litex.h
> index 918bab45243c..53fb03a2f257 100644
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
> -#define LITEX_REG_SIZE	  0x4
> -#define LITEX_SUBREG_SIZE	0x1
> +/* LiteX SoCs support 8- or 32-bit CSR Bus data width (i.e., subreg. size) */
> +#if defined(CONFIG_LITEX_SUBREG_SIZE) && \
> +	(CONFIG_LITEX_SUBREG_SIZE == 1 || CONFIG_LITEX_SUBREG_SIZE == 4)
> +#define LITEX_SUBREG_SIZE      CONFIG_LITEX_SUBREG_SIZE
> +#else
> +#error LiteX subregister size (LITEX_SUBREG_SIZE) must be 4 or 1!
> +#endif
>  #define LITEX_SUBREG_SIZE_BIT	 (LITEX_SUBREG_SIZE * 8)
>  
> +/* LiteX subregisters of any width are always aligned on a 4-byte boundary */
> +#define LITEX_SUBREG_ALIGN	  0x4
> +
>  static inline void _write_litex_subregister(u32 val, void __iomem *addr)
>  {
>  	writel((u32 __force)cpu_to_le32(val), addr);
> @@ -34,25 +33,31 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
>  	return le32_to_cpu((__le32 __force)readl(addr));
>  }
>  
> -#define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
> -	_write_litex_subregister(val, (base_offset) + \
> -					LITEX_REG_SIZE * (subreg_id))
> -
> -#define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
> -	_read_litex_subregister((base_offset) + \
> -					LITEX_REG_SIZE * (subreg_id))
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
> +	(((reg_size) - 1) / LITEX_SUBREG_SIZE + 1)
> +
> +/* since the number of 4-byte aligned subregisters required to store a single
> + * LiteX CSR (MMIO) register varies with LITEX_SUBREG_SIZE, the offset of the
> + * next adjacent LiteX CSR register w.r.t. the offset of the current one also
> + * depends on how many subregisters the latter is spread across
> + */
> +#define _next_reg_off(off, size) \
> +	((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)
> +
> +/*

Little nit, I see one thing you did here is change the comment style, Can you
stick to having a single /* on the first line?  This is as per coding style for
"most" of the kernel:

 https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting

>   * The purpose of `litex_set_reg`/`litex_get_reg` is to implement the logic
>   * of writing to/reading from the LiteX CSR in a single place that can be
>   * then reused by all LiteX drivers.
> @@ -64,22 +69,18 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
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
> +static inline void litex_set_reg(void __iomem *reg, u64 reg_size, u64 val)
>  {
> -	ulong shifted_data, shift, i;
> +	u8 ns, shift, i;
>  
> -	for (i = 0; i < reg_size; ++i) {
> -		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> -		shifted_data = val >> shift;
> -
> -		WRITE_LITEX_SUBREGISTER(shifted_data, reg, i);
> +	ns = _litex_num_subregs(reg_size);
> +	for (i = 0; i < ns; i++) {
> +		shift = LITEX_SUBREG_SIZE_BIT * (ns - 1 - i);
> +		_write_litex_subregister(val >> shift, reg);
> +		reg += LITEX_SUBREG_ALIGN;
>  	}
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
> +static inline u64 litex_get_reg(void __iomem *reg, u64 reg_size)
>  {
> -	ulong shifted_data, shift, i;
> -	ulong result = 0;
> +	u64 r;
> +	u8 i;
>  
> -	for (i = 0; i < reg_size; ++i) {
> -		shifted_data = READ_LITEX_SUBREGISTER(reg, i);
> -
> -		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> -		result |= (shifted_data << shift);
> +	r = _read_litex_subregister(reg);
> +	for (i = 1; i < _litex_num_subregs(reg_size); i++) {
> +		r <<= LITEX_SUBREG_SIZE_BIT;
> +		reg += LITEX_SUBREG_ALIGN;
> +		r |= _read_litex_subregister(reg);
>  	}
> -
> -	return result;
> +	return r;
>  }
>  
> -
>  static inline void litex_write8(void __iomem *reg, u8 val)
>  {
> -	WRITE_LITEX_SUBREGISTER(val, reg, 0);
> +	litex_set_reg(reg, sizeof(u8), val);
>  }
>  
>  static inline void litex_write16(void __iomem *reg, u16 val)
>  {
> -	WRITE_LITEX_SUBREGISTER(val >> 8, reg, 0);
> -	WRITE_LITEX_SUBREGISTER(val, reg, 1);
> +	litex_set_reg(reg, sizeof(u16), val);
>  }
>  
>  static inline void litex_write32(void __iomem *reg, u32 val)
>  {
> -	WRITE_LITEX_SUBREGISTER(val >> 24, reg, 0);
> -	WRITE_LITEX_SUBREGISTER(val >> 16, reg, 1);
> -	WRITE_LITEX_SUBREGISTER(val >> 8, reg, 2);
> -	WRITE_LITEX_SUBREGISTER(val, reg, 3);
> +	litex_set_reg(reg, sizeof(u32), val);
>  }
>  
>  static inline void litex_write64(void __iomem *reg, u64 val)
>  {
> -	WRITE_LITEX_SUBREGISTER(val >> 56, reg, 0);
> -	WRITE_LITEX_SUBREGISTER(val >> 48, reg, 1);
> -	WRITE_LITEX_SUBREGISTER(val >> 40, reg, 2);
> -	WRITE_LITEX_SUBREGISTER(val >> 32, reg, 3);
> -	WRITE_LITEX_SUBREGISTER(val >> 24, reg, 4);
> -	WRITE_LITEX_SUBREGISTER(val >> 16, reg, 5);
> -	WRITE_LITEX_SUBREGISTER(val >> 8, reg, 6);
> -	WRITE_LITEX_SUBREGISTER(val, reg, 7);
> +	litex_set_reg(reg, sizeof(u64), val);
>  }
>  
>  static inline u8 litex_read8(void __iomem *reg)
>  {
> -	return READ_LITEX_SUBREGISTER(reg, 0);
> +	return litex_get_reg(reg, sizeof(u8));
>  }
>  
>  static inline u16 litex_read16(void __iomem *reg)
>  {
> -	return (READ_LITEX_SUBREGISTER(reg, 0) << 8)
> -		| (READ_LITEX_SUBREGISTER(reg, 1));
> +	return litex_get_reg(reg, sizeof(u16));
>  }
>  
>  static inline u32 litex_read32(void __iomem *reg)
>  {
> -	return (READ_LITEX_SUBREGISTER(reg, 0) << 24)
> -		| (READ_LITEX_SUBREGISTER(reg, 1) << 16)
> -		| (READ_LITEX_SUBREGISTER(reg, 2) << 8)
> -		| (READ_LITEX_SUBREGISTER(reg, 3));
> +	return litex_get_reg(reg, sizeof(u32));
>  }
>  
>  static inline u64 litex_read64(void __iomem *reg)
>  {
> -	return ((u64)READ_LITEX_SUBREGISTER(reg, 0) << 56)
> -		| ((u64)READ_LITEX_SUBREGISTER(reg, 1) << 48)
> -		| ((u64)READ_LITEX_SUBREGISTER(reg, 2) << 40)
> -		| ((u64)READ_LITEX_SUBREGISTER(reg, 3) << 32)
> -		| ((u64)READ_LITEX_SUBREGISTER(reg, 4) << 24)
> -		| ((u64)READ_LITEX_SUBREGISTER(reg, 5) << 16)
> -		| ((u64)READ_LITEX_SUBREGISTER(reg, 6) << 8)
> -		| ((u64)READ_LITEX_SUBREGISTER(reg, 7));
> +	return litex_get_reg(reg, sizeof(u64));
>  }
>  
>  #endif /* _LINUX_LITEX_H */
> -- 
> 2.26.2

Thank you,

-Stafford
