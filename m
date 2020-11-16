Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF652B4629
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgKPOqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:46:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36312 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgKPOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:46:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiGv0190154;
        Mon, 16 Nov 2020 14:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=USM3AmnzDkNjCYw4O23Qyo3qGJ8zslUvAEXmTKca3ns=;
 b=S00F5gsQHIsV5ACCQfisnBntW6l2wVnIbdMqFSbUE/m4lsj81spSxTFcmIIG4BO7c7pK
 RXKi72wI4wc2kR0rtdwT98pw7PY6ISPqp77zl8LBSLXpVJfRQ82xk6KgsAA8txXLh0Tw
 measfHAWjdJ+Uw0MwH88e5+Ei4KhXu2lyRPvXiPiIf7eNMUlj1671zYcaVIoUr65CazN
 pjxYtNxw+DYKuGcgZUcyadFYunRtgRzIkVk/bgwuGuJvvTOiCmcfpUj9t+G7moIIfSSt
 2vfnvtUyavI4/kvPmetG/R2ZY/b52CQymhu+q2TS149a6GZv9yseqAvLTf0L3deK+BWc sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34t76knch3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:45:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjVr7056146;
        Mon, 16 Nov 2020 14:45:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34usps3sca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:45:49 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AGEji3M024397;
        Mon, 16 Nov 2020 14:45:44 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:45:44 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
Date:   Mon, 16 Nov 2020 15:47:36 +0100
Message-Id: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 addressing comments from Andy:

- paranoid_entry/exit is back to assembly code. This avoids having
  a C version of SWAPGS and the need to disable stack-protector.
  (remove patches 8, 9, 21 from v1).

- SAVE_AND_SWITCH_TO_KERNEL_CR3 and RESTORE_CR3 are removed from
  paranoid_entry/exit and move to C (patch 19).

- __per_cpu_offset is mapped into the user page-table (patch 11)
  so that paranoid_entry can update GS before CR3 is switched.

- use a different stack canary with the user and kernel page-tables.
  This is a new patch in v2 to not leak the kernel stack canary
  in the user page-table (patch 21).

Patches are now based on v5.10-rc4.

----

With Page Table Isolation (PTI), syscalls as well as interrupts and
exceptions occurring in userspace enter the kernel with a user
page-table. The kernel entry code will then switch the page-table
from the user page-table to the kernel page-table by updating the
CR3 control register. This CR3 switch is currently done early in
the kernel entry sequence using assembly code.

This RFC proposes to defer the PTI CR3 switch until we reach C code.
The benefit is that this simplifies the assembly entry code, and make
the PTI CR3 switch code easier to understand. This also paves the way
for further possible projects such an easier integration of Address
Space Isolation (ASI), or the possibilily to execute some selected
syscall or interrupt handlers without switching to the kernel page-table
(and thus avoid the PTI page-table switch overhead).

Deferring CR3 switch to C code means that we need to run more of the
kernel entry code with the user page-table. To do so, we need to:

 - map more syscall, interrupt and exception entry code into the user
   page-table (map all noinstr code);

 - map additional data used in the entry code (such as stack canary);

 - run more entry code on the trampoline stack (which is mapped both
   in the kernel and in the user page-table) until we switch to the
   kernel page-table and then switch to the kernel stack;

 - have a per-task trampoline stack instead of a per-cpu trampoline
   stack, so the task can be scheduled out while it hasn't switched
   to the kernel stack.

Note that, for now, the CR3 switch can only be pushed as far as interrupts
remain disabled in the entry code. This is because the CR3 switch is done
based on the privilege level from the CS register from the interrupt frame.
I plan to fix this but that's some extra complication (need to track if the
user page-table is used or not).

The proposed patchset is in RFC state to get early feedback about this
proposal.

The code survives running a kernel build and LTP. Note that changes are
only for 64-bit at the moment, I haven't looked at 32-bit yet but I will
definitively check it.

Patches are based on v5.10-rc4.

Thanks,

alex.

-----

Alexandre Chartre (21):
  x86/syscall: Add wrapper for invoking syscall function
  x86/entry: Update asm_call_on_stack to support more function arguments
  x86/entry: Consolidate IST entry from userspace
  x86/sev-es: Define a setup stack function for the VC idtentry
  x86/entry: Implement ret_from_fork body with C code
  x86/pti: Provide C variants of PTI switch CR3 macros
  x86/entry: Fill ESPFIX stack using C code
  x86/pti: Introduce per-task PTI trampoline stack
  x86/pti: Function to clone page-table entries from a specified mm
  x86/pti: Function to map per-cpu page-table entry
  x86/pti: Extend PTI user mappings
  x86/pti: Use PTI stack instead of trampoline stack
  x86/pti: Execute syscall functions on the kernel stack
  x86/pti: Execute IDT handlers on the kernel stack
  x86/pti: Execute IDT handlers with error code on the kernel stack
  x86/pti: Execute system vector handlers on the kernel stack
  x86/pti: Execute page fault handler on the kernel stack
  x86/pti: Execute NMI handler on the kernel stack
  x86/pti: Defer CR3 switch to C code for IST entries
  x86/pti: Defer CR3 switch to C code for non-IST and syscall entries
  x86/pti: Use a different stack canary with the user and kernel
    page-table

 arch/x86/entry/common.c               |  58 ++++-
 arch/x86/entry/entry_64.S             | 346 +++++++++++---------------
 arch/x86/entry/entry_64_compat.S      |  22 --
 arch/x86/include/asm/entry-common.h   | 194 +++++++++++++++
 arch/x86/include/asm/idtentry.h       | 130 +++++++++-
 arch/x86/include/asm/irq_stack.h      |  11 +
 arch/x86/include/asm/page_64_types.h  |  36 ++-
 arch/x86/include/asm/processor.h      |   3 +
 arch/x86/include/asm/pti.h            |  18 ++
 arch/x86/include/asm/stackprotector.h |  35 ++-
 arch/x86/include/asm/switch_to.h      |   7 +-
 arch/x86/include/asm/traps.h          |   2 +-
 arch/x86/kernel/cpu/mce/core.c        |   7 +-
 arch/x86/kernel/espfix_64.c           |  41 +++
 arch/x86/kernel/nmi.c                 |  34 ++-
 arch/x86/kernel/sev-es.c              |  63 +++++
 arch/x86/kernel/traps.c               |  61 +++--
 arch/x86/mm/fault.c                   |  11 +-
 arch/x86/mm/pti.c                     |  76 ++++--
 include/linux/sched.h                 |   8 +
 kernel/fork.c                         |  25 ++
 21 files changed, 874 insertions(+), 314 deletions(-)

-- 
2.18.4

