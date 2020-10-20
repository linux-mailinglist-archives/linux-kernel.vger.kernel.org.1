Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C842935A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404957AbgJTHWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbgJTHWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:22:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D9CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xhw3H2QX3tICj9sxZ/ux9knj+Ltjn7roSmeWowve6X0=; b=qk/y7e0HKfalmfo609rXDu6iyF
        XwpzCEQ9uETNrLkSMxq4hFjkOFEdOhPGMcBJMdzFWpZy/HLblXg5maY9yRWzSZSjw2ltBPcqCjvIo
        VsGI+BsBkaq2QH62qs+ybi5CicrWlwK/untRW0wImlNsX+KH3nogc+PGaC13cc/o7kEbUakrOa1ng
        f+tZd1SCqfJwJRzISBToQByzGYXz/cdVgIrGFKXovrG3bKErIZOZXBKdY1EkQc8BS0sDCxAQ7mN8U
        svwdjMgWdPJO5vfAp6o4BdR0ytetvoHTBcYmlhAxZWl2EPfuYaZof593IJ4boKzhAny8ow29BqMry
        rJwnKwBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUly4-0002yq-S3; Tue, 20 Oct 2020 07:22:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45D773011FE;
        Tue, 20 Oct 2020 09:22:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29A3920593806; Tue, 20 Oct 2020 09:22:00 +0200 (CEST)
Date:   Tue, 20 Oct 2020 09:22:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/2] sched/cpupri: Remap CPUPRI_NORMAL to MAX_RT_PRIO-1
Message-ID: <20201020072200.GX2611@hirez.programming.kicks-ass.net>
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
 <20201014194858.GC2974@worktop.programming.kicks-ass.net>
 <20388bee-9534-3ca0-4916-0bd0b9852189@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20388bee-9534-3ca0-4916-0bd0b9852189@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 04:14:16PM +0200, Dietmar Eggemann wrote:
> On 14/10/2020 21:48, Peter Zijlstra wrote:
> 
> [...]
> 
> > +	switch (prio) {
> > +	case CPUPRI_INVALID:
> > +		cpupri = CPUPRI_INVALID;	/* -1 */
> > +		break;
> > +
> > +	case 0...98:
> 
> kernel/sched/cpupri.c:54:7: error: too many decimal points in number
>    54 |  case 0...98:
>       |       ^~~~~~
> 
> There need to be spaces around the ellipses.
> 
> Otherwise LGTM.

Yah, some robot already told me. Fix this already in the queue.git
version. Thanks for looking at it though.
