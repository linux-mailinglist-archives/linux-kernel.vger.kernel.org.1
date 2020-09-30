Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72127E5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgI3J7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:59:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28416 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729218AbgI3J7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:59:21 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U9VxhG035395;
        Wed, 30 Sep 2020 05:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=y1uvlA0Y2Rb80ew7TegKrKYHl/5RGZSv1CvWSylZsuQ=;
 b=oktI4tX0qVvpb4UvS6gr7tOI+enoNAjzUAKp91AGBVQZp/bQdQR48oVnqMCimPGFZA2k
 wroTL002rCyAIRDE2zUjudMwR3qoPKWBZ7mFp2zqE6ajXV6ABDV2/oxfss7hm8J48m3Y
 JSYnVfK0Rqzkdx3/ABxVx5WVeC3A/bRk0z09OgAh0RP8Bth53pH731WOnbFaK9HV6+Qy
 QjSZfGmmjNr5wsmpxlWQClWKzDxoC56cY4X8mbLOtXTCy3UuCH3xwt5EKq1FuJOZ764x
 7IohK2pFEUobecxeOeWOS7ocKb6bx76wV1TZdxeGQo4dFoZAxE7p7B0pd7BYDr9bLcBC pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vqa6s0b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 05:59:10 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08U9WBBZ036263;
        Wed, 30 Sep 2020 05:59:05 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vqa6s02c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 05:59:04 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08U9wZhZ009954;
        Wed, 30 Sep 2020 09:58:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 33sw9828fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 09:58:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08U9wX6R12976480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 09:58:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47D3C4C052;
        Wed, 30 Sep 2020 09:58:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F67A4C04E;
        Wed, 30 Sep 2020 09:58:32 +0000 (GMT)
Received: from localhost (unknown [9.145.18.215])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Sep 2020 09:58:32 +0000 (GMT)
Date:   Wed, 30 Sep 2020 11:58:31 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] objtool: fix x86 orc generation on big endian cross
 compiles
Message-ID: <patch-2.thread-e6a24b.git-e6a24bf796d2.your-ad-here.call-01601459756-ext-4914@work.hours>
References: <cover.thread-e6a24b.your-ad-here.call-01601459756-ext-4914@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-e6a24b.your-ad-here.call-01601459756-ext-4914@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_05:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=1 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009300073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct objtool orc generation endianness problems to enable fully
functional x86 cross compiles on big endian hardware.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/x86/include/asm/orc_types.h       | 24 ++++++++++++++++++++++++
 tools/arch/x86/include/asm/orc_types.h | 24 ++++++++++++++++++++++++
 tools/objtool/orc_dump.c               |  4 ++--
 tools/objtool/orc_gen.c                |  2 ++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index d25534940bde..931f99b70af3 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -61,6 +61,13 @@
 #define UNWIND_HINT_TYPE_RET_OFFSET	3
 
 #ifndef __ASSEMBLY__
+#ifdef __KERNEL__
+#include <linux/swab.h>
+#include <asm/byteorder.h>
+#else
+#include <endian.h>
+#endif
+
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
  * Frame Information standard.  It contains only the necessary parts of DWARF
@@ -69,6 +76,9 @@
  * the stack for a given code address.  Each instance of the struct corresponds
  * to one or more code locations.
  */
+#if defined(__BYTE_ORDER) ? \
+	__BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
@@ -78,6 +88,20 @@ struct orc_entry {
 	unsigned	end:1;
 } __packed;
 
+#else
+
+struct orc_entry {
+	s16		sp_offset;
+	s16		bp_offset;
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+} __packed;
+
+#endif
+
 /*
  * This struct is used by asm and inline asm code to manually annotate the
  * location of registers on the stack for the ORC unwinder.
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index d25534940bde..931f99b70af3 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -61,6 +61,13 @@
 #define UNWIND_HINT_TYPE_RET_OFFSET	3
 
 #ifndef __ASSEMBLY__
+#ifdef __KERNEL__
+#include <linux/swab.h>
+#include <asm/byteorder.h>
+#else
+#include <endian.h>
+#endif
+
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
  * Frame Information standard.  It contains only the necessary parts of DWARF
@@ -69,6 +76,9 @@
  * the stack for a given code address.  Each instance of the struct corresponds
  * to one or more code locations.
  */
+#if defined(__BYTE_ORDER) ? \
+	__BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
@@ -78,6 +88,20 @@ struct orc_entry {
 	unsigned	end:1;
 } __packed;
 
+#else
+
+struct orc_entry {
+	s16		sp_offset;
+	s16		bp_offset;
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+} __packed;
+
+#endif
+
 /*
  * This struct is used by asm and inline asm code to manually annotate the
  * location of registers on the stack for the ORC unwinder.
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index fca46e006fc2..0fbf8521c891 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -196,11 +196,11 @@ int orc_dump(const char *_objname)
 
 		printf(" sp:");
 
-		print_reg(orc[i].sp_reg, orc[i].sp_offset);
+		print_reg(orc[i].sp_reg, (s16)le16toh(orc[i].sp_offset));
 
 		printf(" bp:");
 
-		print_reg(orc[i].bp_reg, orc[i].bp_offset);
+		print_reg(orc[i].bp_reg, (s16)le16toh(orc[i].bp_offset));
 
 		printf(" type:%s end:%d\n",
 		       orc_type_name(orc[i].type), orc[i].end);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 968f55e6dd94..b3978fad93e6 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -90,6 +90,8 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	/* populate ORC data */
 	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
+	orc->sp_offset = htole16(orc->sp_offset);
+	orc->bp_offset = htole16(orc->bp_offset);
 
 	/* populate reloc for ip */
 	reloc = malloc(sizeof(*reloc));
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
