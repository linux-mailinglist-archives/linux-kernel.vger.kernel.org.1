Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40BF282B44
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 16:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJDObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 10:31:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbgJDObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 10:31:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 094E29L5110510;
        Sun, 4 Oct 2020 10:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=ZJGTibtGf3/SFVm4vzQqX/GIdo3dLm5njPBU34YRFRQ=;
 b=qVU3LJ5ONaD2cF39SdtEGnxo5LVZKZaamzE96n4d9Z6i2fVX2fbKT3JEjZUl5JdnjiMC
 1ozN6j0NakykFyZlKbBSxvH4vPzegfhDTQ9fkDLkRu0lim/CHtqUBbsKRN28L+baCBoh
 CxdlqdOe8MHudOgDfv7sNxCw3GayLihW979oiLPkW4GTAW91OHxGiXm+HodWq/bI3Wqk
 Y1yN+59pxdofwWgz58jKW2+SUw0TCkfDmznjr+2HG14e79lyqBeRoZ5vOoMHCizYrMhG
 cqc43EhFW4fZ01zoSpOj0/+Qcjnxufr6GmhpVe0OmYzfeENaNZMEo4UHFx0usiLKAgDW ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33yf4tryvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 10:30:55 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 094ENGGC152745;
        Sun, 4 Oct 2020 10:30:55 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33yf4tryv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 10:30:54 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 094ECtRQ000488;
        Sun, 4 Oct 2020 14:30:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 33xgjh8mg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Oct 2020 14:30:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 094EUoEQ28246320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Oct 2020 14:30:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA643AE056;
        Sun,  4 Oct 2020 14:30:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8827BAE051;
        Sun,  4 Oct 2020 14:30:48 +0000 (GMT)
Received: from localhost (unknown [9.145.42.132])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  4 Oct 2020 14:30:48 +0000 (GMT)
Date:   Sun, 4 Oct 2020 16:30:46 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 2/4] x86/insn: instruction decoder and big endian
 cross compiles
Message-ID: <patch-2.thread-a8def4.git-784bd8382b30.your-ad-here.call-01601818410-ext-7687@work.hours>
References: <20201002160114.7yb7z7aeijhchpwl@treble>
 <cover.thread-a8def4.your-ad-here.call-01601818410-ext-7687@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-a8def4.your-ad-here.call-01601818410-ext-7687@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-04_12:2020-10-02,2020-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=2 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010040104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

x86 instruction decoder code is shared across the kernel source and the
tools. Currently objtool seems to be the only tool from build tools needed
which breaks x86 cross compilation on big endian systems. Make the x86
instruction decoder build host endianness agnostic to support x86 cross
compilation and enable objtool to implement endianness awareness for
big endian architectures support.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/x86/include/asm/insn.h       |  33 ++++++++++
 arch/x86/lib/insn.c               | 101 ++++++++++++++----------------
 tools/arch/x86/include/asm/insn.h |  33 ++++++++++
 tools/arch/x86/lib/insn.c         | 101 ++++++++++++++----------------
 4 files changed, 160 insertions(+), 108 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 5c1ae3eff9d4..004e27bdf121 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -7,9 +7,12 @@
  * Copyright (C) IBM Corporation, 2009
  */
 
+#include <asm/byteorder.h>
 /* insn_attr_t is defined in inat.h */
 #include <asm/inat.h>
 
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct insn_field {
 	union {
 		insn_value_t value;
@@ -20,6 +23,36 @@ struct insn_field {
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
+	p->little = __cpu_to_le32(v);
+	p->nbytes = n;
+}
+
+#endif
+
 struct insn {
 	struct insn_field prefixes;	/*
 					 * Prefixes
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..520b31fc1f1a 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -5,6 +5,7 @@
  * Copyright (C) IBM Corporation, 2002, 2004, 2009
  */
 
+#include <linux/kernel.h>
 #ifdef __KERNEL__
 #include <linux/string.h>
 #else
@@ -15,15 +16,28 @@
 
 #include <asm/emulate_prefix.h>
 
+#define leXX_to_cpu(t, r)						\
+({									\
+	__typeof__(t) v;						\
+	switch (sizeof(t)) {						\
+	case 4: v = le32_to_cpu(r); break;				\
+	case 2: v = le16_to_cpu(r); break;				\
+	case 1:	v = r; break;						\
+	default:							\
+		BUILD_BUG(); break;					\
+	}								\
+	v;								\
+})
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); r; })
+	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
@@ -157,8 +171,7 @@ void insn_get_prefixes(struct insn *insn)
 		b = peek_next(insn_byte_t, insn);
 		attr = inat_get_opcode_attribute(b);
 		if (inat_is_rex_prefix(attr)) {
-			insn->rex_prefix.value = b;
-			insn->rex_prefix.nbytes = 1;
+			insn_field_set(&insn->rex_prefix, b, 1);
 			insn->next_byte++;
 			if (X86_REX_W(b))
 				/* REX.W overrides opnd_size */
@@ -295,8 +308,7 @@ void insn_get_modrm(struct insn *insn)
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
-		modrm->value = mod;
-		modrm->nbytes = 1;
+		insn_field_set(modrm, mod, 1);
 		if (inat_is_group(insn->attr)) {
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
@@ -334,7 +346,7 @@ int insn_rip_relative(struct insn *insn)
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
 	 */
-	return (modrm->nbytes && (modrm->value & 0xc7) == 0x5);
+	return (modrm->nbytes && (modrm->bytes[0] & 0xc7) == 0x5);
 }
 
 /**
@@ -353,11 +365,11 @@ void insn_get_sib(struct insn *insn)
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
@@ -407,19 +419,18 @@ void insn_get_displacement(struct insn *insn)
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
@@ -435,18 +446,14 @@ static int __get_moffset(struct insn *insn)
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
@@ -464,13 +471,11 @@ static int __get_immv32(struct insn *insn)
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
@@ -487,18 +492,15 @@ static int __get_immv(struct insn *insn)
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
@@ -515,12 +517,10 @@ static int __get_immptr(struct insn *insn)
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
@@ -528,8 +528,7 @@ static int __get_immptr(struct insn *insn)
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
 	}
-	insn->immediate2.value = get_next(unsigned short, insn);
-	insn->immediate2.nbytes = 2;
+	insn_field_set(&insn->immediate2, get_next(unsigned short, insn), 2);
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
@@ -565,22 +564,17 @@ void insn_get_immediate(struct insn *insn)
 
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
@@ -599,8 +593,7 @@ void insn_get_immediate(struct insn *insn)
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
index 568854b14d0a..b9b6928cb62b 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -7,9 +7,12 @@
  * Copyright (C) IBM Corporation, 2009
  */
 
+#include <asm/byteorder.h>
 /* insn_attr_t is defined in inat.h */
 #include "inat.h"
 
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+
 struct insn_field {
 	union {
 		insn_value_t value;
@@ -20,6 +23,36 @@ struct insn_field {
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
+	p->little = __cpu_to_le32(v);
+	p->nbytes = n;
+}
+
+#endif
+
 struct insn {
 	struct insn_field prefixes;	/*
 					 * Prefixes
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0151dfc6da61..77e92aa52cdc 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -5,6 +5,7 @@
  * Copyright (C) IBM Corporation, 2002, 2004, 2009
  */
 
+#include <linux/kernel.h>
 #ifdef __KERNEL__
 #include <linux/string.h>
 #else
@@ -15,15 +16,28 @@
 
 #include "../include/asm/emulate_prefix.h"
 
+#define leXX_to_cpu(t, r)						\
+({									\
+	__typeof__(t) v;						\
+	switch (sizeof(t)) {						\
+	case 4: v = le32_to_cpu(r); break;				\
+	case 2: v = le16_to_cpu(r); break;				\
+	case 1:	v = r; break;						\
+	default:							\
+		BUILD_BUG(); break;					\
+	}								\
+	v;								\
+})
+
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); leXX_to_cpu(t, r); })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); r; })
+	({ t r = *(t*)((insn)->next_byte + n); leXX_to_cpu(t, r); })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
@@ -157,8 +171,7 @@ void insn_get_prefixes(struct insn *insn)
 		b = peek_next(insn_byte_t, insn);
 		attr = inat_get_opcode_attribute(b);
 		if (inat_is_rex_prefix(attr)) {
-			insn->rex_prefix.value = b;
-			insn->rex_prefix.nbytes = 1;
+			insn_field_set(&insn->rex_prefix, b, 1);
 			insn->next_byte++;
 			if (X86_REX_W(b))
 				/* REX.W overrides opnd_size */
@@ -295,8 +308,7 @@ void insn_get_modrm(struct insn *insn)
 
 	if (inat_has_modrm(insn->attr)) {
 		mod = get_next(insn_byte_t, insn);
-		modrm->value = mod;
-		modrm->nbytes = 1;
+		insn_field_set(modrm, mod, 1);
 		if (inat_is_group(insn->attr)) {
 			pfx_id = insn_last_prefix_id(insn);
 			insn->attr = inat_get_group_attribute(mod, pfx_id,
@@ -334,7 +346,7 @@ int insn_rip_relative(struct insn *insn)
 	 * For rip-relative instructions, the mod field (top 2 bits)
 	 * is zero and the r/m field (bottom 3 bits) is 0x5.
 	 */
-	return (modrm->nbytes && (modrm->value & 0xc7) == 0x5);
+	return (modrm->nbytes && (modrm->bytes[0] & 0xc7) == 0x5);
 }
 
 /**
@@ -353,11 +365,11 @@ void insn_get_sib(struct insn *insn)
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
@@ -407,19 +419,18 @@ void insn_get_displacement(struct insn *insn)
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
@@ -435,18 +446,14 @@ static int __get_moffset(struct insn *insn)
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
@@ -464,13 +471,11 @@ static int __get_immv32(struct insn *insn)
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
@@ -487,18 +492,15 @@ static int __get_immv(struct insn *insn)
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
@@ -515,12 +517,10 @@ static int __get_immptr(struct insn *insn)
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
@@ -528,8 +528,7 @@ static int __get_immptr(struct insn *insn)
 	default:	/* opnd_bytes must be modified manually */
 		goto err_out;
 	}
-	insn->immediate2.value = get_next(unsigned short, insn);
-	insn->immediate2.nbytes = 2;
+	insn_field_set(&insn->immediate2, get_next(unsigned short, insn), 2);
 	insn->immediate1.got = insn->immediate2.got = 1;
 
 	return 1;
@@ -565,22 +564,17 @@ void insn_get_immediate(struct insn *insn)
 
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
@@ -599,8 +593,7 @@ void insn_get_immediate(struct insn *insn)
 		goto err_out;
 	}
 	if (inat_has_second_immediate(insn->attr)) {
-		insn->immediate2.value = get_next(signed char, insn);
-		insn->immediate2.nbytes = 1;
+		insn_field_set(&insn->immediate2, get_next(signed char, insn), 1);
 	}
 done:
 	insn->immediate.got = 1;
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿

