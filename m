Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9BF283BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgJEPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:51:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgJEPvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:51:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095FWLiO182716;
        Mon, 5 Oct 2020 11:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=z42qBTBLXn3SXiXv2fDUJ1YzfYmjRJgCZXRP5o4p2t4=;
 b=j3fIG+US93kNuuI04++6p6WxdFn94X1koQNYzjNniV4f/ffz0O+XAUIXcDBk3mWz2WeW
 +ETHvth7u5GrutJjBJSVolHF6S3Pf6hYMg+uUWHFHwPSS3OgryKWRTjSCvoQ0FaH9Weo
 AdyI35FJyVEwT3rxy+Yqf4FyLWSK7pKFIVOqGIWQwjtdVNO7NwGz7F3xfmMgNaRZa7cM
 W6tZ5Z77BgS1BbGu0oGAw/eg8L47OR7/skc7KgnnY/4D6R16BiG+k1eNGIxVC//YAJrX
 26KTRAlJtaK/6v/3p7WsBYPG8b1+Y7m1d9u3XQtWlxwOCjEJYD3OH+re/lPvAghnm6CA 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34064jgs0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:50:46 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 095FWNd0182876;
        Mon, 5 Oct 2020 11:50:45 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34064jgryk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:50:45 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095FlcKo028150;
        Mon, 5 Oct 2020 15:50:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 33xgx82b21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 15:50:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 095FoeoI8257794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Oct 2020 15:50:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 984684C04A;
        Mon,  5 Oct 2020 15:50:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDD1E4C044;
        Mon,  5 Oct 2020 15:50:39 +0000 (GMT)
Received: from localhost (unknown [9.145.67.211])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  5 Oct 2020 15:50:39 +0000 (GMT)
Date:   Mon, 5 Oct 2020 17:50:38 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH RESEND v4 4/4] objtool: fix x86 orc generation on big
 endian cross compiles
Message-ID: <patch-4.thread-b2a547.git-b2a54784c254.your-ad-here.call-01601912612-ext-9766@work.hours>
References: <20201005140328.hpbpkfpx3hmpuapt@treble>
 <cover.thread-b2a547.your-ad-here.call-01601912612-ext-9766@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-b2a547.your-ad-here.call-01601912612-ext-9766@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_10:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=2 malwarescore=0 priorityscore=1501
 mlxscore=0 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct objtool orc generation endianness problems to enable fully
functional x86 cross compiles on big endian hardware.

Introduces bswap_if_needed macro which does a byte swap if target
endianness doesn't match the host, i.e. cross compilation for little
endian on big endian and vice versa. To be used for multi-byte values
conversion, which are read from / about to be written to a target native
endianness ELF file.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/x86/include/asm/orc_types.h              | 10 +++++
 tools/arch/x86/include/asm/orc_types.h        | 10 +++++
 .../arch/x86/include/arch_endianness.h        |  9 +++++
 tools/objtool/check.c                         |  5 ++-
 tools/objtool/endianness.h                    | 38 +++++++++++++++++++
 tools/objtool/orc_dump.c                      |  5 ++-
 tools/objtool/orc_gen.c                       |  3 ++
 tools/objtool/special.c                       |  6 ++-
 8 files changed, 80 insertions(+), 6 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_endianness.h
 create mode 100644 tools/objtool/endianness.h

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index fdbffec4cfde..5a2baf28a1dc 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -40,6 +40,8 @@
 #define ORC_REG_MAX			15
 
 #ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
  * Frame Information standard.  It contains only the necessary parts of DWARF
@@ -51,10 +53,18 @@
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
 	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+#endif
 } __packed;
 
 #endif /* __ASSEMBLY__ */
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index fdbffec4cfde..5a2baf28a1dc 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -40,6 +40,8 @@
 #define ORC_REG_MAX			15
 
 #ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
  * Frame Information standard.  It contains only the necessary parts of DWARF
@@ -51,10 +53,18 @@
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
 	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+#endif
 } __packed;
 
 #endif /* __ASSEMBLY__ */
diff --git a/tools/objtool/arch/x86/include/arch_endianness.h b/tools/objtool/arch/x86/include/arch_endianness.h
new file mode 100644
index 000000000000..7c362527da20
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_endianness.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ARCH_ENDIANNESS_H
+#define _ARCH_ENDIANNESS_H
+
+#include <endian.h>
+
+#define __TARGET_BYTE_ORDER __LITTLE_ENDIAN
+
+#endif /* _ARCH_ENDIANNESS_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2df9f769412e..fd892b77e98f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -13,6 +13,7 @@
 #include "special.h"
 #include "warn.h"
 #include "arch_elf.h"
+#include "endianness.h"
 
 #include <linux/objtool.h>
 #include <linux/hashtable.h>
@@ -1370,7 +1371,7 @@ static int read_unwind_hints(struct objtool_file *file)
 		cfa = &insn->cfi.cfa;
 
 		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
-			insn->ret_offset = hint->sp_offset;
+			insn->ret_offset = bswap_if_needed(hint->sp_offset);
 			continue;
 		}
 
@@ -1382,7 +1383,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		cfa->offset = hint->sp_offset;
+		cfa->offset = bswap_if_needed(hint->sp_offset);
 		insn->cfi.type = hint->type;
 		insn->cfi.end = hint->end;
 	}
diff --git a/tools/objtool/endianness.h b/tools/objtool/endianness.h
new file mode 100644
index 000000000000..ebece3191b58
--- /dev/null
+++ b/tools/objtool/endianness.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ENDIANNESS_H
+#define _OBJTOOL_ENDIANNESS_H
+
+#include <linux/kernel.h>
+#include <endian.h>
+#include "arch_endianness.h"
+
+#ifndef __TARGET_BYTE_ORDER
+#error undefined arch __TARGET_BYTE_ORDER
+#endif
+
+#if __BYTE_ORDER != __TARGET_BYTE_ORDER
+#define __NEED_BSWAP 1
+#else
+#define __NEED_BSWAP 0
+#endif
+
+/*
+ * Does a byte swap if target endianness doesn't match the host, i.e. cross
+ * compilation for little endian on big endian and vice versa.
+ * To be used for multi-byte values conversion, which are read from / about
+ * to be written to a target native endianness ELF file.
+ */
+#define bswap_if_needed(val)						\
+({									\
+	__typeof__(val) __ret;						\
+	switch (sizeof(val)) {						\
+	case 8: __ret = __NEED_BSWAP ? bswap_64(val) : (val); break;	\
+	case 4: __ret = __NEED_BSWAP ? bswap_32(val) : (val); break;	\
+	case 2: __ret = __NEED_BSWAP ? bswap_16(val) : (val); break;	\
+	default:							\
+		BUILD_BUG(); break;					\
+	}								\
+	__ret;								\
+})
+
+#endif /* _OBJTOOL_ENDIANNESS_H */
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 5e6a95368d35..4e818a22e44b 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -8,6 +8,7 @@
 #include <asm/orc_types.h>
 #include "objtool.h"
 #include "warn.h"
+#include "endianness.h"
 
 static const char *reg_name(unsigned int reg)
 {
@@ -197,11 +198,11 @@ int orc_dump(const char *_objname)
 
 		printf(" sp:");
 
-		print_reg(orc[i].sp_reg, orc[i].sp_offset);
+		print_reg(orc[i].sp_reg, bswap_if_needed(orc[i].sp_offset));
 
 		printf(" bp:");
 
-		print_reg(orc[i].bp_reg, orc[i].bp_offset);
+		print_reg(orc[i].bp_reg, bswap_if_needed(orc[i].bp_offset));
 
 		printf(" type:%s end:%d\n",
 		       orc_type_name(orc[i].type), orc[i].end);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 235663b96adc..134d7863093d 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -11,6 +11,7 @@
 
 #include "check.h"
 #include "warn.h"
+#include "endianness.h"
 
 int create_orc(struct objtool_file *file)
 {
@@ -96,6 +97,8 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	/* populate ORC data */
 	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
+	orc->sp_offset = bswap_if_needed(orc->sp_offset);
+	orc->bp_offset = bswap_if_needed(orc->bp_offset);
 
 	/* populate reloc for ip */
 	reloc = malloc(sizeof(*reloc));
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 1a2420febd08..ab7cb1e13411 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -15,6 +15,7 @@
 #include "special.h"
 #include "warn.h"
 #include "arch_special.h"
+#include "endianness.h"
 
 struct special_entry {
 	const char *sec;
@@ -77,8 +78,9 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 	if (entry->feature) {
 		unsigned short feature;
 
-		feature = *(unsigned short *)(sec->data->d_buf + offset +
-					      entry->feature);
+		feature = bswap_if_needed(*(unsigned short *)(sec->data->d_buf +
+							      offset +
+							      entry->feature));
 		arch_handle_alternative(feature, alt);
 	}
 
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
