Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DAE2DE349
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgLRN1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:27:15 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:35299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgLRN1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:27:14 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MplTn-1kIGFQ2MpR-00qDC3; Fri, 18 Dec 2020 14:24:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de
Subject: [PATCH] kernel: irq: irqdesc: comments on endif's
Date:   Fri, 18 Dec 2020 14:24:32 +0100
Message-Id: <20201218132432.15407-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:RFun1C1AJhAtwngaY+Z4ATJMzXiKeOgT52H1jOynT086lX6iXS/
 BtAUl+ks2wSEVwpOEaGYO3vGggF76RTDEGJJKDRBjnCpX2yHRgPIaoh6soOWOYjEYbUcM2z
 jqK9J754EvRfUqBeehcFxmNe8996WY11P6wkIVmMstK5Y1y6/1wCDNFvcOCZjN7peflp25f
 VOOZmJEuK0utz8rsLF4fA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6BpIuxItSYY=:vWqInkKPQJgQKsSHocXnhg
 o1oTMswHfRdeh4Qxj077rmNLqWPyqU/cM+2eqVrBDDWEemcLZ9Oyv7Fryn/crG/vDi+IdZ8J6
 mN9T/4SR5R76Vo/7iau0LViRCcKRbWT90wfSsFf10lsSGTbLPVMjnyvDwD/hzPBNHtwZquFRA
 L8jYhLtTZmxqrBajTGTQrzbSq8VR8/LYhySzwwODO6RG9HN+s9NVlRDOwZSRkHvkpo6wztkyd
 1+X9QMWTf1jkWG5ty8VJ5GySXLmxEiN9PL3h/2eCRkVR83+iEWWhDkXKNfjgDAqDgy7arMZ+V
 +C2chQrgwu+4NzdrsDaRNiwH3uQFQuh25g4zYm/EN3lRdpKujmPEDrw5nu5jh8esfX0t/YbbL
 0minWShmAOGUQBsJG14dvYhYvcRB5iEbWwS/F2SC+mqyXAx3LH5zywvw4vR84
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better readability, add a comments to #endif's, telling which
condition they're closing.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 kernel/irq/irqdesc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index e810eb9906ea..ed56e9c65866 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -729,8 +729,8 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 	set_irq_regs(old_regs);
 	return ret;
 }
-#endif
-#endif
+#endif /* CONFIG_IRQ_DOMAIN */
+#endif /* CONFIG_HANDLE_DOMAIN_IRQ */
 
 /* Dynamic interrupt handling */
 
-- 
2.11.0

