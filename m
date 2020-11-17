Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBCF2B5ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKQIRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:17:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39836 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:17:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH8EAWS183951;
        Tue, 17 Nov 2020 08:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=w45UBZTEsjzQNU0Kylmv3fwJ/nypxL4Qcx+v1uER5uk=;
 b=sXM9pJz9/XB+7Vo3r0F8sEkE5o4GHnMtiGbsah9ca03T5fcAcrU73oaOh0akzQPU6aoC
 S2yevzMblynxDOOpJkGkuBzUjNnJNQ+cYExi5PF7r2HPUgXi/7p4gundi1BOK58GlApl
 XWHwLN12lcPK6mu75gdUAVBT19oCmABkO5lY2+1GV7G9TGvjnUcdoORSq2+BC2C7a4TM
 yxwjGsl5R5LcPHLpTtkwoNlUOkUf+tRItn/MaHGZdfjJ4m6XAQVMdZ0YJWUBmKCOtOvW
 4Jfi41hdVT4QgVBydR3LY/WmpPxdIbOm0F6o8CI3/UPdA50bzDH1ru0qcHEHbB5FVFsz Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34t76ks4mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 08:16:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AH8FaPj086046;
        Tue, 17 Nov 2020 08:16:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34uspt25e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 08:16:44 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AH8GfwA020111;
        Tue, 17 Nov 2020 08:16:41 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 00:16:41 -0800
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116202426.GF1131@zn.tnic>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <692599af-53c8-7881-2bc7-8898085400cd@oracle.com>
Date:   Tue, 17 Nov 2020 09:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201116202426.GF1131@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=900 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=891
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/20 9:24 PM, Borislav Petkov wrote:
> On Mon, Nov 16, 2020 at 03:47:36PM +0100, Alexandre Chartre wrote:
>> Deferring CR3 switch to C code means that we need to run more of the
>> kernel entry code with the user page-table. To do so, we need to:
>>
>>   - map more syscall, interrupt and exception entry code into the user
>>     page-table (map all noinstr code);
>>
>>   - map additional data used in the entry code (such as stack canary);
>>
>>   - run more entry code on the trampoline stack (which is mapped both
>>     in the kernel and in the user page-table) until we switch to the
>>     kernel page-table and then switch to the kernel stack;
> 
> So PTI was added exactly to *not* have kernel memory mapped in the user
> page table. You're partially reversing that...

We are not reversing PTI, we are extending it.

PTI removes all kernel mapping from the user page-table. However there's
no issue with mapping some kernel data into the user page-table as long as
these data have no sensitive information.

Actually, PTI is already doing that but with a very limited scope. PTI adds
into the user page-table some kernel mappings which are needed for userland
to enter the kernel (such as the kernel entry text, the ESPFIX, the
CPU_ENTRY_AREA_BASE...).

So here, we are extending the PTI mapping so that we can execute more kernel
code while using the user page-table; it's a kind of PTI on steroids.


>>   - have a per-task trampoline stack instead of a per-cpu trampoline
>>     stack, so the task can be scheduled out while it hasn't switched
>>     to the kernel stack.
> 
> per-task? How much more memory is that per task?
> 

Currently, this is done by doubling the size of the task stack (patch 8),
so that's an extra 8KB. Half of the stack is used as the regular kernel
stack, and the other half used as the PTI stack:

+/*
+ * PTI doubles the size of the stack. The entire stack is mapped into
+ * the kernel address space. However, only the top half of the stack is
+ * mapped into the user address space.
+ *
+ * On syscall or interrupt, user mode enters the kernel with the user
+ * page-table, and the stack pointer is switched to the top of the
+ * stack (which is mapped in the user address space and in the kernel).
+ * The syscall/interrupt handler will then later decide when to switch
+ * to the kernel address space, and to switch to the top of the kernel
+ * stack which is only mapped in the kernel.
+ *
+ *   +-------------+
+ *   |             | ^                       ^
+ *   | kernel-only | | KERNEL_STACK_SIZE     |
+ *   |    stack    | |                       |
+ *   |             | V                       |
+ *   +-------------+ <- top of kernel stack  | THREAD_SIZE
+ *   |             | ^                       |
+ *   | kernel and  | | KERNEL_STACK_SIZE     |
+ *   | PTI stack   | |                       |
+ *   |             | V                       v
+ *   +-------------+ <- top of stack
+ */

The minimum size would be 1 page (4KB) as this is the minimum mapping size.
It's certainly enough for now as the usage of the PTI stack is limited, but
we will need larger stack if we won't to execute more kernel code with the
user page-table.

alex.
