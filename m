Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0032510C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 06:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgHYEhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 00:37:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728747AbgHYEhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:37:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P4WL8D001865;
        Tue, 25 Aug 2020 00:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cXJ1hb+rxB2SKxqD4eqkp6G4YrcNWaRqf6p7TUeDxs0=;
 b=GLHWScQgfEaJS7Yu3wqWBXpepdpBiY03F9d7XKSgQwq9TW2DjOl0TiVwo3+gSGXPM/Qp
 v7Z0h0CVNNEFrmWXTxuY3ikiS5Od6HOqK2cFTrBi+j5jc/cChtP6fg9RvfADcu4Kgy12
 3eAwmJ7i2Dp1hMg08hUIwzwk1cT7sIIA2Nug6UHueIi56Nf8VtsB0o95tLuxK7I+TxRf
 NC5rcFg1NkD/uhVorIDxEjDY/jMTJXin3CpzLTyvh1E8NpivyhF1gh4g1u+4VUTXQRRT
 iAaLWzRv/uUlwtuplnLKVH/+HGcotkt/x5ZLRlmA7SwH1bTQufaJdW2kw9t+xtFo784F bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334sekjxqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 00:36:53 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07P4aqfn013525;
        Tue, 25 Aug 2020 00:36:52 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 334sekjxpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 00:36:52 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07P4X5Vj027929;
        Tue, 25 Aug 2020 04:36:50 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 33498u8xqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 04:36:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07P4alRq26673550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 04:36:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA3BEAE05A;
        Tue, 25 Aug 2020 04:36:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50FE0AE045;
        Tue, 25 Aug 2020 04:36:45 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.33.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 04:36:45 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/8] powerpc/watchpoint/selftests: Tests for kernel accessing user memory
Date:   Tue, 25 Aug 2020 10:06:17 +0530
Message-Id: <20200825043617.1073634-9-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
References: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce tests to cover simple scenarios where user is watching
memory which can be accessed by kernel as well. We also support
_MODE_EXACT with _SETHWDEBUG interface. Move those testcases out-
side of _BP_RANGE condition. This will help to test _MODE_EXACT
scenarios when CONFIG_HAVE_HW_BREAKPOINT is not set, eg:

  $ ./ptrace-hwbreak
  ...
  PTRACE_SET_DEBUGREG, Kernel Access Userspace, len: 8: Ok
  PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
  PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
  PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
  PPC_PTRACE_SETHWDEBUG, MODE_EXACT, Kernel Access Userspace, len: 1: Ok
  success: ptrace-hwbreak

Suggested-by: Pedro Miraglia Franco de Carvalho <pedromfc@linux.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 48 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
index fc477dfe86a2..2e0d86e0687e 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
@@ -20,6 +20,8 @@
 #include <signal.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/syscall.h>
+#include <linux/limits.h>
 #include "ptrace.h"
 
 #define SPRN_PVR	0x11F
@@ -44,6 +46,7 @@ struct gstruct {
 };
 static volatile struct gstruct gstruct __attribute__((aligned(512)));
 
+static volatile char cwd[PATH_MAX] __attribute__((aligned(8)));
 
 static void get_dbginfo(pid_t child_pid, struct ppc_debug_info *dbginfo)
 {
@@ -138,6 +141,9 @@ static void test_workload(void)
 			write_var(len);
 	}
 
+	/* PTRACE_SET_DEBUGREG, Kernel Access Userspace test */
+	syscall(__NR_getcwd, &cwd, PATH_MAX);
+
 	/* PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO test */
 	write_var(1);
 
@@ -150,6 +156,9 @@ static void test_workload(void)
 	else
 		read_var(1);
 
+	/* PPC_PTRACE_SETHWDEBUG, MODE_EXACT, Kernel Access Userspace test */
+	syscall(__NR_getcwd, &cwd, PATH_MAX);
+
 	/* PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO test */
 	gstruct.a[rand() % A_LEN] = 'a';
 
@@ -293,6 +302,24 @@ static int test_set_debugreg(pid_t child_pid)
 	return 0;
 }
 
+static int test_set_debugreg_kernel_userspace(pid_t child_pid)
+{
+	unsigned long wp_addr = (unsigned long)cwd;
+	char *name = "PTRACE_SET_DEBUGREG";
+
+	/* PTRACE_SET_DEBUGREG, Kernel Access Userspace test */
+	wp_addr &= ~0x7UL;
+	wp_addr |= (1Ul << DABR_READ_SHIFT);
+	wp_addr |= (1UL << DABR_WRITE_SHIFT);
+	wp_addr |= (1UL << DABR_TRANSLATION_SHIFT);
+	ptrace_set_debugreg(child_pid, wp_addr);
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	check_success(child_pid, name, "Kernel Access Userspace", wp_addr, 8);
+
+	ptrace_set_debugreg(child_pid, 0);
+	return 0;
+}
+
 static void get_ppc_hw_breakpoint(struct ppc_hw_breakpoint *info, int type,
 				  unsigned long addr, int len)
 {
@@ -338,6 +365,22 @@ static void test_sethwdebug_exact(pid_t child_pid)
 	ptrace_delhwdebug(child_pid, wh);
 }
 
+static void test_sethwdebug_exact_kernel_userspace(pid_t child_pid)
+{
+	struct ppc_hw_breakpoint info;
+	unsigned long wp_addr = (unsigned long)&cwd;
+	char *name = "PPC_PTRACE_SETHWDEBUG, MODE_EXACT";
+	int len = 1; /* hardcoded in kernel */
+	int wh;
+
+	/* PPC_PTRACE_SETHWDEBUG, MODE_EXACT, Kernel Access Userspace test */
+	get_ppc_hw_breakpoint(&info, PPC_BREAKPOINT_TRIGGER_WRITE, wp_addr, 0);
+	wh = ptrace_sethwdebug(child_pid, &info);
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	check_success(child_pid, name, "Kernel Access Userspace", wp_addr, len);
+	ptrace_delhwdebug(child_pid, wh);
+}
+
 static void test_sethwdebug_range_aligned(pid_t child_pid)
 {
 	struct ppc_hw_breakpoint info;
@@ -452,9 +495,10 @@ static void
 run_tests(pid_t child_pid, struct ppc_debug_info *dbginfo, bool dawr)
 {
 	test_set_debugreg(child_pid);
+	test_set_debugreg_kernel_userspace(child_pid);
+	test_sethwdebug_exact(child_pid);
+	test_sethwdebug_exact_kernel_userspace(child_pid);
 	if (dbginfo->features & PPC_DEBUG_FEATURE_DATA_BP_RANGE) {
-		test_sethwdebug_exact(child_pid);
-
 		test_sethwdebug_range_aligned(child_pid);
 		if (dawr || is_8xx) {
 			test_sethwdebug_range_unaligned(child_pid);
-- 
2.26.2

