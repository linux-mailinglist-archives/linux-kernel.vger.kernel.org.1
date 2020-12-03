Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0EA2CD415
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbgLCK4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:56:02 -0500
Received: from foss.arm.com ([217.140.110.172]:37062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387870AbgLCK4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:56:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD0F113E;
        Thu,  3 Dec 2020 02:55:15 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 129CC3F66B;
        Thu,  3 Dec 2020 02:55:11 -0800 (PST)
Date:   Thu, 3 Dec 2020 10:55:09 +0000
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
Subject: Re: [PATCH v4 16/26] kvm: arm64: Bootstrap PSCI SMC handler in nVHE
 EL2
Message-ID: <20201203105509.GD96754@C02TD0UTHF1T.local>
References: <20201202184122.26046-1-dbrazdil@google.com>
 <20201202184122.26046-17-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202184122.26046-17-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 06:41:12PM +0000, David Brazdil wrote:
> Add a handler of PSCI SMCs in nVHE hyp code. The handler is initialized
> with the version used by the host's PSCI driver and the function IDs it
> was configured with. If the SMC function ID matches one of the
> configured PSCI calls (for v0.1) or falls into the PSCI function ID
> range (for v0.2+), the SMC is handled by the PSCI handler. For now, all
> SMCs return PSCI_RET_NOT_SUPPORTED.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>

> +static bool is_psci_0_1_call(u64 func_id)
> +{
> +	return (func_id == kvm_host_psci_0_1_function_ids.cpu_suspend) ||
> +	       (func_id == kvm_host_psci_0_1_function_ids.cpu_on) ||
> +	       (func_id == kvm_host_psci_0_1_function_ids.cpu_off) ||
> +	       (func_id == kvm_host_psci_0_1_function_ids.migrate);
> +}

One minor thing, as I just spotted on an earlier patch: if FW doesn't
implement one of these, the ID will be 0, so we might need to snapshot
whether or not the function is enabled to stop spurious calls to FID 0.

To be clear, that can be done in a follow-up if necessary.

Thanks,
Mark.
