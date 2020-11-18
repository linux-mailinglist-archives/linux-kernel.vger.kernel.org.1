Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1349F2B7F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKROGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:06:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55180 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgKROGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:06:42 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605708400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1N0GlT9qGCH138D8dJlcQap/AW6+MhR4g7lQ7s8KPno=;
        b=KCSyH8t1qdlbMXeHEAARFAgZbiAO6VVK2D/Bv/V42Ioxv8+TX5exFjmYNJm45jbReXynKO
        bph6r1/gKxm0wuPFTAtUplJdD56orlArlgl1obGvObqtRnWNJ2b0dNQZkhcPC4njsD52NR
        1FRqsKeRZ8jTkps+Df0/Y6YK44zlGNC8BYmwH01CCLe4C+KevZRpxXn0fiajaj6R2uuckn
        USrqRTQ4ncxmkaU7VixJijnj3TAHNuTnH1cA4DqBmccJfYlXy9/rF7hXzZiW6+ONoXWIwn
        SnIPUnB0WbHo0dGRSUP+/1Zr9p7QJVx3jmJOBLn6Go1Q8qouO+7+6biJA/kZzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605708400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1N0GlT9qGCH138D8dJlcQap/AW6+MhR4g7lQ7s8KPno=;
        b=C53Iwz+qVWuEvpPZzaHzsZhOFzqn5+HQZ7qXcvpNgGHUwyfSZgvqhXcy5fuEXz/KPQ9UNt
        GJHbQCDzIZTBFbAw==
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
In-Reply-To: <79d2e4ee-bfe1-7e86-6f35-f6fda1ce17fa@amd.com>
References: <20201024213535.443185-20-dwmw2@infradead.org>
 <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com>
 <87a6vpgqbt.fsf@nanos.tec.linutronix.de>
 <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com>
 <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org>
 <877dqtgkzb.fsf@nanos.tec.linutronix.de>
 <874klxghwu.fsf@nanos.tec.linutronix.de>
 <45B3C20C-3BBB-40F3-8A7B-EB20EDD0706F@infradead.org>
 <87y2j9exk2.fsf@nanos.tec.linutronix.de>
 <8C2E184C-D069-4C60-96B5-0758FBC6E402@infradead.org>
 <d4115cc7-3876-e012-b6ec-c525d608834f@amd.com>
 <87tutwg76j.fsf@nanos.tec.linutronix.de>
 <5c86570ce3bedb90514bc1e73b96011660f520b0.camel@infradead.org>
 <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
 <6b44a048de974fb6e2ecb5bf688c122b3107537d.camel@infradead.org>
 <20d99e1f359b448d042d27112e55f8070bf460bb.camel@infradead.org>
 <13f8cb3c-713e-c26e-b2ef-4700f9f6ceac@amd.com>
 <05e3a5ba317f5ff48d2f8356f19e617f8b9d23a4.camel@infradead.org>
 <c2361f78-b739-2f71-562b-d2c5f20825e7@amd.com>
 <79d2e4ee-bfe1-7e86-6f35-f6fda1ce17fa@amd.com>
Date:   Wed, 18 Nov 2020 15:06:39 +0100
Message-ID: <877dqirc7k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suravee,

On Wed, Nov 18 2020 at 17:29, Suravee Suthikulpanit wrote:
> On 11/17/20 9:00 AM, Suravee Suthikulpanit wrote:
>
> I might need your help debugging this issue. I'm seeing the following error:
>
> [   14.005937] irq 29, desc: 00000000d200500b, depth: 0, count: 0, unhandled: 0
> [   14.006234] ->handle_irq():  00000000eab4b6eb, handle_bad_irq+0x0/0x230
> [   14.006234] ->irq_data.chip(): 000000001cce6d6b, intcapxt_controller+0x0/0x120
> [   14.006234] ->action(): 0000000083bfd734
> [   14.006234] ->action->handler(): 0000000094806345, amd_iommu_int_handler+0x0/0x10
> [   14.006234] unexpected IRQ trap at vector 1d
>
> Do you have any idea what might have gone wrong here?

Yes. This lacks setting up the low level flow handler. Delta patch
below.

Thanks,

        tglx
---
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2033,6 +2033,7 @@ static int intcapxt_irqdomain_alloc(stru
 
 		irqd->chip = &intcapxt_controller;
 		irqd->chip_data = info->data;
+		__irq_set_handler(i, handle_edge_irq, 0, "edge");
 	}
 
 	return ret;
