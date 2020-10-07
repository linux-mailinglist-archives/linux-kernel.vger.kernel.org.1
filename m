Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB5A28596B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgJGHXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGHXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:23:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3A6C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GTbnu1OQDpjQoN3xHkVtQy2g6e+K3PncKYy5876/h/U=; b=fXEOAPVZ0ZnK37dF2nsniqh3RH
        xrL5boRR7i0e78cMMQPWtenhyhlzp+TChA4Wvt0YuwAo7W8BSsZjWlecJNjwUl7I5cG1jkmFekxe1
        GdtECl3NJwiJg0Zbae+yUTg+NoCr/Ms3jZK20KoGM0bK2hNLVz/dgjFOhr7avCFMul2KS9p4DQMBn
        1wrULMRW0VkXPlQJmK3lLJc9oHXO3Tab3vyVUzpWxMpv0b3wAW+7PZIHS9hnkM+aO1ucOY/qeRUZi
        9mTOJ2UUJkgYBUnuGZaiWsyoNxihKVfQWzcJ673eXSfHIxmEpTV0g6If18aLjcLtIduqXXJqcUDH2
        mIw+CnXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ3mw-0003HA-KZ; Wed, 07 Oct 2020 07:23:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B149B304B90;
        Wed,  7 Oct 2020 09:22:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CEFF20419079; Wed,  7 Oct 2020 09:22:58 +0200 (CEST)
Date:   Wed, 7 Oct 2020 09:22:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 12/17] sched,rt: Use cpumask_any*_distribute()
Message-ID: <20201007072258.GA2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.156231026@infradead.org>
 <20201006155527.w6jck2rgk64t45wm@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006155527.w6jck2rgk64t45wm@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 04:55:27PM +0100, Qais Yousef wrote:
> > +int cpumask_any_distribute(const struct cpumask *srcp)
> > +{
> > +	int next, prev;
> > +
> > +	/* NOTE: our first selection will skip 0. */
> > +	prev = __this_cpu_read(distribute_cpu_mask_prev);
> 
> We had a discussion then that __this_cpu*() variant assumes preemption being
> disabled and it's safer to use this_cpu*() variant instead. Still holds true
> here?

I think we ended up with not caring. We wanted a 'random' value, we get
a 'random' value from a 'random' CPU, still works ;-)
