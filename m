Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9128DB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgJNIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:33:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38490 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgJNIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:33:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8TnWF024154;
        Wed, 14 Oct 2020 08:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=dngeZ8n9mXihWuMdvo9jC04/GenkD+EXiDmLqvyLl9Q=;
 b=byq/npMmocHxiIKS7tZ1RDcOCPrbxh4XlZ9T1W9YBgb91WgtCI6o0b65oQiEgKRJVoMN
 vTG0MRZK+SEqjfg19eulTsIfULFI9Du/CGTgaUwRbDBPUP2IgS6nQLz57jR55saHsDCv
 wY4TFOaes692o+d6rwaOuBTlO3T6OpKh9hqggHrwvdZ24IaQG/vkUDyQoesvo1ycgSLo
 RBi6I4mGjgux8BFtLgZgYHFsbP6qkdBVtZbj9JT0Ak/uJwJVWj8EAos0J96mAKb5whXo
 fa9lsYC+8OdHNuDET7pekY4/D6EwzCL5xfP5z54DyMo7pRZalG1WR/YFXlLBpUuYGBgA TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 343vaecfn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 08:32:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8TguQ125847;
        Wed, 14 Oct 2020 08:32:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 343php84kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 08:32:57 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09E8Wthn000307;
        Wed, 14 Oct 2020 08:32:55 GMT
Received: from monad.ca.oracle.com (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 01:32:55 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Slaby <jslaby@suse.cz>, Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/8] x86/asm: add memset_movnti()
Date:   Wed, 14 Oct 2020 01:32:53 -0700
Message-Id: <20201014083300.19077-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014083300.19077-1-ankur.a.arora@oracle.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MOVNTI based implementation of memset().

memset_orig() and memset_movnti() only differ in the opcode used in the
inner loop, so move the memset_orig() logic into a macro, which gets
expanded into memset_movq() and memset_movnti().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/lib/memset_64.S | 68 +++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9ff15ee404a4..79703cc04b6a 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -27,7 +27,7 @@ SYM_FUNC_START(__memset)
 	 *
 	 * Otherwise, use original memset function.
 	 */
-	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
+	ALTERNATIVE_2 "jmp memset_movq", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memset_erms", X86_FEATURE_ERMS
 
 	movq %rdi,%r9
@@ -68,7 +68,8 @@ SYM_FUNC_START_LOCAL(memset_erms)
 	ret
 SYM_FUNC_END(memset_erms)
 
-SYM_FUNC_START_LOCAL(memset_orig)
+.macro MEMSET_MOV OP fence
+SYM_FUNC_START_LOCAL(memset_\OP)
 	movq %rdi,%r10
 
 	/* expand byte value  */
@@ -79,64 +80,71 @@ SYM_FUNC_START_LOCAL(memset_orig)
 	/* align dst */
 	movl  %edi,%r9d
 	andl  $7,%r9d
-	jnz  .Lbad_alignment
-.Lafter_bad_alignment:
+	jnz  .Lbad_alignment_\@
+.Lafter_bad_alignment_\@:
 
 	movq  %rdx,%rcx
 	shrq  $6,%rcx
-	jz	 .Lhandle_tail
+	jz	 .Lhandle_tail_\@
 
 	.p2align 4
-.Lloop_64:
+.Lloop_64_\@:
 	decq  %rcx
-	movq  %rax,(%rdi)
-	movq  %rax,8(%rdi)
-	movq  %rax,16(%rdi)
-	movq  %rax,24(%rdi)
-	movq  %rax,32(%rdi)
-	movq  %rax,40(%rdi)
-	movq  %rax,48(%rdi)
-	movq  %rax,56(%rdi)
+	\OP  %rax,(%rdi)
+	\OP  %rax,8(%rdi)
+	\OP  %rax,16(%rdi)
+	\OP  %rax,24(%rdi)
+	\OP  %rax,32(%rdi)
+	\OP  %rax,40(%rdi)
+	\OP  %rax,48(%rdi)
+	\OP  %rax,56(%rdi)
 	leaq  64(%rdi),%rdi
-	jnz    .Lloop_64
+	jnz    .Lloop_64_\@
 
 	/* Handle tail in loops. The loops should be faster than hard
 	   to predict jump tables. */
 	.p2align 4
-.Lhandle_tail:
+.Lhandle_tail_\@:
 	movl	%edx,%ecx
 	andl    $63&(~7),%ecx
-	jz 		.Lhandle_7
+	jz 		.Lhandle_7_\@
 	shrl	$3,%ecx
 	.p2align 4
-.Lloop_8:
+.Lloop_8_\@:
 	decl   %ecx
-	movq  %rax,(%rdi)
+	\OP  %rax,(%rdi)
 	leaq  8(%rdi),%rdi
-	jnz    .Lloop_8
+	jnz    .Lloop_8_\@
 
-.Lhandle_7:
+.Lhandle_7_\@:
 	andl	$7,%edx
-	jz      .Lende
+	jz      .Lende_\@
 	.p2align 4
-.Lloop_1:
+.Lloop_1_\@:
 	decl    %edx
 	movb 	%al,(%rdi)
 	leaq	1(%rdi),%rdi
-	jnz     .Lloop_1
+	jnz     .Lloop_1_\@
 
-.Lende:
+.Lende_\@:
+	.if \fence
+	sfence
+	.endif
 	movq	%r10,%rax
 	ret
 
-.Lbad_alignment:
+.Lbad_alignment_\@:
 	cmpq $7,%rdx
-	jbe	.Lhandle_7
+	jbe	.Lhandle_7_\@
 	movq %rax,(%rdi)	/* unaligned store */
 	movq $8,%r8
 	subq %r9,%r8
 	addq %r8,%rdi
 	subq %r8,%rdx
-	jmp .Lafter_bad_alignment
-.Lfinal:
-SYM_FUNC_END(memset_orig)
+	jmp .Lafter_bad_alignment_\@
+.Lfinal_\@:
+SYM_FUNC_END(memset_\OP)
+.endm
+
+MEMSET_MOV OP=movq fence=0
+MEMSET_MOV OP=movnti fence=1
-- 
2.9.3

