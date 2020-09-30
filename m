Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CE027E87C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgI3MYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:24:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729596AbgI3MYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UC1rFQ028211;
        Wed, 30 Sep 2020 08:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=OJBLkzYFlefv23a2+w2OqD3GhS6C+G0CXU5lysIghmM=;
 b=QIUaabUEnlP67aicUwVIsuNUWa4lz8DWl46r7T8z0VxRhU10O99q2Sl2Jpv9UuQ7Fn+O
 M8gUP8A3+Yb+3+VenXue+c70pOt58+EPX9/MdPqRiuLac+sy72cfS1VP8V2MuPDaJ8a5
 fhTtQbY3jRD9kA4VJAKUn/Ps8nZYLuz8pIlGpTE8UVl6MpDBUVhbVaPYggStX4zp7GoV
 3b+9tQhGRvf9HrTGx/tldElmXZCAqgGb7J4TpQWUUM0V3H7Uu9yAWN7Rw0WiYil6gZGw
 ft5F/HQQA+ZDK1eZqndWlwJ2+WvoMwgpxlS2qxDurhUB6SDewIGLlQv2HvFyX73R4Llh dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vs31spwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 08:24:30 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UC1r72028204;
        Wed, 30 Sep 2020 08:24:29 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vs31spw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 08:24:29 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UCCCHV005079;
        Wed, 30 Sep 2020 12:24:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 33v6mgrybs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 12:24:27 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08UCOPTG18940296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 12:24:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54C0F52052;
        Wed, 30 Sep 2020 12:24:25 +0000 (GMT)
Received: from localhost (unknown [9.145.18.215])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id AED305205A;
        Wed, 30 Sep 2020 12:24:24 +0000 (GMT)
Date:   Wed, 30 Sep 2020 14:24:23 +0200
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
Subject: [RFC PATCH v2 2/2] objtool: fix x86 orc generation on big endian
 cross compiles
Message-ID: <patch-2.thread-ca645c.git-ca645c336a18.your-ad-here.call-01601468251-ext-3723@work.hours>
References: <20200930101251.GX2628@hirez.programming.kicks-ass.net>
 <cover.thread-ca645c.your-ad-here.call-01601468251-ext-3723@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-ca645c.your-ad-here.call-01601468251-ext-3723@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_06:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300094
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
index fdbffec4cfde..c72bee8e6ec0 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -40,6 +40,13 @@
 #define ORC_REG_MAX			15
 
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
@@ -48,6 +55,9 @@
  * the stack for a given code address.  Each instance of the struct corresponds
  * to one or more code locations.
  */
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
@@ -57,6 +67,20 @@ struct orc_entry {
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
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ORC_TYPES_H */
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index fdbffec4cfde..c72bee8e6ec0 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -40,6 +40,13 @@
 #define ORC_REG_MAX			15
 
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
@@ -48,6 +55,9 @@
  * the stack for a given code address.  Each instance of the struct corresponds
  * to one or more code locations.
  */
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
@@ -57,6 +67,20 @@ struct orc_entry {
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
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ORC_TYPES_H */
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 5e6a95368d35..19fa6f65040e 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -197,11 +197,11 @@ int orc_dump(const char *_objname)
 
 		printf(" sp:");
 
-		print_reg(orc[i].sp_reg, orc[i].sp_offset);
+		print_reg(orc[i].sp_reg, (s16)le16toh(orc[i].sp_offset));
 
 		printf(" bp:");
 
-		print_reg(orc[i].bp_reg, orc[i].bp_offset);
+		print_reg(orc[i].bp_reg, (s16)le16toh(orc[i].bp_offset));
 
 		printf(" type:%s end:%d\n",
 		       orc_type_name(orc[i].type), orc[i].end);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 235663b96adc..ab9cff93fabd 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -96,6 +96,8 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
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
