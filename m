Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD82510BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 06:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHYEg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 00:36:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgHYEgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:36:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P4XTfC112753;
        Tue, 25 Aug 2020 00:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Zxf+8hQgHsYWGcKse8DPFzbL2AUqkNnXpw237AZFaCE=;
 b=NSjMa/q1QP+AdqLA27Jzrj+MIz4WrdAZ0DZb3AGTl8BZPlL3kNlGxvSecadN9txXt0Ti
 07ZYj/mVeiBadvdxawpZqLybk1h1qPzIHhXU18P4wNnj1W+wValm5qVGubmFIx2esad3
 GwnVlrpr0OSVKPtjs9VdULEB0udMx24DsaAmALJZrQZBSHVCqfSx02CcW1U/GHkGn8pM
 8wlqlP/NIN3I4qW0z16vFTZLnv63TvQ7WXYPSGm6OrRz0Y8XVFUxXJCZO8KwEq3c1wGh
 lRvav8dyReTJZKWA+HZC+eqzWQbWZo2Oa51+cIJ0LFIEtEOeuWMCRCJkxditPLkE6/Bl qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334s1ybjej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 00:36:30 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07P4Xo2G113535;
        Tue, 25 Aug 2020 00:36:29 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334s1ybjdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 00:36:29 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07P4XTJN028063;
        Tue, 25 Aug 2020 04:36:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 332uk8hu9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 04:36:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07P4aNjq30605610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 04:36:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C65B9AE055;
        Tue, 25 Aug 2020 04:36:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D7C6AE051;
        Tue, 25 Aug 2020 04:36:21 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.33.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 04:36:20 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] powerpc/watchpoint: Bug fixes plus new feature flag
Date:   Tue, 25 Aug 2020 10:06:09 +0530
Message-Id: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 fixes issue for quardword instruction on p10 predecessors.
Patch #2 fixes issue for vector instructions.
Patch #3 fixes a bug about watchpoint not firing when created with
         ptrace PPC_PTRACE_SETHWDEBUG and CONFIG_HAVE_HW_BREAKPOINT=N.
         The fix uses HW_BRK_TYPE_PRIV_ALL for ptrace user which, I
         guess, should be fine because we don't leak any kernel
         addresses and PRIV_ALL will also help to cover scenarios when
         kernel accesses user memory.
Patch #4,#5 fixes infinite exception bug, again the bug happens only
         with CONFIG_HAVE_HW_BREAKPOINT=N.
Patch #6 fixes two places where we are missing to set hw_len.
Patch #7 introduce new feature bit PPC_DEBUG_FEATURE_DATA_BP_ARCH_31
         which will be set when running on ISA 3.1 compliant machine.
Patch #8 finally adds selftest to test scenarios fixed by patch#2,#3
         and also moves MODE_EXACT tests outside of BP_RANGE condition.

Christophe, let me know if this series breaks something for 8xx.

v4: https://lore.kernel.org/r/20200817102330.777537-1-ravi.bangoria@linux.ibm.com/

v4->v5:
 - Patch #1 and #2 are new. These bug happen irrespective of
   CONFIG_HAVE_HW_BREAKPOINT.
 - Patch #3 to #8 are carry forwarded from v4
 - Rebased to powerpc/next

Ravi Bangoria (8):
  powerpc/watchpoint: Fix quarword instruction handling on p10
    predecessors
  powerpc/watchpoint: Fix handling of vector instructions
  powerpc/watchpoint/ptrace: Fix SETHWDEBUG when
    CONFIG_HAVE_HW_BREAKPOINT=N
  powerpc/watchpoint: Move DAWR detection logic outside of
    hw_breakpoint.c
  powerpc/watchpoint: Fix exception handling for
    CONFIG_HAVE_HW_BREAKPOINT=N
  powerpc/watchpoint: Add hw_len wherever missing
  powerpc/watchpoint/ptrace: Introduce PPC_DEBUG_FEATURE_DATA_BP_ARCH_31
  powerpc/watchpoint/selftests: Tests for kernel accessing user memory

 Documentation/powerpc/ptrace.rst              |   1 +
 arch/powerpc/include/asm/hw_breakpoint.h      |  14 +-
 arch/powerpc/include/uapi/asm/ptrace.h        |   1 +
 arch/powerpc/kernel/Makefile                  |   3 +-
 arch/powerpc/kernel/hw_breakpoint.c           | 149 +---------------
 .../kernel/hw_breakpoint_constraints.c        | 162 ++++++++++++++++++
 arch/powerpc/kernel/process.c                 |  48 ++++++
 arch/powerpc/kernel/ptrace/ptrace-noadv.c     |  10 +-
 arch/powerpc/xmon/xmon.c                      |   1 +
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c |  48 +++++-
 10 files changed, 285 insertions(+), 152 deletions(-)
 create mode 100644 arch/powerpc/kernel/hw_breakpoint_constraints.c

-- 
2.26.2

