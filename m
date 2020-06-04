Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB31EEB34
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 21:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgFDTeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 15:34:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgFDTeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:34:03 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 054J5H01032168;
        Thu, 4 Jun 2020 15:34:00 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31f6hcgyra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 15:33:59 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 054JWX5W030638;
        Thu, 4 Jun 2020 19:33:58 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf482mjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Jun 2020 19:33:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 054JXtgd53215486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jun 2020 19:33:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D07CFAE058;
        Thu,  4 Jun 2020 19:33:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 885FDAE056;
        Thu,  4 Jun 2020 19:33:54 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.82.189])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jun 2020 19:33:54 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v4] powerpc/fadump: fix race between pstore write and fadump crash trigger
Date:   Fri,  5 Jun 2020 01:03:51 +0530
Message-Id: <20200604193351.65317-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-04_12:2020-06-04,2020-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 cotscore=-2147483648 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we enter into fadump crash path via system reset we fail to update
the pstore.

On the system reset path we first update the pstore then we go for fadump
crash. But the problem here is when all the CPUs try to get the pstore
lock to initiate the pstore write, only one CPUs will acquire the lock
and proceed with the pstore write. Since it in NMI context CPUs that fail
to get lock do not wait for their turn to write to the pstore and simply
proceed with the next operation which is fadump crash. One of the CPU who
proceeded with fadump crash path triggers the crash and does not wait for
the CPU who gets the pstore lock to complete the pstore update.

Timeline diagram to depicts the sequence of events that leads to an
unsuccessful pstore update when we hit fadump crash path via system reset.

                 1    2     3    ...      n   CPU Threads
                 |    |     |             |
                 |    |     |             |
 Reached to   -->|--->|---->| ----------->|
 system reset    |    |     |             |
 path            |    |     |             |
                 |    |     |             |
 Try to       -->|--->|---->|------------>|
 acquire the     |    |     |             |
 pstore lock     |    |     |             |
                 |    |     |             |
                 |    |     |             |
 Got the      -->| +->|     |             |<-+
 pstore lock     | |  |     |             |  |-->  Didn't get the
                 | --------------------------+     lock and moving
                 |    |     |             |        ahead on fadump
                 |    |     |             |        crash path
                 |    |     |             |
  Begins the  -->|    |     |             |
  process to     |    |     |             |<-- Got the chance to
  update the     |    |     |             |    trigger the crash
  pstore         | -> |     |    ... <-   |
                 | |  |     |         |   |
                 | |  |     |         |   |<-- Triggers the
                 | |  |     |         |   |    crash
                 | |  |     |         |   |      ^
                 | |  |     |         |   |      |
  Writing to  -->| |  |     |         |   |      |
  pstore         | |  |     |         |   |      |
                   |                  |          |
       ^           |__________________|          |
       |               CPU Relax                 |
       |                                         |
       +-----------------------------------------+
                          |
                          v
            Race: crash triggered before pstore
                  update completes

To avoid this race condition a barrier is added on crash_fadump path, it
prevents the CPU to trigger the crash until all the online CPUs completes
their task.

A barrier is added to make sure all the secondary CPUs hit the
crash_fadump function before we initiates the crash. A timeout is kept to
ensure the primary CPU (one who initiates the crash) do not wait for
secondary CPUs indefinitely.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

 ---
Chanagelog:

v1 -> v3:
   - https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-April/208267.html

v3 -> v4:

   - Now the primary CPU (one who triggers dump) waits for all secondary
     CPUs to enter and then initiates the crash.

 ---

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 59e60a9a9f5c..4953f3246220 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -32,6 +32,14 @@
 #include <asm/fadump-internal.h>
 #include <asm/setup.h>
 
+/*
+ * The CPU who acquired the lock to trigger the fadump crash should
+ * wait for other CPUs to enter.
+ *
+ * The timeout is in milliseconds.
+ */
+#define CRASH_TIMEOUT		500
+
 static struct fw_dump fw_dump;
 
 static void __init fadump_reserve_crash_area(u64 base);
@@ -46,6 +54,8 @@ struct fadump_mrange_info reserved_mrange_info = { "reserved", NULL, 0, 0, 0 };
 #ifdef CONFIG_CMA
 static struct cma *fadump_cma;
 
+static atomic_t cpus_in_crash;
+
 /*
  * fadump_cma_init() - Initialize CMA area from a fadump reserved memory
  *
@@ -596,8 +606,10 @@ early_param("fadump_reserve_mem", early_fadump_reserve_mem);
 
 void crash_fadump(struct pt_regs *regs, const char *str)
 {
+	unsigned int msecs;
 	struct fadump_crash_info_header *fdh = NULL;
 	int old_cpu, this_cpu;
+	unsigned int ncpus = num_online_cpus() - 1; /* Do not include first CPU */
 
 	if (!should_fadump_crash())
 		return;
@@ -613,6 +625,8 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 	old_cpu = cmpxchg(&crashing_cpu, -1, this_cpu);
 
 	if (old_cpu != -1) {
+		atomic_inc(&cpus_in_crash);
+
 		/*
 		 * We can't loop here indefinitely. Wait as long as fadump
 		 * is in force. If we race with fadump un-registration this
@@ -636,6 +650,16 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 
 	fdh->online_mask = *cpu_online_mask;
 
+	/*
+	 * If we came in via system reset, wait a while for the secondary
+	 * CPUs to enter.
+	 */
+	if (TRAP(&(fdh->regs)) == 0x100) {
+		msecs = CRASH_TIMEOUT;
+		while ((atomic_read(&cpus_in_crash) < ncpus) && (--msecs > 0))
+			mdelay(1);
+	}
+
 	fw_dump.ops->fadump_trigger(fdh, str);
 }
 
-- 
2.25.4

