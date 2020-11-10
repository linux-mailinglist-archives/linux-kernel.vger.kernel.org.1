Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEF72AD912
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgKJOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:43:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbgKJOnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:43:05 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1149320678;
        Tue, 10 Nov 2020 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605019384;
        bh=xRxv/AUxy4vi7s0st2HDTl3DqkNZPZIv8nBqNrHDOhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SCPl37DM9sd5XiKV8yicyvZuiaMVl2SaLBgBrewwLevvpurSVI2lwFyDBnprrk/k4
         ASh85QC3keK9wqhH8bTbXss2eRHeFtiuKpu5lM0LYY/d9mnP213EO6M+NAgFC98Zdu
         vBBvpW9UGfMrU/MCTZdaTlajV3A8/v2Fskckw4Ck=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcUrN-009Ta1-P7; Tue, 10 Nov 2020 14:43:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 14:43:01 +0000
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
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 01/24] psci: Accessor for configured PSCI version
In-Reply-To: <20201109113233.9012-2-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-2-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <ba9c8ccf25ff82b834ab78930570b993@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 11:32, David Brazdil wrote:
> The version of PSCI that the kernel should use to communicate with
> firmware is typically obtained from probing PSCI_VERSION. However, that
> doesn't work for PSCI v0.1 where the host gets the information from
> DT/ACPI, or if PSCI is not supported / was disabled.
> 
> KVM's host PSCI proxy needs to be configured with the same version
> used by the host driver. Expose the PSCI version used by the host
> with a read-only accessor.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  drivers/firmware/psci/psci.c | 11 +++++++++++
>  include/linux/psci.h         |  8 ++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c 
> b/drivers/firmware/psci/psci.c
> index 00af99b6f97c..bc1b2d60fdbf 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -49,6 +49,13 @@ static int resident_cpu = -1;
>  struct psci_operations psci_ops;
>  static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
> 
> +static int driver_version = PSCI_VERSION(0, 0);
> +
> +int psci_driver_version(void)
> +{
> +	return driver_version;
> +}
> +
>  bool psci_tos_resident_on(int cpu)
>  {
>  	return cpu == resident_cpu;
> @@ -461,6 +468,8 @@ static int __init psci_probe(void)
>  		return -EINVAL;
>  	}
> 
> +	driver_version = ver;
> +
>  	psci_0_2_set_functions();
> 
>  	psci_init_migrate();
> @@ -514,6 +523,8 @@ static int __init psci_0_1_init(struct device_node 
> *np)
> 
>  	pr_info("Using PSCI v0.1 Function IDs from DT\n");
> 
> +	driver_version = PSCI_VERSION(0, 1);
> +
>  	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
>  		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
>  		psci_ops.cpu_suspend = psci_cpu_suspend;
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index 2a1bfb890e58..5b5dcf176aa6 100644
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
> +int psci_driver_version(void);
> +
>  struct psci_operations {
>  	u32 (*get_version)(void);
>  	int (*cpu_suspend)(u32 state, unsigned long entry_point);

I still maintain that populating .get_version in all cases instead of
duplicating an existing functionality is a better outcome. PSCI not
supported would be implied by .get_version being NULL.

What breaks?

         M.
-- 
Jazz is not dead. It just smells funny...
