Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3373C262986
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 10:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgIIIFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 04:05:53 -0400
Received: from verein.lst.de ([213.95.11.211]:56254 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730079AbgIIIDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:03:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FC0468B02; Wed,  9 Sep 2020 10:03:37 +0200 (CEST)
Date:   Wed, 9 Sep 2020 10:03:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     peterz@infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        will@kernel.org, paulmck@kernel.org, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
Message-ID: <20200909080336.GA12376@lst.de>
References: <20200818105102.926463950@infradead.org> <20200818112418.460474861@infradead.org> <20200820061927.GA6447@lst.de> <20200820134001.GV2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820134001.GV2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 03:40:01PM +0200, peterz@infradead.org wrote:
> Anyway, tl;dr, what do we actually want? Do we favour the embedded
> irq_work variant over smp_call_function_single_asyn() ?

For blk-mq we really like an embedded structure that allows to bounce
the work to another CPU using IPIs.

> There's a few subtle differences, where smp_call_function_single_async()
> will directly call @func when @cpu == smp_processor_id(),
> irq_work_remote will give you WARN -- since irq_work to the local CPU is
> defined as a self-IPI, which isn't implemented on all architectures and
> is a distinctly different behaviour.

For the block code we handle the self case explicitly as it allows us
to optimize further and avoid an indirect call.  That being said we
don't do a preempt_disable for that any more, as completing on the
"wrong" CPU for a just migrated completion handler is at worst a
performance degration but not a functional issue.  So instead of the
warn we'd at least like an error return that allows to directly call
the completion handler.
