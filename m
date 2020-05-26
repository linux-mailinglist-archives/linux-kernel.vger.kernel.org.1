Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C31D4D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 14:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOMIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 08:08:17 -0400
Received: from foss.arm.com ([217.140.110.172]:54982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgEOMIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:08:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39021D6E;
        Fri, 15 May 2020 05:08:16 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.24.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 195183F305;
        Fri, 15 May 2020 05:08:13 -0700 (PDT)
Date:   Fri, 15 May 2020 13:08:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: Re: [PATCH v3 6/7] firmware: smccc: Add function to fetch SMCCC
 version
Message-ID: <20200515120811.GF67718@C02TD0UTHF1T.local>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
 <20200506164411.3284-7-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506164411.3284-7-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:44:10PM +0100, Sudeep Holla wrote:
> For backward compatibility reasons, PSCI maintains SMCCC version as
> SMCCC didn't provide ARM_SMCCC_VERSION_FUNC_ID until v1.1
> 
> Let us provide accessors to fetch the SMCCC version in PSCI so that
> other SMCCC v1.1+ features can use it.

Stale commit message? This was factored out of PSCI in the prior commit.

> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/smccc/smccc.c | 4 ++++
>  include/linux/arm-smccc.h      | 9 +++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
> index 488699aae24f..672974df0dfe 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -24,3 +24,7 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
>  	return smccc_conduit;
>  }
>  
> +u32 arm_smccc_version_get(void)
> +{
> +	return smccc_version;
> +}

Could we please call this arm_smccc_get_version(), to align with the
existing arm_smccc_1_1_get_conduit()?

> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 11fb20bfa8f7..8dd54dad1ec5 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -109,6 +109,15 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
>   */
>  enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
>  
> +/**
> + * arm_smccc_version_get()
> + *
> + * Returns the version to be used for SMCCCv1.1 or later.
> + *
> + * When SMCCCv1.1 or above is not present, assumes and returns SMCCCv1.0.
> + */
> +u32 arm_smccc_version_get(void);

Can we please reword the last line to something like:

| When SMCCCv1.1 or above is not present, returns SMCCCv1.0, but this
| does not imply the presence of firmware or a valid conduit. Callers
| handling SMCCCv1.0 must determine the conduit by other means.

With all that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
