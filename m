Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DBC290201
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405915AbgJPJf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405602AbgJPJfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:35:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA7C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yb8gL7vEzjslH+fMZzPSTu+Wz6mcGTp1t7dxaMIvEbE=; b=ltm0e3rvGKODAYrhAaSNItnfV1
        lobnqnzR8Fxmc3lbCXiQtfNEvG7DIMbq7ELDrhDFNUkCZ4KHPTJKAihUXNHIp04762tWOha3F35PS
        BF1BagMv/GEdhsSFJ8SzTbc6nz4caBvf4H0BpKgx2SB/99wEXwBrqwkIq+0p8v1bZEd6p4UVYtRjr
        ITuw0hGv9b7TvqL6Gp6k7KDa7eKjvj67YDEmsFQvTkKYVEuWWr41h8w0yacwfPfigLBndIY837OxX
        wyXFayUaZK1xGT/8TqebnO57nT/PZgt8RHu4Ocmlac54fZiivJwLBK8Dm3z9DNOJgNYILdHGt1z7/
        1h3MKHmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTM8g-0002hx-JN; Fri, 16 Oct 2020 09:35:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E42C300DAE;
        Fri, 16 Oct 2020 11:35:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B7A6203C7039; Fri, 16 Oct 2020 11:35:03 +0200 (CEST)
Date:   Fri, 16 Oct 2020 11:35:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     zhout <ouwen210@hotmail.com>, g@hirez.programming.kicks-ass.net
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH v3 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
Message-ID: <20201016093503.GG2611@hirez.programming.kicks-ass.net>
References: <20201015110532.738127234@infradead.org>
 <20201015110923.971283427@infradead.org>
 <BN8PR12MB2978A3BB8062DF4CEEB184109A030@BN8PR12MB2978.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR12MB2978A3BB8062DF4CEEB184109A030@BN8PR12MB2978.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:43:17AM +0800, zhout wrote:
> On Thu, Oct 15, 2020 at 01:05:43PM +0200, Peter Zijlstra wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> 
> [ ... ]  
> 
> > +static inline bool rq_has_pinned_tasks(struct rq *rq)
> > +{
> > +	return rq->nr_pinned;
> > +}
> > +
> 
> Even I do not understand well enough, the return type of the
> above function is bool and rq->nr_pinned is unsigned int.
> Write this way:
> 
> static inline bool rq_has_pinned_tasks(struct rq *rq)
> {
> 	return !!rq->nr_pinned;
> }

The C compiler does this for us. C has a lot of implicit type
conversions.

It is the same mechanism at work when we write:

	if (rq->nr_pinned)

We know that works and we don't have to write:

	if (!!rq->nr_pinned)

(although we may, but it is pointless).

