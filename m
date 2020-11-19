Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D92B9A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgKSS3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgKSS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:29:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4LIkeskhd935eUwqijtsoAM0pfoT4xJqUA6L3kxJuH8=; b=QHiwHIIeWOa4GXy2EfG3PvLNfv
        El4CyX0m4VRDLmmHgs/MqsjjtO1m76j94PU7c8Roomj2tZJPPIq+kD5nM78g6OBFOE7iYRAjt9jQ2
        mWUEXSOPUKVSwO0bWj7RnXzIzrtR80Edx0Wx1oMc8OdT4hPo6Eqwh1nfCP7QwDF34ZyF0hp24olZW
        kvSUIBxwEFDXRusQdYPgqZbsPzEjJqVmmh07Ybjrtp7UuqVAcu5CWzTZv9WKH+3pYu+RoopPDWn70
        lu95GTGwxvNIVK31Qi/DPM8usTa0FvB2TTjPBTMj2ABok+EBoCk3b5EcRwpqBd2I/slfTs7/yShUj
        5zknQSMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfofo-0008Bj-6o; Thu, 19 Nov 2020 18:28:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B03FC3060AE;
        Thu, 19 Nov 2020 19:28:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E27E20234C36; Thu, 19 Nov 2020 19:28:43 +0100 (CET)
Date:   Thu, 19 Nov 2020 19:28:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent
 of RT
Message-ID: <20201119182843.GA2414@hirez.programming.kicks-ass.net>
References: <20201118194838.753436396@linutronix.de>
 <20201118204007.269943012@linutronix.de>
 <20201119093834.GH3306@suse.de>
 <20201119111411.GL3121378@hirez.programming.kicks-ass.net>
 <CAHk-=wire3dzhHx=KiL_f5Rj0=1u9ustsa33QoR-F9-v-NU9Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wire3dzhHx=KiL_f5Rj0=1u9ustsa33QoR-F9-v-NU9Ng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:23:47AM -0800, Linus Torvalds wrote:
> On Thu, Nov 19, 2020 at 3:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > I still hate all of this, and I really fear that with migrate_disable()
> > available, people will be lazy and usage will increase :/
> >
> > Case at hand is this series, the only reason we need it here is because
> > per-cpu page-tables are expensive...
> 
> No, I think you as a scheduler person just need to accept it.

Well, I did do write the patches.

> Because this is certainly not the only time migration limiting has
> come up, and no, it has absolutely nothing to do with per-cpu page
> tables being completely unacceptable.

It is for this instance; but sure, it's come up before in other
contexts.

> The scheduler people need to get used to this. Really. Because ASMP is
> just going to be a fact.

ASMP is different in that it is a hardware constraint, you're just not
going to be able to run more of X than there's X capable hardware units
on (be if FPUs, Vector units, 32bit or whatever)

> There are few things more futile than railing against reality, Peter.

But, but, my windmills! :-)

> Honestly, the only argument I've ever heard against limiting migration
> is the whole "our scheduling theory doesn't cover it".
> 
> So either throw the broken theory away, or live with it. Theory that
> doesn't match reality isn't theory, it's religion.

The first stage of throwing it out is understanding the problem, which
is just about where we're at. Next is creating a new formalism (if
possible) that covers this new issue. That might take a while.

Thing is though; without a formalism to reason about timeliness
guarantees, there is no Real-Time.

So sure, I've written the patches, doesn't mean I have to like the place
we're in due to it.
