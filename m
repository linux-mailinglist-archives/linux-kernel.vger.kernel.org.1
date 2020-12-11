Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19F2D758C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405437AbgLKM1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:27:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390375AbgLKM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607689494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJl5hEzN0y59Vtw87cxNPpF86WC4d2s1wMxA3PvngTY=;
        b=QkF7/TAu+9MaJ57Au/MC5dEtDIBw42E1JkMSJiNI4vLDIwlZ3CMYngEE0E8TN9d8E41v48
        M6xwVzaPA9WVYU0gbhfUMu/5m7ELiqt6oQzgGYmwOOKbspAJCgFzTIdmaGy4cCjsJGUpbf
        WACDgdz+r0aiqL0cQlhPKKjb13UnApU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-N81QwZVPP1C0LtTBqbC3nw-1; Fri, 11 Dec 2020 07:24:52 -0500
X-MC-Unique: N81QwZVPP1C0LtTBqbC3nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4683E10082EE;
        Fri, 11 Dec 2020 12:24:51 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9A1C5F9A6;
        Fri, 11 Dec 2020 12:24:50 +0000 (UTC)
Subject: Re: [PATCH] x86/apic/vector: Fix ordering in vector assignment
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>
References: <87ft4djtyp.fsf@nanos.tec.linutronix.de>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <c5bb2239-dd40-03b2-d9d7-dace7499172d@redhat.com>
Date:   Fri, 11 Dec 2020 07:24:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ft4djtyp.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/20 3:18 PM, Thomas Gleixner wrote:
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

Tested-and-Reviewed-by: Prarit Bhargava <prarit@redhat.com>

P.

