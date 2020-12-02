Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA92CC0EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgLBPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:35:36 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:54393 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgLBPff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:35:35 -0500
X-Originating-IP: 90.43.98.209
Received: from rope.localdomain (astlambert-651-1-83-209.w90-43.abo.wanadoo.fr [90.43.98.209])
        (Authenticated sender: m@thi.eu.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EAC6E240003;
        Wed,  2 Dec 2020 15:34:48 +0000 (UTC)
Received: by rope.localdomain (Postfix, from userid 1000)
        id 4AD7B513EA; Wed,  2 Dec 2020 16:34:48 +0100 (CET)
From:   Mathieu Chouquet-Stringer <me@mathieu.digital>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Yue Hu <huyue2@yulong.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Update documentation to reflect what TAINT_CPU_OUT_OF_SPEC means nowadays
Date:   Wed,  2 Dec 2020 16:32:43 +0100
Message-Id: <20201202153244.709752-1-me@mathieu.digital>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Jonathan,

Here's a patch updating the meaning of TAINT_CPU_OUT_OF_SPEC after
Borislav introduced changes in a7e1f67ed29f and upcoming patches in tip.

TAINT_CPU_OUT_OF_SPEC now means a bit more what it implies as the
flag isn't set just because of a CPU misconfiguration or mismatch.
Historically it was for SMP kernel oops on an officially SMP incapable
processor but now it also covers CPUs whose MSRs have been incorrectly
poked at from userspace, drivers being used on non supported
architectures, broken firmware, mismatched CPUs, ...

Update documentation and script to reflect that.

Signed-off-by: Mathieu Chouquet-Stringer <me@mathieu.digital>
---
 Documentation/admin-guide/sysctl/kernel.rst   |  2 +-
 Documentation/admin-guide/tainted-kernels.rst | 23 +++++++++++++++----
 tools/debugging/kernel-chktaint               |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d4b32cc32bb7..edd89e2d3af7 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1336,7 +1336,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
 ======  =====  ==============================================================
      1  `(P)`  proprietary module was loaded
      2  `(F)`  module was force loaded
-     4  `(S)`  SMP kernel oops on an officially SMP incapable processor
+     4  `(S)`  kernel running on an out of specification system
      8  `(R)`  module was force unloaded
     16  `(M)`  processor reported a Machine Check Exception (MCE)
     32  `(B)`  bad page referenced or some unexpected page flags
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index f718a2eaf1f6..ceeed7b0798d 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -84,7 +84,7 @@ Bit  Log  Number  Reason that got the kernel tainted
 ===  ===  ======  ========================================================
   0  G/P       1  proprietary module was loaded
   1  _/F       2  module was force loaded
-  2  _/S       4  SMP kernel oops on an officially SMP incapable processor
+  2  _/S       4  kernel running on an out of specification system
   3  _/R       8  module was force unloaded
   4  _/M      16  processor reported a Machine Check Exception (MCE)
   5  _/B      32  bad page referenced or some unexpected page flags
@@ -116,10 +116,23 @@ More detailed explanation for tainting
  1)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
      modules were loaded normally.
 
- 2)  ``S`` if the oops occurred on an SMP kernel running on hardware that
-     hasn't been certified as safe to run multiprocessor.
-     Currently this occurs only on various Athlons that are not
-     SMP capable.
+ 2)  ``S`` if the kernel is running on a processor or system that is out of
+     specification: hardware has been put into an unsupported configuration,
+     therefore proper execution cannot be guaranteed.
+     Kernel will be tainted if, for example:
+
+     - on x86: PAE is forced through forcepae on intel CPUs (such as Pentium M)
+       which do not report PAE but may have a functional implementation, an SMP
+       kernel is running on non officially capable SMP Athlon CPUs, MSRs are
+       being poked at from userspace.
+     - on arm: kernel running on certain CPUs (such as Keystone 2) without
+       having certain kernel features enabled.
+     - on arm64: there are mismatched hardware features between CPUs, the
+       bootloader has booted CPUs in different modes.
+     - certain drivers are being used on non supported architectures (such as
+       scsi/snic on something else than x86_64, scsi/ips on non
+       x86/x86_64/itanium, have broken firmware settings for the
+       irqchip/irq-gic on arm64 ...).
 
  3)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
      modules were unloaded normally.
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 2240cb56e6e5..607b2b280945 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -72,7 +72,7 @@ if [ `expr $T % 2` -eq 0 ]; then
 	addout " "
 else
 	addout "S"
-	echo " * SMP kernel oops on an officially SMP incapable processor (#2)"
+	echo " * kernel running on an out of specification system (#2)"
 fi
 
 T=`expr $T / 2`
-- 
2.28.0

