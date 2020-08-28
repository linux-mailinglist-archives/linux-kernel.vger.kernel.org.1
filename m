Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE1255883
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgH1K1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 06:27:36 -0400
Received: from foss.arm.com ([217.140.110.172]:46004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbgH1K13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:27:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8906331B;
        Fri, 28 Aug 2020 03:27:28 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3BB3F68F;
        Fri, 28 Aug 2020 03:27:27 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:27:25 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     vincent.donnefort@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/20 10:00, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> rq->cpu_capacity is a key element in several scheduler parts, such as EAS
> task placement and load balancing. Tracking this value enables testing
> and/or debugging by a toolkit.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h

[...]

> +int sched_trace_rq_cpu_capacity(struct rq *rq)
> +{
> +	return rq ?
> +#ifdef CONFIG_SMP
> +		rq->cpu_capacity
> +#else
> +		SCHED_CAPACITY_SCALE
> +#endif
> +		: -1;
> +}
> +EXPORT_SYMBOL_GPL(sched_trace_rq_cpu_capacity);
> +

The placement of this #ifdef looks odd to me. But FWIW

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Cheers

--
Qais Yousef
