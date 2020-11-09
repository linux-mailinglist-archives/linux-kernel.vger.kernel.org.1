Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1808A2ABEFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbgKIOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:42:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46592 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbgKIOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:42:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EY9UD185597;
        Mon, 9 Nov 2020 14:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=DCRdvoq7498R1xxo/4++8FedyNqXTY7mzqVS1JnXL7k=;
 b=rp+hF6a85lWB/wVsnpao00AjMgHnVXfYgFiCAeK6WP2FJkIWL495Z6708Jbel2t6atZR
 qyBmSOAmc9lmZYGqm6XqJJKMClYThhs8KDuxnDcTh5gSH8zGXFZL5wjsFxy6UviXB1Uk
 87q9Xgp59OLVt1Y1S2cuaE5VgiNG84V4CVse7u3nCggIpzwlyqSA8AmVcQUPOl/u/0ps
 gUhlaXoQ6l15ACGa6fz8uOReB7vLUDLCmyb4CpQwzJxPqlKKhFqyoAnlWTq2IIoTHATp
 IW5ZOZSasJqREPJjPgL/MtVLraVhWomWggSRAZpNbERP6+7QN0yrsBdnsT95Se954UKk 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhkp7kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:42:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EemKb174417;
        Mon, 9 Nov 2020 14:42:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34p5fxs15c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:42:20 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9EgHBt031136;
        Mon, 9 Nov 2020 14:42:17 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:42:16 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 00/24] x86/pti: Defer CR3 switch to C code
Date:   Mon,  9 Nov 2020 15:44:01 +0100
Message-Id: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending without messing up email addresses (hopefully!),
 Please reply using this email thread to have correct emails.
 Sorry for the noise.]

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

Code is based on v5.10-rc3.

Thanks,

alex.

-----

Alexandre Chartre (24):
  x86/syscall: Add wrapper for invoking syscall function
  x86/entry: Update asm_call_on_stack to support more function arguments
  x86/entry: Consolidate IST entry from userspace
  x86/sev-es: Define a setup stack function for the VC idtentry
  x86/entry: Implement ret_from_fork body with C code
  x86/pti: Provide C variants of PTI switch CR3 macros
  x86/entry: Fill ESPFIX stack using C code
  x86/entry: Add C version of SWAPGS and SWAPGS_UNSAFE_STACK
  x86/entry: Add C version of paranoid_entry/exit
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
  x86/entry: Disable stack-protector for IST entry C handlers
  x86/entry: Defer paranoid entry/exit to C code
  x86/entry: Remove paranoid_entry and paranoid_exit
  x86/pti: Defer CR3 switch to C code for non-IST and syscall entries

 arch/x86/entry/common.c               | 259 ++++++++++++-
 arch/x86/entry/entry_64.S             | 513 ++++++++------------------
 arch/x86/entry/entry_64_compat.S      |  22 --
 arch/x86/include/asm/entry-common.h   | 108 ++++++
 arch/x86/include/asm/idtentry.h       | 153 +++++++-
 arch/x86/include/asm/irq_stack.h      |  11 +
 arch/x86/include/asm/page_64_types.h  |  36 +-
 arch/x86/include/asm/paravirt.h       |  15 +
 arch/x86/include/asm/paravirt_types.h |  17 +-
 arch/x86/include/asm/processor.h      |   3 +
 arch/x86/include/asm/pti.h            |  18 +
 arch/x86/include/asm/switch_to.h      |   7 +-
 arch/x86/include/asm/traps.h          |   2 +-
 arch/x86/kernel/cpu/mce/core.c        |   7 +-
 arch/x86/kernel/espfix_64.c           |  41 ++
 arch/x86/kernel/nmi.c                 |  34 +-
 arch/x86/kernel/sev-es.c              |  52 +++
 arch/x86/kernel/traps.c               |  61 +--
 arch/x86/mm/fault.c                   |  11 +-
 arch/x86/mm/pti.c                     |  71 ++--
 kernel/fork.c                         |  22 ++
 21 files changed, 1002 insertions(+), 461 deletions(-)

-- 
2.18.4

