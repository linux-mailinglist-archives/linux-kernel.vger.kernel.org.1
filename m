Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43D62B8A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 03:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgKSCdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 21:33:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7933 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgKSCdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 21:33:52 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cc3dV0Fs2z6xYC;
        Thu, 19 Nov 2020 10:33:34 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 10:33:39 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        <guohanjun@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation/features: Update feature lists for 5.10
Date:   Thu, 19 Nov 2020 10:27:09 +0800
Message-ID: <20201119022709.45843-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature lists don't match reality as of v5.10-rc4, update them
accordingly (by features-refresh.sh).

Fixes: aa65ff6b18e0 ("powerpc/64s: Implement queued spinlocks and rwlocks")
Fixes: e95a4f8cb985 ("csky: Add SECCOMP_FILTER supported")
Fixes: 0bb605c2c7f2 ("sh: Add SECCOMP_FILTER")
Fixes: bdcd93ef9afb ("csky: Add context tracking support")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 .../features/locking/queued-rwlocks/arch-support.txt          | 2 +-
 .../features/locking/queued-spinlocks/arch-support.txt        | 2 +-
 .../features/seccomp/seccomp-filter/arch-support.txt          | 4 ++--
 Documentation/features/time/context-tracking/arch-support.txt | 2 +-
 Documentation/features/time/virt-cpuacct/arch-support.txt     | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 5c6bcfcf8e1f..4dd5e554873f 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -22,7 +22,7 @@
     |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index b55e420a34ea..b16d4f71e5ce 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -22,7 +22,7 @@
     |       nios2: | TODO |
     |    openrisc: |  ok  |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index c688aba22a8d..eb3d74092c61 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
@@ -25,7 +25,7 @@
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
-    |          sh: | TODO |
+    |          sh: |  ok  |
     |       sparc: | TODO |
     |          um: |  ok  |
     |         x86: |  ok  |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 266c81e8a721..52aea275aab7 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 56b372da6b01..e51f3af38e31 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |        csky: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
-- 
2.17.1

