Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42F2A9629
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgKFMZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgKFMZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:25:08 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4854220728;
        Fri,  6 Nov 2020 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604665507;
        bh=V/Ngl+S6qEm3sU0uEaVkuAcYmnBwh6ZSK48gtM1t+SM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KtXHeJtgR+x5+njnUSXftuBQbkIMrGAotZNXi4Ldu2y2k2D61oENT054zurjalV97
         Xwk+0XMHlRdo2bs6E2LsG3diL6HX6DDgF7Uwt5a1/TMPp5aARhqQS3VC0bUY4UFytz
         vGpkXJY4ciGO2qWrbnqJLwMUYNTVwgKaANhMuAqk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kb0nh-008CCI-4P; Fri, 06 Nov 2020 12:25:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Nov 2020 12:25:05 +0000
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
Subject: Re: [RFC PATCH 00/26] kvm: arm64: Always-on nVHE hypervisor
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <60a77f17737ffcfa31c3d1dfacc24384@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-04 18:36, David Brazdil wrote:
> As we progress towards being able to keep guest state private to the
> host running nVHE hypervisor, this series allows the hypervisor to
> install itself on newly booted CPUs before the host is allowed to run
> on them.
> 
> To this end, the hypervisor starts trapping host SMCs and intercepting
> host's PSCI CPU_ON/OFF/SUSPEND calls. It replaces the host's entry 
> point
> with its own, initializes the EL2 state of the new CPU and installs
> the nVHE hyp vector before ERETing to the host's entry point.
> 
> Other PSCI SMCs are forwarded to EL3, though only the known set of SMCs
> implemented in the kernel is allowed. Non-PSCI SMCs are also forwarded
> to EL3. Future changes will need to ensure the safety of all SMCs wrt.
> private guests.
> 
> The host is still allowed to reset EL2 back to the stub vector, eg. for
> hibernation or kexec, but will not disable nVHE when there are no VMs.
> 
> Tested on Rock Pi 4b.
> 
> 
> Sending this as an RFC to get feedback on the following decisions:
> 
> 1) The kernel checks new cores' features against the finalized system
> capabilities. To avoid the need to move this code/data to EL2, the
> implementation only allows to boot cores that were online at the time 
> of
> KVM initialization.
> 
> 2) Trapping and forwarding SMCs cannot be switched off. This could 
> cause
> issues eg. if EL3 always returned to EL1. A kernel command line flag 
> may
> be needed to turn the feature off on such platforms.

I'd rather have it the other way around (buy-in rather than turn off).
On top of the potential issue with stupid EL3s, there is the issue that
PSCI is optional, and that protected VMs won't be able to work without
it. Another related thing is that EL3 itself is optional.

Note that this flag shouldn't be specific to PSCI proxying. It should 
also
control Stage-2 wrapping, and the whole pKVM.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
