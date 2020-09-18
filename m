Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5736B270170
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRP5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIRP5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:57:11 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C622389E;
        Fri, 18 Sep 2020 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600444630;
        bh=vA5PLQQRY/xkPeBiOz82rbt8QOuSuBotaq2VJex7mHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6RL7JR2ZsNkzQTluyv0GWIIOr7ekA9QSeYW3P5knpa4kCV/LhgRriDJlUoAIisKR
         MshF83VRQgX8RM1UrzT2jEtvMR415TDAdhOYRJFG8dsZrYtZin0pO/HLnWA3/0R5Lv
         8ImBdo4W2hbrIOSYewDE3qLqwr9XHbjl3mnxzs44=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kJIl3-00D3F2-1Y; Fri, 18 Sep 2020 16:57:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        james.morse@arm.com, will@kernel.org, catalin.marinas@arm.com
Cc:     linuxarm@huawei.com
Subject: Re: [PATCH v3] KVM: arm64: fix doc warnings in mmu code
Date:   Fri, 18 Sep 2020 16:57:00 +0100
Message-Id: <160044458392.1301915.5239370632867337903.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1600307269-50957-1-git-send-email-tanxiaofei@huawei.com>
References: <1600307269-50957-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com, tanxiaofei@huawei.com, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, james.morse@arm.com, will@kernel.org, catalin.marinas@arm.com, linuxarm@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 09:47:49 +0800, Xiaofei Tan wrote:
> Fix following warnings caused by mismatch bewteen function parameters
> and comments.
> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'mmu' not described in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'may_block' not described in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:128: warning: Excess function parameter 'kvm' description in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:499: warning: Function parameter or member 'writable' not described in 'kvm_phys_addr_ioremap'
> arch/arm64/kvm/mmu.c:538: warning: Function parameter or member 'mmu' not described in 'stage2_wp_range'
> arch/arm64/kvm/mmu.c:538: warning: Excess function parameter 'kvm' description in 'stage2_wp_range'

Applied to next, thanks!

[1/1] KVM: arm64: Fix doc warnings in mmu code
      commit: c9c0279cc02b4e161686de7ccd1973357f29db8c

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


