Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9B2E8C74
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 15:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbhACOBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 09:01:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbhACOBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 09:01:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CC5B20C56;
        Sun,  3 Jan 2021 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609682468;
        bh=HTypC30TDtap+wwyfZ7D+lF6Xf783015Cd+73+IGuD4=;
        h=From:To:Cc:Subject:Date:From;
        b=hoqjBQMsL0M+WFOYBk/RiHhGD0f3wf3zgivimzkWaIaHRZOWHhvs83ko3/UIquXZr
         JzoqCqv6D9c/Fs0qO9HcPRSZhUeaK7hTX7nusmqp7/8KzhcSKESrTsXLEcXz1ZOQlS
         cEnm+L7eF5Z+DvzLuA5H/BSN7W03A7AVtgOn/C0pXKUKoYGIiu6agHFaw4HAxCwfdW
         zm+Onu/34tJwWr922C7vUUj17Z7fHIkAn2AVRg43mru0Mm8oiqBSmq5SE/NDYVPPdc
         R0jrFiHjUunynrXGv3FTaJtSzqzrAXH1gxUAS1TTAo51C9df5wOlKUNlFNFLrk/6cI
         ErsZZbvoLRxbA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Scull <ascull@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: remove incorrect __init annotation
Date:   Sun,  3 Jan 2021 15:00:50 +0100
Message-Id: <20210103140104.3853922-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When hyp_cpu_pm_exit() is not inlined, it causes a link time warning:

WARNING: modpost: vmlinux.o(.text+0x39974): Section mismatch in reference from the function kvm_arch_init() to the function .init.text:hyp_cpu_pm_exit()
The function kvm_arch_init() references
the function __init hyp_cpu_pm_exit().
This is often because kvm_arch_init lacks a __init
annotation or the annotation of hyp_cpu_pm_exit is wrong.

This is not only called at boot time, so remove the annotation
to prevent undefined behavior in case it gets called after being
freed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kvm/arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6e637d2b4cfb..71a49eae9ea0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1574,12 +1574,12 @@ static struct notifier_block hyp_init_cpu_pm_nb = {
 	.notifier_call = hyp_init_cpu_pm_notifier,
 };
 
-static void __init hyp_cpu_pm_init(void)
+static void hyp_cpu_pm_init(void)
 {
 	if (!is_protected_kvm_enabled())
 		cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
 }
-static void __init hyp_cpu_pm_exit(void)
+static void hyp_cpu_pm_exit(void)
 {
 	if (!is_protected_kvm_enabled())
 		cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
-- 
2.29.2

