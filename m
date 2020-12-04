Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DAF2CF279
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgLDQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:58:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgLDQ61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:58:27 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Barret Rhoden <brho@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 1/2] initramfs: fix clang build failure
Date:   Fri,  4 Dec 2020 17:57:33 +0100
Message-Id: <20201204165742.3815221-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is only one function in init/initramfs.c that is in the .text
section, and it is marked __weak. When building with clang-12 and
the integrated assembler, this leads to a bug with recordmcount:

./scripts/recordmcount  "init/initramfs.o"
Cannot find symbol for section 2: .text.
init/initramfs.o: failed

I'm not quite sure what exactly goes wrong, but I notice that this
function is only ever called from an __init function, and normally
inlined. Marking it __init as well is clearly correct and it
leads to recordmcount no longer complaining.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 1f97c0328a7a..55b74d7e5260 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -535,7 +535,7 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
-void __weak free_initrd_mem(unsigned long start, unsigned long end)
+void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
 {
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
 	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
-- 
2.27.0

