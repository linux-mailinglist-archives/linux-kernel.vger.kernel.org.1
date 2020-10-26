Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6CE298D53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773331AbgJZMz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:55:28 -0400
Received: from casper.infradead.org ([90.155.50.34]:39218 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772266AbgJZMz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OVC/8ufCPdq+6mgXa8rH1fqWXxtwPmsOC8FTITP0Ogg=; b=lmrPgvmTrlLJY4lFSLK93bv8oi
        lqKNouM/F5wE7yAL6T3q9AWeeewXG7xxnCWF+NkLhH4JdAvWo4OnHK0zDNmL7LJBeXaSidLqfH1yd
        ivFdZbL98R9+66M4jbXnLan8kHsGdt6MYI6ZjYfUYZFc61JyKCISRich3D1H39FkaoyNa1ZA3yByJ
        hqIip4B0CRrzTA/CjPPN5PkcbOmTbxa4iXbNbirMqSrPHkxjfy+gk8htNtb/7hPqY2E+VEljahXND
        lgoMZp0KdI4mGBN8uaqV1AF7LN3LT3wVL2zpG7z/aztbMMkmK51E1sFhTXg32Q/Tv0v6W0obt6DiK
        Oee+t9og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX221-00056D-6h; Mon, 26 Oct 2020 12:55:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A40663006D0;
        Mon, 26 Oct 2020 13:55:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BD3E2141F77F; Mon, 26 Oct 2020 13:55:24 +0100 (CET)
Date:   Mon, 26 Oct 2020 13:55:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201026125524.GP2594@hirez.programming.kicks-ass.net>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
 <0c0d815c-bd5a-ff2d-1417-28a41173f2b4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0d815c-bd5a-ff2d-1417-28a41173f2b4@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:56:03AM +0000, Filipe Manana wrote:
> > That smells like the same issue reported here:
> > 
> >   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
> > 
> > Make sure you have commit:
> > 
> >   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
> > 
> > (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?
> 
> Yes, CONFIG_DEBUG_PREEMPT is enabled.

Bummer :/

> I'll try with that commit and let you know, however it's gonna take a
> few hours to build a kernel and run all fstests (on that test box it
> takes over 3 hours) to confirm that fixes the issue.

*ouch*, 3 hours is painful. How long to make it sick with the current
kernel? quicker I would hope?

> Thanks for the quick reply!

Anyway, I don't think that commit can actually explain the issue :/

The false positive on lockdep_assert_held() happens when the recursion
count is !0, however we _should_ be having IRQs disabled when
lockdep_recursion > 0, so that should never be observable.

My hope was that DEBUG_PREEMPT would trigger on one of the
__this_cpu_{inc,dec}(lockdep_recursion) instance, because that would
then be a clear violation.

And you're seeing this on x86, right?

Let me puzzle moar..
