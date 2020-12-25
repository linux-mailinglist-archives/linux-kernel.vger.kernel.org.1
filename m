Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2417A2E2BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgLYOUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 09:20:19 -0500
Received: from mail-m964.mail.126.com ([123.126.96.4]:46796 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgLYOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 09:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=iJJoJscBI/+hKpJYBX
        zopxzPlvxajIEcfsRetkuiDGM=; b=XjcCnFcvScn5ZnrlF73ybd0bpt6l9ERaor
        knBLj0du7YMzDS+GHBdTtHpS4rPNrUax5QS2odUjMdCcpK70sz9N9rGByaAmPmak
        iKRzC9sxqMFVAFlQ6JQsRTV05nstUr6xSx3MtJs1uJctOH1X4hFYJBenTj4WLRoq
        2II6RPlz0=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp9 (Coremail) with SMTP id NeRpCgAnXYqakOVfbXMoQA--.6041S2;
        Fri, 25 Dec 2020 15:11:24 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        christophe.leroy@csgroup.eu, penberg@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH] powerpc/mm: avoid null pointer dereference in flush_tlb_mm
Date:   Fri, 25 Dec 2020 15:11:11 +0800
Message-Id: <1608880271-2294955-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NeRpCgAnXYqakOVfbXMoQA--.6041S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFW5Jw4fury8Kr4rtF1rXrb_yoWxZrgEq3
        9xAws7J3yqy3ykZF4kAr4rWF98Aws7ZF4agwn0g34avr90gw4rJFW0q39rGF15WFWIvFWD
        Xa4Dtr15JF1FvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRoGQPUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbikhwG11pECE6EAAAAsD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<0dc294f7>, there should be a check for 'mm' to prevent Null pointer dereference in case of 'mm' argument was legitimately passed.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 arch/powerpc/mm/nohash/tlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 5872f69..09796c9 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -268,6 +268,9 @@ void flush_tlb_mm(struct mm_struct *mm)
 {
 	unsigned int pid;
 
+	if (unlikely(!mm))
+		return;
+
 	preempt_disable();
 	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
-- 
2.7.4

