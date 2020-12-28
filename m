Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5FE2E372D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 13:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgL1MwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 07:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgL1Mv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 07:51:59 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B6EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 04:51:19 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id y15so6779782qtv.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 04:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hv2ioTbL1zMj9gIROibqlzyiSvUB2QQUQZT7xuEgqQs=;
        b=ZgbCAKajhD8OosJK3dMOl5EID+HXRwiq7uhgug/V+6hrE1QUJJ6LofdtaNvPrx2xU5
         2a/GYi23zRHtld9mjyAlOYUDD2brYv4TUYZmh9+GrGDDOLmkVhlhQ3XcZ/gNFKob0N5U
         zaXhrHh0aWeIrR5PMSHSwrbdn7kBJnZZESIX+VzwST+JnW/4DQjgEWBfMjB3BcdJr8Jh
         pgfrJ7dNa09s638ZrmMlLMf/1Rz75xwQHbdFEUoxuY3Aa+ZBgQrXH07yO3G/UaUuh8Y0
         rCNdseEezy127j2nOYypTX1OOiqJ5mQwV3yV0ojwSA3G603USducBXm00EuBjTHwUqFL
         nRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hv2ioTbL1zMj9gIROibqlzyiSvUB2QQUQZT7xuEgqQs=;
        b=BwNNO2+fZME1AnhsFm05Z+OHmx2FphF5HF2V/wO5GOvxyCxRgWn1b72xKXENvWkHKf
         KI2V75ojOMs9DzbDun4cx2FKz0tfsqqtY/Sg1jQM39xb0e8Z2GL/edlVmHGAiTBbxKFt
         86e24YJo1FvKqcg42IhGdkIym1EwjkBhapwKULDnwfwTy3gFGGam1m46kgy58TvLiNCk
         Dpya4EPy97VMJ0uUIP2ni0vP06FfkbCLZjH8LFojwkA/ntrUGP6Yt+NPqctO0UBKQzI2
         4i0tesY7WM5ygpvMtUG4SYGc1MtLBuMdW1/TW/V8PjzAd4Rh956RLlDtplKg/Hl1Fy8R
         8KAw==
X-Gm-Message-State: AOAM532ky7ZL/RX1XbwBieaYPyHRuora/JDHpLrn/AM+pluBlDapz6l8
        wRwrjRE9j7Q+YFhDB6f7EYdYnPah1z8=
X-Google-Smtp-Source: ABdhPJxguxShGt5bQQbUMlM7Ge1nK7DSZnefrBMouNsIyKAAsAHhxDkYmIL6cGPIG4XiQxGBqhaSHw==
X-Received: by 2002:ac8:5741:: with SMTP id 1mr43139587qtx.294.1609159877722;
        Mon, 28 Dec 2020 04:51:17 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-255-32.pitbpa.fios.verizon.net. [108.39.255.32])
        by smtp.gmail.com with ESMTPSA id i3sm16658957qkd.119.2020.12.28.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 04:51:17 -0800 (PST)
Date:   Mon, 28 Dec 2020 07:51:14 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 4/4] drivers/soc/litex: make 'litex_[set|get]_reg()'
 methods private
Message-ID: <20201228125114.GI6062@errol.ini.cmu.edu>
References: <20201227161320.2194830-1-gsomlo@gmail.com>
 <20201227161320.2194830-5-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227161320.2194830-5-gsomlo@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 11:13:20AM -0500, Gabriel Somlo wrote:
> The 'litex_[set|get]_reg()' methods use the 'reg_size' parameter to
> specify the width of the LiteX CSR (MMIO) register being accessed.
> 
> Since 'u64' is the widest data being supported, the value of 'reg_size'
> MUST be between 1 and sizeof(u64), which SHOULD be checked at runtime
> if these methods are publicly available for use by other LiteX device
> drivers.
> 
> At the same time, none of the existing (or foreseeable) LiteX device
> drivers have a need to access registers whose size is unknown during
> compilation. As such, all LiteX device drivers should use fixed-width
> accessor methods such as 'litex_[write|read][8|16|32|64]()'.
> 
> This patch renames 'litex_[set|get]_reg()' to '_litex_[set|get]_reg()',
> indicating that they should NOT be directly called from outside of
> the 'include/linux/litex.h' header file.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/soc/litex/Kconfig |  2 +-
>  include/linux/litex.h     | 35 ++++++++++++++++++++---------------
>  2 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> index 973f8d2fe1a7..b9b3d51ea7df 100644
> --- a/drivers/soc/litex/Kconfig
> +++ b/drivers/soc/litex/Kconfig
> @@ -11,7 +11,7 @@ config LITEX_SOC_CONTROLLER
>  	select LITEX
>  	help
>  	  This option enables the SoC Controller Driver which verifies
> -	  LiteX CSR access and provides common litex_get_reg/litex_set_reg
> +	  LiteX CSR access and provides common litex_[read|write]*
>  	  accessors.
>  	  All drivers that use functions from litex.h must depend on
>  	  LITEX.
> diff --git a/include/linux/litex.h b/include/linux/litex.h
> index 3456d527f644..14748fa86a99 100644
> --- a/include/linux/litex.h
> +++ b/include/linux/litex.h
> @@ -59,21 +59,25 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
>  	((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)
>  
>  /*
> - * The purpose of `litex_set_reg`/`litex_get_reg` is to implement the logic
> - * of writing to/reading from the LiteX CSR in a single place that can be
> - * then reused by all LiteX drivers.
> + * The purpose of `_litex_[set|get]_reg()` is to implement the logic of
> + * writing to/reading from the LiteX CSR in a single place that can be then
> + * reused by all LiteX drivers via the `litex_[write|read][8|16|32|64]()`
> + * accessors for the appropriate data width.
> + * NOTE: direct use of `_litex_[set|get]_reg()` by LiteX drivers is strongly
> + * discouraged, as they perform no error checking on the requested data width!
>   */
>  
>  /**
> - * litex_set_reg() - Writes the value to the LiteX CSR (Control&Status Register)
> + * _litex_set_reg() - Writes a value to the LiteX CSR (Control&Status Register)
>   * @reg: Address of the CSR
>   * @reg_size: The width of the CSR expressed in the number of bytes
>   * @val: Value to be written to the CSR
>   *
>   * This function splits a single (possibly multi-byte) LiteX CSR write into
>   * a series of subregister writes with a proper offset.
> + * NOTE: caller is responsible for ensuring (0 < reg_size < sizeof(u64)).

This will be fixed in v6 to read "(0 < reg_size <= sizeof(u64))".

>   */
> -static inline void litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
> +static inline void _litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
>  {
>  	u8 shift = _litex_num_subregs(reg_size) * LITEX_SUBREG_SIZE_BIT;
>  
> @@ -85,7 +89,7 @@ static inline void litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
>  }
>  
>  /**
> - * litex_get_reg() - Reads the value of the LiteX CSR (Control&Status Register)
> + * _litex_get_reg() - Reads a value of the LiteX CSR (Control&Status Register)
>   * @reg: Address of the CSR
>   * @reg_size: The width of the CSR expressed in the number of bytes
>   *
> @@ -93,8 +97,9 @@ static inline void litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
>   *
>   * This function generates a series of subregister reads with a proper offset
>   * and joins their results into a single (possibly multi-byte) LiteX CSR value.
> + * NOTE: caller is responsible for ensuring (0 < reg_size < sizeof(u64)).

Ditto.

Thanks,
--Gabriel

>   */
> -static inline u64 litex_get_reg(void __iomem *reg, size_t reg_size)
> +static inline u64 _litex_get_reg(void __iomem *reg, size_t reg_size)
>  {
>  	u64 r;
>  	u8 i;
> @@ -110,42 +115,42 @@ static inline u64 litex_get_reg(void __iomem *reg, size_t reg_size)
>  
>  static inline void litex_write8(void __iomem *reg, u8 val)
>  {
> -	litex_set_reg(reg, sizeof(u8), val);
> +	_litex_set_reg(reg, sizeof(u8), val);
>  }
>  
>  static inline void litex_write16(void __iomem *reg, u16 val)
>  {
> -	litex_set_reg(reg, sizeof(u16), val);
> +	_litex_set_reg(reg, sizeof(u16), val);
>  }
>  
>  static inline void litex_write32(void __iomem *reg, u32 val)
>  {
> -	litex_set_reg(reg, sizeof(u32), val);
> +	_litex_set_reg(reg, sizeof(u32), val);
>  }
>  
>  static inline void litex_write64(void __iomem *reg, u64 val)
>  {
> -	litex_set_reg(reg, sizeof(u64), val);
> +	_litex_set_reg(reg, sizeof(u64), val);
>  }
>  
>  static inline u8 litex_read8(void __iomem *reg)
>  {
> -	return litex_get_reg(reg, sizeof(u8));
> +	return _litex_get_reg(reg, sizeof(u8));
>  }
>  
>  static inline u16 litex_read16(void __iomem *reg)
>  {
> -	return litex_get_reg(reg, sizeof(u16));
> +	return _litex_get_reg(reg, sizeof(u16));
>  }
>  
>  static inline u32 litex_read32(void __iomem *reg)
>  {
> -	return litex_get_reg(reg, sizeof(u32));
> +	return _litex_get_reg(reg, sizeof(u32));
>  }
>  
>  static inline u64 litex_read64(void __iomem *reg)
>  {
> -	return litex_get_reg(reg, sizeof(u64));
> +	return _litex_get_reg(reg, sizeof(u64));
>  }
>  
>  #endif /* _LINUX_LITEX_H */
> -- 
> 2.26.2
> 
