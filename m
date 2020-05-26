Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E261B6E46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgDXGmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 02:42:11 -0400
Received: from verein.lst.de ([213.95.11.211]:33378 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgDXGmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:42:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12ED568CEC; Fri, 24 Apr 2020 08:42:07 +0200 (CEST)
Date:   Fri, 24 Apr 2020 08:42:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Salman Qazi <sqazi@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] block: Limit number of items taken from the I/O
 scheduler in one go
Message-ID: <20200424064206.GA23666@lst.de>
References: <20200423210523.52833-1-sqazi@google.com> <20200424061529.GA23303@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424061529.GA23303@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 08:15:29AM +0200, Christoph Hellwig wrote:
> This is a weird loop.  I'd split the code betweem the again label and
> the run_again check here into a __blk_mq_sched_dispatch_requests
> helper, and then you can do:
> 
> 	if (__blk_mq_sched_dispatch_requests()) {
> 		if (__blk_mq_sched_dispatch_requests())
> 			blk_mq_run_hw_queue(hctx, true);
> 	}
> 
> here.  Preferably with ha good comment explaining the logic.

Also I wonder if inverting the return values in the lower level function
would make things a little more readable - a true return suggests
everything worked fine.  Alternative 0 for sucess and -EAGAIN for needs
a retry also would be pretty self-documenting.
