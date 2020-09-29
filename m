Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBBA27D002
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgI2Nzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:55:37 -0400
Received: from foss.arm.com ([217.140.110.172]:45198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgI2Nzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:55:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E8CF31B;
        Tue, 29 Sep 2020 06:55:36 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E87303F6CF;
        Tue, 29 Sep 2020 06:55:32 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, gshan@redhat.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/3] arm64/mm/hotplug: Register boot memory hot remove notifier earlier
Date:   Tue, 29 Sep 2020 19:24:45 +0530
Message-Id: <1601387687-6077-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
References: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
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
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..4e70f4fea06c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1499,7 +1499,16 @@ static struct notifier_block prevent_bootmem_remove_nb = {
 
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

