Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA72ABE11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgKIOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:00:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53840 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKIOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:00:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9DxBhQ012192;
        Mon, 9 Nov 2020 14:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=HFSkyWSaQWef0NJfDHgd6ydFmgXxCKSG04Oxn6eODi8=;
 b=ALzG1ErLPsb9o48A8QGZdRMPZhRhkiwA3HHktxh36iNsn/2C4s+w/X+yHDBqo10jwFkk
 512EndLWbtOnm/qMwLTNuaRm5xtNAsnPhvyLe6BW4ji/SJ6Exmp7xQPGN6rjPUXk0Y8F
 gyA1JzwhlIgeS0pubJ4uL1C3a+JLFn68eS3HR8gstbEsYKo/R1BVv20IpBI+uXRYH8TI
 e4U0OjGVQxnVr0uSE5pQA+almXkNi6om0v+bJToFSBjh0ZKKd7LbAGHLO2qAQsj+jNlG
 U/zdmPF/YioiRmAfxePd+nlQEg/bYu710iBIwnUL1ilFmL1eWXF29geVprdItC1nwjd2 pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34p72ec6u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:00:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Dp1pI163679;
        Mon, 9 Nov 2020 13:58:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34p5bqhpvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 13:58:29 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9DwSe8006398;
        Mon, 9 Nov 2020 13:58:28 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 05:58:27 -0800
Subject: Re: [RFC][PATCH 00/24] x86/pti: Defer CR3 switch to C code
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
Message-ID: <28a04992-a187-7ff5-9e5d-aa21165ac5cd@oracle.com>
Date:   Mon, 9 Nov 2020 15:00:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry but it looks like email addresses are messed up in my emails. Our email
server has a new security "feature" which has the good idea to change external
email addresses.

I will resend the patches with the correct addresses once I've found
how to prevent this mess.

alex.

On 11/9/20 12:22 PM, Alexandre Chartre wrote:
> With Page Table Isolation (PTI), syscalls as well as interrupts and
> exceptions occurring in userspace enter the kernel with a user
> page-table. The kernel entry code will then switch the page-table
> from the user page-table to the kernel page-table by updating the
> CR3 control register. This CR3 switch is currently done early in
> the kernel entry sequence using assembly code.
> 
> This RFC proposes to defer the PTI CR3 switch until we reach C code.
> The benefit is that this simplifies the assembly entry code, and make
> the PTI CR3 switch code easier to understand. This also paves the way
> for further possible projects such an easier integration of Address
> Space Isolation (ASI), or the possibilily to execute some selected
> syscall or interrupt handlers without switching to the kernel page-table
> (and thus avoid the PTI page-table switch overhead).
> 
> Deferring CR3 switch to C code means that we need to run more of the
> kernel entry code with the user page-table. To do so, we need to:
> 
>   - map more syscall, interrupt and exception entry code into the user
>     page-table (map all noinstr code);
> 
>   - map additional data used in the entry code (such as stack canary);
> 
>   - run more entry code on the trampoline stack (which is mapped both
>     in the kernel and in the user page-table) until we switch to the
>     kernel page-table and then switch to the kernel stack;
> 
>   - have a per-task trampoline stack instead of a per-cpu trampoline
>     stack, so the task can be scheduled out while it hasn't switched
>     to the kernel stack.
> 
> Note that, for now, the CR3 switch can only be pushed as far as interrupts
> remain disabled in the entry code. This is because the CR3 switch is done
> based on the privilege level from the CS register from the interrupt frame.
> I plan to fix this but that's some extra complication (need to track if the
> user page-table is used or not).
> 
> The proposed patchset is in RFC state to get early feedback about this
> proposal.
> 
> The code survives running a kernel build and LTP. Note that changes are
> only for 64-bit at the moment, I haven't looked at 32-bit yet but I will
> definitively check it.
> 
> Code is based on v5.10-rc3.
> 
> Thanks,
> 
> alex.
> 
> -----
> 
> Alexandre Chartre (24):
>    x86/syscall: Add wrapper for invoking syscall function
>    x86/entry: Update asm_call_on_stack to support more function arguments
>    x86/entry: Consolidate IST entry from userspace
>    x86/sev-es: Define a setup stack function for the VC idtentry
>    x86/entry: Implement ret_from_fork body with C code
>    x86/pti: Provide C variants of PTI switch CR3 macros
>    x86/entry: Fill ESPFIX stack using C code
>    x86/entry: Add C version of SWAPGS and SWAPGS_UNSAFE_STACK
>    x86/entry: Add C version of paranoid_entry/exit
>    x86/pti: Introduce per-task PTI trampoline stack
>    x86/pti: Function to clone page-table entries from a specified mm
>    x86/pti: Function to map per-cpu page-table entry
>    x86/pti: Extend PTI user mappings
>    x86/pti: Use PTI stack instead of trampoline stack
>    x86/pti: Execute syscall functions on the kernel stack
>    x86/pti: Execute IDT handlers on the kernel stack
>    x86/pti: Execute IDT handlers with error code on the kernel stack
>    x86/pti: Execute system vector handlers on the kernel stack
>    x86/pti: Execute page fault handler on the kernel stack
>    x86/pti: Execute NMI handler on the kernel stack
>    x86/entry: Disable stack-protector for IST entry C handlers
>    x86/entry: Defer paranoid entry/exit to C code
>    x86/entry: Remove paranoid_entry and paranoid_exit
>    x86/pti: Defer CR3 switch to C code for non-IST and syscall entries
> 
>   arch/x86/entry/common.c               | 259 ++++++++++++-
>   arch/x86/entry/entry_64.S             | 513 ++++++++------------------
>   arch/x86/entry/entry_64_compat.S      |  22 --
>   arch/x86/include/asm/entry-common.h   | 108 ++++++
>   arch/x86/include/asm/idtentry.h       | 153 +++++++-
>   arch/x86/include/asm/irq_stack.h      |  11 +
>   arch/x86/include/asm/page_64_types.h  |  36 +-
>   arch/x86/include/asm/paravirt.h       |  15 +
>   arch/x86/include/asm/paravirt_types.h |  17 +-
>   arch/x86/include/asm/processor.h      |   3 +
>   arch/x86/include/asm/pti.h            |  18 +
>   arch/x86/include/asm/switch_to.h      |   7 +-
>   arch/x86/include/asm/traps.h          |   2 +-
>   arch/x86/kernel/cpu/mce/core.c        |   7 +-
>   arch/x86/kernel/espfix_64.c           |  41 ++
>   arch/x86/kernel/nmi.c                 |  34 +-
>   arch/x86/kernel/sev-es.c              |  52 +++
>   arch/x86/kernel/traps.c               |  61 +--
>   arch/x86/mm/fault.c                   |  11 +-
>   arch/x86/mm/pti.c                     |  71 ++--
>   kernel/fork.c                         |  22 ++
>   21 files changed, 1002 insertions(+), 461 deletions(-)
> 
