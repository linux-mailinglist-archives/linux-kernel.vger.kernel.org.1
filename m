Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D122EEAA9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbhAHBCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbhAHBCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:02:32 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACB3C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:01:51 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q20so1891359pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H8IcOdAyibzRQGXQEP5k4aObN4wu9DJRf0dSDz/i5L0=;
        b=C9NGEUuAM5vBKRzR24q3eqYuT//r0M6Puseln6vu2k2CbVRLZQsp+a/82vpmcRdTLV
         hHrxzm/p7eCUn7VON7FKSjPiK9MRpomjVu20r5iicVI4C1UTzOycDFux6NbDqtk/O2M3
         lru09DBZcaEMhe+dJuNNEP0lz2FPTJwxrxWlVEeLY65vq2OX4Mrw16zzOoUHTpV5hvnK
         vfmh/NyAjNwIxACpumqSdNhFfwtAx676c6LYfG7lEZML3vxbtouV3Y/j51u7l00/TnDd
         629qrt30yLW92TnzV+94ifr5o+sP5T7Kp8NRvvLoQCTC3s5UU4inVsiGs+wH5FrB78A9
         83Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8IcOdAyibzRQGXQEP5k4aObN4wu9DJRf0dSDz/i5L0=;
        b=lCg0KV8y2KC5c+6B9nAVClLUwADCfyp6ln2x1yQR4pqb0YbHXh3EMdwP1ERNn1JpMA
         qKtubx5BTx3STpzBoyqXq/pOJ9i3e7o3PF+lrT3dn6uZDuhR99LYxVsG9I1Y3DcwKRGP
         GECseIBc9NhQQNj4zY/UUth7SVtfxT9E5SJIpKAYhuIOCr2MSmSxMj4tppYcjiBREWtb
         sm+sLs6+BuA3IGgzDBgcStvRrZbxVqP7iDpMriNnWKHWk0vJQ82+b+pjCiSM6uy4vXWt
         8ZWhvkyfp/NoQxXxanlttkddEmnCfWew0MNk/1DJmoLJPpkL8DQvxGXEIxHpnyndElvL
         7PpA==
X-Gm-Message-State: AOAM530Rdx8k/E9dyJzxETyYMWIMjfFrMeToege6KPYnrjAlp4E8BZwG
        x+TZixHX+4+Ibl2qErpgTh+ODA==
X-Google-Smtp-Source: ABdhPJw4NL308Jew6euuvK4s6qyKTILSBa9PnGCWJuhxO1DIMrQrzkxc2z1sM9lZOhZk5ZQU3ZwUvA==
X-Received: by 2002:a63:6e8f:: with SMTP id j137mr4412260pgc.416.1610067711528;
        Thu, 07 Jan 2021 17:01:51 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id jx4sm6140238pjb.24.2021.01.07.17.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:01:50 -0800 (PST)
Date:   Thu, 7 Jan 2021 18:01:48 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 25/26] arm64: Add TRFCR_ELx definitions
Message-ID: <20210108010148.GH43045@xps15>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
 <20210107123859.674252-26-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107123859.674252-26-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:38:58PM +0000, Suzuki K Poulose wrote:
> From: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> 
> Add definitions for the Arm v8.4 SelfHosted trace extensions registers.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> [ split the register definitions to separate patch
>   rename some of the symbols ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  arch/arm64/include/asm/sysreg.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 8b5e7e5c3cc8..4acff97519b9 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -191,6 +191,7 @@
>  #define SYS_GCR_EL1			sys_reg(3, 0, 1, 0, 6)
>  
>  #define SYS_ZCR_EL1			sys_reg(3, 0, 1, 2, 0)
> +#define SYS_TRFCR_EL1			sys_reg(3, 0, 1, 2, 1)
>  
>  #define SYS_TTBR0_EL1			sys_reg(3, 0, 2, 0, 0)
>  #define SYS_TTBR1_EL1			sys_reg(3, 0, 2, 0, 1)
> @@ -471,6 +472,7 @@
>  
>  #define SYS_SCTLR_EL2			sys_reg(3, 4, 1, 0, 0)
>  #define SYS_ZCR_EL2			sys_reg(3, 4, 1, 2, 0)
> +#define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
>  #define SYS_DACR32_EL2			sys_reg(3, 4, 3, 0, 0)
>  #define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
>  #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
> @@ -829,6 +831,7 @@
>  #define ID_AA64MMFR2_CNP_SHIFT		0
>  
>  /* id_aa64dfr0 */
> +#define ID_AA64DFR0_TRACE_FILT_SHIFT	40
>  #define ID_AA64DFR0_DOUBLELOCK_SHIFT	36
>  #define ID_AA64DFR0_PMSVER_SHIFT	32
>  #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
> @@ -1003,6 +1006,14 @@
>  /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
>  #define SYS_MPIDR_SAFE_VAL	(BIT(31))
>  
> +#define TRFCR_ELx_TS_SHIFT		5
> +#define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
> +#define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2UL) << TRFCR_ELx_TS_SHIFT)
> +#define TRFCR_ELx_TS_PHYSICAL		((0x3UL) << TRFCR_ELx_TS_SHIFT)
> +#define TRFCR_EL2_CX			BIT(3)
> +#define TRFCR_ELx_ExTRE			BIT(1)
> +#define TRFCR_ELx_E0TRE			BIT(0)
> +
>  #ifdef __ASSEMBLY__
>  
>  	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
> -- 
> 2.24.1
> 
