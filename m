Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9693221200
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGOQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 12:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgGOQJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:09:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10AA020663;
        Wed, 15 Jul 2020 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594829339;
        bh=bGeYzdnLyqgNQbzdikYSDZHJdsBbhUXs6T3YVnEGcrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X9y9gDOiJTgw7AiHgcYiyYBC818cGoeRU0nknGrPeBceUeimdYY50DYLXemqOhIRd
         SDZId5d1UDeBcrCVYKY/FI2p9pJiMVPt2xqHihhub5YzYQX2wnZY0mTeV1FV4HbkgC
         dQmSoIhqb8zBLB8l+S1O/ZHRSJcL6HPd8BWrLbG0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jvjxp-00C2dl-EG; Wed, 15 Jul 2020 17:08:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 Jul 2020 17:08:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, wanghaibin.wang@huawei.com
Subject: Re: [REPORT] possible circular locking dependency when booting a VM
 on arm64 host
In-Reply-To: <7225eba7-6e5e-ec7e-953b-d1fef0b1775b@huawei.com>
References: <7225eba7-6e5e-ec7e-953b-d1fef0b1775b@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <99e001bba70216d9e9a54a786791cb92@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, yisen.zhuang@huawei.com, salil.mehta@huawei.com, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-07-09 11:41, Zenghui Yu wrote:
> Hi All,
> 
> I had seen the following lockdep splat when booting a guest on my
> Kunpeng 920 with GICv4 enabled. I can also trigger the same splat
> on v5.5 so it should already exist in the kernel for a while. I'm
> not sure what the exact problem is and hope someone can have a look!

I can't manage to trigger this splat on my D05, despite running guests
with GICv4 enabled. A couple of questions below:

> 
> 
> Thanks,
> Zenghui
> 
> [  103.855511] ======================================================
> [  103.861664] WARNING: possible circular locking dependency detected
> [  103.867817] 5.8.0-rc4+ #35 Tainted: G        W
> [  103.872932] ------------------------------------------------------
> [  103.879083] CPU 2/KVM/20515 is trying to acquire lock:
> [  103.884200] ffff202fcd5865b0 (&irq_desc_lock_class){-.-.}-{2:2},
> at: __irq_get_desc_lock+0x60/0xa0
> [  103.893127]
>                but task is already holding lock:
> [  103.898933] ffff202fcfd07f58 (&rq->lock){-.-.}-{2:2}, at:
> __schedule+0x114/0x8b8
> [  103.906301]
>                which lock already depends on the new lock.
> 
> [  103.914441]
>                the existing dependency chain (in reverse order) is:
> [  103.921888]
>                -> #3 (&rq->lock){-.-.}-{2:2}:
> [  103.927438]        _raw_spin_lock+0x54/0x70
> [  103.931605]        task_fork_fair+0x48/0x150
> [  103.935860]        sched_fork+0x100/0x268
> [  103.939856]        copy_process+0x628/0x1868
> [  103.944106]        _do_fork+0x74/0x710
> [  103.947840]        kernel_thread+0x78/0xa0
> [  103.951917]        rest_init+0x30/0x270
> [  103.955742]        arch_call_rest_init+0x14/0x1c
> [  103.960339]        start_kernel+0x534/0x568
> [  103.964503]
>                -> #2 (&p->pi_lock){-.-.}-{2:2}:
> [  103.970224]        _raw_spin_lock_irqsave+0x70/0x98
> [  103.975080]        try_to_wake_up+0x5c/0x5b0
> [  103.979330]        wake_up_process+0x28/0x38
> [  103.983581]        create_worker+0x128/0x1b8
> [  103.987834]        workqueue_init+0x308/0x3bc
> [  103.992172]        kernel_init_freeable+0x180/0x33c
> [  103.997027]        kernel_init+0x18/0x118
> [  104.001020]        ret_from_fork+0x10/0x18
> [  104.005097]
>                -> #1 (&pool->lock){-.-.}-{2:2}:
> [  104.010817]        _raw_spin_lock+0x54/0x70
> [  104.014983]        __queue_work+0x120/0x6e8
> [  104.019146]        queue_work_on+0xa0/0xd8
> [  104.023225]        irq_set_affinity_locked+0xa8/0x178
> [  104.028253]        __irq_set_affinity+0x5c/0x90
> [  104.032762]        irq_set_affinity_hint+0x74/0xb0
> [  104.037540]        hns3_nic_init_irq+0xe0/0x210 [hns3]
> [  104.042655]        hns3_client_init+0x2d8/0x4e0 [hns3]
> [  104.047779]        hclge_init_client_instance+0xf0/0x3a8 [hclge]
> [  104.053760]        hnae3_init_client_instance.part.3+0x30/0x68 
> [hnae3]
> [  104.060257]        hnae3_register_ae_dev+0x100/0x1f0 [hnae3]
> [  104.065892]        hns3_probe+0x60/0xa8 [hns3]

Are you performing some kind of PCIe hot-plug here? Or is that done
at boot only? It seems to help triggering the splat.

> [  104.070319]        local_pci_probe+0x44/0x98
> [  104.074573]        work_for_cpu_fn+0x20/0x30
> [  104.078823]        process_one_work+0x258/0x618
> [  104.083333]        worker_thread+0x1c0/0x438
> [  104.087585]        kthread+0x120/0x128
> [  104.091318]        ret_from_fork+0x10/0x18
> [  104.095394]
>                -> #0 (&irq_desc_lock_class){-.-.}-{2:2}:
> [  104.101895]        __lock_acquire+0x11bc/0x1530
> [  104.106406]        lock_acquire+0x100/0x3f8
> [  104.110570]        _raw_spin_lock_irqsave+0x70/0x98
> [  104.115426]        __irq_get_desc_lock+0x60/0xa0
> [  104.120021]        irq_set_vcpu_affinity+0x48/0xc8
> [  104.124793]        its_make_vpe_non_resident+0x6c/0xc0
> [  104.129910]        vgic_v4_put+0x64/0x70
> [  104.133815]        vgic_v3_put+0x28/0x100
> [  104.137806]        kvm_vgic_put+0x3c/0x60
> [  104.141801]        kvm_arch_vcpu_put+0x38/0x58
> [  104.146228]        kvm_sched_out+0x38/0x58
> [  104.150306]        __schedule+0x554/0x8b8
> [  104.154298]        schedule+0x50/0xe0
> [  104.157946]        kvm_arch_vcpu_ioctl_run+0x644/0x9e8
> [  104.163063]        kvm_vcpu_ioctl+0x4b4/0x918
> [  104.167403]        ksys_ioctl+0xb4/0xd0
> [  104.171222]        __arm64_sys_ioctl+0x28/0xc8
> [  104.175647]        el0_svc_common.constprop.2+0x74/0x138
> [  104.180935]        do_el0_svc+0x34/0xa0
> [  104.184755]        el0_sync_handler+0xec/0x128
> [  104.189179]        el0_sync+0x140/0x180
> [  104.192997]

The kernel seems to scream at us because we have two paths
exercising  the irq_desc_lock_class, one holding the rq->lock
because we are on the schedule out path.

These two locks are somehow unrelated (they just belong to the
same class), but the kernel cannot know that.

Not quite sure how to solve it though. The set_vcpu_affinity
call is necessary on the preemption path in order to make the
vpe non-resident. But it would help if I could reproduce it...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
