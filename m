Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBBC276E47
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgIXKKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:10:54 -0400
Received: from gentwo.org ([3.19.106.255]:48690 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgIXKKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:10:53 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id D7A6C3F1AE; Thu, 24 Sep 2020 10:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id D4FD23F1AA;
        Thu, 24 Sep 2020 10:10:52 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:10:52 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     David Brazdil <dbrazdil@google.com>
cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 00/10] Independent per-CPU data section for nVHE
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
Message-ID: <alpine.DEB.2.22.394.2009241003100.1613@www.lameter.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, David Brazdil wrote:

> Introduce '.hyp.data..percpu' as part of ongoing effort to make nVHE
> hyp code self-contained and independent of the rest of the kernel.

The percpu subsystems point is to enable the use of special hardware
instructions that can perform address calculation and a memory operation
in one interruptible instruction. This is in particular useful to avoid
higher overhead for memory management related counters because preempt
disable/enable etc can be avoided.

ARM cannot do that and thus has a LC/SC loop.

This is a patchset for ARM64 so its not clear to me what kind of advantage
there would be against a simple implementation that does a regular fetch
from a base address with an offset.

> Main benefits:
>  * independent nVHE per-CPU data section that can be unmapped from host,
>  * more robust linking of nVHE hyp code,
>  * no need for hyp-specific macros to access per-CPU variables.

Maybe simply don't use percpu variables for your arm code? Those pointers
to data will be much more indepedent of the rest of the kernel and allow a
much higher degree of being self-contained.

