Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F926FE7B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgIRN3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgIRN3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:29:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B0E20DD4;
        Fri, 18 Sep 2020 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600435739;
        bh=ZSXhJnytwBfZIguG2YZF5f+1ToMcOTDSxabFk/OagLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SB5sadO+SW/AHdSWa0pxHQC1+WiMYxgcOKisX+5DtSFcraR7rysLlqSohsCBJ32uj
         z7AOXp2fxOyNvBZO4FMt8YgHMMlxf+6c97GLbggAOkHppGoKIS8cA/fwcKD0pij9fU
         3h3Ai2myIT4JLbdZg090Ga5oa6m3U2d9s3ue764Y=
Date:   Fri, 18 Sep 2020 14:28:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v3] KVM: arm64: fix doc warnings in mmu code
Message-ID: <20200918132854.GC31232@willie-the-truck>
References: <1600307269-50957-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600307269-50957-1-git-send-email-tanxiaofei@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 09:47:49AM +0800, Xiaofei Tan wrote:
> Fix following warnings caused by mismatch bewteen function parameters
> and comments.
> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'mmu' not described in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'may_block' not described in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:128: warning: Excess function parameter 'kvm' description in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:499: warning: Function parameter or member 'writable' not described in 'kvm_phys_addr_ioremap'
> arch/arm64/kvm/mmu.c:538: warning: Function parameter or member 'mmu' not described in 'stage2_wp_range'
> arch/arm64/kvm/mmu.c:538: warning: Excess function parameter 'kvm' description in 'stage2_wp_range'
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  arch/arm64/kvm/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
