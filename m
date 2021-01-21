Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA02FECB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbhAUOQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbhAUOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:15:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 06:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kkZoVMI8wUStGleFdEU/MPC3jyb8xZnP+NsWwxV31bQ=; b=on1Mp5P7+YomwsO9dYXvJde88E
        txFMu0q6bX+bQHXAhy44PZcKNo0DM4KHtooPCFPu0McTAmMYywsxov8lMphU1ZITq+InqOcOnsqkq
        P0LRTrpqf601qzAzfmbQNChUSkxXWtRno9ZiHWYw+mKX+yygV2YvLYImigjMMwzvN8jhC8X16KLew
        cp9ItVvaUJT5cEZTstDu4m7z3unrZtOMmpIBOM86gOzNRScOw4Ro9iAN673/cAAqzYqTPxC2eUf+y
        Wd65mlxBm/DF9e/ltPvcEzsiv+gVEa+c06vATjoRCWSuN6tu2l6N4N9wW/aEK8xQvTbWNz5JNokpZ
        l6q4CD5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2aiq-00H8WT-HQ; Thu, 21 Jan 2021 14:14:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9F893003E1;
        Thu, 21 Jan 2021 15:14:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B04542028D525; Thu, 21 Jan 2021 15:14:02 +0100 (CET)
Date:   Thu, 21 Jan 2021 15:14:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, cai@redhat.com, vincent.donnefort@arm.com,
        decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH -v3 3/9] sched: Dont run cpu-online with balance_push()
 enabled
Message-ID: <YAmMKoBnIdgsM4wG@hirez.programming.kicks-ass.net>
References: <20210121101702.402798862@infradead.org>
 <20210121103506.415606087@infradead.org>
 <jhjft2umlte.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjft2umlte.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:00:45PM +0000, Valentin Schneider wrote:
> On 21/01/21 11:17, Peter Zijlstra wrote:
> > @@ -7608,6 +7614,12 @@ int sched_cpu_dying(unsigned int cpu)
> >       }
> >       rq_unlock_irqrestore(rq, &rf);
> >
> > +	/*
> > +	 * Should really be after we clear cpu_online(), but we're in
> > +	 * stop_machine(), so it all works.
> > +	 */
> 
> I believe you noted yourself in some earlier version that this *is* running
> with cpu_online(cpu) == false, __cpu_disable() being invoked before the
> _DYING .teardown callbacks are run.

Argh! lemme go fix that comment.
