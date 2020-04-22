Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7FA1B48ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 17:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDVPjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 11:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDVPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:39:43 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07822C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FoLUof5mdWUo8b+92mC8LHdFdzDhi/CgXbqz2mqJj/U=; b=WDwPpELfKA5q/XesRT5H2w8UCz
        9qhy6l4xRkAZKXTtdIk2VwFSjMuswZzkPG+1D0SeqZP3asQhp7pzTQ34Ey0KvpSS54R9Tdi94KGNH
        4cYIFaHg1jGiE9zDb6sfEEIWfMioJSDycnVIqWPO5cXaTdlYa5/Bm32gUY6ZWbctw/rzae2jD209T
        tQBmTfchAB38KQj4ZP2p6/kEzzfiOhnPF9WW/T0WtQdnes13dV0monZ75wXdLEq7Q9WvJa74zrCV1
        oq/8Lchkt0JDkxahGe349mNoeLb6BWnD5tFtBDBcU39mxrBB7LjMsi4esmYTwQb4aoAifKkKFY35M
        GRTkDYWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRHSy-0003dx-Fg; Wed, 22 Apr 2020 15:39:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67BEF300739;
        Wed, 22 Apr 2020 17:39:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30D32286B71BE; Wed, 22 Apr 2020 17:39:10 +0200 (CEST)
Date:   Wed, 22 Apr 2020 17:39:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
Message-ID: <20200422153910.GN20730@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.988065598@infradead.org>
 <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com>
 <20200422132923.GK20730@hirez.programming.kicks-ass.net>
 <CAKfTPtBsFDt8JyxjD39B2YP+kCN9nXWZxnaJys9sz2CjWzd1Zw@mail.gmail.com>
 <20200422135921.GL20730@hirez.programming.kicks-ass.net>
 <CAKfTPtDa2JPtc2qPSe=d187u8pp7AdvV4wKJiUJsDiAvUTE9hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDa2JPtc2qPSe=d187u8pp7AdvV4wKJiUJsDiAvUTE9hg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:09:15PM +0200, Vincent Guittot wrote:
> > It's not unbounded, like a true idle-time scheduler would be, but it can
> > still be pretty horrible. nice19 has some of that too of course, but
> > idle has it worse, esp. also because it begs others to preempt it.
> 
> Yeah... you have to pay the benefit of letting other tasks to preempt
> faster. But both sched_idle and nice19 have the same weight 

#define WEIGHT_IDLEPRIO		3

 /*  15 */        36,        29,        23,        18,        15,

15 != 3

Also, like said elsewhere, idle is much more eager to let itself be
preempted.
