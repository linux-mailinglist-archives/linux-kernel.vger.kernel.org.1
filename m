Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C042C5BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404970AbgKZSLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:11:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404527AbgKZSLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:11:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQI2RVR183015;
        Thu, 26 Nov 2020 13:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yErNLQzXf4H49Yf5isNvlY0rkReaN+BMh29dfprf0vE=;
 b=G1T87rTzHzExL5xLLKR/2b4jmIcdgVdpf0bt7Gpge3VPj8xjjmrzjwjy8jd96kJAX3CA
 FNe/gnquuRLw5LCra51xYI+/zMtGw51FAvb4WALz3mbTKXm2Y6fhBR3OIO5CDcMsTOuz
 5K3XHR7N4GwiWuM39OZcmS4bEAjzV2PaymPTNauhHc2gOhNq3239J3nbfWkca9sfEwOO
 /jW8OgI4QAOFXXFHwTLiOuUdbCcQrJt2q3SL44Kfj+4LfcRiWnepjIQkPcZ2SnZ/LTZR
 PIZ/yVhf+kd/PWkpXC/YUrXs1jLHWo/JWK5tbUEvxe+aSFaQKyasSmnWMsiH8nxhyC+z 9A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352cqur37f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 13:11:16 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQI8jNV016127;
        Thu, 26 Nov 2020 18:11:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 34yy8r3b6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 18:11:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQI9veI58327376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 18:09:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E518A405C;
        Thu, 26 Nov 2020 18:09:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B436BA4054;
        Thu, 26 Nov 2020 18:09:53 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.81.45])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Nov 2020 18:09:53 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC PATCH 14/14] samples/ftrace: Add powerpc support for ftrace direct samples
Date:   Thu, 26 Nov 2020 23:38:51 +0530
Message-Id: <820ababd519a6901d21e5927bbc89445ea110151.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_06:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple powerpc trampoline to demonstrate use of ftrace direct on
powerpc.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 samples/Kconfig                       |  2 +-
 samples/ftrace/ftrace-direct-modify.c | 58 +++++++++++++++++++++++++++
 samples/ftrace/ftrace-direct-too.c    | 48 ++++++++++++++++++++--
 samples/ftrace/ftrace-direct.c        | 45 +++++++++++++++++++--
 4 files changed, 144 insertions(+), 9 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 0ed6e4d71d87b1..fdc9e44dba3b95 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -26,7 +26,7 @@ config SAMPLE_TRACE_PRINTK
 config SAMPLE_FTRACE_DIRECT
 	tristate "Build register_ftrace_direct() example"
 	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
-	depends on X86_64 # has x86_64 inlined asm
+	depends on X86_64 || PPC64 # has inlined asm
 	help
 	  This builds an ftrace direct function example
 	  that hooks to wake_up_process and prints the parameters.
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index c13a5bc5095bea..89d66a12d300e1 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 
 void my_direct_func1(void)
 {
@@ -18,6 +19,7 @@ extern void my_tramp2(void *);
 
 static unsigned long my_ip = (unsigned long)schedule;
 
+#ifdef CONFIG_X86
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
@@ -38,6 +40,58 @@ asm (
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
 );
+#elif CONFIG_PPC64
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.global		my_tramp1\n"
+"   my_tramp1:\n"
+"	std	0, 16(1)\n"
+"	stdu	1, -480(1)\n"
+"	std	2, 24(1)\n"
+"	mflr	7\n"
+"	std	7, 368(1)\n"
+"	bcl	20, 31, 1f\n"
+"1:	mflr	12\n"
+"	ld	2, (3f - 1b)(12)\n"
+"	bl	my_direct_func1\n"
+"	nop\n"
+"	ld	2, 24(1)\n"
+"	ld	7, 368(1)\n"
+"	mtctr	7\n"
+"	addi	1, 1, 480\n"
+"	ld	0, 16(1)\n"
+"	mtlr	0\n"
+"	bctr\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+"	nop\n"
+"	.type		my_tramp2, @function\n"
+"	.global		my_tramp2\n"
+"   my_tramp2:\n"
+"	std	0, 16(1)\n"
+"	stdu	1, -480(1)\n"
+"	std	2, 24(1)\n"
+"	mflr	7\n"
+"	std	7, 368(1)\n"
+"	bcl	20, 31, 2f\n"
+"2:	mflr	12\n"
+"	ld	2, (3f - 2b)(12)\n"
+"	bl	my_direct_func2\n"
+"	nop\n"
+"	ld	2, 24(1)\n"
+"	ld	7, 368(1)\n"
+"	mtctr	7\n"
+"	addi	1, 1, 480\n"
+"	ld	0, 16(1)\n"
+"	mtlr	0\n"
+"	bctr\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"3:\n"
+"	.quad		.TOC.@tocbase\n"
+"	.popsection\n"
+);
+#endif
+
 
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
@@ -72,6 +126,10 @@ static int __init ftrace_direct_init(void)
 {
 	int ret;
 
+#ifdef CONFIG_PPC64
+	my_ip = ppc_function_entry((void *)my_ip) + 4;
+#endif
+
 	ret = register_ftrace_direct(my_ip, my_tramp);
 	if (!ret)
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index d5c5022be66429..9a82abecbe0dcc 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -3,6 +3,7 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 
 void my_direct_func(struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
@@ -13,6 +14,9 @@ void my_direct_func(struct vm_area_struct *vma,
 
 extern void my_tramp(void *);
 
+static unsigned long my_ip = (unsigned long)handle_mm_fault;
+
+#ifdef CONFIG_X86
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
@@ -31,18 +35,54 @@ asm (
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
+#elif CONFIG_PPC64
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.global		my_tramp\n"
+"   my_tramp:\n"
+"	std	0, 16(1)\n"
+"	stdu	1, -480(1)\n"
+"	std	2, 24(1)\n"
+"	std	3, 136(1)\n"
+"	std	4, 144(1)\n"
+"	std	5, 152(1)\n"
+"	mflr	7\n"
+"	std	7, 368(1)\n"
+"	bcl	20, 31, 1f\n"
+"1:	mflr	12\n"
+"	ld	2, (2f - 1b)(12)\n"
+"	bl	my_direct_func\n"
+"	nop\n"
+"	ld	5, 152(1)\n"
+"	ld	4, 144(1)\n"
+"	ld	3, 136(1)\n"
+"	ld	2, 24(1)\n"
+"	ld	7, 368(1)\n"
+"	mtctr	7\n"
+"	addi	1, 1, 480\n"
+"	ld	0, 16(1)\n"
+"	mtlr	0\n"
+"	bctr\n"
+"	.size		my_tramp, .-my_tramp\n"
+"2:\n"
+"	.quad		.TOC.@tocbase\n"
+"	.popsection\n"
+);
+#endif
 
 
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)handle_mm_fault,
-				     (unsigned long)my_tramp);
+#ifdef CONFIG_PPC64
+	my_ip = ppc_function_entry((void *)my_ip) + 4;
+#endif
+	return register_ftrace_direct(my_ip, (unsigned long)my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)handle_mm_fault,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct(my_ip, (unsigned long)my_tramp);
 }
 
 module_init(ftrace_direct_init);
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 63ca06d42c803f..da67b6217f91d2 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,6 +3,7 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
+#include <linux/kprobes.h> /* for ppc_function_entry() */
 
 void my_direct_func(struct task_struct *p)
 {
@@ -11,6 +12,9 @@ void my_direct_func(struct task_struct *p)
 
 extern void my_tramp(void *);
 
+static unsigned long my_ip = (unsigned long)wake_up_process;
+
+#ifdef CONFIG_X86
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
@@ -25,18 +29,51 @@ asm (
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
+#elif CONFIG_PPC64
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.global		my_tramp\n"
+"   my_tramp:\n"
+"	std	0, 16(1)\n"
+"	stdu	1, -480(1)\n"
+"	std	2, 24(1)\n"
+"	std	3, 136(1)\n"
+"	mflr	7\n"
+"	std	7, 368(1)\n"
+"	bcl	20, 31, 1f\n"
+"1:	mflr	12\n"
+"	ld	2, (2f - 1b)(12)\n"
+"	bl	my_direct_func\n"
+"	nop\n"
+"	ld	3, 136(1)\n"
+"	ld	2, 24(1)\n"
+"	ld	7, 368(1)\n"
+"	mtctr	7\n"
+"	addi	1, 1, 480\n"
+"	ld	0, 16(1)\n"
+"	mtlr	0\n"
+"	bctr\n"
+"	.size		my_tramp, .-my_tramp\n"
+"2:\n"
+"	.quad		.TOC.@tocbase\n"
+"	.popsection\n"
+);
+#endif
 
 
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)wake_up_process,
-				     (unsigned long)my_tramp);
+#ifdef CONFIG_PPC64
+	/* Ftrace location is (usually) the second instruction at a function's local entry point */
+	my_ip = ppc_function_entry((void *)my_ip) + 4;
+#endif
+	return register_ftrace_direct(my_ip, (unsigned long)my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)wake_up_process,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct(my_ip, (unsigned long)my_tramp);
 }
 
 module_init(ftrace_direct_init);
-- 
2.25.4

