Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCF2AB02B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 05:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgKIE3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 23:29:18 -0500
Received: from foss.arm.com ([217.140.110.172]:33910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgKIE3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:29:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35DE0106F;
        Sun,  8 Nov 2020 20:29:17 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.78.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FA233F6CF;
        Sun,  8 Nov 2020 20:29:13 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     gshan@redhat.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/3] arm64/mm/hotplug: Register boot memory hot remove notifier earlier
Date:   Mon,  9 Nov 2020 09:58:55 +0530
Message-Id: <1604896137-16644-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604896137-16644-1-git-send-email-anshuman.khandual@arm.com>
References: <1604896137-16644-1-git-send-email-anshuman.khandual@arm.com>
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
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1c0f3e02f731..71dd9d753b8b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1510,7 +1510,16 @@ static struct notifier_block prevent_bootmem_remove_nb = {
 
 static int __init prevent_bootmem_remove_init(void)
 {
-	return register_memory_notifier(&prevent_bootmem_remove_nb);
+	int ret = 0;
+
+	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+		return ret;
+
+	ret = register_memory_notifier(&prevent_bootmem_remove_nb);
+	if (ret)
+		pr_err("%s: Notifier registration failed %d\n", __func__, ret);
+
+	return ret;
 }
-device_initcall(prevent_bootmem_remove_init);
+early_initcall(prevent_bootmem_remove_init);
 #endif
-- 
2.20.1

