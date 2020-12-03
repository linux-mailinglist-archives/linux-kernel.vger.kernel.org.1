Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887A42CD3F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbgLCKsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:48:06 -0500
Received: from foss.arm.com ([217.140.110.172]:36812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388715AbgLCKsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:48:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C078113E;
        Thu,  3 Dec 2020 02:47:20 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02FB3F66B;
        Thu,  3 Dec 2020 02:47:15 -0800 (PST)
Date:   Thu, 3 Dec 2020 10:47:12 +0000
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
Subject: Re: [PATCH v4 06/26] psci: Add accessor for psci_0_1_function_ids
Message-ID: <20201203104712.GC96754@C02TD0UTHF1T.local>
References: <20201202184122.26046-1-dbrazdil@google.com>
 <20201202184122.26046-7-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202184122.26046-7-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 06:41:02PM +0000, David Brazdil wrote:
> Make it possible to retrieve a copy of the psci_0_1_function_ids struct.
> This is useful for KVM if it is configured to intercept host's PSCI SMCs.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

... just to check, does KVM snapshot which function IDs are valid, or do
we want to add that state here too? That can be a follow-up if
necessary.

Thanks,
Mark.

> ---
>  drivers/firmware/psci/psci.c | 12 +++++-------
>  include/linux/psci.h         |  9 +++++++++
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 593fdd0e09a2..f5fc429cae3f 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -58,15 +58,13 @@ typedef unsigned long (psci_fn)(unsigned long, unsigned long,
>  				unsigned long, unsigned long);
>  static psci_fn *invoke_psci_fn;
>  
> -struct psci_0_1_function_ids {
> -	u32 cpu_suspend;
> -	u32 cpu_on;
> -	u32 cpu_off;
> -	u32 migrate;
> -};
> -
>  static struct psci_0_1_function_ids psci_0_1_function_ids;
>  
> +struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
> +{
> +	return psci_0_1_function_ids;
> +}
> +
>  #define PSCI_0_2_POWER_STATE_MASK		\
>  				(PSCI_0_2_POWER_STATE_ID_MASK | \
>  				PSCI_0_2_POWER_STATE_TYPE_MASK | \
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index 2a1bfb890e58..4ca0060a3fc4 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -34,6 +34,15 @@ struct psci_operations {
>  
>  extern struct psci_operations psci_ops;
>  
> +struct psci_0_1_function_ids {
> +	u32 cpu_suspend;
> +	u32 cpu_on;
> +	u32 cpu_off;
> +	u32 migrate;
> +};
> +
> +struct psci_0_1_function_ids get_psci_0_1_function_ids(void);
> +
>  #if defined(CONFIG_ARM_PSCI_FW)
>  int __init psci_dt_init(void);
>  #else
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
