Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009292A946E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKFKgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgKFKgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:36:11 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49821221FA;
        Fri,  6 Nov 2020 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604658970;
        bh=c8VhSjexJh87smF8lFF4bobVi/ptsexAmWhReQCmBlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0j/VB3sGPYfq+QC06pPn6kTewoZ7RHbPIMLsAqMbjQKZ8LcjxAkLsx5fJMw6y85z
         JhsbfImsn08r70Y9HTimznLDZz2HnsnpiGWmh7GTAX+tRMkk5+G2JtR9bu0n35D6io
         gMpwgq7LLrBbaWfi6LTkqUyU3oPgs7dBTE+bdDgg=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <cai@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/2] arm64: psci: Avoid printing in cpu_psci_cpu_die()
Date:   Fri,  6 Nov 2020 10:36:01 +0000
Message-Id: <20201106103602.9849-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106103602.9849-1-will@kernel.org>
References: <20201106103602.9849-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_psci_cpu_die() is called in the context of the dying CPU, which
will no longer be online or tracked by RCU. It is therefore not generally
safe to call printk() if the PSCI "cpu off" request fails, so remove the
pr_crit() invocation.

Cc: Qian Cai <cai@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/psci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 43ae4e0c968f..6a4f3e37c3b4 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -75,8 +75,6 @@ static void cpu_psci_cpu_die(unsigned int cpu)
 		    PSCI_0_2_POWER_STATE_TYPE_SHIFT;
 
 	ret = psci_ops.cpu_off(state);
-
-	pr_crit("unable to power off CPU%u (%d)\n", cpu, ret);
 }
 
 static int cpu_psci_cpu_kill(unsigned int cpu)
-- 
2.29.1.341.ge80a0c044ae-goog

