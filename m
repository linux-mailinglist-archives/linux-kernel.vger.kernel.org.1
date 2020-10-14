Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC68E28DB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgJNIdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:33:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42032 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgJNIdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:33:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8SYqr079281;
        Wed, 14 Oct 2020 08:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0LOAlCR7+l/nqsBzeW4eiXFvfSz5VzzoawRgTiBvYww=;
 b=gFTjpD2T7UidHHTZkiAsGpZXozTXlAnbc2lxmuTrdl2nC8Jb5/0qbQ480eCX/sS9VFG8
 WUlQ9nqWNt1tm/3gt22S3Por9cCW2u+I2jD2ObumrFq1nZY2h8tuBTH7dew2PH6d1WtE
 bUFSv77uCpNuxBAzbHKZVimgi8GXq8iKdQRGfKnZdFP5sRB+CvSurMShja3SgbD0oXrK
 QeOF2rCu+q9vj/cKfQJqIPmxRnMTar+A9zjrSKsilNeBrW39cmql3XG8Y+X7+D0FyLT8
 tV9jpcE8SdhYCibs2BKsjF33+FXEvDFDiOgK2M6YNlwIgRHOGTImRuRbzuFc5f4khSbJ vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 343pajvt3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 08:33:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8UYoR111566;
        Wed, 14 Oct 2020 08:33:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 343pvxfsr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 08:33:03 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09E8X16S029052;
        Wed, 14 Oct 2020 08:33:01 GMT
Received: from monad.ca.oracle.com (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 01:33:01 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 3/8] perf bench: add memset_movnti()
Date:   Wed, 14 Oct 2020 01:32:54 -0700
Message-Id: <20201014083300.19077-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014083300.19077-1-ankur.a.arora@oracle.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clone memset_movnti() from arch/x86/lib/memset_64.S.

perf bench mem memset on -f x86-64-movnt on Intel Broadwellx, Skylakex
and AMD Rome:

Intel Broadwellx:
$ for i in 2 8 32 128 512; do
	perf bench mem memset -f x86-64-movnt -s ${i}MB
  done

  # Output pruned.
  # Running 'mem/memset' benchmark:
  # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
  # Copying 2MB bytes ...
        11.837121 GB/sec
  # Copying 8MB bytes ...
        11.783560 GB/sec
  # Copying 32MB bytes ...
        11.868591 GB/sec
  # Copying 128MB bytes ...
        11.865211 GB/sec
  # Copying 512MB bytes ...
        11.864085 GB/sec

Intel Skylakex:
$ for i in 2 8 32 128 512; do
	perf bench mem memset -f x86-64-movnt -s ${i}MB
  done
  # Running 'mem/memset' benchmark:
  # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
  # Copying 2MB bytes ...
         6.361971 GB/sec
  # Copying 8MB bytes ...
         6.300403 GB/sec
  # Copying 32MB bytes ...
         6.288992 GB/sec
  # Copying 128MB bytes ...
         6.328793 GB/sec
  # Copying 512MB bytes ...
         6.324471 GB/sec

AMD Rome:
$ for i in 2 8 32 128 512; do
	perf bench mem memset -f x86-64-movnt -s ${i}MB
  done
  # Running 'mem/memset' benchmark:
  # function 'x86-64-movnt' (movnt-based memset() in arch/x86/lib/memset_64.S)
  # Copying 2MB bytes ...
        10.993199 GB/sec
  # Copying 8MB bytes ...
        14.221784 GB/sec
  # Copying 32MB bytes ...
        14.293337 GB/sec
  # Copying 128MB bytes ...
        15.238947 GB/sec
  # Copying 512MB bytes ...
        16.476093 GB/sec

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/arch/x86/lib/memset_64.S               | 68 ++++++++++++++++------------
 tools/perf/bench/mem-memset-x86-64-asm-def.h |  6 ++-
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index fd5d25a474b7..bfbf6d06f81e 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -26,7 +26,7 @@ SYM_FUNC_START(__memset)
 	 *
 	 * Otherwise, use original memset function.
 	 */
-	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
+	ALTERNATIVE_2 "jmp memset_movq", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memset_erms", X86_FEATURE_ERMS
 
 	movq %rdi,%r9
@@ -65,7 +65,8 @@ SYM_FUNC_START(memset_erms)
 	ret
 SYM_FUNC_END(memset_erms)
 
-SYM_FUNC_START(memset_orig)
+.macro MEMSET_MOV OP fence
+SYM_FUNC_START(memset_\OP)
 	movq %rdi,%r10
 
 	/* expand byte value  */
@@ -76,64 +77,71 @@ SYM_FUNC_START(memset_orig)
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
diff --git a/tools/perf/bench/mem-memset-x86-64-asm-def.h b/tools/perf/bench/mem-memset-x86-64-asm-def.h
index dac6d2b7c39b..53ead7f91313 100644
--- a/tools/perf/bench/mem-memset-x86-64-asm-def.h
+++ b/tools/perf/bench/mem-memset-x86-64-asm-def.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-MEMSET_FN(memset_orig,
+MEMSET_FN(memset_movq,
 	"x86-64-unrolled",
 	"unrolled memset() in arch/x86/lib/memset_64.S")
 
@@ -11,3 +11,7 @@ MEMSET_FN(__memset,
 MEMSET_FN(memset_erms,
 	"x86-64-stosb",
 	"movsb-based memset() in arch/x86/lib/memset_64.S")
+
+MEMSET_FN(memset_movnti,
+	"x86-64-movnt",
+	"movnt-based memset() in arch/x86/lib/memset_64.S")
-- 
2.9.3

