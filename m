Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E0F272355
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIUMGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:06:03 -0400
Received: from foss.arm.com ([217.140.110.172]:42026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgIUMGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:06:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 537151063;
        Mon, 21 Sep 2020 05:06:02 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.75.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C06B93F73B;
        Mon, 21 Sep 2020 05:05:58 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] arm64/mm/hotplug: Register boot memory hot remove notifier earlier
Date:   Mon, 21 Sep 2020 17:35:06 +0530
Message-Id: <1600689908-28213-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
References: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves memory notifier registration earlier in the boot process from
device_initcall() to early_initcall() which will help in guarding against
potential early boot memory offline requests. Even though there should not
be any actual offlinig requests till memory block devices are initialized
with memory_dev_init() but then generic init sequence might just change in
future. Hence an early registration for the memory event notifier would be
helpful. While here, just skip the registration if CONFIG_MEMORY_HOTREMOVE
is not enabled and also call out when memory notifier registration fails.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..df3b7415b128 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1499,7 +1499,17 @@ static struct notifier_block prevent_bootmem_remove_nb = {
 
 static int __init prevent_bootmem_remove_init(void)
 {
-	return register_memory_notifier(&prevent_bootmem_remove_nb);
+	int ret = 0;
+
+	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+		return ret;
+
+	ret = register_memory_notifier(&prevent_bootmem_remove_nb);
+	if (!ret)
+		return ret;
+
+	pr_err("Notifier registration failed - boot memory can be removed\n");
+	return ret;
 }
-device_initcall(prevent_bootmem_remove_init);
+early_initcall(prevent_bootmem_remove_init);
 #endif
-- 
2.20.1

