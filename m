Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEFA268DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgINOev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:34:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41599 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgINOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:32:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200914143237euoutp014cdf814a295d54a319462584c468d0b1~0rPn8awqs0576605766euoutp01v
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:32:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200914143237euoutp014cdf814a295d54a319462584c468d0b1~0rPn8awqs0576605766euoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600093957;
        bh=cZ/X0pnwEDNop7KD1zyKUAqIDp6wLTFuzlElBsuE/G0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ck4TzJMCDsjuaDQnvrub4Hu7Jw7VI000ULIkZYpbeFmAx/KX/HTAuEYkf8cyOYbXH
         Vcpbu7qXVM++OiB8MUxTa6lmE1y+/ltiKc/8P3QEF19AjzMQCNwi5vQ+fI/Tsp/F4Y
         ZPQ3Nk5lVOTDpb/RFPfLQ88FaMWItKJhB0ziAlJU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200914143236eucas1p2319c37a886287840d2e3cb9edac17604~0rPnbhDka0871208712eucas1p2-;
        Mon, 14 Sep 2020 14:32:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 52.03.05997.40F7F5F5; Mon, 14
        Sep 2020 15:32:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200914143236eucas1p17e8849c67d01db2c5ebb3b6a126aebf4~0rPm3Knt51897018970eucas1p1Z;
        Mon, 14 Sep 2020 14:32:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200914143236eusmtrp1fbdd66f78d44a47ee04fc814c6815fd7~0rPm2Q9Bs1836018360eusmtrp1b;
        Mon, 14 Sep 2020 14:32:36 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-dc-5f5f7f04405f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0F.9B.06314.30F7F5F5; Mon, 14
        Sep 2020 15:32:36 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200914143235eusmtip118a24575f4b6fe3314d94755aa930f1f~0rPl-f5i60253302533eusmtip1c;
        Mon, 14 Sep 2020 14:32:35 +0000 (GMT)
Subject: Re: [PATCH v3 10/16] irqchip/bcm2836: Configure mailbox interrupts
 as standard interrupts
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <3e52be78-1725-a3a2-c97c-625d46017a4b@samsung.com>
Date:   Mon, 14 Sep 2020 16:32:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901144324.1071694-11-maz@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUYRTlm/fNm+fQk89J82YbTCXYollGHxRS0o8XQUUFlS3jlI/JcmOe
        S1agOdEyTJFJVK9h2izNrLGZGreImkpRc2toYRoJW8DCDFJaJKXG1+K/c849h3suXI7RDamj
        uLTMHNGcaUzXs1rsafzRMRcXGgzzur9E045uL0M/X7UhOtT/SEPtFQX0QJkP09qacOp6+1xN
        ffV2lpa8qtbQVz6e1tmb1dTqHWbpzXvHWep2nWJozfkfDD0YWLiUCJ4Gj1qoclQh4aDFxgqO
        qn1CndytES64cgVX5VFWKLrfgYXA87us0N/erhHcZYVCXe2AShhwTV3DJ2uXpIrpaXmiOS4x
        Rbuz5PoznF02cY/n/TFchK5FWFEIByQB5M7vjBVpOR2pQPAw4GYVMohAPuzHChlA0Fd8i/kb
        8V+8q1IG5QjcvTf+RD7/Jm3BSAg3nqRCTaVFE8ThxASd9luaoIkhJRj6mkfY4IAl8WD9ZB3F
        PEmEwa9DyIo4DpOZUF49JShHkG3Q2PIGK5YwaD77bhSHkEVQ9O0sCmKGTAPLnXOMgiPB/+78
        aDsgVzjweWWNUns5dHRdVil4PHxsuv1HnwytpTasBCwIetpvaBRiQ+ArPoMU12IItA+xwXYM
        iQFnfZwiLwN3Q8uoDCQUXn4KU0qEwknPaUaReThySKe4o0Fuuvlv7YPOp8wJpJfHnCaPOUce
        c478f+8FhCtRpJgrZZhEaX6mmB8rGTOk3ExT7I6sDBf6/ZGtI02Dtaj+53YvIhzSj+NT8g0G
        ndqYJxVkeBFwjD6cT2pr3abjU40Fe0VzlsGcmy5KXjSJw/pIfsGlD1t1xGTMEXeLYrZo/jtV
        cSFRRcje+9pfHKntinHYHte3rW6bbV01eVN17Iwc7lroW1Op83BpzeYryYkpvd9WyA+H74xk
        pVk2eyfkq2wNLVvW+tVRdOmLapJUsC5MWuHYmLDh4pNs3DKnJ9mJ1+2958zedTr1J/91Ej7n
        iOCiu9ZYVj517p/eeTWmNJDUuKTvTHjTej2WdhrjZzFmyfgL2M/yjo0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRzFe3bv7q7S4HFu+CSaMRAjcnXVuUfREX2ISxQWfckyt6WXaTln
        u5upQS2tqGXhiASnTYVlpktsw/mSRA5JfEkjycAXKlSIQEvWC2pJTg38dvif8zvwh0MTkrvC
        SDq/0MyZCnUFciqUHF4bmIknr2k0B5trBHhsxk/gb02VAK8s9otwXXMpvu4aJ3FXpxR7ZieE
        eLynjsL2qXYRnhoX4+66QSG2+f9SuO3lfQp7PQ8J3Fm/TOAb08pDkPW98AlZt9MN2BsVlRTr
        dF9hux0zIrbBY2E9LXco1vpqjGSnJ3opdnF0VMR6XdfY7q6AgA14dp8Qn1GkmYwWM7cnz8ib
        0+VnGZygYFKwIiEpRcEkqs6lJijlB9RpuVxBfjFnOqDWKvLsre/JIteuEt/8PdIKnspsIIRG
        MAlNNvYKbCCUlsDHALXOe8lNIwoNVluFmzoc/ZmwUZuhBYBW3o4LgkY4zEVD3wc2QlKoR7MT
        I2QwRMAHJFp6dXPDkMDzyG5zb7RSkEG2hWBTCC2GavTj1wqwAZomYSx60h4dPMtgNhqp/LIV
        CUODNXMbaAhUIevvGhDUBExGTu9nYlPHoIqO2i0dgSbn6gVVQOLYhju2IY5tiGMb0gDIFiDl
        LLxBb+AZBa8z8JZCvSLHaPCA9SH4Xi97u8C756f8ANJAvlOsvazRSIS6Yr7U4AeIJuRS8eE3
        w9kSca6utIwzGTUmSwHH+4Fy/Tc7ESnLMa7PqtCsYZSMCqcwqkRVYjKWR4hvw74sCdTrzNxF
        jiviTP85AR0SaQU21UfF6VX9h6yByEmj4AgTbY6rj1rt79RbXQ2Z2c4e2f5wL/N6+NalhUbR
        wbj5xvR67fHUpa9rx2SP3IHMKr4soUMNd9gX9OVsYMghja0ejE86atS1/QzE5Ozu1TZeGPKF
        Zaxprkr6eiIynHytUn1y9dazJe0ndQmkyvc2yUk+T8fsI0y87h8xuK2wHgMAAA==
X-CMS-MailID: 20200914143236eucas1p17e8849c67d01db2c5ebb3b6a126aebf4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200914143236eucas1p17e8849c67d01db2c5ebb3b6a126aebf4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200914143236eucas1p17e8849c67d01db2c5ebb3b6a126aebf4
References: <20200901144324.1071694-1-maz@kernel.org>
        <20200901144324.1071694-11-maz@kernel.org>
        <CGME20200914143236eucas1p17e8849c67d01db2c5ebb3b6a126aebf4@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 01.09.2020 16:43, Marc Zyngier wrote:
> In order to switch the bcm2836 driver to privide standard interrupts
> for IPIs, it first needs to stop lying about the way things work.
>
> The mailbox interrupt is actually a multiplexer, with enough
> bits to store 32 pending interrupts per CPU. So let's turn it
> into a chained irqchip.
>
> Once this is done, we can instanciate the corresponding IPIs,
> and pass them to the architecture code.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

This one also fails. It breaks booting of Raspberry Pi 3b boards (both 
in ARM and ARM64 mode):

NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = (ptrval)
[00000000] *pgd=80000000004003, *pmd=00000000
Internal error: Oops: 80000206 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc4+ #9166
Hardware name: BCM2835
PC is at 0x0
LR is at irq_percpu_enable+0x40/0x50
pc : [<00000000>]    lr : [<c0274638>]    psr: 600000d3
sp : c1201e00  ip : c1201e18  fp : c1201e14
r10: c0ef23dc  r9 : c120583c  r8 : 00000000
r7 : 00000011  r6 : eb032d00  r5 : 00000000  r4 : eb032d00
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : eb032d18
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment user
Control: 30c5383d  Table: 00003000  DAC: fffffffd
Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
Stack: (0xc1201e00 to 0xc1202000)
...
Backtrace:
[<c02745f8>] (irq_percpu_enable) from [<c0272498>] 
(enable_percpu_irq+0xa4/0xd8)
  r5:c1204ec8 r4:00000000
[<c02723f4>] (enable_percpu_irq) from [<c020ded0>] 
(ipi_setup.part.0+0x3c/0x48)
  r8:c107ba80 r7:00000018 r6:00000011 r5:c1204ee0 r4:00000001
[<c020de94>] (ipi_setup.part.0) from [<c1005684>] 
(set_smp_ipi_range+0xd8/0xf8)
  r5:c1204ee0 r4:00000008
[<c10055ac>] (set_smp_ipi_range) from [<c1023388>] 
(bcm2836_arm_irqchip_l1_intc_of_init+0x1c0/0x22c)
  r8:c1366820 r7:c1204ec8 r6:00000010 r5:00000001 r4:00000000
[<c10231c8>] (bcm2836_arm_irqchip_l1_intc_of_init) from [<c102f28c>] 
(of_irq_init+0x18c/0x2dc)
  r9:00000000 r8:c1201f34 r7:c1204ec8 r6:c1201f2c r5:c1201f2c r4:eb004880
[<c102f100>] (of_irq_init) from [<c1022f4c>] (irqchip_init+0x1c/0x24)
  r10:0000006c r9:00000000 r8:00000000 r7:ffffffff r6:cccccccd r5:c0eb7abe
  r4:c103ba30
[<c1022f30>] (irqchip_init) from [<c1003960>] (init_IRQ+0x30/0x98)
[<c1003930>] (init_IRQ) from [<c1000ebc>] (start_kernel+0x3b4/0x628)
  r5:c0eb7abe r4:c12c1000
[<c1000b08>] (start_kernel) from [<00000000>] (0x0)
  r10:30c5387d r9:410fd034 r8:02600000 r7:00000000 r6:30c0387d r5:00000000
  r4:c1000330
Code: bad PC value
random: get_random_bytes called from init_oops_id+0x30/0x4c with crng_init=0
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---


> ---
>   drivers/irqchip/irq-bcm2836.c | 151 ++++++++++++++++++++++++++++------
>   1 file changed, 125 insertions(+), 26 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

