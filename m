Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E207F29D362
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgJ1VnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:43:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57598 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgJ1VnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7MYNhBmFxSQONbBnQ8o6/ByUMEEsDa2VGap2UvkJPEM=; b=LwpKqW/5sGeV2IJG66u8QpMmgp
        5iGneiI3pUQrQeB7HPoBjuNTTCykmDof4knO5zf57rLmWh2eXH034PD1GQoxmLHQsWvM2M6+qPn6l
        MqvJi15Wj/n11N/88rhCQh+6NNl6Y858v7aKbj23s7NKkV19WRRqHH98sjx4i0oS2pGi7/CK88eSX
        /BPPhihQ1Qs4uzsSlz7+1s4c4YGw4Y+psO5n8qyoPLnyPiIXrO6PYOiI8odMhQxrPqd9sJQLcKMSK
        ei89Z3VQ6fpU0MYEss1bx8G1opK58y8ZUhPR4WdX0siWttbtIYnXAnQhwnXZa92/xU6WcmMFltJrn
        cUERPLcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXmpK-0005o2-0H; Wed, 28 Oct 2020 14:53:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8DCB83006D0;
        Wed, 28 Oct 2020 15:53:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66C2E2B064B32; Wed, 28 Oct 2020 15:53:24 +0100 (CET)
Date:   Wed, 28 Oct 2020 15:53:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v3 5/6] irq_work: Provide irq_work_queue_remote()
Message-ID: <20201028145324.GD2628@hirez.programming.kicks-ass.net>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.526249871@infradead.org>
 <20201028134046.GE229044@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028134046.GE229044@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:40:46PM +0100, Frederic Weisbecker wrote:
> On Wed, Oct 28, 2020 at 12:07:12PM +0100, Peter Zijlstra wrote:
> > While the traditional irq_work relies on the ability to self-IPI, it
> > makes sense to provide an unconditional irq_work_queue_remote()
> > interface.
> 
> We may need a reason as well here.

Rewrote it like so.
---

While the traditional irq_work relies on the ability to self-IPI, the
remote irq_work only requires generic SMP bits and can thus be made
available unconditionally.
