Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71AB28155C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbgJBOg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgJBOgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601649414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RL9FkyEQEEDC7i4TxK7mLdt4FElF6i+ix0CGBCfcTBQ=;
        b=UzyWzjrD4uKqCnX55w7+tqwTnjOQpkMGOxJMB1MIWjwaH5hVjZSeYYKrNyJLwiwagkldt1
        HFs6yjc9bjWPrMbsaF+HxdI1vqUnJsABnjVMt8EvbMg2HWEpnCqcp/nYoNsHt0G6Dt2WFm
        IHaaOdUAH631K9jHmMW4kq/+vUob1Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-O7mBmVrVOh-mquDb9eronA-1; Fri, 02 Oct 2020 10:36:50 -0400
X-MC-Unique: O7mBmVrVOh-mquDb9eronA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0DEE8064BD;
        Fri,  2 Oct 2020 14:36:47 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4711660BE2;
        Fri,  2 Oct 2020 14:36:43 +0000 (UTC)
Date:   Fri, 2 Oct 2020 16:36:40 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        qemu-devel@nongnu.org, Dave Martin <Dave.Martin@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] MTE support for KVM guest
Message-ID: <20201002143640.uzsz3nhr45payhlb@kamzik.brq.redhat.com>
References: <20200925093607.3051-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925093607.3051-1-steven.price@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:36:05AM +0100, Steven Price wrote:
> Version 3 of adding MTE support for KVM guests. See the previous (v2)
> posting for background:
> 
>  https://lore.kernel.org/r/20200904160018.29481-1-steven.price%40arm.com
> 
> These patches add support to KVM to enable MTE within a guest. They are
> based on Catalin's v9 MTE user-space support series[1] (currently in
> next).
> 
> Changes since v2:
> 
>  * MTE is no longer a VCPU feature, instead it is a VM cap.
> 
>  * Being a VM cap means easier probing (check for KVM_CAP_ARM_MTE).
> 
>  * The cap must be set before any VCPUs are created, preventing any
>    shenanigans where MTE is enabled for the guest after memory accesses
>    have been performed.
> 
> [1] https://lore.kernel.org/r/20200904103029.32083-1-catalin.marinas@arm.com
> 
> Steven Price (2):
>   arm64: kvm: Save/restore MTE registers
>   arm64: kvm: Introduce MTE VCPU feature
> 
>  arch/arm64/include/asm/kvm_emulate.h       |  3 +++
>  arch/arm64/include/asm/kvm_host.h          |  7 +++++++
>  arch/arm64/include/asm/sysreg.h            |  3 ++-
>  arch/arm64/kvm/arm.c                       |  9 +++++++++
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
>  arch/arm64/kvm/mmu.c                       | 15 +++++++++++++++
>  arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
>  include/uapi/linux/kvm.h                   |  1 +
>  8 files changed, 66 insertions(+), 6 deletions(-)
> 
> -- 
> 2.20.1
> 
>

Hi Steven,

These patches look fine to me, but I'd prefer we have a working
implementation in QEMU before we get too excited about the KVM
bits. kvmtool isn't sufficient since it doesn't support migration
(at least afaik). In the past we've implemented features in KVM
that look fine, but then issues have been discovered when trying
to enable them from QEMU, where we also support migration. This
feature looks like there's risk of issues with the userspace side.
Although these two patches would probably stay the same, even if
userspace requires more support.

Thanks,
drew

