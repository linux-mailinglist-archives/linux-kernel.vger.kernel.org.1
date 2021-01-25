Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B543330246A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 12:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbhAYLoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 06:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbhAYLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 06:05:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7263AC0617AB;
        Mon, 25 Jan 2021 00:34:47 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:32:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611563524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VIFVgQuhSoz0N+KmK+4I5F5/PH/Pk7UeV0vbUoJKmvI=;
        b=25qqQcYm+u2w9fCKE3kjfxMJK5p8nTKRC2iytjZksLxfdEx0Qp3tKsCDs/0IPsjWbgqd8x
        aFxALdxas1lKhPFlzvTOxsxjQsDK7xgIUxFaXmRIAEfuwJ2QwXLNukRCerEYHg2veO3sJC
        vZuSAhkSvpTcujeyVE+tQ6RGRnAzCA9m3zKWFsQzxFHZiOZRM1ueQ7oiEguZD8NbFiArDU
        Ew1uqnW65/DM+JhDNR5axwSx8KC7GnnYo74e+kTovJ6kdpW01r07iBB3NlGBpnpnAAtfHm
        n9EuckvZUIbawZ55X/1AQ7cBT/SEOmdQjkBYvAdOuSHk8sxq7Mzme9izrckusw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611563524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VIFVgQuhSoz0N+KmK+4I5F5/PH/Pk7UeV0vbUoJKmvI=;
        b=auYeC10UdGYBeTPIZVZZz/GULAnc+AFZzNqJ1vLGywX709bpTFqvnPu1E4RLPY/Gox6I6Q
        tEQDSEnLL3JcSiAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20210125083204.ahddujk5m6njwbju@linutronix.de>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-4-bigeasy@linutronix.de>
 <20210125083012.GD942655@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125083012.GD942655@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-25 08:30:12 [+0000], Christoph Hellwig wrote:
> > +static void blk_mq_complete_send_ipi(struct request *rq)
> > +{
> > +	struct llist_head *list;
> > +	unsigned int cpu;
> > +
> > +	cpu = rq->mq_ctx->cpu;
> > +	list = &per_cpu(blk_cpu_done, cpu);
> > +	if (llist_add(&rq->ipi_list, list)) {
> > +		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> > +		smp_call_function_single_async(cpu, &rq->csd);
> > +	}
> > +}
> 
> Nit: it would be nice to initialize cpu and list in the declaration
> lines.

Why? They get initialized later.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Sebastian
