Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8D42E74F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 23:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgL2WLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 17:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2WLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 17:11:50 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D3020825;
        Tue, 29 Dec 2020 22:11:09 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kuNCt-004Ti1-6E; Tue, 29 Dec 2020 22:11:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Dec 2020 22:11:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix section mismatches around
 hyp_cpu_pm_{init,exit}
In-Reply-To: <20201229214336.4098955-1-natechancellor@gmail.com>
References: <20201229214336.4098955-1-natechancellor@gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <49e9d2e2e7103c49882b54c18c567667@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: natechancellor@gmail.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-29 21:43, Nathan Chancellor wrote:
> Commit fa8c3d65538a ("KVM: arm64: Keep nVHE EL2 vector installed")
> inadvertently changed clang's inlining decisions around
> hyp_cpu_pm_{init,exit}, causing the following section mismatch 
> warnings:
> 
> WARNING: modpost: vmlinux.o(.text+0x95c6c): Section mismatch in
> reference from the function kvm_arch_init() to the function
> .init.text:hyp_cpu_pm_exit()
> The function kvm_arch_init() references
> the function __init hyp_cpu_pm_exit().
> This is often because kvm_arch_init lacks a __init
> annotation or the annotation of hyp_cpu_pm_exit is wrong.
> 
> WARNING: modpost: vmlinux.o(.text+0x97054): Section mismatch in
> reference from the function init_subsystems() to the function
> .init.text:hyp_cpu_pm_init()
> The function init_subsystems() references
> the function __init hyp_cpu_pm_init().
> This is often because init_subsystems lacks a __init
> annotation or the annotation of hyp_cpu_pm_init is wrong.
> 
> Remove the __init annotation so that there are no warnings regardless 
> of
> how functions are inlined.
> 
> Fixes: 1fcf7ce0c602 ("arm: kvm: implement CPU PM notifier")
> Fixes: 06a71a24bae5 ("arm64: KVM: unregister notifiers in hyp mode
> teardown path")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1230
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Hi Nathan,

Already posted[1] last week.

Thanks,

         M.

[1] htps://lore.kernel.org/r/20201223120854.255347-1-maz@kernel.org
-- 
Jazz is not dead. It just smells funny...
