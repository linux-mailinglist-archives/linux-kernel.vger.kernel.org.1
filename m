Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8396B2CA32B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391042AbgLAMu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:50:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:33688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389263AbgLAMu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:50:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606826982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBFHb/HGCw5HLKcQo//54wObYejkH5zsQzmJIUfBbac=;
        b=hDTKSNF4dgx9ZjzgDwcWgcaO/vK5Jpw+Hy1cNLLkkZ+SjrUsOG5tSZbApzMIxAo/0kGy4h
        EqrDdfBm3mq34u2l6MEavDsLm1mZbGsrxg4W4n6nZKadJxazeI2v3VLsoockBhpfsdr3Wx
        q0+Rricx0l0YkyUIqpSicB3aP72CN/Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10E83ACC1;
        Tue,  1 Dec 2020 12:49:42 +0000 (UTC)
Date:   Tue, 1 Dec 2020 13:49:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <X8Y75VZ8XXSZ3Wgr@alley>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
 <20201130030828.GA1363814@tassilo.jf.intel.com>
 <20201130173842.GB26693@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130173842.GB26693@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-11-30 12:38:43, Paul Gortmaker wrote:
> [Re: [PATCH 0/3] clear_warn_once: add timed interval resetting] On 29/11/2020 (Sun 19:08) Andi Kleen wrote:
> 
> > On Thu, Nov 26, 2020 at 01:30:26AM -0500, Paul Gortmaker wrote:
> > > But you currently can't make use of clear_warn_once unless you've got
> > > debugfs enabled and mounted - which may not be desired by some people
> > > in some deployment situations.
> > 
> > Seems awfully special purpose. The problem with debugfs is security,
> > or is it no convenient process that could do cron like functionality? 
> 
> My understanding is that it is a bit of both.  As users of rt tasks,
> they won't be running anything like cron that could add to OS jitter on
> the (presumably minimal) rootfs - so they were looking for a clean
> engineered solution with near zero overhead, that they could easily
> deploy on all nodes after the rt tuning was 99% completed and node
> images had been bundled.  Just to be sure everything was operating as
> they'd aimed to achieve.

Is this feature requested by RT people?
Or is it just a possible use-case?

I am not sure that RT is a really good example. The cron job is only
part of the problem. The message would create a noise on its own.
It would be shown on console or read/stored by a userspace log
daemon. I am not sure that RT people would really want to use this.

That said, I still do not have strong opinion about the feature.
It might make sense on its own. But I still see it as a workaround
for another problem.

Non-trivial periodic tasks sometimes cause problems. And we do not
know how big avalanche of messages it might restart.

Also the once is sometimes used on purpose. It prevents repeated delays
on fast paths. I wonder if it can sometimes even prevent recursion.

I know that everything is possible already now. But this patchset
makes it more visible and easier to use.

Best Regards,
Petr
