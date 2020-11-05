Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686582A7AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgKEJrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKEJrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:47:13 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8AAE2080D;
        Thu,  5 Nov 2020 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604569632;
        bh=HHlnMYvribr6tXTc4dWdBjcjHKLjb6dHLifRUqDqwQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EFLzxc0G4nItwOrjOMnnSewgHj9shosTzBoWlwDLKKI7KwDNQ7RaKW9TqsU/pIg+p
         uMsxcNdZQZJQo+Rj1yD1EmgjbipQWG6wClnZfll/W+huy0QRJr1y0deHb5k/8Mzl3/
         ECS9HsXAUOFDwEhdx2CSmDCDPi5yO0opgabFzzXQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kabrJ-007n9r-JG; Thu, 05 Nov 2020 09:47:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 09:47:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>, kernel-team@android.com
Subject: Re: [RFC PATCH 01/26] psci: Export configured PSCI version
In-Reply-To: <20201104183630.27513-2-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
 <20201104183630.27513-2-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <2265d2fed043ab79721c1014d6144558@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-04 18:36, David Brazdil wrote:
> The version of PSCI that the kernel should use to communicate with
> firmware is typically obtained from probing PSCI_VERSION. However, that
> doesn't work for PSCI v0.1 where the host gets the information from
> DT/ACPI, or if PSCI is not supported / was disabled.
> 
> KVM's PSCI proxy for the host needs to be configured with the same
> version used by the host driver. Expose the PSCI version used by the
> host.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  drivers/firmware/psci/psci.c | 6 ++++++
>  include/linux/psci.h         | 8 ++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c 
> b/drivers/firmware/psci/psci.c
> index 00af99b6f97c..ff523bdbfe3f 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -49,6 +49,8 @@ static int resident_cpu = -1;
>  struct psci_operations psci_ops;
>  static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
> 
> +int psci_driver_version = PSCI_VERSION(0, 0);
> +
>  bool psci_tos_resident_on(int cpu)
>  {
>  	return cpu == resident_cpu;
> @@ -461,6 +463,8 @@ static int __init psci_probe(void)
>  		return -EINVAL;
>  	}
> 
> +	psci_driver_version = ver;
> +
>  	psci_0_2_set_functions();
> 
>  	psci_init_migrate();
> @@ -514,6 +518,8 @@ static int __init psci_0_1_init(struct device_node 
> *np)
> 
>  	pr_info("Using PSCI v0.1 Function IDs from DT\n");
> 
> +	psci_driver_version = PSCI_VERSION(0, 1);
> +
>  	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
>  		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
>  		psci_ops.cpu_suspend = psci_cpu_suspend;
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index 2a1bfb890e58..cb35b90d1746 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -21,6 +21,14 @@ bool psci_power_state_is_valid(u32 state);
>  int psci_set_osi_mode(bool enable);
>  bool psci_has_osi_support(void);
> 
> +/**
> + * The version of the PSCI specification followed by the driver.
> + * This is equivalent to calling PSCI_VERSION except:
> + *   (a) it also works for PSCI v0.1, which does not support 
> PSCI_VERSION, and
> + *   (b) it is set to v0.0 if the PSCI driver was not initialized.
> + */
> +extern int psci_driver_version;
> +
>  struct psci_operations {
>  	u32 (*get_version)(void);
>  	int (*cpu_suspend)(u32 state, unsigned long entry_point);

How about providing a get_version callback for pre-0.2 implementations
instead? This would avoid exposing more symbols (psci_ops is already
global).

Thanks,

         M.

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 00af99b6f97c..b84454e12d92 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -500,6 +500,11 @@ static int __init psci_0_2_init(struct device_node 
*np)
  	return psci_probe();
  }

+static u32 psci_0_1_get_version(void)
+{
+	return PSCI_VERSION(0, 1);
+}
+
  /*
   * PSCI < v0.2 get PSCI Function IDs via DT.
   */
@@ -514,6 +519,8 @@ static int __init psci_0_1_init(struct device_node 
*np)

  	pr_info("Using PSCI v0.1 Function IDs from DT\n");

+	psci_ops.get_version = psci_0_1_get_version;
+
  	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
  		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
  		psci_ops.cpu_suspend = psci_cpu_suspend;

-- 
Jazz is not dead. It just smells funny...
