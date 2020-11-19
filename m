Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F69F2B9933
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgKSRWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:22:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbgKSRWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:22:48 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEB42468B;
        Thu, 19 Nov 2020 17:22:46 +0000 (UTC)
Date:   Thu, 19 Nov 2020 17:22:43 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, jonathan.zhouwen@huawei.com,
        coresight@lists.linaro.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 25/25] coresight: Add support for v8.4 SelfHosted
 tracing
Message-ID: <20201119172243.GF4376@gaia>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-26-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-26-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:47PM +0000, Suzuki K Poulose wrote:
> From: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> 
> v8.4 tracing extensions added support for trace filtering controlled
> by TRFCR_ELx. This must be programmed to allow tracing at EL1/EL2 and
> EL0. The timestamp used is the virtual time. Also enable CONTEXIDR_EL2
> tracing if we are running the kernel at EL2.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> [ Move the trace filtering setup etm_init_arch_data() and
>  clean ups]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 1d054d2ab2a0..647685736134 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -760,6 +760,30 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>  	return false;
>  }
>  
> +static void cpu_enable_tracing(void)
> +{
> +	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
> +	u64 trfcr;
> +
> +	if (!(dfr0 >> ID_AA64DFR0_TRACE_FILT_SHIFT))
> +		return;

What if we get a new field at position 44 while the FILT one at 40 is 0?
We should use cpuid_feature_extract_field() here.

BTW, can this function not go in the cpufeature.c code?

-- 
Catalin
