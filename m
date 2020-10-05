Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FE6283BA4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgJEPvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:51:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgJEPvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:51:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095FgsVg052593;
        Mon, 5 Oct 2020 11:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=tpW+OHIW5BL+27/v9aLx9WzIxNO8FY6ndAOcEfjOgTM=;
 b=KJ64ibXcN312EHCRf8MreEspNOXvZc1Rq3kAQQQLIZeaNuFbJuzc0ENBV0picujoYxc9
 04n+N0lrUFhfn0cwF06k/L4pr77QhnnmMP0fsORRzj0myt7PRALRtjlKc8GXexPp+pZG
 l3GD1aBLdhYUHv+4G1/SFkNecKdV4ROb42qgCx6xG/QzeMFpPLZrqI2GlJSKwF2UrbKk
 s04aJ7rUFlHacTSg1ZqeQkLKxnVhlKkdITuA39bloZbvu71e7WCCwaoo1FShUgszEy8Y
 T55sEQjz2pbCmiWywRx3MG/upfTKh72eJeHmwFshSgz+5UTGJogrV3wZCMjMjcn8pyIN rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3406c8r78w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:50:49 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 095Fh1xU052787;
        Mon, 5 Oct 2020 11:50:49 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3406c8r77f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:50:48 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095FlCbK028085;
        Mon, 5 Oct 2020 15:50:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 33xgx82b25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 15:50:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 095FohG019464652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Oct 2020 15:50:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD549A4040;
        Mon,  5 Oct 2020 15:50:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2787AA404D;
        Mon,  5 Oct 2020 15:50:43 +0000 (GMT)
Received: from localhost (unknown [9.145.67.211])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  5 Oct 2020 15:50:43 +0000 (GMT)
Date:   Mon, 5 Oct 2020 17:50:41 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        Matt Helsley <mhelsley@vmware.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] objtool: avoid ../ headers includes and name clashes
Message-ID: <patch.git-e6c557b830fe.your-ad-here.call-01601912655-ext-2182@work.hours>
References: <cover.thread-b2a547.your-ad-here.call-01601912612-ext-9766@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-b2a547.your-ad-here.call-01601912612-ext-9766@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_10:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=1 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently objtool headers are being included either by their base name
or included via ../ from a parent directory. In case of a base name usage:

 #include "warn.h"
 #include "arch_elf.h"

it does not make it apparent from which directory the file comes from.
To make it slightly better, and actually to avoid name clashes some arch
specific files have "arch_" suffix. And files from an arch folder have
to revert to including via ../ e.g:
 #include "../../elf.h"

With additional architectures support and the code base growth there is
a need for clearer headers naming scheme for multiple reasons:
1. to make it instantly obvious where these files come from (objtool
   itself / objtool arch|generic folders / some other external files),
2. to avoid name clashes of objtool arch specific headers, potential
   obtool arch generic headers and the system header files (there is
   /usr/include/elf.h already),
3. to avoid ../ includes and improve code readability.
4. to give a warm fuzzy feeling to developers who are mostly kernel
   developers and are accustomed to linux kernel headers arranging
   scheme.

Doesn't this make it instantly obvious where are these files come from?

 #include <objtool/warn.h>
 #include <arch/elf.h>

And doesn't it look nicer to avoid ugly ../ includes? Which also
guarantees this is elf.h from the objtool and not /usr/include/elf.h.

 #include <objtool/elf.h>

This patch defines and implements new objtool headers arranging
scheme. Which is:
- all generic headers go to include/objtool (similar to include/linux)
- all arch headers go to arch/$(SRCARCH)/include/arch (to get arch
  prefix). This is similar to linux arch specific "asm/*" headers but we
  are not abusing "asm" name and calling it what it is. This also helps
  to prevent name clashes (arch is not used in system headers or kernel
  exports).

To bring objtool to this state the following things are done:
1. current top level tools/objtool/ headers are moved into
   include/objtool/ subdirectory,
2. arch specific headers, currently only arch/x86/include/ are moved into
   arch/x86/include/arch/ and were stripped of "arch_" suffix,
3. new -I$(srctree)/tools/objtool/include include path to make
   includes like <objtool/warn.h> possible,
4. rewriting file includes,
5. make git not to ignore include/objtool/ subdirectory.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 v1 - v2: patch is rebased on top of
          [RFC PATCH RESEND v4] objtool and cross compilation
          patch series.

 tools/objtool/.gitignore                         |  2 +-
 tools/objtool/Makefile                           |  1 +
 tools/objtool/arch/x86/decode.c                  |  8 ++++----
 .../arch/x86/include/{ => arch}/cfi_regs.h       |  0
 .../arch/x86/include/{arch_elf.h => arch/elf.h}  |  0
 .../{arch_endianness.h => arch/endianness.h}     |  0
 .../include/{arch_special.h => arch/special.h}   |  0
 tools/objtool/arch/x86/special.c                 |  4 ++--
 tools/objtool/builtin-check.c                    |  4 ++--
 tools/objtool/builtin-orc.c                      |  4 ++--
 tools/objtool/check.c                            | 16 ++++++++--------
 tools/objtool/elf.c                              |  6 +++---
 tools/objtool/{ => include/objtool}/arch.h       |  4 ++--
 tools/objtool/{ => include/objtool}/builtin.h    |  0
 tools/objtool/{ => include/objtool}/cfi.h        |  2 +-
 tools/objtool/{ => include/objtool}/check.h      |  4 ++--
 tools/objtool/{ => include/objtool}/elf.h        |  0
 tools/objtool/{ => include/objtool}/endianness.h |  2 +-
 tools/objtool/{ => include/objtool}/objtool.h    |  2 +-
 tools/objtool/{ => include/objtool}/special.h    |  4 ++--
 tools/objtool/{ => include/objtool}/warn.h       |  2 +-
 tools/objtool/objtool.c                          |  6 +++---
 tools/objtool/orc_dump.c                         |  6 +++---
 tools/objtool/orc_gen.c                          |  6 +++---
 tools/objtool/special.c                          | 10 +++++-----
 tools/objtool/weak.c                             |  2 +-
 26 files changed, 48 insertions(+), 47 deletions(-)
 rename tools/objtool/arch/x86/include/{ => arch}/cfi_regs.h (100%)
 rename tools/objtool/arch/x86/include/{arch_elf.h => arch/elf.h} (100%)
 rename tools/objtool/arch/x86/include/{arch_endianness.h => arch/endianness.h} (100%)
 rename tools/objtool/arch/x86/include/{arch_special.h => arch/special.h} (100%)
 rename tools/objtool/{ => include/objtool}/arch.h (96%)
 rename tools/objtool/{ => include/objtool}/builtin.h (100%)
 rename tools/objtool/{ => include/objtool}/cfi.h (96%)
 rename tools/objtool/{ => include/objtool}/check.h (96%)
 rename tools/objtool/{ => include/objtool}/elf.h (100%)
 rename tools/objtool/{ => include/objtool}/endianness.h (97%)
 rename tools/objtool/{ => include/objtool}/objtool.h (96%)
 rename tools/objtool/{ => include/objtool}/special.h (94%)
 rename tools/objtool/{ => include/objtool}/warn.h (98%)

diff --git a/tools/objtool/.gitignore b/tools/objtool/.gitignore
index 45cefda24c7b..14236db3677f 100644
--- a/tools/objtool/.gitignore
+++ b/tools/objtool/.gitignore
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 arch/x86/lib/inat-tables.c
-objtool
+/objtool
 fixdep
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 4ea9a833dde7..1da7ae2d33f0 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -36,6 +36,7 @@ all: $(OBJTOOL)
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
+	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cde9c36e40ae..6baa22732ca6 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -11,11 +11,11 @@
 #include "../../../arch/x86/lib/inat.c"
 #include "../../../arch/x86/lib/insn.c"
 
-#include "../../check.h"
-#include "../../elf.h"
-#include "../../arch.h"
-#include "../../warn.h"
 #include <asm/orc_types.h>
+#include <objtool/check.h>
+#include <objtool/elf.h>
+#include <objtool/arch.h>
+#include <objtool/warn.h>
 
 static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_AX, CFI_R8},
diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/arch/cfi_regs.h
similarity index 100%
rename from tools/objtool/arch/x86/include/cfi_regs.h
rename to tools/objtool/arch/x86/include/arch/cfi_regs.h
diff --git a/tools/objtool/arch/x86/include/arch_elf.h b/tools/objtool/arch/x86/include/arch/elf.h
similarity index 100%
rename from tools/objtool/arch/x86/include/arch_elf.h
rename to tools/objtool/arch/x86/include/arch/elf.h
diff --git a/tools/objtool/arch/x86/include/arch_endianness.h b/tools/objtool/arch/x86/include/arch/endianness.h
similarity index 100%
rename from tools/objtool/arch/x86/include/arch_endianness.h
rename to tools/objtool/arch/x86/include/arch/endianness.h
diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch/special.h
similarity index 100%
rename from tools/objtool/arch/x86/include/arch_special.h
rename to tools/objtool/arch/x86/include/arch/special.h
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index fd4af88c0ea5..b4bd3505fc94 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
 
-#include "../../special.h"
-#include "../../builtin.h"
+#include <objtool/special.h>
+#include <objtool/builtin.h>
 
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c6d199bfd0ae..f47951e19c9d 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -15,8 +15,8 @@
 
 #include <subcmd/parse-options.h>
 #include <string.h>
-#include "builtin.h"
-#include "objtool.h"
+#include <objtool/builtin.h>
+#include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
 
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 7b31121fa60b..6745f3328a0e 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -13,8 +13,8 @@
  */
 
 #include <string.h>
-#include "builtin.h"
-#include "objtool.h"
+#include <objtool/builtin.h>
+#include <objtool/objtool.h>
 
 static const char *orc_usage[] = {
 	"objtool orc generate [<options>] file.o",
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fd892b77e98f..cb5535000ff7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -6,14 +6,14 @@
 #include <string.h>
 #include <stdlib.h>
 
-#include "builtin.h"
-#include "cfi.h"
-#include "arch.h"
-#include "check.h"
-#include "special.h"
-#include "warn.h"
-#include "arch_elf.h"
-#include "endianness.h"
+#include <arch/elf.h>
+#include <objtool/builtin.h>
+#include <objtool/cfi.h>
+#include <objtool/arch.h>
+#include <objtool/check.h>
+#include <objtool/special.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 #include <linux/objtool.h>
 #include <linux/hashtable.h>
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5c0341b0cde3..6a54ba719965 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -15,10 +15,10 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
-#include "builtin.h"
+#include <objtool/builtin.h>
 
-#include "elf.h"
-#include "warn.h"
+#include <objtool/elf.h>
+#include <objtool/warn.h>
 
 #define MAX_NAME_LEN 128
 
diff --git a/tools/objtool/arch.h b/tools/objtool/include/objtool/arch.h
similarity index 96%
rename from tools/objtool/arch.h
rename to tools/objtool/include/objtool/arch.h
index 4a84c3081b8e..dc4f503a3ae4 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -8,8 +8,8 @@
 
 #include <stdbool.h>
 #include <linux/list.h>
-#include "objtool.h"
-#include "cfi.h"
+#include <objtool/objtool.h>
+#include <objtool/cfi.h>
 
 #ifdef INSN_USE_ORC
 #include <asm/orc_types.h>
diff --git a/tools/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
similarity index 100%
rename from tools/objtool/builtin.h
rename to tools/objtool/include/objtool/builtin.h
diff --git a/tools/objtool/cfi.h b/tools/objtool/include/objtool/cfi.h
similarity index 96%
rename from tools/objtool/cfi.h
rename to tools/objtool/include/objtool/cfi.h
index c7c59c6a44ee..fd5cb0bed9bf 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/include/objtool/cfi.h
@@ -6,7 +6,7 @@
 #ifndef _OBJTOOL_CFI_H
 #define _OBJTOOL_CFI_H
 
-#include "cfi_regs.h"
+#include <arch/cfi_regs.h>
 
 #define CFI_UNDEFINED		-1
 #define CFI_CFA			-2
diff --git a/tools/objtool/check.h b/tools/objtool/include/objtool/check.h
similarity index 96%
rename from tools/objtool/check.h
rename to tools/objtool/include/objtool/check.h
index 5ec00a4b891b..bba10968eac0 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -7,8 +7,8 @@
 #define _CHECK_H
 
 #include <stdbool.h>
-#include "cfi.h"
-#include "arch.h"
+#include <objtool/cfi.h>
+#include <objtool/arch.h>
 
 struct insn_state {
 	struct cfi_state cfi;
diff --git a/tools/objtool/elf.h b/tools/objtool/include/objtool/elf.h
similarity index 100%
rename from tools/objtool/elf.h
rename to tools/objtool/include/objtool/elf.h
diff --git a/tools/objtool/endianness.h b/tools/objtool/include/objtool/endianness.h
similarity index 97%
rename from tools/objtool/endianness.h
rename to tools/objtool/include/objtool/endianness.h
index ebece3191b58..10241341eff3 100644
--- a/tools/objtool/endianness.h
+++ b/tools/objtool/include/objtool/endianness.h
@@ -2,9 +2,9 @@
 #ifndef _OBJTOOL_ENDIANNESS_H
 #define _OBJTOOL_ENDIANNESS_H
 
+#include <arch/endianness.h>
 #include <linux/kernel.h>
 #include <endian.h>
-#include "arch_endianness.h"
 
 #ifndef __TARGET_BYTE_ORDER
 #error undefined arch __TARGET_BYTE_ORDER
diff --git a/tools/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
similarity index 96%
rename from tools/objtool/objtool.h
rename to tools/objtool/include/objtool/objtool.h
index 4125d4578b23..32f4cd1da9fa 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -10,7 +10,7 @@
 #include <linux/list.h>
 #include <linux/hashtable.h>
 
-#include "elf.h"
+#include <objtool/elf.h>
 
 #define __weak __attribute__((weak))
 
diff --git a/tools/objtool/special.h b/tools/objtool/include/objtool/special.h
similarity index 94%
rename from tools/objtool/special.h
rename to tools/objtool/include/objtool/special.h
index abddf38ef334..8a09f4e9d480 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -7,8 +7,8 @@
 #define _SPECIAL_H
 
 #include <stdbool.h>
-#include "check.h"
-#include "elf.h"
+#include <objtool/check.h>
+#include <objtool/elf.h>
 
 #define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
 
diff --git a/tools/objtool/warn.h b/tools/objtool/include/objtool/warn.h
similarity index 98%
rename from tools/objtool/warn.h
rename to tools/objtool/include/objtool/warn.h
index 7799f60de80a..d99c4675e4a5 100644
--- a/tools/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -11,7 +11,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include "elf.h"
+#include <objtool/elf.h>
 
 extern const char *objname;
 
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 9df0cd86d310..e848feb0a5fc 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -21,9 +21,9 @@
 #include <subcmd/pager.h>
 #include <linux/kernel.h>
 
-#include "builtin.h"
-#include "objtool.h"
-#include "warn.h"
+#include <objtool/builtin.h>
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
 
 struct cmd_struct {
 	const char *name;
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 4e818a22e44b..c53fae9dbe93 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -6,9 +6,9 @@
 #include <unistd.h>
 #include <linux/objtool.h>
 #include <asm/orc_types.h>
-#include "objtool.h"
-#include "warn.h"
-#include "endianness.h"
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 static const char *reg_name(unsigned int reg)
 {
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 134d7863093d..8a56cb5d538e 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -9,9 +9,9 @@
 #include <linux/objtool.h>
 #include <asm/orc_types.h>
 
-#include "check.h"
-#include "warn.h"
-#include "endianness.h"
+#include <objtool/check.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 int create_orc(struct objtool_file *file)
 {
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index ab7cb1e13411..2c7fbda7b055 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -11,11 +11,11 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "builtin.h"
-#include "special.h"
-#include "warn.h"
-#include "arch_special.h"
-#include "endianness.h"
+#include <arch/special.h>
+#include <objtool/builtin.h>
+#include <objtool/special.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 struct special_entry {
 	const char *sec;
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 7843e9a7a72f..f2716827cc30 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -7,7 +7,7 @@
 
 #include <stdbool.h>
 #include <errno.h>
-#include "objtool.h"
+#include <objtool/objtool.h>
 
 #define UNSUPPORTED(name)						\
 ({									\
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
