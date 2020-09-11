Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68BF26687D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 15:02:14 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:38219 "EHLO
        5.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIKTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 15:02:13 -0400
Received: from player772.ha.ovh.net (unknown [10.108.54.36])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id CFDAB140855
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 21:02:10 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player772.ha.ovh.net (Postfix) with ESMTPSA id 0C2161620AD18;
        Fri, 11 Sep 2020 19:02:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-105G0064e52adae-e863-4d66-a4f7-f870f57de118,
                    B3063C92EDE29B5A09E12E435EF56C89C4C75BBC) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: rewrite admin-guide/sysctl/abi.rst
Date:   Fri, 11 Sep 2020 21:01:52 +0200
Message-Id: <20200911190152.29730-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14533678950405000581
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the structure used in sysctl/kernel.rst, this updates
abi.rst to use ReStructured Text more fully and updates the entries to
match current kernels:

  * the list of files is now the table of contents;
  * links are used to point to other documentation and other sections;
  * all the existing entries are no longer present, so this removes
    them;
  * document vsyscall32.

Mentions of the kernel version are dropped. Since the document is
entirely rewritten, I've replaced the copyright statement.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/abi.rst | 71 ++++++------------------
 1 file changed, 18 insertions(+), 53 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/abi.rst b/Documentation/admin-guide/sysctl/abi.rst
index 599bcde7f0b7..d88b48db8bf9 100644
--- a/Documentation/admin-guide/sysctl/abi.rst
+++ b/Documentation/admin-guide/sysctl/abi.rst
@@ -2,66 +2,31 @@
 Documentation for /proc/sys/abi/
 ================================
 
-kernel version 2.6.0.test2
+.. See scripts/check-sysctl-docs to keep this up to date:
+.. scripts/check-sysctl-docs -vtable="abi" \
+..         Documentation/admin-guide/sysctl/abi.rst \
+..         $(git grep -l register_sysctl_)
 
-Copyright (c) 2003,  Fabian Frederick <ffrederick@users.sourceforge.net>
+Copyright (c) 2020, Stephen Kitt
 
-For general info: index.rst.
+For general info, see :doc:`index`.
 
 ------------------------------------------------------------------------------
 
-This path is binary emulation relevant aka personality types aka abi.
-When a process is executed, it's linked to an exec_domain whose
-personality is defined using values available from /proc/sys/abi.
-You can find further details about abi in include/linux/personality.h.
+The files in ``/proc/sys/abi`` can be used to see and modify
+ABI-related settings.
 
-Here are the files featuring in 2.6 kernel:
+Currently, these files might (depending on your configuration)
+show up in ``/proc/sys/kernel``:
 
-- defhandler_coff
-- defhandler_elf
-- defhandler_lcall7
-- defhandler_libcso
-- fake_utsname
-- trace
+.. contents:: :local:
 
-defhandler_coff
----------------
+vsyscall32 (x86)
+================
 
-defined value:
-	PER_SCOSVR3::
+Determines whether the kernels maps a vDSO page into 32-bit processes;
+can be set to 1 to enable, or 0 to disable. Defaults to enabled if
+``CONFIG_COMPAT_VDSO`` is set, disabled otherwide.
 
-		0x0003 | STICKY_TIMEOUTS | WHOLE_SECONDS | SHORT_INODE
-
-defhandler_elf
---------------
-
-defined value:
-	PER_LINUX::
-
-		0
-
-defhandler_lcall7
------------------
-
-defined value :
-	PER_SVR4::
-
-		0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
-
-defhandler_libsco
------------------
-
-defined value:
-	PER_SVR4::
-
-		0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
-
-fake_utsname
-------------
-
-Unused
-
-trace
------
-
-Unused
+This controls the same setting as the ``vdso32`` kernel boot
+parameter.

base-commit: 5ff4aa70bf347e13ec87697b1c732ce86060c47d
-- 
2.20.1

