Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1559275BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIWP1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIWP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:27:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297B0C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tEcppYbaHvOc+zDwI50BMA4krB7SREy/l5n2F8YUvpY=; b=g7XBqqq+dVb0S9s0KXfAjCs8db
        Fnrs8rRSLNhag0UXdsYC81acmH09tonukUGvUYVIg7iw4zWuuGd03kxHh64hdFwxNY8oVroSAY8LK
        rxWtv5S6SGNxbr4u0bZQ0uTeqs0B8IfuJQWinlV6drEJ5atKQyTERs1RsaceuuPPoBAIePht8aolT
        WAOqsKlMoHBs4NoTKausiBk2JuNdJ+1oueJBmQIl0pmu0ubYqGP/xqPPeY3AgfQ5ZpWEP2FSri61t
        ni6+PCoNE0riU4usfy+B1IO3g6lhAtHoMBBsQ6uMQBi9zBvgQP/dIQRyucvzNX6ZRyZAwQtzpWloz
        wIbQr3Hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL6fc-0002Mi-32; Wed, 23 Sep 2020 15:27:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 852EE3003E5;
        Wed, 23 Sep 2020 17:26:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FDB6213DCC7B; Wed, 23 Sep 2020 17:26:58 +0200 (CEST)
Date:   Wed, 23 Sep 2020 17:26:58 +0200
From:   peterz@infradead.org
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Use bool parameter for update_tg_load_avg()
Message-ID: <20200923152658.GX1362448@hirez.programming.kicks-ass.net>
References: <20200923132935.20778-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923132935.20778-1-tian.xianting@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 09:29:35PM +0800, Xianting Tian wrote:
> In the file fair.c, sometims update_tg_load_avg(cfs_rq, 0) is used,
> sometimes update_tg_load_avg(cfs_rq, false) is used. So change it
> to use bool parameter.

afaict it's never true (or my git-grep failed), so why not remove the
argument entirely?
