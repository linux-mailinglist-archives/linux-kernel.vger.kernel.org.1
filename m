Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0287929D70B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgJ1WUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731746AbgJ1WRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from localhost (i15-lef02-th2-89-83-213-3.ft.lns.abo.bbox.fr [89.83.213.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D28F247A8;
        Wed, 28 Oct 2020 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603896999;
        bh=G+4eHaTlr1oso7K1WB9indQYOj4awsZeCRmwhMfptrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giJ4paqw6VXp5JsOpN/I2IyFY+mM1UjwmZP6u9bIQ70hUw+iM7gnucFEzOt8utrqY
         iD/mC1KMnzey/eD8NanN2YQVqSHHv9QjZsMkrNjl3vYfAZO+M0nKV0W5dKfg/Y0Mbp
         OPab+8Vj06cj+F7wdctoX8MKULwMSdKdGzv/58v4=
Date:   Wed, 28 Oct 2020 15:56:37 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v3 5/6] irq_work: Provide irq_work_queue_remote()
Message-ID: <20201028145637.GF229044@lothringen>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.526249871@infradead.org>
 <20201028134046.GE229044@lothringen>
 <20201028145324.GD2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028145324.GD2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 03:53:24PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 28, 2020 at 02:40:46PM +0100, Frederic Weisbecker wrote:
> > On Wed, Oct 28, 2020 at 12:07:12PM +0100, Peter Zijlstra wrote:
> > > While the traditional irq_work relies on the ability to self-IPI, it
> > > makes sense to provide an unconditional irq_work_queue_remote()
> > > interface.
> > 
> > We may need a reason as well here.
> 
> Rewrote it like so.
> ---
> 
> While the traditional irq_work relies on the ability to self-IPI, the
> remote irq_work only requires generic SMP bits and can thus be made
> available unconditionally.

Thanks!
