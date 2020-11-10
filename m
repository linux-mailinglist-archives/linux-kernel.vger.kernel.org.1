Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FAD2AD5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgKJMSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:18:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D159C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XTy/n79CehGxJmq00udI0yIaOLN2MvHchRCnNyXCdfc=; b=KP4Nanp767Oh9WC+p12u/WhSVw
        EVYH+PCh146ENrVfcEGYKSbJt47x4UAjENkfNVQqj4zdozEGrT2clRJxNUUQNQX/h94puPF+Wk+cP
        Tbuj7iEkUi/3Dm97av9X4CaeLROQXHl6qUF9z7HXYhS8Jc9VPVMye1kqnPcc1bzIx5F8wntlf0Gz7
        Q06w+V2iKAZhH+W/zRD9AIfwAydbrTmMiUKhmYxCkCUHEBXKTH/vDHqMy85HT/aexbaZad9+TlemA
        wWFoWPUx9nrNConA9wc5WC7Qtq9H16xgvbLMElouyL2/TxT1P2JmV5lpO+vowlL2tgym72yFLf9Eo
        f67hUWuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcSbM-000460-Dl; Tue, 10 Nov 2020 12:18:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B43F300455;
        Tue, 10 Nov 2020 13:18:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E6122C29A9E4; Tue, 10 Nov 2020 13:18:17 +0100 (CET)
Date:   Tue, 10 Nov 2020 13:18:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Yun Hsiang <hsiang023167@gmail.com>, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
Message-ID: <20201110121817.GF2594@hirez.programming.kicks-ass.net>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <87blgag4an.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blgag4an.derkling@matbug.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 11:36:48AM +0100, Patrick Bellasi wrote:

> > +static int uclamp_reset(enum uclamp_id clamp_id, unsigned long flags)
> > +{
> > +	/* No _UCLAMP_RESET flag set: do not reset */
> > +	if (!(flags & SCHED_FLAG_UTIL_CLAMP_RESET))
> > +		return false;
> > +
> > +	/* Only _UCLAMP_RESET flag set: reset both clamps */
> > +	if (!(flags & (SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)))
> > +		return true;
> > +
> > +	/* Both _UCLAMP_RESET and _UCLAMP_MIN flags are set: reset only min */
> > +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MIN) && clamp_id == UCLAMP_MIN)
> > +		return true;
> > +
> > +	/* Both _UCLAMP_RESET and _UCLAMP_MAX flags are set: reset only max */
> > +	if ((flags & SCHED_FLAG_UTIL_CLAMP_MAX) && clamp_id == UCLAMP_MAX)
> > +		return true;
> > +
> > +	return false;
> 
> I was suggesting maybe we need READ_ONCE() in the if above but did not
> addressed previous Dietmar's question [2] on why.
> 
> The function above has a correct semantics only when the ordering of the
> if statement is strictly observed.
> 
> Now, since we don't have any data dependency on the multiple if cases,
> are we sure an overzealous compiler will never come up with some
> "optimized reordering" of the checks required?
> 
> IOW, if the compiler could scramble the checks on an optimization, we
> would get a wrong semantics which is also very difficult do debug.
> Hence the idea to use READ_ONCE, to both tell the compiler to not
> even attempt reordering those checks and also to better document the
> code about the importance of the ordering on those checks.
> 
> Is now more clear? Does that makes sense?

I don't think the compiler is allowed to do as you fear. Specifically it
cannot move the first branch down because that would change the meaning
of this function and affect observable behaviour even in the traditional
single-threaded environment.


