Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416892D710C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 08:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436799AbgLKHqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 02:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388543AbgLKHqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 02:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607672677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AkXWisn5lwTYRJhef3Gdd38GlHG5+xj5Euc6lWI1feE=;
        b=SpSf/POvX2WqmND1gukldnK0yz22EIRcH8FNIRL5Ep/qqW92nDcD9x4S5VdnaLXSZt1GrW
        4sIbJtA8w6haVP5aO45GkD6CLfM6s/xQVj5HOYk8PM/z27GXkIllUgw1RIjEkkPkM8z6LV
        uLBvW957MgCU1UeV/X30s9iHnboa49k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-fSaZ9C4IN7qFFTDVksh1Zw-1; Fri, 11 Dec 2020 02:44:33 -0500
X-MC-Unique: fSaZ9C4IN7qFFTDVksh1Zw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 728E310054FF;
        Fri, 11 Dec 2020 07:44:32 +0000 (UTC)
Received: from T590 (ovpn-13-178.pek2.redhat.com [10.72.13.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C575A6F44D;
        Fri, 11 Dec 2020 07:44:19 +0000 (UTC)
Date:   Fri, 11 Dec 2020 15:44:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] x86/apic/vector: Fix ordering in vector assignment
Message-ID: <20201211074415.GA1535580@T590>
References: <87ft4djtyp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft4djtyp.fsf@nanos.tec.linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 09:18:22PM +0100, Thomas Gleixner wrote:
> Prarit reported that depending on the affinity setting the
> 
>  ' irq $N: Affinity broken due to vector space exhaustion.'
> 
> message is showing up in dmesg, but the vector space on the CPUs in the
> affinity mask is definitely not exhausted.
> 
> Shung-Hsi provided traces and analysis which pinpoints the problem:
> 
> The ordering of trying to assign an interrupt vector in
> assign_irq_vector_any_locked() is simply wrong if the interrupt data has a
> valid node assigned. It does:
> 
>  1) Try the intersection of affinity mask and node mask
>  2) Try the node mask
>  3) Try the full affinity mask
>  4) Try the full online mask
> 
> Obviously #2 and #3 are in the wrong order as the requested affinity
> mask has to take precedence.
> 
> In the observed cases #1 failed because the affinity mask did not contain
> CPUs from node 0. That made it allocate a vector from node 0, thereby
> breaking affinity and emitting the misleading message.
> 
> Revert the order of #2 and #3 so the full affinity mask without the node
> intersection is tried before actually affinity is broken.
> 
> If no node is assigned then only the full affinity mask and if that fails
> the full online mask is tried.
> 
> Fixes: d6ffc6ac83b1 ("x86/vector: Respect affinity mask in irq descriptor")
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Reported-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/kernel/apic/vector.c |   24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -273,20 +273,24 @@ static int assign_irq_vector_any_locked(
>  	const struct cpumask *affmsk = irq_data_get_affinity_mask(irqd);
>  	int node = irq_data_get_node(irqd);
>  
> -	if (node == NUMA_NO_NODE)
> -		goto all;
> -	/* Try the intersection of @affmsk and node mask */
> -	cpumask_and(vector_searchmask, cpumask_of_node(node), affmsk);
> -	if (!assign_vector_locked(irqd, vector_searchmask))
> -		return 0;
> -	/* Try the node mask */
> -	if (!assign_vector_locked(irqd, cpumask_of_node(node)))
> -		return 0;
> -all:
> +	if (node != NUMA_NO_NODE) {
> +		/* Try the intersection of @affmsk and node mask */
> +		cpumask_and(vector_searchmask, cpumask_of_node(node), affmsk);
> +		if (!assign_vector_locked(irqd, vector_searchmask))
> +			return 0;
> +	}
> +
>  	/* Try the full affinity mask */
>  	cpumask_and(vector_searchmask, affmsk, cpu_online_mask);
>  	if (!assign_vector_locked(irqd, vector_searchmask))
>  		return 0;
> +
> +	if (node != NUMA_NO_NODE) {
> +		/* Try the node mask */
> +		if (!assign_vector_locked(irqd, cpumask_of_node(node)))
> +			return 0;
> +	}
> +
>  	/* Try the full online mask */
>  	return assign_vector_locked(irqd, cpu_online_mask);
>  }
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

