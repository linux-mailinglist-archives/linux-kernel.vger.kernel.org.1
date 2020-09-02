Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67B425A48B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 06:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIBEaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 00:30:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgIBEaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:30:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0824Q56c068734;
        Wed, 2 Sep 2020 00:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ci7WtcBgXjwMgtDNS7y8uXtd7EFCLDM+efB1QVrCVhw=;
 b=ScyKyr9FQRyiz/4rVep+jNnDpYm/S1sByrkIE02dvq2FbcD2ENeG5VJeF7dcV7MtngjU
 6mHC4oFPpYZ03ahUKe35SPH5GVHZGsVOGOfYdniUa95nRAEHLVm1/1FjUTWXdUK51PHx
 Sp4eUj6nkYyRr3kwRCcdIQxrFgpGPx3bOnGFRxpuA7kIi1j5EwuYV4OrTLTCFi/lXAz/
 5b4HBYlIfm6Ov9LIFKh5SZnKXbl6shQWQpUvlUy7ssX88kS4Nw9EptjRzpED30Y8Y+Cz
 ttTU0m0Hq3CkujuX7svKtX4L73kmd7ujvMYPEX1SgpQG9S9jaDpBgMTtFJlsQX13JGwf Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a4c481am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:29:57 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0824RMvk071557;
        Wed, 2 Sep 2020 00:29:57 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a4c481ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:29:57 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0824SGXt023767;
        Wed, 2 Sep 2020 04:29:55 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 337en7jkrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 04:29:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0824TpYF30015784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 04:29:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2CB8A4054;
        Wed,  2 Sep 2020 04:29:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EADD4A405F;
        Wed,  2 Sep 2020 04:29:48 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.37.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 04:29:48 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] powerpc/watchpoint: Bug fixes plus new feature flag
Date:   Wed,  2 Sep 2020 09:59:37 +0530
Message-Id: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_02:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020031
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

v5: https://lore.kernel.org/r/20200825043617.1073634-1-ravi.bangoria@linux.ibm.com

v5->v6:
 - Fix build faulure reported by kernel test robot
 - patch #5. Use more compact if condition, suggested by Christophe


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
 arch/powerpc/include/asm/hw_breakpoint.h      |  12 ++
 arch/powerpc/include/uapi/asm/ptrace.h        |   1 +
 arch/powerpc/kernel/Makefile                  |   3 +-
 arch/powerpc/kernel/hw_breakpoint.c           | 149 +---------------
 .../kernel/hw_breakpoint_constraints.c        | 162 ++++++++++++++++++
 arch/powerpc/kernel/process.c                 |  48 ++++++
 arch/powerpc/kernel/ptrace/ptrace-noadv.c     |   9 +-
 arch/powerpc/xmon/xmon.c                      |   1 +
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c |  48 +++++-
 10 files changed, 282 insertions(+), 152 deletions(-)
 create mode 100644 arch/powerpc/kernel/hw_breakpoint_constraints.c

-- 
2.26.2

