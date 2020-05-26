Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B45019D635
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 13:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbgDCL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 07:59:04 -0400
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:48038 "EHLO
        1.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390858AbgDCL7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:59:04 -0400
X-Greylist: delayed 12602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Apr 2020 07:59:01 EDT
Received: from player758.ha.ovh.net (unknown [10.110.171.212])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id C88EE1B9ECD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Apr 2020 10:20:02 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
        (Authenticated sender: clg@kaod.org)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id F1521111A22EA;
        Fri,  3 Apr 2020 08:19:44 +0000 (UTC)
Subject: Re: [PATCH v10 00/14] powerpc/vas: Page fault handling for user space
 NX requests
To:     Haren Myneni <haren@linux.ibm.com>, mpe@ellerman.id.au
Cc:     npiggin@gmail.com, mikey@neuling.org, herbert@gondor.apana.org.au,
        frederic.barrat@fr.ibm.com, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, hch@infradead.org, oohall@gmail.com,
        sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        ajd@linux.ibm.com
References: <1585810846.2275.23.camel@hbabu-laptop>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <14d46487-47ee-4ec8-5241-576368b1b119@kaod.org>
Date:   Fri, 3 Apr 2020 10:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585810846.2275.23.camel@hbabu-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17415982711574793042
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdeigddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 9:00 AM, Haren Myneni wrote:
> 
> On power9, Virtual Accelerator Switchboard (VAS) allows user space or
> kernel to communicate with Nest Accelerator (NX) directly using COPY/PASTE
> instructions. NX provides various functionalities such as compression,
> encryption and etc. But only compression (842 and GZIP formats) is
> supported in Linux kernel on power9.
> 
> 842 compression driver (drivers/crypto/nx/nx-842-powernv.c)
> is already included in Linux. Only GZIP support will be available from
> user space.
> 
> Applications can issue GZIP compression / decompression requests to NX with
> COPY/PASTE instructions. When NX is processing these requests, can hit
> fault on the request buffer (not in memory). It issues an interrupt and
> pastes fault CRB in fault FIFO. Expects kernel to handle this fault and
> return credits for both send and fault windows after processing.

How complex would it be to provide a QEMU PowerNV model for the NX and 
VAS units ? We can stage the different level of support. First would be 
a simple HW init. I am interested for the XIVE modeling of course.

Thanks,

C.
 
> 
> This patch series adds IRQ and fault window setup, and NX fault handling:
> - Alloc IRQ and trigger port address, and configure IRQ per VAS instance.
> - Set port# for each window to generate an interrupt when noticed fault.
> - Set fault window and FIFO on which NX paste fault CRB.
> - Setup IRQ thread fault handler per VAS instance.
> - When receiving an interrupt, Read CRBs from fault FIFO and update
>   coprocessor_status_block (CSB) in the corresponding CRB with translation
>   failure (CSB_CC_TRANSLATION). After issuing NX requests, process polls
>   on CSB address. When it sees translation error, can touch the request
>   buffer to bring the page in to memory and reissue NX request.
> - If copy_to_user fails on user space CSB address, OS sends SEGV signal.
> 
> Tested these patches with NX-GZIP enable patches and posted them as separate
> patch series.
> 
> Patch 1: Define alloc IRQ per chip which is needed to alloc IRQ per VAS
>            instance.
> Patch 2: Define nx_fault_stamp on which NX writes fault status for the fault
>          CRB
> Patch 3: Alloc and setup IRQ and trigger port address for each VAS instance
> Patches 4 & 5: Setup fault window and register NX per each VAS instance. This
>          window is used for NX to paste fault CRB in FIFO.
> Patch 6: Reference to pid and mm so that pid is not used until window closed.
>          Needed for multi thread application where child can open a window
>          and can be used by parent it later.
> Patch 7: Setup threaded IRQ handler per VAS
> Patch 8: Process CRBs from fault FIFO and notify tasks by updating CSB or
>          through signals.
> Patches 9 & 11: Return credits for send and fault windows after handling
>         faults.
> Patches 10 & 12: Dump FIFO / CRB data and messages for error conditions
> Patch 13: Fix closing send window after all credits are returned. This issue
>          happens only for user space requests. No page faults on kernel
>          request buffer.
> Patch 14: For each process / thread, use mm_context->vas_windows counter to
> 	 clear foreign address mapping and disable it.
> 
> Changelog:
> 
> V2:
>   - Use threaded IRQ instead of own kernel thread handler
>   - Use pswid instead of user space CSB address to find valid CRB
>   - Removed unused macros and other changes as suggested by Christoph Hellwig
> 
> V3:
>   - Rebased to 5.5-rc2
>   - Use struct pid * instead of pid_t for vas_window tgid
>   - Code cleanup as suggested by Christoph Hellwig
> 
> V4:
>   - Define xive alloc and get IRQ info based on chip ID and use these
>    functions for IRQ setup per VAS instance. It eliminates skiboot
>     dependency as suggested by Oliver.
> 
> V5:
>   - Do not update CSB if the process is exiting (patch8)
> 
> V6:
>   - Add interrupt handler instead of default one and return IRQ_HANDLED
>     if the fault handling thread is already in progress. (Patch7)
>   - Use platform send window ID and CCW[0] bit to find valid CRB in
>     fault FIFO (Patch7).
>   - Return fault address to user space in BE and other changes as
>     suggested by Michael Neuling. (patch8)
>   - Rebased to 5.6-rc4
> 
> V7:
>   - Fixed sparse warnings (patches 4, 9 and 10)
> 
> V8:
>   - Moved mm_context_remove_copro() before mmdrop() (patch6)
>   - Moved barrier before csb.flags store and add WARN_ON_ONCE() checks (patch8)
> 
> V9:
>   - Rebased to 5.6
>   - Changes based on Cedric's comments
>         - Removed "Define xive_native_alloc_get_irq_info()" patch and used
>           irq_get_handler_data() (patch3)
>   - Changes based on comments from Nicholas Piggin
>         - Moved "Taking PID reference" patch before setting VAS fault handler
>           patch
>         - Removed mutex_lock/unlock (patch7)
>         - Other cleanup changes
> 
> V10:
>   - Include patch to enable and disable CP_ABORT execution using
>     mm_context->vas_windows counter.
>   - Remove 'if (txwin)' line which is covered with 'else' before (patch6) 
> 
> Haren Myneni (14):
>   powerpc/xive: Define xive_native_alloc_irq_on_chip()
>   powerpc/vas: Define nx_fault_stamp in coprocessor_request_block
>   powerpc/vas: Alloc and setup IRQ and trigger port address
>   powerpc/vas: Setup fault window per VAS instance
>   powerpc/vas: Register NX with fault window ID and IRQ port value
>   powerpc/vas: Take reference to PID and mm for user space windows
>   powerpc/vas: Setup thread IRQ handler per VAS instance
>   powerpc/vas: Update CSB and notify process for fault CRBs
>   powerpc/vas: Return credits after handling fault
>   powerpc/vas: Print CRB and FIFO values
>   powerpc/vas: Do not use default credits for receive window
>   powerpc/vas: Display process stuck message
>   powerpc/vas: Free send window in VAS instance after credits returned
>   powerpc: Use mm_context vas_windows counter to issue CP_ABORT
> 
>  arch/powerpc/include/asm/book3s/64/mmu.h    |   3 +
>  arch/powerpc/include/asm/icswx.h            |  20 +-
>  arch/powerpc/include/asm/mmu_context.h      |  22 ++
>  arch/powerpc/include/asm/processor.h        |   1 -
>  arch/powerpc/include/asm/xive.h             |   9 +-
>  arch/powerpc/kernel/process.c               |   8 +-
>  arch/powerpc/platforms/powernv/Makefile     |   2 +-
>  arch/powerpc/platforms/powernv/vas-debug.c  |   2 +-
>  arch/powerpc/platforms/powernv/vas-fault.c  | 382 ++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/vas-window.c | 202 ++++++++++++++-
>  arch/powerpc/platforms/powernv/vas.c        |  85 ++++++-
>  arch/powerpc/platforms/powernv/vas.h        |  57 ++++-
>  arch/powerpc/sysdev/xive/native.c           |   6 +-
>  13 files changed, 767 insertions(+), 32 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/vas-fault.c
> 

