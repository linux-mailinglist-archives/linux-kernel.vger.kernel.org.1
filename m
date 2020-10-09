Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0992886A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgJIKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbgJIKOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:14:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE917C0613D4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=41G919/IDE6Dv+b4JHmasARImUNHzPwDNY0svliXrek=; b=UDm9MhNS7Z1ihWN9Kp3GphpXuN
        bXkVs+PRnP52IDnuKFmr/a/sgrvO7O3an7fY+JW947eb/IJYfWnVugNKE3VYXOHomiBtspBMCq9xo
        N5rth3PFFri+Ce8m0+hgiXn2XT8piTmll9koYH/Rlem3uNVoGRyTInbIqI8ONp8ZEXJIqdmQYqC/3
        KoOH8nN/CPJ8a2y86iAp/wiYu9+MSJU6GfC1Z3TADzSvcVa2QZ4AzI//0Wwk2qQGb3luBhguIsBWI
        s17R+vPe3t2WIkDJCiXTGxTFrzmLYpvvVVHUpdKw4PjGbaa/VtkOa0WSBCWBdUFQHHqjM7ecGzFfQ
        Yagc8zVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQpQ3-0006wd-58; Fri, 09 Oct 2020 10:14:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FDCD3056DE;
        Fri,  9 Oct 2020 12:14:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8317820DB441C; Fri,  9 Oct 2020 12:14:31 +0200 (CEST)
Date:   Fri, 9 Oct 2020 12:14:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009101431.GJ2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009091218.GF4967@dhcp22.suse.cz>
 <20201009094245.GG2628@hirez.programming.kicks-ass.net>
 <20201009101044.GH4967@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009101044.GH4967@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 12:10:44PM +0200, Michal Hocko wrote:
> On Fri 09-10-20 11:42:45, Peter Zijlstra wrote:
> > On Fri, Oct 09, 2020 at 11:12:18AM +0200, Michal Hocko wrote:
> > > Is there any additional feedback? Should I split up the patch and repost
> > > for inclusion?
> > 
> > Maybe remove PREEMPT_NONE after that?  Since that's then equivalent to
> > building with VOLUNTARY and booting with preempt=none.
> 
> So do you mean that I should post an additional patch which does this on
> top? With a justification that there is one option less to chose from?

Exactly!
