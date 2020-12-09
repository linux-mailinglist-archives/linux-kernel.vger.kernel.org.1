Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C152D4903
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbgLIS3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgLIS3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:29:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:28:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607538529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/G0px9XqDscrgZxnqctR4DOelbKvcKboOAeKPUSAvA=;
        b=dt8QQERC9EBkIjRbXw+jnAKns/JDX0DJhw+bGqfkSZKs21QSUr9bxsOMCOH5H0BbnOu5q0
        NvHz0r5+twmopMqXIH53hMmZnxkwAztU035bBRw7/T3CFwe7+yaBEIChoEbqTEZseLzIS2
        LSaMk497rAssc0BtmXVzusAU/CuPteoBHIKTsFqMGiV1r+tmLAGYnkk40LL3f6IYe9yaT4
        +A7GdiWUdhsxMrtnlbUhbHCu5X1NlZSdNSfHVYUo/u4VBVgUepXGfiJQm+6J/Dq81jhDUc
        mvrUmH/rk4AcEwkb62WdB8BQZXZc1X/CJhc002K3hyxH1gr/W+3UG4QCBQqFag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607538529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/G0px9XqDscrgZxnqctR4DOelbKvcKboOAeKPUSAvA=;
        b=V9oddA+L1YqKVGDGcoLJ4YY+sLLaYeA6SQbksDx2ccLzboMUc+/6ciSohAV7pgAI+/OlD/
        /ArGFKw9yciVziAQ==
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <maz@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: "irq 4: Affinity broken due to vector space exhaustion." warning on restart of ttyS0 console
In-Reply-To: <20201209063304.GF23060@syu-laptop>
References: <3ba26c8d-04ac-1822-d5c2-4a8906f7fd9a@redhat.com> <871rh1gcck.fsf@nanos.tec.linutronix.de> <20201209063304.GF23060@syu-laptop>
Date:   Wed, 09 Dec 2020 19:28:49 +0100
Message-ID: <87wnxqzvdq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shung-Hsi!

On Wed, Dec 09 2020 at 14:33, Shung-Hsi Yu wrote:
> On Tue, Nov 10, 2020 at 09:56:27PM +0100, Thomas Gleixner wrote:
>> The real problem is irqbalanced aggressively exhausting the vector space
>> of a _whole_ socket to the point that there is not a single vector left
>> for serial. That's the problem you want to fix.
>
> I believe this warning also gets triggered even when there's _no_ vector
> exhaustion.
>
> This seem to happen when the IRQ's affinity mask is set (wrongly) to CPUs on
> a different NUMA node (e.g. cpumask_of_node(1) when the irqd->irq == 0).
>
>   $ lscpu
>   ...
>   NUMA node0 CPU(s):   0-25,52-77
>   NUMA node1 CPU(s):   26-51,78-103
>
>   $ cat /sys/kernel/debug/tracing/trace
>            ...
>     (agetty)-3004    [047] d...    81.777152: vector_activate: irq=4 is_managed=0 can_reserve=1 reserve=0
>     (agetty)-3004    [047] d...    81.777157: vector_alloc: irq=4 vector=0 reserved=1 ret=-22
>     ----------------------------------------> irq_matrix_alloc() failed with
>                                               EINVAL because the cpumask
>                                               passed in is empty, which is a
>                                               result of affmask being
>                                               (ff,ffffc000,000fffff,fc000000)
>                                               and cpumask_of_node(node)
>                                               being
>                                               (00,00003fff,fff00000,03ffffff). 
>
>     (agetty)-3004    [047] d...    81.789349: irq_matrix_alloc: bit=33 cpu=1 online=1 avl=199 alloc=2 managed=1 online_maps=104 global_avl=20688, global_rsvd=341, total_alloc=216
>     (agetty)-3004    [047] d...    81.789351: vector_alloc: irq=4 vector=33 reserved=1 ret=0
>     (agetty)-3004    [047] d...    81.789353: vector_update: irq=4 vector=33 cpu=1 prev_vector=0 prev_cpu=26
>     (agetty)-3004    [047] d...    81.789355: vector_config: irq=4 vector=33 cpu=1 apicdest=0x00000002
>     ----------------------------------------> "irq 4: Affinity broken due to
>                                               vector space exhaustion."
>                                               warning shows up
>

Ok. That's a different story. Nice explanation!

But the fix is not to tone down the warning. The proper fix is to do the
search in the correct order.

Thanks,

        tglx
---
 arch/x86/kernel/apic/vector.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -273,20 +273,24 @@ static int assign_irq_vector_any_locked(
 	const struct cpumask *affmsk = irq_data_get_affinity_mask(irqd);
 	int node = irq_data_get_node(irqd);
 
-	if (node == NUMA_NO_NODE)
-		goto all;
-	/* Try the intersection of @affmsk and node mask */
-	cpumask_and(vector_searchmask, cpumask_of_node(node), affmsk);
-	if (!assign_vector_locked(irqd, vector_searchmask))
-		return 0;
-	/* Try the node mask */
-	if (!assign_vector_locked(irqd, cpumask_of_node(node)))
-		return 0;
-all:
+	if (node != NUMA_NO_NODE) {
+		/* Try the intersection of @affmsk and node mask */
+		cpumask_and(vector_searchmask, cpumask_of_node(node), affmsk);
+		if (!assign_vector_locked(irqd, vector_searchmask))
+			return 0;
+	}
+
 	/* Try the full affinity mask */
 	cpumask_and(vector_searchmask, affmsk, cpu_online_mask);
 	if (!assign_vector_locked(irqd, vector_searchmask))
 		return 0;
+
+	if (node != NUMA_NO_NODE) {
+		/* Try the node mask */
+		if (!assign_vector_locked(irqd, cpumask_of_node(node)))
+			return 0;
+	}
+
 	/* Try the full online mask */
 	return assign_vector_locked(irqd, cpu_online_mask);
 }
