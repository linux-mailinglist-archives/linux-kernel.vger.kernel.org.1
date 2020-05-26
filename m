Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E231E1848
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 01:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgEYXkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 19:40:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24588 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbgEYXkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 19:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590450006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNOHdFyOR1+/V7085DfdiHGVU4eJXGBMIjXwIcz4T1k=;
        b=DIl+OHBRAsIoYgvuqkEHbdu1RMpPu3Dn+JccN3xWixfml0XcgyBs5rR95QzPMsLEwHkX66
        3mkyKWT1vuDgsq7fg3j9ap7yLHjuQqFJ6JDINAvj4NC9SvItr0IVpYr3XYl1RiHz2gc2GM
        CHRzAo6PrmAwezEoJCcdtR193JNP//Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-PK4Y-qa6OICb2LhK_eN3rA-1; Mon, 25 May 2020 19:40:01 -0400
X-MC-Unique: PK4Y-qa6OICb2LhK_eN3rA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA7C1005510;
        Mon, 25 May 2020 23:39:59 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-149.bne.redhat.com [10.64.54.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 291835C1BB;
        Mon, 25 May 2020 23:39:51 +0000 (UTC)
Subject: Re: [PATCH RFCv2 0/9] kvm/arm64: Support Async Page Fault
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     mark.rutland@arm.com, aarcange@redhat.com, drjones@redhat.com,
        suzuki.poulose@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com,
        james.morse@arm.com, shan.gavin@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200508032919.52147-1-gshan@redhat.com>
Message-ID: <2063b7bb-ff68-f515-db00-7e9c0ca8d339@redhat.com>
Date:   Tue, 26 May 2020 09:39:48 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200508032919.52147-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 1:29 PM, Gavin Shan wrote:
> There are two stages of page faults and the stage one page fault is
> handled by guest itself. The guest is trapped to host when the page
> fault is caused by stage 2 page table, for example missing. The guest
> is suspended until the requested page is populated. There might be
> IO activities involved for host to populate the requested page. For
> instance, the requested page has been swapped out previously. In this
> case, the guest (vCPU) has to suspend for a few of milliseconds, which
> depends on the swapping media, regardless of the overall system load.
> 
> The series adds asychornous page fault to improve the situation. A
> signal (PAGE_NOT_PRESENT) is sent from host to the guest if the requested
> page isn't absent immediately. In the mean while, a worker is started
> to populate the requested page in background. Guest either picks another
> available process to run or puts current (faulting) process to power
> saving mode when receiving the (PAGE_NOT_PRESENT) signal. After the
> requested page is populated by the worker, another signal (PAGE_READY)
> is sent from host to guest. Guest wakes up the (faulting) process when
> receiving the (PAGE_READY) signal.
> 
> The signals are conveyed through control block. The control block physical
> address is passed from guest to host through dedicated KVM vendor specific
> hypercall. The control block is visible and accessible by host and guest
> in the mean while. The hypercall is also used to enable, disable, configure
> the functionality. Notifications, by injected abort data exception, are
> fired when there are pending signals. The exception handler will be invoked
> in guest kernel.
> 
> Testing
> =======
> The tests are carried on the following machine. A guest with single vCPU
> and 4GB memory is started. Also, the QEMU process is put into memory cgroup
> (v1) whose memory limit is set to 2GB. In the guest, there are two threads,
> which are memory bound and CPU bound separately. The memory bound thread
> allocates all available memory, accesses and them free them. The CPU bound
> thread simply executes block of "nop". The test is carried out for 5 time
> continuously and the average number (per minute) of executed blocks in the
> CPU bound thread is taken as indicator of improvement.
> 
>     Vendor: GIGABYTE   CPU: 224 x Cavium ThunderX2(R) CPU CN9975 v2.2 @ 2.0GHz
>     Memory: 32GB       Disk: Fusion-MPT SAS-3 (PCIe3.0 x8)
> 
>     Without-APF: 7029030180/minute = avg(7559625120 5962155840 7823208540
>                                          7629633480 6170527920)
>     With-APF:    8286827472/minute = avg(8464584540 8177073360 8262723180
>                                          8095084020 8434672260)
>     Outcome:     +17.8%
> 
> Another test case is to measure the time consumed by the application, but
> with the CPU-bound thread disabled.
> 
>     Without-APF: 40.3s = avg(40.6 39.3 39.2 41.6 41.2)
>     With-APF:    40.8s = avg(40.6 41.1 40.9 41.0 40.7)
>     Outcome:     +1.2%
> 
> I also have some code in the host to capture the number of async page faults,
> time used to do swapin and its maximal/minimal values when async page fault
> is enabled. During the test, the CPU-bound thread is disabled. There is about
> 30% of the time used to do swapin.
> 
>     Number of async page fault:     7555 times
>     Total time used by application: 42.2 seconds
>     Total time used by swapin:      12.7 seconds   (30%)
>           Minimal swapin time:      36.2 us
>           Maximal swapin time:      55.7 ms
> 

A kindly ping... Marc/Mark/Will, please let me know your comments
on this. thanks in advance!

> Changelog
> =========
> RFCv1 -> RFCv2
>     * Rebase to 5.7.rc3
>     * Performance data                                                   (Marc Zyngier)
>     * Replace IMPDEF system register with KVM vendor specific hypercall  (Mark Rutland)
>     * Based on Will's KVM vendor hypercall probe mechanism               (Will Deacon)
>     * Don't use IMPDEF DFSC (0x43). Async page fault reason is conveyed
>       by the control block                                               (Mark Rutland)
>     * Delayed wakeup mechanism in guest kernel                           (Gavin Shan)
>     * Stability improvement in the guest kernel: delayed wakeup mechanism,
>       external abort disallowed region, lazily clear async page fault,
>       disabled interrupt on acquiring the head's lock and so on          (Gavin Shan)
>     * Stability improvement in the host kernel: serialized async page
>       faults etc.                                                        (Gavin Shan)
>     * Performance improvement in guest kernel: percpu sleeper head       (Gavin Shan)
> 
> Gavin Shan (7):
>    kvm/arm64: Rename kvm_vcpu_get_hsr() to kvm_vcpu_get_esr()
>    kvm/arm64: Detach ESR operator from vCPU struct
>    kvm/arm64: Replace hsr with esr
>    kvm/arm64: Export kvm_handle_user_mem_abort() with prefault mode
>    kvm/arm64: Support async page fault
>    kernel/sched: Add cpu_rq_is_locked()
>    arm64: Support async page fault
> 
> Will Deacon (2):
>    arm64: Probe for the presence of KVM hypervisor services during boot
>    arm/arm64: KVM: Advertise KVM UID to guests via SMCCC
> 
>   arch/arm64/Kconfig                       |  11 +
>   arch/arm64/include/asm/exception.h       |   3 +
>   arch/arm64/include/asm/hypervisor.h      |  11 +
>   arch/arm64/include/asm/kvm_emulate.h     |  83 +++--
>   arch/arm64/include/asm/kvm_host.h        |  47 +++
>   arch/arm64/include/asm/kvm_para.h        |  40 +++
>   arch/arm64/include/uapi/asm/Kbuild       |   2 -
>   arch/arm64/include/uapi/asm/kvm_para.h   |  22 ++
>   arch/arm64/kernel/entry.S                |  33 ++
>   arch/arm64/kernel/process.c              |   4 +
>   arch/arm64/kernel/setup.c                |  35 ++
>   arch/arm64/kvm/Kconfig                   |   1 +
>   arch/arm64/kvm/Makefile                  |   2 +
>   arch/arm64/kvm/handle_exit.c             |  48 +--
>   arch/arm64/kvm/hyp/switch.c              |  33 +-
>   arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |   7 +-
>   arch/arm64/kvm/inject_fault.c            |   4 +-
>   arch/arm64/kvm/sys_regs.c                |  38 +-
>   arch/arm64/mm/fault.c                    | 434 +++++++++++++++++++++++
>   include/linux/arm-smccc.h                |  32 ++
>   include/linux/sched.h                    |   1 +
>   kernel/sched/core.c                      |   8 +
>   virt/kvm/arm/arm.c                       |  40 ++-
>   virt/kvm/arm/async_pf.c                  | 335 +++++++++++++++++
>   virt/kvm/arm/hyp/aarch32.c               |   4 +-
>   virt/kvm/arm/hyp/vgic-v3-sr.c            |   7 +-
>   virt/kvm/arm/hypercalls.c                |  37 +-
>   virt/kvm/arm/mmio.c                      |  27 +-
>   virt/kvm/arm/mmu.c                       |  69 +++-
>   29 files changed, 1264 insertions(+), 154 deletions(-)
>   create mode 100644 arch/arm64/include/asm/kvm_para.h
>   create mode 100644 arch/arm64/include/uapi/asm/kvm_para.h
>   create mode 100644 virt/kvm/arm/async_pf.c
> 

