Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A682C5A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404208AbgKZRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:21:29 -0500
Received: from foss.arm.com ([217.140.110.172]:41088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgKZRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:21:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DACB31B;
        Thu, 26 Nov 2020 09:21:28 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 353A53F23F;
        Thu, 26 Nov 2020 09:21:24 -0800 (PST)
Date:   Thu, 26 Nov 2020 17:21:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 01/23] psci: Support psci_ops.get_version for v0.1
Message-ID: <20201126172121.GB38486@C02TD0UTHF1T.local>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-2-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-2-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:53:59PM +0000, David Brazdil wrote:
> KVM's host PSCI SMC filter needs to be aware of the PSCI version of the
> system but currently it is impossible to distinguish between v0.1 and
> PSCI disabled because both have get_version == NULL.
> 
> Populate get_version for v0.1 with a function that returns a constant.
> 
> psci_opt.get_version is currently unused so this has no effect on
> existing functionality.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  drivers/firmware/psci/psci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 00af99b6f97c..213c68418a65 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -146,6 +146,11 @@ static int psci_to_linux_errno(int errno)
>  	return -EINVAL;
>  }
>  
> +static u32 psci_get_version_0_1(void)
> +{
> +	return PSCI_VERSION(0, 1);
> +}

Elsewhere in this file we've used a psci_${MAJOR}_${MINOR}_* naming
scheme.

To match that, I'd prefer we call this psci_0_1_get_version(), and
rename psci_get_version() to psci_0_2_get_version().

With that:
	
Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> +
>  static u32 psci_get_version(void)
>  {
>  	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
> @@ -514,6 +519,8 @@ static int __init psci_0_1_init(struct device_node *np)
>  
>  	pr_info("Using PSCI v0.1 Function IDs from DT\n");
>  
> +	psci_ops.get_version = psci_get_version_0_1;
> +
>  	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
>  		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
>  		psci_ops.cpu_suspend = psci_cpu_suspend;
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
