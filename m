Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD32044A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 01:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgFVXqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 19:46:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54811 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbgFVXqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:12 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8f-0005DO-R7; Mon, 22 Jun 2020 23:46:10 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH 12/17] microblaze: switch to copy_thread_tls()
Date:   Tue, 23 Jun 2020 01:43:21 +0200
Message-Id: <20200622234326.906346-13-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the copy_thread_tls() calling convention which passes tls through a
register. This is required so we can remove the copy_thread{_tls}() split
and remove the HAVE_COPY_THREAD_TLS macro.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/microblaze/Kconfig          | 1 +
 arch/microblaze/kernel/process.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d262ac0c8714..e3a211a41880 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -46,6 +46,7 @@ config MICROBLAZE
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE if MMU
 	select SPARSE_IRQ
+	select HAVE_COPY_THREAD_TLS
 
 # Endianness selection
 choice
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 6527ec22f158..c2ca9c326510 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -54,8 +54,8 @@ void flush_thread(void)
 {
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long arg, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+		    unsigned long arg, struct task_struct *p, unsigned long tls)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
@@ -114,7 +114,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	 *  which contains TLS area
 	 */
 	if (clone_flags & CLONE_SETTLS)
-		childregs->r21 = childregs->r10;
+		childregs->r21 = tls;
 
 	return 0;
 }
-- 
2.27.0

