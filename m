Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5117E24646B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHQKYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 06:24:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726161AbgHQKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:24:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HA2Yx2030409;
        Mon, 17 Aug 2020 06:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6rHct8CYFquwu64es5L0JgVpUaLIDKc/vt54YPSWpb8=;
 b=XlASdY5rfymF6tHkT8ydyMvr/L4G0s2lCyTT3sVuKCyIWgUCWKmUwJ1qeB/I3SwMv0ws
 KEOUepr2SUSx5r/sPT6r+VBoTft+q2jmHJ0xU/vqy90rdMq6/cDE0qwBX2ik3gw7D1+4
 GZadbvtPeSUYb+MSEWi+ZLWt/pnA8ZEvfEyCt+YCZx1H0UeInJIdkXGRjgJJetdQbWz0
 tfLHTjVQEqJgKyfOtzmglK+hjDqfxvI6illSMpxVR69tJkdyYW/SFRryP1xMKpSd0e0i
 WlJSAwGlFe3CJZXHC16tbizp9Y+NVU/LZy4cuvZX96uNlyefCrdSNg97HRoClqD+oCtc GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y3ss97nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 06:23:55 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07HANtYg100721;
        Mon, 17 Aug 2020 06:23:55 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y3ss97kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 06:23:55 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HALNkI004976;
        Mon, 17 Aug 2020 10:23:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 32x7b819pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 10:23:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HANmx330867714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 10:23:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A34704C040;
        Mon, 17 Aug 2020 10:23:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2077D4C044;
        Mon, 17 Aug 2020 10:23:46 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.37.13])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 10:23:45 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@br.ibm.com,
        rogealve@br.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] powerpc/watchpoint: Bug fixes plus new feature flag
Date:   Mon, 17 Aug 2020 15:53:24 +0530
Message-Id: <20200817102330.777537-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_02:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 fixes a bug about watchpoint not firing when created with
         ptrace PPC_PTRACE_SETHWDEBUG and CONFIG_HAVE_HW_BREAKPOINT=N.
         The fix uses HW_BRK_TYPE_PRIV_ALL for ptrace user which, I
         guess, should be fine because we don't leak any kernel
         addresses and PRIV_ALL will also help to cover scenarios when
         kernel accesses user memory.
Patch #2,#3 fixes infinite exception bug, again the bug happens only
         with CONFIG_HAVE_HW_BREAKPOINT=N.
Patch #4 fixes two places where we are missing to set hw_len.
Patch #5 introduce new feature bit PPC_DEBUG_FEATURE_DATA_BP_ARCH_31
         which will be set when running on ISA 3.1 compliant machine.
Patch #6 finally adds selftest to test scenarios fixed by patch#2,#3
         and also moves MODE_EXACT tests outside of BP_RANGE condition.

Christophe, let me know if this series breaks something for 8xx.

v3: https://lore.kernel.org/r/20200805062750.290289-1-ravi.bangoria@linux.ibm.com

v3->v4:
  - Patch #1. Allow HW_BRK_TYPE_PRIV_ALL instead of HW_BRK_TYPE_USER
  - Patch #2, #3, #4 and #6 are new.
  - Rebased to powerpc/next.

Ravi Bangoria (6):
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
 arch/powerpc/include/asm/hw_breakpoint.h      |  11 ++
 arch/powerpc/include/uapi/asm/ptrace.h        |   1 +
 arch/powerpc/kernel/Makefile                  |   3 +-
 arch/powerpc/kernel/hw_breakpoint.c           | 149 +----------------
 .../kernel/hw_breakpoint_constraints.c        | 152 ++++++++++++++++++
 arch/powerpc/kernel/process.c                 |  48 ++++++
 arch/powerpc/kernel/ptrace/ptrace-noadv.c     |  10 +-
 arch/powerpc/xmon/xmon.c                      |   1 +
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c |  48 +++++-
 10 files changed, 273 insertions(+), 151 deletions(-)
 create mode 100644 arch/powerpc/kernel/hw_breakpoint_constraints.c

-- 
2.26.2

