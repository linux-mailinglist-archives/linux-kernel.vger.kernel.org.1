Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B834A2B0E63
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKLTlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:41:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbgKLTlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605210110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B23U3gg95JNs9PQEfTQosUDSG0cp4zCcIfz1B+t7gA8=;
        b=ffnPr5rR8bGRpIjBZPoSLXOpDYtU2xDi0Aq0jjnveDVwzpxg91s/352wgfeDYFGvZ4BasT
        ge7KSLcB1MZjrgRT2//vvgdplprgxIQvQBh5KPEeK8EtMQccylRrYvYf3MhP8fe0+q5453
        GK5YLxw87+0HiZxxuojjhnW+H1NF+xQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-FeSgfCcVP_mA90IFEUIXbQ-1; Thu, 12 Nov 2020 14:41:46 -0500
X-MC-Unique: FeSgfCcVP_mA90IFEUIXbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0244803625;
        Thu, 12 Nov 2020 19:41:43 +0000 (UTC)
Received: from ovpn-66-145.rdu2.redhat.com (ovpn-66-145.rdu2.redhat.com [10.10.66.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C0905B4B2;
        Thu, 12 Nov 2020 19:41:35 +0000 (UTC)
Message-ID: <a61baa42fbb5a5d7bcc167589c856e34b68b431c.camel@redhat.com>
Subject: Re: [PATCH v4 10/19] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
From:   Qian Cai <cai@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Date:   Thu, 12 Nov 2020 14:41:34 -0500
In-Reply-To: <jhja6vmxthb.mognet@arm.com>
References: <20201023101158.088940906@infradead.org>
         <20201023102346.921768277@infradead.org>
         <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
         <jhjd00ixz9z.mognet@arm.com>
         <13786aa5a5fc958708ef1182c885d1a574449d99.camel@redhat.com>
         <jhja6vmxthb.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-12 at 19:31 +0000, Valentin Schneider wrote:
> One thing I don't get: that trace shows refcount_dec_and_test()
> (kernel/sched/core.c:2263) happening before the wait_for_completion(). It's
> not the case in the below trace.

Yes, that is normal. Sometimes, the decoding is a bit off not sure because of
some debugging options like KASAN obscures it.

> a) Do you also get this on CONFIG_PREEMPT=y?

I don't know. None of the systems here has that, but I could probably try.

> b) Could you try the below?

Let me run it and report.

> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 02076e6d3792..fad0a8e62aca 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1923,7 +1923,7 @@ static int migration_cpu_stop(void *data)
>  		else
>  			p->wake_cpu = dest_cpu;
>  
> -	} else if (dest_cpu < 0) {
> +	} else if (dest_cpu < 0 || pending) {
>  		/*
>  		 * This happens when we get migrated between migrate_enable()'s
>  		 * preempt_enable() and scheduling the stopper task. At that
> @@ -1933,6 +1933,17 @@ static int migration_cpu_stop(void *data)
>  		 * more likely.
>  		 */
>  
> +		/*
> +		 * The task moved before the stopper got to run. We're holding
> +		 * ->pi_lock, so the allowed mask is stable - if it got
> +		 * somewhere allowed, we're done.
> +		 */
> +		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
> +			p->migration_pending = NULL;
> +			complete = true;
> +			goto out;
> +		}
> +
>  		/*
>  		 * When this was migrate_enable() but we no longer have an
>  		 * @pending, a concurrent SCA 'fixed' things and we should be
> 

