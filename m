Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379D62B1FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKMQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:10:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgKMQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:10:31 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ADG4E7G108601;
        Fri, 13 Nov 2020 11:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ZyDwttnhFF75aidCqcCzo37mE7ObsGjZEwrkmGPic0g=;
 b=WeU3WduC4pNqABUcbVe0wu7yJlsIqvComewmSHEjsm1M7dwIqK+5aAm5FMvlbREBhbQO
 okiTOm4ASN0/h7ddrx3XAwiogWybVmJFzDBtnlLcjr7QlhwpjMxibikL9EAwr3u3PJE2
 TfN5r8cUr7ODFtiYDnC6gU2ZLKPaInR81jORW9cNHnHBcncUz6XPsUW97HYcWrN4EtaU
 TmfO86ArF8zz7yMBGwayhV1sdKNpqkc54glxhivJ+AoJDTln3yRAOIms+jVV+LBCQYOm
 lWDxx4af86FJU+tNNHCajT7Bl0L1fahVngUnu4Pu9/Mf4N1y8pazgw2Pys+W7lr7TcQ8 HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34svsd15nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 11:10:07 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ADG4Ehh108607;
        Fri, 13 Nov 2020 11:10:05 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34svsd15kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 11:10:04 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ADG7dsO023776;
        Fri, 13 Nov 2020 16:09:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 34njuh3gk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 16:09:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ADG9v3Y7996048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 16:09:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FDDB4C040;
        Fri, 13 Nov 2020 16:09:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C60A4C04E;
        Fri, 13 Nov 2020 16:09:56 +0000 (GMT)
Received: from localhost (unknown [9.171.17.225])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 13 Nov 2020 16:09:56 +0000 (GMT)
Date:   Fri, 13 Nov 2020 17:09:54 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/insn: Fix vector instructions decoding on big endian
Message-ID: <patch.git-a153abbe9170.your-ad-here.call-01605283379-ext-7358@work.hours>
References: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_10:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running instruction decoder posttest on s390 with allyesconfig shows
errors. Instructions used in couple of kernel objects could not be
correctly decoded on big endian system.

insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 5
insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
insn_decoder_test: warning: ffffffff831eb4e1:    62 d1 fd 48 7f 04 24    vmovdqa64 %zmm0,(%r12)
insn_decoder_test: warning: objdump says 7 bytes, but insn_get_length() says 6
insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
insn_decoder_test: warning: ffffffff831eb4e8:    62 51 fd 48 7f 44 24 01         vmovdqa64 %zmm8,0x40(%r12)
insn_decoder_test: warning: objdump says 8 bytes, but insn_get_length() says 6

This is because in few places instruction field bytes are set directly
with further usage of "value". To address that introduce and use
insn_set_byte() helper, which correctly updates "value" on big endian
systems.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 Please let me know if this patch is good as it is or I should squash it
 into the patch 2 of my patch series and resend it again.

 arch/x86/include/asm/insn.h       | 12 ++++++++++++
 arch/x86/lib/insn.c               | 18 +++++++++---------
 tools/arch/x86/include/asm/insn.h | 12 ++++++++++++
 tools/arch/x86/lib/insn.c         | 18 +++++++++---------
 4 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 004e27bdf121..3710a809db5d 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -30,6 +30,12 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
 	p->nbytes = n;
 }
 
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+}
+
 #else
 
 struct insn_field {
@@ -51,6 +57,12 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
 	p->nbytes = n;
 }
 
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+	p->value = __le32_to_cpu(p->little);
+}
 #endif
 
 struct insn {
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 520b31fc1f1a..435630a6ec97 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -161,9 +161,9 @@ void insn_get_prefixes(struct insn *insn)
 			b = insn->prefixes.bytes[3];
 			for (i = 0; i < nb; i++)
 				if (prefixes->bytes[i] == lb)
-					prefixes->bytes[i] = b;
+					insn_set_byte(prefixes, i, b);
 		}
-		insn->prefixes.bytes[3] = lb;
+		insn_set_byte(&insn->prefixes, 3, lb);
 	}
 
 	/* Decode REX prefix */
@@ -194,13 +194,13 @@ void insn_get_prefixes(struct insn *insn)
 			if (X86_MODRM_MOD(b2) != 3)
 				goto vex_end;
 		}
-		insn->vex_prefix.bytes[0] = b;
-		insn->vex_prefix.bytes[1] = b2;
+		insn_set_byte(&insn->vex_prefix, 0, b);
+		insn_set_byte(&insn->vex_prefix, 1, b2);
 		if (inat_is_evex_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			b2 = peek_nbyte_next(insn_byte_t, insn, 3);
-			insn->vex_prefix.bytes[3] = b2;
+			insn_set_byte(&insn->vex_prefix, 3, b2);
 			insn->vex_prefix.nbytes = 4;
 			insn->next_byte += 4;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -208,7 +208,7 @@ void insn_get_prefixes(struct insn *insn)
 				insn->opnd_bytes = 8;
 		} else if (inat_is_vex3_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes = 3;
 			insn->next_byte += 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -220,7 +220,7 @@ void insn_get_prefixes(struct insn *insn)
 			 * Makes it easier to decode vex.W, vex.vvvv,
 			 * vex.L and vex.pp. Masking with 0x7f sets vex.W == 0.
 			 */
-			insn->vex_prefix.bytes[2] = b2 & 0x7f;
+			insn_set_byte(&insn->vex_prefix, 2, b2 & 0x7f);
 			insn->vex_prefix.nbytes = 2;
 			insn->next_byte += 2;
 		}
@@ -256,7 +256,7 @@ void insn_get_opcode(struct insn *insn)
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
-	opcode->bytes[0] = op;
+	insn_set_byte(opcode, 0, op);
 	opcode->nbytes = 1;
 
 	/* Check if there is VEX prefix or not */
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index b9b6928cb62b..a3a1f60f129a 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -30,6 +30,12 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
 	p->nbytes = n;
 }
 
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+}
+
 #else
 
 struct insn_field {
@@ -51,6 +57,12 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
 	p->nbytes = n;
 }
 
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+	p->value = __le32_to_cpu(p->little);
+}
 #endif
 
 struct insn {
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 77e92aa52cdc..3d9355ed1246 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -161,9 +161,9 @@ void insn_get_prefixes(struct insn *insn)
 			b = insn->prefixes.bytes[3];
 			for (i = 0; i < nb; i++)
 				if (prefixes->bytes[i] == lb)
-					prefixes->bytes[i] = b;
+					insn_set_byte(prefixes, i, b);
 		}
-		insn->prefixes.bytes[3] = lb;
+		insn_set_byte(&insn->prefixes, 3, lb);
 	}
 
 	/* Decode REX prefix */
@@ -194,13 +194,13 @@ void insn_get_prefixes(struct insn *insn)
 			if (X86_MODRM_MOD(b2) != 3)
 				goto vex_end;
 		}
-		insn->vex_prefix.bytes[0] = b;
-		insn->vex_prefix.bytes[1] = b2;
+		insn_set_byte(&insn->vex_prefix, 0, b);
+		insn_set_byte(&insn->vex_prefix, 1, b2);
 		if (inat_is_evex_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			b2 = peek_nbyte_next(insn_byte_t, insn, 3);
-			insn->vex_prefix.bytes[3] = b2;
+			insn_set_byte(&insn->vex_prefix, 3, b2);
 			insn->vex_prefix.nbytes = 4;
 			insn->next_byte += 4;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -208,7 +208,7 @@ void insn_get_prefixes(struct insn *insn)
 				insn->opnd_bytes = 8;
 		} else if (inat_is_vex3_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes = 3;
 			insn->next_byte += 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -220,7 +220,7 @@ void insn_get_prefixes(struct insn *insn)
 			 * Makes it easier to decode vex.W, vex.vvvv,
 			 * vex.L and vex.pp. Masking with 0x7f sets vex.W == 0.
 			 */
-			insn->vex_prefix.bytes[2] = b2 & 0x7f;
+			insn_set_byte(&insn->vex_prefix, 2, b2 & 0x7f);
 			insn->vex_prefix.nbytes = 2;
 			insn->next_byte += 2;
 		}
@@ -256,7 +256,7 @@ void insn_get_opcode(struct insn *insn)
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
-	opcode->bytes[0] = op;
+	insn_set_byte(opcode, 0, op);
 	opcode->nbytes = 1;
 
 	/* Check if there is VEX prefix or not */
-- 
2.25.4
