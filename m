Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23BA24AF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 08:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHTGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 02:20:29 -0400
Received: from verein.lst.de ([213.95.11.211]:40836 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgHTGU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:20:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 378DF68BEB; Thu, 20 Aug 2020 08:20:25 +0200 (CEST)
Date:   Thu, 20 Aug 2020 08:20:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
Message-ID: <20200820062024.GB6447@lst.de>
References: <20200818105102.926463950@infradead.org> <20200818112418.460474861@infradead.org> <20200818162542.GB27196@lst.de> <20200819072209.GU2674@hirez.programming.kicks-ass.net> <CAHk-=wgMATDQQxLSsgmxCoCqApVXVeRnGOf6iWjnYdTJY_R3aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMATDQQxLSsgmxCoCqApVXVeRnGOf6iWjnYdTJY_R3aw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:50:55AM -0700, Linus Torvalds wrote:
> On Wed, Aug 19, 2020 at 12:22 AM <peterz@infradead.org> wrote:
> >
> > That is, the external serialization comes from the non-atomic
> > test-and-set they both have. This works nicely when there is external
> > state that already serializes things, but totally comes apart (and
> > causes trivial list corruption) when you get it wrong.
> 
> Quite often, there just isn't any *need* for serialization, because
> there is only ever one op active.

Yes, that's pretty much the block use case.  The request gets completed
once, and and the IPI is used to bounce it back to the issuing cpu.
