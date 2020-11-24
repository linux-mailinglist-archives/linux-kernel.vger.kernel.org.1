Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F262C2F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404152AbgKXSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:05:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13892 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403976AbgKXSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:05:04 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AOI2FgN012149;
        Tue, 24 Nov 2020 13:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=IA8698aworvdv6bocUzgdcqGvNs/sqVDV3mMRrWTIHg=;
 b=bdUsLH7e2y+73AP8haKf5zTqeVNt4gaj8Vt4t5/GJT7LcsmL2cfOdQKn45QbugTmPDek
 rA6c5u9/XN1nTdpf6wU4fuTQzdxKpwiM50qp9IfOLwBvEIMIVwpHbYGYFgbrsmmaTv9c
 SI1zVxoZ3iVjGstj590jczuAkce7kzEC7zaK7rpVl5jLMvJRuzwC/LeresOsqixOZygw
 CiynJKnrwUiO+XWte1SPoN7jGkRYkKsBtdOSiyCMA2V1a8GgFL/YXuLbiHN6YFfychBs
 pYc+Z4gXeeqH4nHSfZxwKLdpsSCZwm7DK/M54UO0hzVKY8HjsEGCVuvbz1WHCeOV8FO1 dw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350nse1s0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 13:05:02 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AOHwv4e004708;
        Tue, 24 Nov 2020 18:05:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 34xth8a03a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 18:05:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AOI4vVv58196350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 18:04:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CC154C04E;
        Tue, 24 Nov 2020 18:04:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2485F4C044;
        Tue, 24 Nov 2020 18:04:57 +0000 (GMT)
Received: from osiris (unknown [9.171.56.110])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Nov 2020 18:04:57 +0000 (GMT)
Date:   Tue, 24 Nov 2020 19:04:55 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.10-rc6
Message-ID: <20201124180455.GA4250@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_05:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 spamscore=0
 mlxlogscore=895 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one important s390 fix for 5.10-rc6.

Thanks,
Heiko

The following changes since commit 78d732e1f326f74f240d416af9484928303d9951:

  s390/cpum_sf.c: fix file permission for cpum_sfb_size (2020-11-12 12:10:36 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-5

for you to fetch changes up to 1179f170b6f0af7bb0b3b7628136eaac450ddf31:

  s390: fix fpu restore in entry.S (2020-11-23 11:52:13 +0100)

----------------------------------------------------------------
- disable interrupts when restoring fpu and vector registers,
  otherwise KVM guests might see corrupted register contents

----------------------------------------------------------------
Sven Schnelle (1):
      s390: fix fpu restore in entry.S

 arch/s390/kernel/asm-offsets.c | 10 +++++-----
 arch/s390/kernel/entry.S       |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 2012c1cf0853..483051e10db3 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -53,11 +53,11 @@ int main(void)
 	/* stack_frame offsets */
 	OFFSET(__SF_BACKCHAIN, stack_frame, back_chain);
 	OFFSET(__SF_GPRS, stack_frame, gprs);
-	OFFSET(__SF_EMPTY, stack_frame, empty1);
-	OFFSET(__SF_SIE_CONTROL, stack_frame, empty1[0]);
-	OFFSET(__SF_SIE_SAVEAREA, stack_frame, empty1[1]);
-	OFFSET(__SF_SIE_REASON, stack_frame, empty1[2]);
-	OFFSET(__SF_SIE_FLAGS, stack_frame, empty1[3]);
+	OFFSET(__SF_EMPTY, stack_frame, empty1[0]);
+	OFFSET(__SF_SIE_CONTROL, stack_frame, empty1[1]);
+	OFFSET(__SF_SIE_SAVEAREA, stack_frame, empty1[2]);
+	OFFSET(__SF_SIE_REASON, stack_frame, empty1[3]);
+	OFFSET(__SF_SIE_FLAGS, stack_frame, empty1[4]);
 	BLANK();
 	OFFSET(__VDSO_GETCPU_VAL, vdso_per_cpu_data, getcpu_val);
 	BLANK();
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 5346545b9860..26bb0603c5a1 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1068,6 +1068,7 @@ EXPORT_SYMBOL(save_fpu_regs)
  *	%r4
  */
 load_fpu_regs:
+	stnsm	__SF_EMPTY(%r15),0xfc
 	lg	%r4,__LC_CURRENT
 	aghi	%r4,__TASK_thread
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
@@ -1099,6 +1100,7 @@ load_fpu_regs:
 .Lload_fpu_regs_done:
 	ni	__LC_CPU_FLAGS+7,255-_CIF_FPU
 .Lload_fpu_regs_exit:
+	ssm	__SF_EMPTY(%r15)
 	BR_EX	%r14
 .Lload_fpu_regs_end:
 ENDPROC(load_fpu_regs)
