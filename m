Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EA12C5BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404857AbgKZSKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:10:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65218 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404842AbgKZSKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:10:18 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQI1Vvl183104;
        Thu, 26 Nov 2020 13:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SSuusB1sxDxyC6UEEiJZrnyaS7GB8UZWMFieTiW72vE=;
 b=f5rWRdJSnLV9cQFHE8RK9C87Of7q4xl5XPqFJ3sjob1x/17ijRI36YeD31z9jo/uSFmM
 lLy8lA/zvfdKEruCv/1iOulaDwZLQKHPmzgBx7tP7QR9kNx3mwtb495GtWxyIWiaWAu/
 U1OsVgkaOlBp4ufWshepxAA0OPUYQ0SlBHdYj7YCzJVcFY4UDmmxjQuM6vJouNlSV9p9
 6+S77VsqjF+GFif7l2H6I95NnoN3B9VWB82vH94z1QJJZykM18fvjdaWrJ7wrqUOXSJV
 Px4d39HR+vWIbfDB7y2nsQLUNdD452zHSlZGUdu+MjxU4rCfTptSQ4iQaBHnHhH+mnsX ug== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352e4pn845-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 13:09:41 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQI9PP1002176;
        Thu, 26 Nov 2020 18:09:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 352ata06n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 18:09:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQI9b7Q60490130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 18:09:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BA82A4060;
        Thu, 26 Nov 2020 18:09:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F473A4054;
        Thu, 26 Nov 2020 18:09:35 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.85.81.45])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Nov 2020 18:09:34 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC PATCH 08/14] powerpc/ftrace: Use FTRACE_REGS_ADDR to identify the correct ftrace trampoline
Date:   Thu, 26 Nov 2020 23:38:45 +0530
Message-Id: <136410660b5b6ff6ceb63d683496b6517103c01c.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1606412433.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_08:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=915 clxscore=1015
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use FTRACE_REGS_ADDR instead of keying off
CONFIG_DYNAMIC_FTRACE_WITH_REGS to identify the proper ftrace trampoline
address to use.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/trace/ftrace.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4fe5f373172fd2..14b39f7797d455 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -361,11 +361,7 @@ static int setup_mcount_compiler_tramp(unsigned long tramp)
 	}
 
 	/* Let's re-write the tramp to go to ftrace_[regs_]caller */
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	ptr = ppc_global_function_entry((void *)ftrace_regs_caller);
-#else
-	ptr = ppc_global_function_entry((void *)ftrace_caller);
-#endif
+	ptr = ppc_global_function_entry((void *)FTRACE_REGS_ADDR);
 	if (create_branch(&instr, (void *)tramp, ptr, 0)) {
 		pr_debug("%ps is not reachable from existing mcount tramp\n",
 				(void *)ptr);
@@ -885,11 +881,7 @@ int __init ftrace_dyn_arch_init(void)
 		0x7d8903a6,		/* mtctr   r12			*/
 		0x4e800420,		/* bctr				*/
 	};
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-	unsigned long addr = ppc_global_function_entry((void *)ftrace_regs_caller);
-#else
-	unsigned long addr = ppc_global_function_entry((void *)ftrace_caller);
-#endif
+	unsigned long addr = ppc_global_function_entry((void *)FTRACE_REGS_ADDR);
 	long reladdr = addr - kernel_toc_addr();
 
 	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
-- 
2.25.4

