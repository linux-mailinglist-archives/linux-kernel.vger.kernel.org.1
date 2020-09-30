Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647C427F4F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbgI3WRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:17:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730090AbgI3WRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:17:54 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UM1vpc141181;
        Wed, 30 Sep 2020 18:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Sybct/5QDQ7imifqCkn0qDmhU6a/bbTlvdUNqREFLUo=;
 b=qI4Gb2mzvW1Wdi8f36hi9KrdpJqliMcQojqHmGLWrwMAwJLlIo75fpmwSK5zsbfydli4
 JaQDXNv+eUxqImuRM5yIlzlKY2iYvc8sRXsdem3y2X5OlwIB2WKZ9faFfozSfOhuOUC4
 kf3UslN2JR4OxxCu7iJVXathZSn9yabG/GTvbZQ89kZiNWCvHHCjerKceylKOhUCzWii
 SYmbQaTRY4/2vIuW9OdXOrvg/gM6NwjvtexHV2Q8ol5x6fg3UygdYwY9CeURH7VV73+E
 B9iwK3YNzZT4DqeUmyf+o0TZkbBGnlFBBTyq64M43Zpz2KFcy03lKJUyRBdYsopnVtsO 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vxxqe92m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 18:17:39 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UM3KMX144836;
        Wed, 30 Sep 2020 18:17:39 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vxxqe91y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 18:17:39 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UMHbMb005712;
        Wed, 30 Sep 2020 22:17:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 33sw982j69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 22:17:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08UMHYck31523314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 22:17:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EA0E11C04A;
        Wed, 30 Sep 2020 22:17:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C689411C04C;
        Wed, 30 Sep 2020 22:17:33 +0000 (GMT)
Received: from localhost (unknown [9.145.18.215])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Sep 2020 22:17:33 +0000 (GMT)
Date:   Thu, 1 Oct 2020 00:17:32 +0200
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
Subject: [RFC PATCH v3 4/4] objtool: fix x86 orc generation on big endian
 cross compiles
Message-ID: <patch-4.thread-6ec90b.git-6ec90b880ce6.your-ad-here.call-01601502173-ext-7769@work.hours>
References: <cover.thread-6ec90b.your-ad-here.call-01601502173-ext-7769@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-6ec90b.your-ad-here.call-01601502173-ext-7769@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_13:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=2 adultscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300174
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct objtool orc generation endianness problems to enable fully
functional x86 cross compiles on big endian hardware.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/x86/include/asm/orc_types.h       | 10 ++++++++++
 tools/arch/x86/include/asm/orc_types.h | 10 ++++++++++
 tools/objtool/arch/x86/special.c       |  2 +-
 tools/objtool/check.c                  |  4 ++--
 tools/objtool/orc_dump.c               |  4 ++--
 tools/objtool/orc_gen.c                |  2 ++
 6 files changed, 27 insertions(+), 5 deletions(-)

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
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index fd4af88c0ea5..8349842aac82 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -9,7 +9,7 @@
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
-	switch (feature) {
+	switch (le16_to_cpu(feature)) {
 	case X86_FEATURE_SMAP:
 		/*
 		 * If UACCESS validation is enabled; force that alternative;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2df9f769412e..f20a4be2fb22 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1370,7 +1370,7 @@ static int read_unwind_hints(struct objtool_file *file)
 		cfa = &insn->cfi.cfa;
 
 		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
-			insn->ret_offset = hint->sp_offset;
+			insn->ret_offset = le16_to_cpu(hint->sp_offset);
 			continue;
 		}
 
@@ -1382,7 +1382,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		cfa->offset = hint->sp_offset;
+		cfa->offset = le16_to_cpu(hint->sp_offset);
 		insn->cfi.type = hint->type;
 		insn->cfi.end = hint->end;
 	}
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 5e6a95368d35..4cea20520ca7 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -197,11 +197,11 @@ int orc_dump(const char *_objname)
 
 		printf(" sp:");
 
-		print_reg(orc[i].sp_reg, orc[i].sp_offset);
+		print_reg(orc[i].sp_reg, (s16)le16_to_cpu(orc[i].sp_offset));
 
 		printf(" bp:");
 
-		print_reg(orc[i].bp_reg, orc[i].bp_offset);
+		print_reg(orc[i].bp_reg, (s16)le16_to_cpu(orc[i].bp_offset));
 
 		printf(" type:%s end:%d\n",
 		       orc_type_name(orc[i].type), orc[i].end);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 235663b96adc..123fd718ea9a 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -96,6 +96,8 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	/* populate ORC data */
 	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
+	orc->sp_offset = cpu_to_le16(orc->sp_offset);
+	orc->bp_offset = cpu_to_le16(orc->bp_offset);
 
 	/* populate reloc for ip */
 	reloc = malloc(sizeof(*reloc));
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
