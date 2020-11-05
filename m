Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0364C2A8860
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbgKEUww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEUww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:52:52 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0267CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:52:52 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b12so1377772plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5B3BUR7zhLFI+O8VNXI+BR9UNMawI4ntjOAqlHZd5gk=;
        b=PY7hBZA644AeQIM5WFIWFKnBaU1T64Di8bpujZvsRJV2OwNbs4WEmQ5iPxMAHpjfUZ
         6KUeil3lRRcjeN/rG6zxP26i2m1lmWIy2CeJp5FyO/Wdl7z8oJ+qXUWAZko/ebjVmuqa
         HVvllgwtGvHF030S/fhUIPu8kMTnGN/hCysMpNLDyoOTQ1GDxdEFUK9vcXr7rl9IK09s
         LEX0mGAiDlOK0zLghJc5LXrI/1V/yb5B8GYVtCPrcNrxK32jyd9ucQZqH8lmnt2lupOA
         KQ2KA30bnejbt7SJ9jN3tigr2nBDU0Q3yE3HDOxMjJrPlMEWx+q862h8o+tC2QerX62U
         it9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5B3BUR7zhLFI+O8VNXI+BR9UNMawI4ntjOAqlHZd5gk=;
        b=pheVTz9Hfgdez1lttBfkxhW7PJkd4rRUaNn+7dqscUqBL4KnEmDOo3YK7m/bEBXj1d
         e9KJctePSav2mT/T4q3sznC4ypGmqkOh6hiXS2tkhhZ2bQ5SCaXBycTzpkBO9JrC33Ci
         RRj5moxkw6AaDE8XtqeM+0UzWXyWZyUuYl33SiSitKNpXLIArdhjjjrM9YxH0UmrUwok
         00JO14fJHdCZ0X06KoLqXjFMBqv0ynMFSCm0vP38GIYJ1SqO5iKSGJM1FsLWb03nrpNI
         eU9wxxxukGTU5ovyLl+JhZgRVtig+orFSX/DFe3fmlklRHzjfJvLs8yPGBzL1kNxmbkx
         fwHQ==
X-Gm-Message-State: AOAM532sXPtfxnuwzGORjfTUNTyI58f3g9fNAXntbneqQGsvzp846wbp
        W3ZTK8aeuLwJDt3OZBS9Wy36uw==
X-Google-Smtp-Source: ABdhPJww/GGKynI6IBlUUKvagJbByBw8FA+0DfNNEzZH2j56kSNZVgl9qGah0Ty8LTCVO7BGI2iMvQ==
X-Received: by 2002:a17:902:c412:b029:d6:fea3:429 with SMTP id k18-20020a170902c412b02900d6fea30429mr3011636plk.50.1604609571377;
        Thu, 05 Nov 2020 12:52:51 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m68sm3290085pga.46.2020.11.05.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:52:50 -0800 (PST)
Date:   Thu, 5 Nov 2020 13:52:48 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/26] coresight: etm4x: Add sysreg access helpers
Message-ID: <20201105205248.GA3047244@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-16-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-16-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:33PM +0000, Suzuki K Poulose wrote:
> ETMv4.4 architecture defines the system instructions for accessing
> ETM via register accesses. Add basic support for accessing a given
> register via system instructions.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          |  39 ++
>  drivers/hwtracing/coresight/coresight-etm4x.h | 348 ++++++++++++++++--
>  2 files changed, 365 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 4af7d45dfe63..90b80982c615 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -56,6 +56,45 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
>  
>  static enum cpuhp_state hp_online;
>  
> +u64 etm4x_sysreg_read(struct csdev_access *csa,
> +		      u32 offset,
> +		      bool _relaxed,
> +		      bool _64bit)

Please fix the stacking.

> +{
> +	u64 res = 0;
> +
> +	switch (offset) {
> +	ETM4x_READ_CASES(res)
> +	default :
> +		WARN_ONCE(1, "etm4x: trying to read unsupported register @%x\n",
> +			 offset);
> +	}
> +
> +	if (!_relaxed)
> +		__iormb(res);	/* Imitate the !relaxed I/O helpers */
> +
> +	return res;
> +}
> +
> +void etm4x_sysreg_write(struct csdev_access *csa,
> +			u64 val,
> +			u32 offset,
> +			bool _relaxed,
> +			bool _64bit)

Here too.

> +{
> +	if (!_relaxed)
> +		__iowmb();	/* Imitate the !relaxed I/O helpers */
> +	if (!_64bit)
> +		val &= GENMASK(31, 0);
> +
> +	switch (offset) {
> +	ETM4x_WRITE_CASES(val)
> +	default :
> +		WARN_ONCE(1, "etm4x: trying to write to unsupported register @%x\n",
> +			offset);
> +	}
> +}
> +
>  static void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata, struct csdev_access *csa)
>  {
>  	/* Writing 0 to TRCOSLAR unlocks the trace registers */
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 510828c73db6..5cf71b30a652 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -125,29 +125,323 @@
>  #define TRCCIDR2			0xFF8
>  #define TRCCIDR3			0xFFC
>  
> -#define etm4x_relaxed_read32(csa, offset)		\
> -	readl_relaxed((csa)->base + (offset))
> -
> -#define etm4x_read32(csa, offset)			\
> -	readl((csa)->base + (offset))
> -
> -#define etm4x_relaxed_write32(csa, val, offset)		\
> -	writel_relaxed((val), (csa)->base + (offset))
> -
> -#define etm4x_write32(csa, val, offset)			\
> -	writel((val), (csa)->base + (offset))
> -
> -#define etm4x_relaxed_read64(csa, offset)		\
> -	readq_relaxed((csa)->base + (offset))
> -
> -#define etm4x_read64(csa, offset)			\
> -	readq((csa)->base + (offset))
> -
> -#define etm4x_relaxed_write64(csa, val, offset)		\
> -	writeq_relaxed((val), (csa)->base + (offset))
> +/*
> + * System instructions to access ETM registers.
> + * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> + */
> +#define ETM4x_OFFSET_TO_REG(x)		((x) >> 2)
> +
> +#define ETM4x_CRn(n)			(((n) >> 7) & 0x7)
> +#define ETM4x_Op2(n)			(((n) >> 4) & 0x7)
> +#define ETM4x_CRm(n)			((n) & 0xf)
> +
> +#include <asm/sysreg.h>
> +#define ETM4x_REG_NUM_TO_SYSREG(n)				\
> +	sys_reg(2, 1, ETM4x_CRn(n), ETM4x_CRm(n), ETM4x_Op2(n))
> +
> +#define READ_ETM4x_REG(reg)					\
> +	read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
> +#define WRITE_ETM4x_REG(val, reg)				\
> +	write_sysreg_s(val, ETM4x_REG_NUM_TO_SYSREG((reg)))
> +
> +#define read_etm4x_sysreg_const_offset(offset)			\
> +	READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
> +
> +#define write_etm4x_sysreg_const_offset(val, offset)		\
> +	WRITE_ETM4x_REG(val, ETM4x_OFFSET_TO_REG(offset))
> +
> +#define CASE_READ(res, x)					\
> +	case (x): { (res) = read_etm4x_sysreg_const_offset((x)); break; }
> +
> +#define CASE_WRITE(val, x)					\
> +	case (x): { write_etm4x_sysreg_const_offset((val), (x)); break; }
> +
> +#define CASE_LIST(op, val)			\
> +	CASE_##op((val), TRCPRGCTLR)		\
> +	CASE_##op((val), TRCPROCSELR)		\
> +	CASE_##op((val), TRCSTATR)		\
> +	CASE_##op((val), TRCCONFIGR)		\
> +	CASE_##op((val), TRCAUXCTLR)		\
> +	CASE_##op((val), TRCEVENTCTL0R)		\
> +	CASE_##op((val), TRCEVENTCTL1R)		\
> +	CASE_##op((val), TRCSTALLCTLR)		\
> +	CASE_##op((val), TRCTSCTLR)		\
> +	CASE_##op((val), TRCSYNCPR)		\
> +	CASE_##op((val), TRCCCCTLR)		\
> +	CASE_##op((val), TRCBBCTLR)		\
> +	CASE_##op((val), TRCTRACEIDR)		\
> +	CASE_##op((val), TRCQCTLR)		\
> +	CASE_##op((val), TRCVICTLR)		\
> +	CASE_##op((val), TRCVIIECTLR)		\
> +	CASE_##op((val), TRCVISSCTLR)		\
> +	CASE_##op((val), TRCVIPCSSCTLR)		\
> +	CASE_##op((val), TRCVDCTLR)		\
> +	CASE_##op((val), TRCVDSACCTLR)		\
> +	CASE_##op((val), TRCVDARCCTLR)		\
> +	CASE_##op((val), TRCSEQEVRn(0))		\
> +	CASE_##op((val), TRCSEQEVRn(1))		\
> +	CASE_##op((val), TRCSEQEVRn(2))		\
> +	CASE_##op((val), TRCSEQRSTEVR)		\
> +	CASE_##op((val), TRCSEQSTR)		\
> +	CASE_##op((val), TRCEXTINSELR)		\
> +	CASE_##op((val), TRCCNTRLDVRn(0))	\
> +	CASE_##op((val), TRCCNTRLDVRn(1))	\
> +	CASE_##op((val), TRCCNTRLDVRn(2))	\
> +	CASE_##op((val), TRCCNTRLDVRn(3))	\
> +	CASE_##op((val), TRCCNTCTLRn(0))	\
> +	CASE_##op((val), TRCCNTCTLRn(1))	\
> +	CASE_##op((val), TRCCNTCTLRn(2))	\
> +	CASE_##op((val), TRCCNTCTLRn(3))	\
> +	CASE_##op((val), TRCCNTVRn(0))		\
> +	CASE_##op((val), TRCCNTVRn(1))		\
> +	CASE_##op((val), TRCCNTVRn(2))		\
> +	CASE_##op((val), TRCCNTVRn(3))		\
> +	CASE_##op((val), TRCIDR8)		\
> +	CASE_##op((val), TRCIDR9)		\
> +	CASE_##op((val), TRCIDR10)		\
> +	CASE_##op((val), TRCIDR11)		\
> +	CASE_##op((val), TRCIDR12)		\
> +	CASE_##op((val), TRCIDR13)		\
> +	CASE_##op((val), TRCIMSPECn(0))		\
> +	CASE_##op((val), TRCIMSPECn(1))		\
> +	CASE_##op((val), TRCIMSPECn(2))		\
> +	CASE_##op((val), TRCIMSPECn(3))		\
> +	CASE_##op((val), TRCIMSPECn(4))		\
> +	CASE_##op((val), TRCIMSPECn(5))		\
> +	CASE_##op((val), TRCIMSPECn(6))		\
> +	CASE_##op((val), TRCIMSPECn(7))		\
> +	CASE_##op((val), TRCIDR0)		\
> +	CASE_##op((val), TRCIDR1)		\
> +	CASE_##op((val), TRCIDR2)		\
> +	CASE_##op((val), TRCIDR3)		\
> +	CASE_##op((val), TRCIDR4)		\
> +	CASE_##op((val), TRCIDR5)		\
> +	CASE_##op((val), TRCIDR6)		\
> +	CASE_##op((val), TRCIDR7)		\
> +	CASE_##op((val), TRCRSCTLRn(2))		\
> +	CASE_##op((val), TRCRSCTLRn(3))		\
> +	CASE_##op((val), TRCRSCTLRn(4))		\
> +	CASE_##op((val), TRCRSCTLRn(5))		\
> +	CASE_##op((val), TRCRSCTLRn(6))		\
> +	CASE_##op((val), TRCRSCTLRn(7))		\
> +	CASE_##op((val), TRCRSCTLRn(8))		\
> +	CASE_##op((val), TRCRSCTLRn(9))		\
> +	CASE_##op((val), TRCRSCTLRn(10))	\
> +	CASE_##op((val), TRCRSCTLRn(11))	\
> +	CASE_##op((val), TRCRSCTLRn(12))	\
> +	CASE_##op((val), TRCRSCTLRn(13))	\
> +	CASE_##op((val), TRCRSCTLRn(14))	\
> +	CASE_##op((val), TRCRSCTLRn(15))	\
> +	CASE_##op((val), TRCRSCTLRn(16))	\
> +	CASE_##op((val), TRCRSCTLRn(17))	\
> +	CASE_##op((val), TRCRSCTLRn(18))	\
> +	CASE_##op((val), TRCRSCTLRn(19))	\
> +	CASE_##op((val), TRCRSCTLRn(20))	\
> +	CASE_##op((val), TRCRSCTLRn(21))	\
> +	CASE_##op((val), TRCRSCTLRn(22))	\
> +	CASE_##op((val), TRCRSCTLRn(23))	\
> +	CASE_##op((val), TRCRSCTLRn(24))	\
> +	CASE_##op((val), TRCRSCTLRn(25))	\
> +	CASE_##op((val), TRCRSCTLRn(26))	\
> +	CASE_##op((val), TRCRSCTLRn(27))	\
> +	CASE_##op((val), TRCRSCTLRn(28))	\
> +	CASE_##op((val), TRCRSCTLRn(29))	\
> +	CASE_##op((val), TRCRSCTLRn(30))	\
> +	CASE_##op((val), TRCRSCTLRn(31))	\
> +	CASE_##op((val), TRCSSCCRn(0))		\
> +	CASE_##op((val), TRCSSCCRn(1))		\
> +	CASE_##op((val), TRCSSCCRn(2))		\
> +	CASE_##op((val), TRCSSCCRn(3))		\
> +	CASE_##op((val), TRCSSCCRn(4))		\
> +	CASE_##op((val), TRCSSCCRn(5))		\
> +	CASE_##op((val), TRCSSCCRn(6))		\
> +	CASE_##op((val), TRCSSCCRn(7))		\
> +	CASE_##op((val), TRCSSCSRn(0))		\
> +	CASE_##op((val), TRCSSCSRn(1))		\
> +	CASE_##op((val), TRCSSCSRn(2))		\
> +	CASE_##op((val), TRCSSCSRn(3))		\
> +	CASE_##op((val), TRCSSCSRn(4))		\
> +	CASE_##op((val), TRCSSCSRn(5))		\
> +	CASE_##op((val), TRCSSCSRn(6))		\
> +	CASE_##op((val), TRCSSCSRn(7))		\
> +	CASE_##op((val), TRCSSPCICRn(0))	\
> +	CASE_##op((val), TRCSSPCICRn(1))	\
> +	CASE_##op((val), TRCSSPCICRn(2))	\
> +	CASE_##op((val), TRCSSPCICRn(3))	\
> +	CASE_##op((val), TRCSSPCICRn(4))	\
> +	CASE_##op((val), TRCSSPCICRn(5))	\
> +	CASE_##op((val), TRCSSPCICRn(6))	\
> +	CASE_##op((val), TRCSSPCICRn(7))	\
> +	CASE_##op((val), TRCOSLAR)		\
> +	CASE_##op((val), TRCOSLSR)		\
> +	CASE_##op((val), TRCPDCR)		\
> +	CASE_##op((val), TRCPDSR)		\
> +	CASE_##op((val), TRCACVRn(0))		\
> +	CASE_##op((val), TRCACVRn(1))		\
> +	CASE_##op((val), TRCACVRn(2))		\
> +	CASE_##op((val), TRCACVRn(3))		\
> +	CASE_##op((val), TRCACVRn(4))		\
> +	CASE_##op((val), TRCACVRn(5))		\
> +	CASE_##op((val), TRCACVRn(6))		\
> +	CASE_##op((val), TRCACVRn(7))		\
> +	CASE_##op((val), TRCACVRn(8))		\
> +	CASE_##op((val), TRCACVRn(9))		\
> +	CASE_##op((val), TRCACVRn(10))		\
> +	CASE_##op((val), TRCACVRn(11))		\
> +	CASE_##op((val), TRCACVRn(12))		\
> +	CASE_##op((val), TRCACVRn(13))		\
> +	CASE_##op((val), TRCACVRn(14))		\
> +	CASE_##op((val), TRCACVRn(15))		\
> +	CASE_##op((val), TRCACATRn(0))		\
> +	CASE_##op((val), TRCACATRn(1))		\
> +	CASE_##op((val), TRCACATRn(2))		\
> +	CASE_##op((val), TRCACATRn(3))		\
> +	CASE_##op((val), TRCACATRn(4))		\
> +	CASE_##op((val), TRCACATRn(5))		\
> +	CASE_##op((val), TRCACATRn(6))		\
> +	CASE_##op((val), TRCACATRn(7))		\
> +	CASE_##op((val), TRCACATRn(8))		\
> +	CASE_##op((val), TRCACATRn(9))		\
> +	CASE_##op((val), TRCACATRn(10))		\
> +	CASE_##op((val), TRCACATRn(11))		\
> +	CASE_##op((val), TRCACATRn(12))		\
> +	CASE_##op((val), TRCACATRn(13))		\
> +	CASE_##op((val), TRCACATRn(14))		\
> +	CASE_##op((val), TRCACATRn(15))		\
> +	CASE_##op((val), TRCDVCVRn(0))		\
> +	CASE_##op((val), TRCDVCVRn(1))		\
> +	CASE_##op((val), TRCDVCVRn(2))		\
> +	CASE_##op((val), TRCDVCVRn(3))		\
> +	CASE_##op((val), TRCDVCVRn(4))		\
> +	CASE_##op((val), TRCDVCVRn(5))		\
> +	CASE_##op((val), TRCDVCVRn(6))		\
> +	CASE_##op((val), TRCDVCVRn(7))		\
> +	CASE_##op((val), TRCDVCMRn(0))		\
> +	CASE_##op((val), TRCDVCMRn(1))		\
> +	CASE_##op((val), TRCDVCMRn(2))		\
> +	CASE_##op((val), TRCDVCMRn(3))		\
> +	CASE_##op((val), TRCDVCMRn(4))		\
> +	CASE_##op((val), TRCDVCMRn(5))		\
> +	CASE_##op((val), TRCDVCMRn(6))		\
> +	CASE_##op((val), TRCDVCMRn(7))		\
> +	CASE_##op((val), TRCCIDCVRn(0))		\
> +	CASE_##op((val), TRCCIDCVRn(1))		\
> +	CASE_##op((val), TRCCIDCVRn(2))		\
> +	CASE_##op((val), TRCCIDCVRn(3))		\
> +	CASE_##op((val), TRCCIDCVRn(4))		\
> +	CASE_##op((val), TRCCIDCVRn(5))		\
> +	CASE_##op((val), TRCCIDCVRn(6))		\
> +	CASE_##op((val), TRCCIDCVRn(7))		\
> +	CASE_##op((val), TRCVMIDCVRn(0))	\
> +	CASE_##op((val), TRCVMIDCVRn(1))	\
> +	CASE_##op((val), TRCVMIDCVRn(2))	\
> +	CASE_##op((val), TRCVMIDCVRn(3))	\
> +	CASE_##op((val), TRCVMIDCVRn(4))	\
> +	CASE_##op((val), TRCVMIDCVRn(5))	\
> +	CASE_##op((val), TRCVMIDCVRn(6))	\
> +	CASE_##op((val), TRCVMIDCVRn(7))	\
> +	CASE_##op((val), TRCCIDCCTLR0)		\
> +	CASE_##op((val), TRCCIDCCTLR1)		\
> +	CASE_##op((val), TRCVMIDCCTLR0)		\
> +	CASE_##op((val), TRCVMIDCCTLR1)		\
> +	CASE_##op((val), TRCITCTRL)		\
> +	CASE_##op((val), TRCCLAIMSET)		\
> +	CASE_##op((val), TRCCLAIMCLR)		\
> +	CASE_##op((val), TRCDEVAFF0)		\
> +	CASE_##op((val), TRCDEVAFF1)		\
> +	CASE_##op((val), TRCLAR)		\
> +	CASE_##op((val), TRCLSR)		\
> +	CASE_##op((val), TRCAUTHSTATUS)		\
> +	CASE_##op((val), TRCDEVARCH)		\
> +	CASE_##op((val), TRCDEVID)		\
> +	CASE_##op((val), TRCDEVTYPE)		\
> +	CASE_##op((val), TRCPIDR4)		\
> +	CASE_##op((val), TRCPIDR5)		\
> +	CASE_##op((val), TRCPIDR6)		\
> +	CASE_##op((val), TRCPIDR7)		\
> +	CASE_##op((val), TRCPIDR0)		\
> +	CASE_##op((val), TRCPIDR1)		\
> +	CASE_##op((val), TRCPIDR2)		\
> +	CASE_##op((val), TRCPIDR3)
> +
> +#define ETM4x_READ_CASES(res)	CASE_LIST(READ, (res))
> +#define ETM4x_WRITE_CASES(val)	CASE_LIST(WRITE, (val))
> +
> +#define read_etm4x_sysreg_offset(csa, offset, _64bit)				\
> +	({									\
> +		u64 __val;							\
> +										\
> +		if (__builtin_constant_p((offset)))				\

Neat trick - I wonder how you stumbled on that one.


> +			__val = read_etm4x_sysreg_const_offset((offset));	\
> +		else								\
> +			__val = etm4x_sysreg_read((csa), (offset),		\
> +						  true, _64bit);		\
> +		__val;								\
> +	 })
> +
> +#define write_etm4x_sysreg_offset(csa, val, offset, _64bit)		\
> +	do {								\
> +		if (__builtin_constant_p((offset)))			\
> +			write_etm4x_sysreg_const_offset((val),		\
> +							(offset));	\
> +		else							\
> +			etm4x_sysreg_write((csa), (val), (offset),	\
> +						true, _64bit);		\
> +	} while (0)
> +
> +
> +#define etm4x_relaxed_read32(csa, offset)				\
> +	((u32)((csa)->io_mem ?						\
> +		 readl_relaxed((csa)->base + (offset)) :		\
> +		 read_etm4x_sysreg_offset((csa), (offset), false)))

Please add an extra new line - otherwise it is very hard to read.

> +#define etm4x_relaxed_read64(csa, offset)				\
> +	((u64)((csa)->io_mem ?						\
> +		 readq_relaxed((csa)->base + (offset)) :		\
> +		 read_etm4x_sysreg_offset((csa), (offset), true)))

Here too.

> +#define etm4x_read32(csa, offset)					\
> +	({								\
> +		u32 __val = etm4x_relaxed_read32((csa), (offset));	\
> +		__iormb(__val);						\
> +		__val;							\
> +	 })
> +
> +#define etm4x_read64(csa, offset)					\
> +	({								\
> +		u64 __val = etm4x_relaxed_read64((csa), (offset));	\
> +		__iormb(__val);						\
> +		__val;							\
> +	 })
> +
> +#define etm4x_relaxed_write32(csa, val, offset)				\
> +	do {								\
> +		if ((csa)->io_mem)					\
> +			writel_relaxed((val), (csa)->base + (offset));	\
> +		else							\
> +			write_etm4x_sysreg_offset((csa), (val),	\
> +						    (offset), false);	\

Why using an if/else statement and above the '?' condition marker?  I would
really like a uniform approach.  Otherwise the reader keeps looking for
something subtle when there isn't.

> +	} while (0)
> +
> +#define etm4x_relaxed_write64(csa, val, offset)				\
> +	do {								\
> +		if ((csa)->io_mem)					\
> +			writeq_relaxed((val), (csa)->base + (offset));	\
> +		else							\
> +			write_etm4x_sysreg_offset((csa), (val),	\
> +						    (offset), true);	\
> +	} while (0)
> +
> +#define etm4x_write32(csa, val, offset)					\
> +	do {								\
> +		__iowmb();						\
> +		etm4x_relaxed_write32((csa), (val), (offset));		\
> +	} while (0)
> +
> +#define etm4x_write64(csa, val, offset)					\
> +	do {								\
> +		__iowmb();						\
> +		etm4x_relaxed_write64((csa), (val), (offset));		\
> +	} while (0)
>  
> -#define etm4x_write64(csa, val, offset)			\
> -	writeq((val), (csa)->base + (offset))
>  
>  /* ETMv4 resources */
>  #define ETM_MAX_NR_PE			8
> @@ -512,4 +806,14 @@ enum etm_addr_ctxtype {
>  
>  extern const struct attribute_group *coresight_etmv4_groups[];
>  void etm4_config_trace_mode(struct etmv4_config *config);
> +
> +u64 etm4x_sysreg_read(struct csdev_access *csa,
> +		      u32 offset,
> +		      bool _relaxed,
> +		      bool _64bit);
> +void etm4x_sysreg_write(struct csdev_access *csa,
> +			u64 val,
> +			u32 offset,
> +			bool _relaxed,
> +			bool _64bit);

With the above: 

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

This patch holds together well.  I commend you on rendering something that is
quite complex into a manageable implementation.  That being said it will impact
Mike's complex configuration patchset (or Mike's complex configuration patchset
will have an impact on this).

>  #endif
> -- 
> 2.24.1
> 
