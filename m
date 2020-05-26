Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8891BEF40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 06:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgD3Efg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 00:35:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726705AbgD3Ef3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:35:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U44IoI196022;
        Thu, 30 Apr 2020 00:34:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30pjy85t1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 00:34:52 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03U4SLlk070710;
        Thu, 30 Apr 2020 00:34:51 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30pjy85t17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 00:34:51 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03U4OjxY008371;
        Thu, 30 Apr 2020 04:34:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5srqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 04:34:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03U4YkSK60817590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 04:34:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE70E42041;
        Thu, 30 Apr 2020 04:34:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 476C84203F;
        Thu, 30 Apr 2020 04:34:43 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.59.105])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 04:34:43 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v4 05/16] powerpc/watchpoint: Provide DAWR number to set_dawr
Date:   Thu, 30 Apr 2020 10:04:06 +0530
Message-Id: <20200430043417.30948-6-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200430043417.30948-1-ravi.bangoria@linux.ibm.com>
References: <20200430043417.30948-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_01:2020-04-30,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new parameter 'nr' to set_dawr() which indicates which DAWR
should be programed.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/hw_breakpoint.h |  4 ++--
 arch/powerpc/kernel/dawr.c               | 15 ++++++++++-----
 arch/powerpc/kernel/process.c            |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 518b41eef924..5b3b02834e0b 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -104,10 +104,10 @@ static inline bool dawr_enabled(void)
 {
 	return dawr_force_enable;
 }
-int set_dawr(struct arch_hw_breakpoint *brk);
+int set_dawr(int nr, struct arch_hw_breakpoint *brk);
 #else
 static inline bool dawr_enabled(void) { return false; }
-static inline int set_dawr(struct arch_hw_breakpoint *brk) { return -1; }
+static inline int set_dawr(int nr, struct arch_hw_breakpoint *brk) { return -1; }
 #endif
 
 #endif	/* __KERNEL__ */
diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
index e91b613bf137..8114ad3a8574 100644
--- a/arch/powerpc/kernel/dawr.c
+++ b/arch/powerpc/kernel/dawr.c
@@ -16,7 +16,7 @@
 bool dawr_force_enable;
 EXPORT_SYMBOL_GPL(dawr_force_enable);
 
-int set_dawr(struct arch_hw_breakpoint *brk)
+int set_dawr(int nr, struct arch_hw_breakpoint *brk)
 {
 	unsigned long dawr, dawrx, mrd;
 
@@ -39,15 +39,20 @@ int set_dawr(struct arch_hw_breakpoint *brk)
 	if (ppc_md.set_dawr)
 		return ppc_md.set_dawr(dawr, dawrx);
 
-	mtspr(SPRN_DAWR0, dawr);
-	mtspr(SPRN_DAWRX0, dawrx);
+	if (nr == 0) {
+		mtspr(SPRN_DAWR0, dawr);
+		mtspr(SPRN_DAWRX0, dawrx);
+	} else {
+		mtspr(SPRN_DAWR1, dawr);
+		mtspr(SPRN_DAWRX1, dawrx);
+	}
 
 	return 0;
 }
 
 static void set_dawr_cb(void *info)
 {
-	set_dawr(info);
+	set_dawr(0, info);
 }
 
 static ssize_t dawr_write_file_bool(struct file *file,
@@ -60,7 +65,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 	/* Send error to user if they hypervisor won't allow us to write DAWR */
 	if (!dawr_force_enable &&
 	    firmware_has_feature(FW_FEATURE_LPAR) &&
-	    set_dawr(&null_brk) != H_SUCCESS)
+	    set_dawr(0, &null_brk) != H_SUCCESS)
 		return -ENODEV;
 
 	rc = debugfs_write_file_bool(file, user_buf, count, ppos);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8479c762aef2..7488adf4d61c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -806,7 +806,7 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
 
 	if (dawr_enabled())
 		// Power8 or later
-		set_dawr(brk);
+		set_dawr(0, brk);
 	else if (IS_ENABLED(CONFIG_PPC_8xx))
 		set_breakpoint_8xx(brk);
 	else if (!cpu_has_feature(CPU_FTR_ARCH_207S))
-- 
2.21.1

