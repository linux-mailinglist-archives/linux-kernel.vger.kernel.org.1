Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48327E878
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgI3MYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:24:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729682AbgI3MYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UC29NC166958;
        Wed, 30 Sep 2020 08:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=EBcIo2G0rCVP0l8ZJTTh9zahp33eh8dVypmP3QQv6ZE=;
 b=hwQdDLxkMD8hMc3JEzAL1wu3d3sSfg5hle75jxEbNov83nRrakqDKFOnrJZ5b/PwnS4A
 DkWU1dSZlaS5GUYWwqGM0946Uvcwba77NnpSnb5CJqoBFJug+y3db+aP3E1D4fcx2/gP
 rt6Zn+G9ZwlAoVxRNQXXDGIT/6Q7zHX/QMqRgyWtcy93sNAVmBzI/D5jF/yn2SwcU27X
 mJoRFFhJHOLDaBhFJSQd3rRav7sVH7A5jX/MUSfJPNQt25Y0MJTySlKNHhyVc2ucRSMI
 MZaTkyJBovgDIOtAHwkaMPCk8l69//tzqpNzkX2HtuXEXR+T2TGd9V9ffsCJRhdzFvgt Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vqqsvwbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 08:24:27 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UC4Eeb174745;
        Wed, 30 Sep 2020 08:24:27 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vqqsvwar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 08:24:26 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UCCoiT005194;
        Wed, 30 Sep 2020 12:24:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 33v6mgrybq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 12:24:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08UCOMcK28639702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 12:24:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 385E0AE04D;
        Wed, 30 Sep 2020 12:24:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DA40AE055;
        Wed, 30 Sep 2020 12:24:21 +0000 (GMT)
Received: from localhost (unknown [9.145.18.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Sep 2020 12:24:21 +0000 (GMT)
Date:   Wed, 30 Sep 2020 14:24:19 +0200
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
Subject: [RFC PATCH v2 1/2] objtool: x86 instruction decoder and big endian
 cross compiles
Message-ID: <patch-1.thread-ca645c.git-a25fdca3bf6d.your-ad-here.call-01601468251-ext-3723@work.hours>
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
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=2 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Make the x86 instruction decoder of the objtool usable on big endian
machines. This is useful for compile tests on non x86, big endian
hardware.

Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
[ gor: more endianness problems findings fixes / rebasing ]
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/x86/include/asm/insn.h       | 42 ++++++++++++++
 arch/x86/lib/insn.c               | 95 +++++++++++++------------------
 tools/arch/x86/include/asm/insn.h | 42 ++++++++++++++
 tools/arch/x86/lib/insn.c         | 95 +++++++++++++------------------
 tools/objtool/arch/x86/special.c  |  2 +-
 tools/objtool/check.c             |  4 +-
 tools/objtool/elf.c               | 34 ++++++-----
 7 files changed, 188 insertions(+), 126 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 5c1ae3eff9d4..e5a2bcc41ac4 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -8,8 +8,16 @@
  */
 
 /* insn_attr_t is defined in inat.h */
+#ifdef __KERNEL__
+#include <linux/swab.h>
+#include <asm/byteorder.h>
+#else
+#include <endian.h>
+#endif
 #include <asm/inat.h>
 
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct insn_field {
 	union {
 		insn_value_t value;
@@ -20,6 +28,40 @@ struct insn_field {
 	unsigned char nbytes;
 };
 
+static inline void insn_field_set(struct insn_field *p, insn_value_t v,
+				  unsigned char n)
+{
+	p->value = v;
+	p->nbytes = n;
+}
+
+#else
+
+struct insn_field {
+	insn_value_t value;
+	union {
+		insn_value_t little;
+		insn_byte_t bytes[4];
+	};
+	/* !0 if we've run insn_get_xxx() for this field */
+	unsigned char got;
+	unsigned char nbytes;
+};
+
+static inline void insn_field_set(struct insn_field *p, insn_value_t v,
+				  unsigned char n)
+{
+	p->value = v;
+#ifdef __KERNEL__
+	p->little = __swap32(v);
+#else
+	p->little = __bswap_32(v);
+#endif
+	p->nbytes = n;
+}
+
+#endif
+
 struct insn {
 	struct insn_field prefixes;	/*
 					 * Prefixes
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..9150bdc8a6d6 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -15,15 +15,23 @@
 
 #include <asm/emulate_prefix.h>
 
+#ifdef __KERNEL__
+#define letoh(t, r) \
+	((sizeof(t) == 4) ? le32_to_cpu(r) : (sizeof(t) == 2) ? le16_to_cpu(r) : r)
+#else
+#define letoh(t, r) \
+	((sizeof(t) == 4) ? le32toh(r) : (sizeof(t) == 2) ? le16toh(r) : r)
+#endif
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); letoh(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); r; })
+	({ t r = *(t*)((insn)->next_byte + n); letoh(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
@@ -157,8 +165,7 @@ void insn_get_prefixes(struct insn *insn)
 		b = peek_next(insn_byte_t, insn);
 		attr = inat_get_opcode_attribute(b);
 		if (inat_is_rex_prefix(attr)) {
-			insn->rex_prefix.value = b;
-			insn->rex_prefix.nbytes = 1;
+			insn_field_set(&insn->rex_prefix, b, 1);
 			insn->next_byte++;
 			if (X86_REX_W(b))
 				/* REX.W overrides opnd_size */
@@ -295,8 +302,7 @@ void insn_get_modrm(struct insn *insn)
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
-		modrm->value = mod;
-		modrm->nbytes = 1;
+		insn_field_set(modrm, mod, 1);
 		if (inat_is_group(insn->attr)) {
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
@@ -334,7 +340,7 @@ int insn_rip_relative(struct insn *insn)
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
 	 */
-	return (modrm->nbytes && (modrm->value & 0xc7) == 0x5);
+	return (modrm->nbytes && (modrm->bytes[0] & 0xc7) == 0x5);
 }
 
 /**
@@ -353,11 +359,11 @@ void insn_get_sib(struct insn *insn)
 	if (!insn->modrm.got)
 		insn_get_modrm(insn);
 	if (insn->modrm.nbytes) {
-		modrm = (insn_byte_t)insn->modrm.value;
+		modrm = insn->modrm.bytes[0];
 		if (insn->addr_bytes != 2 &&
 		    X86_MODRM_MOD(modrm) != 3 && X86_MODRM_RM(modrm) == 4) {
-			insn->sib.value = get_next(insn_byte_t, insn);
-			insn->sib.nbytes = 1;
+			insn_field_set(&insn->sib,
+				       get_next(insn_byte_t, insn), 1);
 		}
 	}
 	insn->sib.got = 1;
@@ -407,19 +413,18 @@ void insn_get_displacement(struct insn *insn)
 		if (mod == 3)
 			goto out;
 		if (mod == 1) {
-			insn->displacement.value = get_next(signed char, insn);
-			insn->displacement.nbytes = 1;
+			insn_field_set(&insn->displacement,
+				       get_next(signed char, insn), 1);
 		} else if (insn->addr_bytes == 2) {
 			if ((mod == 0 && rm == 6) || mod == 2) {
-				insn->displacement.value =
-					 get_next(short, insn);
-				insn->displacement.nbytes = 2;
+				insn_field_set(&insn->displacement,
+					       get_next(short, insn), 2);
 			}
 		} else {
 			if ((mod == 0 && rm == 5) || mod == 2 ||
 			    (mod == 0 && base == 5)) {
-				insn->displacement.value = get_next(int, insn);
-				insn->displacement.nbytes = 4;
+				insn_field_set(&insn->displacement,
+					       get_next(int, insn), 4);
 			}
 		}
 	}
@@ -435,18 +440,14 @@ static int __get_moffset(struct insn *insn)
 {
 	switch (insn->addr_bytes) {
 	case 2:
-		insn->moffset1.value = get_next(short, insn);
-		insn->moffset1.nbytes = 2;
+		insn_field_set(&insn->moffset1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
+		insn_field_set(&insn->moffset1, get_next(int, insn), 4);
 		break;
 	case 8:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
-		insn->moffset2.value = get_next(int, insn);
-		insn->moffset2.nbytes = 4;
+		insn_field_set(&insn->moffset1, get_next(int, insn), 4);
+		insn_field_set(&insn->moffset2, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -464,13 +465,11 @@ static int __get_immv32(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
+		insn_field_set(&insn->immediate, get_next(short, insn), 2);
 		break;
 	case 4:
 	case 8:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
+		insn_field_set(&insn->immediate, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -487,18 +486,15 @@ static int __get_immv(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
+		insn_field_set(&insn->immediate1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->immediate1.value = get_next(int, insn);
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
 		insn->immediate1.nbytes = 4;
 		break;
 	case 8:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
+		insn_field_set(&insn->immediate2, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -515,12 +511,10 @@ static int __get_immptr(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
+		insn_field_set(&insn->immediate1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
 		break;
 	case 8:
 		/* ptr16:64 is not exist (no segment) */
@@ -528,8 +522,7 @@ static int __get_immptr(struct insn *insn)
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
 	}
-	insn->immediate2.value = get_next(unsigned short, insn);
-	insn->immediate2.nbytes = 2;
+	insn_field_set(&insn->immediate2, get_next(unsigned short, insn), 2);
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
@@ -565,22 +558,17 @@ void insn_get_immediate(struct insn *insn)
 
 	switch (inat_immediate_size(insn->attr)) {
 	case INAT_IMM_BYTE:
-		insn->immediate.value = get_next(signed char, insn);
-		insn->immediate.nbytes = 1;
+		insn_field_set(&insn->immediate, get_next(signed char, insn), 1);
 		break;
 	case INAT_IMM_WORD:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
+		insn_field_set(&insn->immediate, get_next(short, insn), 2);
 		break;
 	case INAT_IMM_DWORD:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
+		insn_field_set(&insn->immediate, get_next(int, insn), 4);
 		break;
 	case INAT_IMM_QWORD:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
+		insn_field_set(&insn->immediate2, get_next(int, insn), 4);
 		break;
 	case INAT_IMM_PTR:
 		if (!__get_immptr(insn))
@@ -599,8 +587,7 @@ void insn_get_immediate(struct insn *insn)
 		goto err_out;
 	}
 	if (inat_has_second_immediate(insn->attr)) {
-		insn->immediate2.value = get_next(signed char, insn);
-		insn->immediate2.nbytes = 1;
+		insn_field_set(&insn->immediate2, get_next(signed char, insn), 1);
 	}
 done:
 	insn->immediate.got = 1;
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 568854b14d0a..85de3ad97699 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -8,8 +8,16 @@
  */
 
 /* insn_attr_t is defined in inat.h */
+#ifdef __KERNEL__
+#include <linux/swab.h>
+#include <asm/byteorder.h>
+#else
+#include <endian.h>
+#endif
 #include "inat.h"
 
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct insn_field {
 	union {
 		insn_value_t value;
@@ -20,6 +28,40 @@ struct insn_field {
 	unsigned char nbytes;
 };
 
+static inline void insn_field_set(struct insn_field *p, insn_value_t v,
+				  unsigned char n)
+{
+	p->value = v;
+	p->nbytes = n;
+}
+
+#else
+
+struct insn_field {
+	insn_value_t value;
+	union {
+		insn_value_t little;
+		insn_byte_t bytes[4];
+	};
+	/* !0 if we've run insn_get_xxx() for this field */
+	unsigned char got;
+	unsigned char nbytes;
+};
+
+static inline void insn_field_set(struct insn_field *p, insn_value_t v,
+				  unsigned char n)
+{
+	p->value = v;
+#ifdef __KERNEL__
+	p->little = __swap32(v);
+#else
+	p->little = __bswap_32(v);
+#endif
+	p->nbytes = n;
+}
+
+#endif
+
 struct insn {
 	struct insn_field prefixes;	/*
 					 * Prefixes
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0151dfc6da61..b4a41e2c7c8b 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -15,15 +15,23 @@
 
 #include "../include/asm/emulate_prefix.h"
 
+#ifdef __KERNEL__
+#define letoh(t, r) \
+	((sizeof(t) == 4) ? le32_to_cpu(r) : (sizeof(t) == 2) ? le16_to_cpu(r) : r)
+#else
+#define letoh(t, r) \
+	((sizeof(t) == 4) ? le32toh(r) : (sizeof(t) == 2) ? le16toh(r) : r)
+#endif
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); letoh(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); r; })
+	({ t r = *(t*)((insn)->next_byte + n); letoh(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
@@ -157,8 +165,7 @@ void insn_get_prefixes(struct insn *insn)
 		b = peek_next(insn_byte_t, insn);
 		attr = inat_get_opcode_attribute(b);
 		if (inat_is_rex_prefix(attr)) {
-			insn->rex_prefix.value = b;
-			insn->rex_prefix.nbytes = 1;
+			insn_field_set(&insn->rex_prefix, b, 1);
 			insn->next_byte++;
 			if (X86_REX_W(b))
 				/* REX.W overrides opnd_size */
@@ -295,8 +302,7 @@ void insn_get_modrm(struct insn *insn)
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
-		modrm->value = mod;
-		modrm->nbytes = 1;
+		insn_field_set(modrm, mod, 1);
 		if (inat_is_group(insn->attr)) {
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
@@ -334,7 +340,7 @@ int insn_rip_relative(struct insn *insn)
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
 	 */
-	return (modrm->nbytes && (modrm->value & 0xc7) == 0x5);
+	return (modrm->nbytes && (modrm->bytes[0] & 0xc7) == 0x5);
 }
 
 /**
@@ -353,11 +359,11 @@ void insn_get_sib(struct insn *insn)
 	if (!insn->modrm.got)
 		insn_get_modrm(insn);
 	if (insn->modrm.nbytes) {
-		modrm = (insn_byte_t)insn->modrm.value;
+		modrm = insn->modrm.bytes[0];
 		if (insn->addr_bytes != 2 &&
 		    X86_MODRM_MOD(modrm) != 3 && X86_MODRM_RM(modrm) == 4) {
-			insn->sib.value = get_next(insn_byte_t, insn);
-			insn->sib.nbytes = 1;
+			insn_field_set(&insn->sib,
+				       get_next(insn_byte_t, insn), 1);
 		}
 	}
 	insn->sib.got = 1;
@@ -407,19 +413,18 @@ void insn_get_displacement(struct insn *insn)
 		if (mod == 3)
 			goto out;
 		if (mod == 1) {
-			insn->displacement.value = get_next(signed char, insn);
-			insn->displacement.nbytes = 1;
+			insn_field_set(&insn->displacement,
+				       get_next(signed char, insn), 1);
 		} else if (insn->addr_bytes == 2) {
 			if ((mod == 0 && rm == 6) || mod == 2) {
-				insn->displacement.value =
-					 get_next(short, insn);
-				insn->displacement.nbytes = 2;
+				insn_field_set(&insn->displacement,
+					       get_next(short, insn), 2);
 			}
 		} else {
 			if ((mod == 0 && rm == 5) || mod == 2 ||
 			    (mod == 0 && base == 5)) {
-				insn->displacement.value = get_next(int, insn);
-				insn->displacement.nbytes = 4;
+				insn_field_set(&insn->displacement,
+					       get_next(int, insn), 4);
 			}
 		}
 	}
@@ -435,18 +440,14 @@ static int __get_moffset(struct insn *insn)
 {
 	switch (insn->addr_bytes) {
 	case 2:
-		insn->moffset1.value = get_next(short, insn);
-		insn->moffset1.nbytes = 2;
+		insn_field_set(&insn->moffset1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
+		insn_field_set(&insn->moffset1, get_next(int, insn), 4);
 		break;
 	case 8:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
-		insn->moffset2.value = get_next(int, insn);
-		insn->moffset2.nbytes = 4;
+		insn_field_set(&insn->moffset1, get_next(int, insn), 4);
+		insn_field_set(&insn->moffset2, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -464,13 +465,11 @@ static int __get_immv32(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
+		insn_field_set(&insn->immediate, get_next(short, insn), 2);
 		break;
 	case 4:
 	case 8:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
+		insn_field_set(&insn->immediate, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -487,18 +486,15 @@ static int __get_immv(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
+		insn_field_set(&insn->immediate1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->immediate1.value = get_next(int, insn);
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
 		insn->immediate1.nbytes = 4;
 		break;
 	case 8:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
+		insn_field_set(&insn->immediate2, get_next(int, insn), 4);
 		break;
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
@@ -515,12 +511,10 @@ static int __get_immptr(struct insn *insn)
 {
 	switch (insn->opnd_bytes) {
 	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
+		insn_field_set(&insn->immediate1, get_next(short, insn), 2);
 		break;
 	case 4:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
 		break;
 	case 8:
 		/* ptr16:64 is not exist (no segment) */
@@ -528,8 +522,7 @@ static int __get_immptr(struct insn *insn)
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
 	}
-	insn->immediate2.value = get_next(unsigned short, insn);
-	insn->immediate2.nbytes = 2;
+	insn_field_set(&insn->immediate2, get_next(unsigned short, insn), 2);
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
@@ -565,22 +558,17 @@ void insn_get_immediate(struct insn *insn)
 
 	switch (inat_immediate_size(insn->attr)) {
 	case INAT_IMM_BYTE:
-		insn->immediate.value = get_next(signed char, insn);
-		insn->immediate.nbytes = 1;
+		insn_field_set(&insn->immediate, get_next(signed char, insn), 1);
 		break;
 	case INAT_IMM_WORD:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
+		insn_field_set(&insn->immediate, get_next(short, insn), 2);
 		break;
 	case INAT_IMM_DWORD:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
+		insn_field_set(&insn->immediate, get_next(int, insn), 4);
 		break;
 	case INAT_IMM_QWORD:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
+		insn_field_set(&insn->immediate1, get_next(int, insn), 4);
+		insn_field_set(&insn->immediate2, get_next(int, insn), 4);
 		break;
 	case INAT_IMM_PTR:
 		if (!__get_immptr(insn))
@@ -599,8 +587,7 @@ void insn_get_immediate(struct insn *insn)
 		goto err_out;
 	}
 	if (inat_has_second_immediate(insn->attr)) {
-		insn->immediate2.value = get_next(signed char, insn);
-		insn->immediate2.nbytes = 1;
+		insn_field_set(&insn->immediate2, get_next(signed char, insn), 1);
 	}
 done:
 	insn->immediate.got = 1;
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index fd4af88c0ea5..287ddf6d8a9e 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -9,7 +9,7 @@
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
-	switch (feature) {
+	switch (le16toh(feature)) {
 	case X86_FEATURE_SMAP:
 		/*
 		 * If UACCESS validation is enabled; force that alternative;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2df9f769412e..6f2574bf0008 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1370,7 +1370,7 @@ static int read_unwind_hints(struct objtool_file *file)
 		cfa = &insn->cfi.cfa;
 
 		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
-			insn->ret_offset = hint->sp_offset;
+			insn->ret_offset = le16toh(hint->sp_offset);
 			continue;
 		}
 
@@ -1382,7 +1382,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		cfa->offset = hint->sp_offset;
+		cfa->offset = le16toh(hint->sp_offset);
 		insn->cfi.type = hint->type;
 		insn->cfi.end = hint->end;
 	}
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e1d7460574b..5c0341b0cde3 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -829,25 +829,27 @@ static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
 	int idx = 0, size;
-	GElf_Rel *relocs;
+	void *buf;
 
 	/* Allocate a buffer for relocations */
-	size = nr * sizeof(*relocs);
-	relocs = malloc(size);
-	if (!relocs) {
+	size = nr * sizeof(GElf_Rel);
+	buf = malloc(size);
+	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = relocs;
+	sec->data->d_buf = buf;
 	sec->data->d_size = size;
+	sec->data->d_type = ELF_T_REL;
 
 	sec->sh.sh_size = size;
 
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
-		relocs[idx].r_offset = reloc->offset;
-		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rel.r_offset = reloc->offset;
+		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		gelf_update_rel(sec->data, idx, &reloc->rel);
 		idx++;
 	}
 
@@ -858,26 +860,28 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
 	int idx = 0, size;
-	GElf_Rela *relocs;
+	void *buf;
 
 	/* Allocate a buffer for relocations with addends */
-	size = nr * sizeof(*relocs);
-	relocs = malloc(size);
-	if (!relocs) {
+	size = nr * sizeof(GElf_Rela);
+	buf = malloc(size);
+	if (!buf) {
 		perror("malloc");
 		return -1;
 	}
 
-	sec->data->d_buf = relocs;
+	sec->data->d_buf = buf;
 	sec->data->d_size = size;
+	sec->data->d_type = ELF_T_RELA;
 
 	sec->sh.sh_size = size;
 
 	idx = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
-		relocs[idx].r_offset = reloc->offset;
-		relocs[idx].r_addend = reloc->addend;
-		relocs[idx].r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		reloc->rela.r_offset = reloc->offset;
+		reloc->rela.r_addend = reloc->addend;
+		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
+		gelf_update_rela(sec->data, idx, &reloc->rela);
 		idx++;
 	}
 
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿

