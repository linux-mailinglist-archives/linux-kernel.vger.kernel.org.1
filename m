Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7E2814E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbgJBOUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:20:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A905C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G+5CbmqP20webr0ErY04CX5j7Q2Q2hOKTgJTeX7y+cg=; b=aaN8GMeUVBrvl3/4ybS46KAtE9
        4Nuv+ycORy19ok5apyzZG0RmaMCChTsLiODaFsCek6iPU1ZtNN4+XioetNyj9KqRQ0/WeOJpivgVL
        qdw8f2vuAQiLEhpPQ6oXO0L5+BCNFdp2ExXVZJl1tZEO0piSRmoX3K39dAGJw4QVniI7przFa+cnl
        V7V+i2hoVxp7gk0Y1MFKy8k0ql1pPOaLs+Ig4esBfi2iAp1IMXohfplq6tLF/GmiXUS06+JqL8RYs
        H5TsnwUdeaPCUO8O9r/a8RRXIQaM1GAkI1VODe4H0vof+lxitiPpApFljeBYIpDa2la8qkSG76xx+
        HpGT76bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOLvC-0002WE-5g; Fri, 02 Oct 2020 14:20:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 894D4304B92;
        Fri,  2 Oct 2020 16:20:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76539203A8F67; Fri,  2 Oct 2020 16:20:28 +0200 (CEST)
Date:   Fri, 2 Oct 2020 16:20:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com
Subject: Re: [PATCH 3/9] sched/hotplug: Ensure only per-cpu kthreads run
 during hotplug
Message-ID: <20201002142028.GY2628@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.520504267@infradead.org>
 <b357302d-4a8c-aa2e-f31d-4501fce890b6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b357302d-4a8c-aa2e-f31d-4501fce890b6@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 06:38:50PM +0200, Dietmar Eggemann wrote:
> On 21/09/2020 18:36, Peter Zijlstra wrote:
> 
> [...]
> 
> > This replaces the unlikely(rq->balance_callbacks) test at the tail of
> > context_switch with an unlikely(rq->balance_work), the fast path is
> 
> While looking for why BALANCE_WORK is needed:
> 
> Shouldn't this be unlikely(rq->balance_callback) and
> unlikely(rq->balance_flags)?

But then we have two loads in the fastpath..
