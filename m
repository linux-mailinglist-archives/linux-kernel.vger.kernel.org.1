Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0F2CD826
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgLCNq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgLCNq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:46:57 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C413A206D8;
        Thu,  3 Dec 2020 13:46:16 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kkow2-00Ffsk-Il; Thu, 03 Dec 2020 13:46:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Dec 2020 13:46:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 16/26] kvm: arm64: Bootstrap PSCI SMC handler in nVHE
 EL2
In-Reply-To: <20201202184122.26046-17-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
 <20201202184122.26046-17-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <3ac00cc2e2887f85e250288a7b6b5e4f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of cosmetic comments below, none of which require immediate
addressing.

[...]

> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> new file mode 100644
> index 000000000000..61375d4571c2
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 - Google LLC
> + * Author: David Brazdil <dbrazdil@google.com>
> + */
> +
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_hyp.h>
> +#include <asm/kvm_mmu.h>
> +#include <kvm/arm_hypercalls.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/psci.h>
> +#include <kvm/arm_psci.h>

nit: is there an ordering issue that requires this to be out
of order?

> +#include <uapi/linux/psci.h>
> +
> +#include <nvhe/trap_handler.h>
> +
> +/* Config options set by the host. */
> +__ro_after_init u32 kvm_host_psci_version;
> +__ro_after_init struct psci_0_1_function_ids 
> kvm_host_psci_0_1_function_ids;

nit: we usually place attributes after the type.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
