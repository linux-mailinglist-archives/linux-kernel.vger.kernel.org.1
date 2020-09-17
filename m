Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48C126D4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIQHau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:30:50 -0400
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:49491 "EHLO
        14.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgIQHas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:30:48 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 03:30:48 EDT
Received: from player789.ha.ovh.net (unknown [10.110.171.31])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id B84BB179FDD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:21:56 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player789.ha.ovh.net (Postfix) with ESMTPSA id 2FDCB1642510B;
        Thu, 17 Sep 2020 07:21:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G001c046186f-521d-4389-83f8-d8f3555f47f3,
                    CDC8E273B2E96CDC0F82EF6907E74C03A725C516) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] docs: rewrite admin-guide/sysctl/abi.rst
Date:   Thu, 17 Sep 2020 09:21:23 +0200
Message-Id: <20200917072123.8847-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1050464616550911365
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdefgdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
Changes since v1:
  - added SPDX-License-Identifier

 Documentation/admin-guide/sysctl/abi.rst | 73 +++++++-----------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/abi.rst b/Documentation/admin-guide/sysctl/abi.rst
index 599bcde7f0b7..ac87eafdb54f 100644
--- a/Documentation/admin-guide/sysctl/abi.rst
+++ b/Documentation/admin-guide/sysctl/abi.rst
@@ -1,67 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
 ================================
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
-
-Here are the files featuring in 2.6 kernel:
-
-- defhandler_coff
-- defhandler_elf
-- defhandler_lcall7
-- defhandler_libcso
-- fake_utsname
-- trace
-
-defhandler_coff
----------------
-
-defined value:
-	PER_SCOSVR3::
-
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
+The files in ``/proc/sys/abi`` can be used to see and modify
+ABI-related settings.
 
-		0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
+Currently, these files might (depending on your configuration)
+show up in ``/proc/sys/kernel``:
 
-fake_utsname
-------------
+.. contents:: :local:
 
-Unused
+vsyscall32 (x86)
+================
 
-trace
------
+Determines whether the kernels maps a vDSO page into 32-bit processes;
+can be set to 1 to enable, or 0 to disable. Defaults to enabled if
+``CONFIG_COMPAT_VDSO`` is set, disabled otherwide.
 
-Unused
+This controls the same setting as the ``vdso32`` kernel boot
+parameter.

base-commit: a070991fe9d1b6d97eb3cf24a2a6ed5f8e7c0169
-- 
2.20.1

