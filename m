Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310162E33E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 04:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgL1DRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 22:17:18 -0500
Received: from m15112.mail.126.com ([220.181.15.112]:51046 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgL1DRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 22:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=rHDg0EM4Tc1M0YYKA4
        UQMqhy0tOgpr+WAMZImhXGOPI=; b=NtHzNaDkdtCeFRfNcfqGRqx3IgKH9zeS3l
        zRMSm+9FOhhQQIRYnVg5N+i4zKgyO+xHQzDpUNz6BgLZiz1E6+g61pfOlE77N1cy
        IJQrmGDlqv0DpVj0WAgcWHpOu8BdKAn41HLj/ib6zornorzyZe62JqEpF39pjKdD
        DqehwFycY=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp2 (Coremail) with SMTP id DMmowAAX3UDBTOlf7uVwKg--.26924S2;
        Mon, 28 Dec 2020 11:10:58 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        geert@linux-m68k.org, rppt@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Defang Bo <bodefang@126.com>
Subject: [PATCH] powerpc/mm: add sanity check to avoid null pointer dereference
Date:   Mon, 28 Dec 2020 11:10:50 +0800
Message-Id: <1609125050-240351-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMmowAAX3UDBTOlf7uVwKg--.26924S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZFW3Cw4xCF17Wr4xuFW3Jrb_yoW8JF4rpw
        1vyr1vvw4Fq3Z5KrySkF1DWryYga1ktF1xC39Fk398ua4rtws5uF1fKwnYya13XF95C3WS
        kFZxKw15Jr13X37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRX_-QUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbiFgwJ11pECtLJ6gAAsh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit<0dc294f717d4>("powerpc/mm: bail out early when flushing TLB page"),
there should be a check for 'mm' to prevent Null pointer dereference
in case of 'mm' argument was legitimately passed.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 arch/powerpc/mm/nohash/tlb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 5872f69..1d89335 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -192,6 +192,9 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 {
 	unsigned int pid;
 
+	if (WARN_ON(!mm))
+		return;
+
 	preempt_disable();
 	pid = mm->context.id;
 	if (pid != MMU_NO_CONTEXT)
@@ -205,8 +208,11 @@ void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 {
 	unsigned int pid;
 
+	if (WARN_ON(!mm))
+		return;
+
 	preempt_disable();
-	pid = mm ? mm->context.id : 0;
+	pid = mm->context.id;
 	if (pid != MMU_NO_CONTEXT)
 		_tlbil_va(vmaddr, pid, tsize, ind);
 	preempt_enable();
@@ -268,6 +274,9 @@ void flush_tlb_mm(struct mm_struct *mm)
 {
 	unsigned int pid;
 
+	if (WARN_ON(!mm))
+		return;
+
 	preempt_disable();
 	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
-- 
2.7.4

