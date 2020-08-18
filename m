Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB804248B85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgHRQ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:26:08 -0400
Received: from verein.lst.de ([213.95.11.211]:34191 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbgHRQZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:25:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7089568B02; Tue, 18 Aug 2020 18:25:42 +0200 (CEST)
Date:   Tue, 18 Aug 2020 18:25:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
Message-ID: <20200818162542.GB27196@lst.de>
References: <20200818105102.926463950@infradead.org> <20200818112418.460474861@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818112418.460474861@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:51:10PM +0200, Peter Zijlstra wrote:
> Convert the performance sensitive users of
> smp_call_single_function_async() over to the new
> irq_work_queue_remote_static().
> 
> The new API is marginally less crap but taking these users away allows
> fixing up smp_call_single_function_async() without risk of performance
> regressions.

You probably want a conversion patch per subsystem so that it sticks
out.  What is so crap about this API?  How could we as subsystem
maintainers help to make it less crappy?
