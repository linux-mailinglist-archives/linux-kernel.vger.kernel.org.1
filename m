Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93AD2CA66A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbgLAO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:58:20 -0500
Received: from foss.arm.com ([217.140.110.172]:44382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389268AbgLAO6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:58:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E9C30E;
        Tue,  1 Dec 2020 06:57:32 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 073823F575;
        Tue,  1 Dec 2020 06:57:23 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:57:20 +0000
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
Subject: Re: [PATCH v3 20/23] kvm: arm64: Intercept host's CPU_SUSPEND PSCI
 SMCs
Message-ID: <20201201145720.GB86881@C02TD0UTHF1T.local>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-21-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-21-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:54:18PM +0000, David Brazdil wrote:
> Add a handler of CPU_SUSPEND host PSCI SMCs. The SMC can either enter
> a sleep state indistinguishable from a WFI or a deeper sleep state that
> behaves like a CPU_OFF+CPU_ON except that the core is still considered
> online when asleep.
> 
> The handler saves r0,pc of the host and makes the same call to EL3 with
> the hyp CPU entry point. It either returns back to the handler and then
> back to the host, or wakes up into the entry point and initializes EL2
> state before dropping back to EL1.

For those CPU_SUSPEND calls which lose context, is there no EL2 state
that you need to save/restore, or is that all saved elsewhere already?

The usual suspects are PMU, debug, and timers, so maybe not. It'd be
nice to have a statement in the commit message if we're certain there's
no state that we need to save.

> A core can only suspend itself but other cores can concurrently invoke
> CPU_ON with this core as target. To avoid racing them for the same
> boot args struct, CPU_SUSPEND uses a different struct instance and entry
> point. Each entry point selects the corresponding struct to restore host
> boot args from. This avoids the need for locking in CPU_SUSPEND.

I found this a bit confusing since the first sentence can be read to
mean that CPU_ON is expected to compose with CPU_SUSPEND, whereas what
this is actually saying is the implementation ensures they don't
interact. How about:

| CPU_ON and CPU_SUSPEND are both implemented using struct cpu_boot_args
| to store the state upon powerup, with each CPU having separate structs
| for CPU_ON and CPU_SUSPEND so that CPU_SUSPEND can operate locklessly
| and so that a CPU_ON xall targetting a CPU cannot interfere with a
| concurrent CPU_SUSPEND call on that CPU.

The patch itself looks fine to me.

Thanks,
Mark.
