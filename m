Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC92FD7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391124AbhATR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbhATRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:55:41 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6DC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j8X2B6e/nyEs+NJNeqzCnZuwySVRnniHinpf7QdycqQ=; b=fC3BZkihHPF+tMwceR6naiiutb
        qfz3Rgpz8x00bj6HuZY4vYB+2Ky1eg90RSTKTqC5EN5BYOjGcKbS/pduZQaG3Dm6LRvopmu+rsW7Y
        Elvz0OqATEMrsGzfgPpDisuuWQ5N84JbRO4Ah4TDK+rwFS29SGF1ycchknpeClgNvhcdQG//3yMOZ
        fDyAd3eoOXRswOHJH3AxZO3Y8kk6YjX5x5elSMD5NbHf3L81fYh88QmtS8pEXgjXEUph5Xq7REuL/
        0zbGTjZwbp6Z6NPRKpfa5751LNBxdR1G7ERvMmThR2bl4U5kiT4sUWwTyFCMQhMicuyYdwarRX8Qi
        67DXD6Ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2Hgr-0002It-1h; Wed, 20 Jan 2021 17:54:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6414303271;
        Wed, 20 Jan 2021 18:54:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB0D120BCCFD7; Wed, 20 Jan 2021 18:54:43 +0100 (CET)
Date:   Wed, 20 Jan 2021 18:54:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     vincent.donnefort@arm.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 3/4] cpu/hotplug: Add cpuhp_invoke_callback_range()
Message-ID: <YAhuY6PyqnNDyY44@hirez.programming.kicks-ass.net>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-4-git-send-email-vincent.donnefort@arm.com>
 <YAgr8RQg6Cn66bvf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAgr8RQg6Cn66bvf@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 02:11:14PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 11, 2021 at 05:10:46PM +0000, vincent.donnefort@arm.com wrote:
> > @@ -157,26 +162,24 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
> >  
> >  	if (st->fail == state) {
> >  		st->fail = CPUHP_INVALID;
> > -
> > -		if (!(bringup ? step->startup.single : step->teardown.single))
> > -			return 0;
> > -
> >  		return -EAGAIN;
> >  	}
> >  
> > +	if (cpuhp_step_empty(bringup, step)) {
> > +		WARN_ON_ONCE(1);
> > +		return 0;
> > +	}
> 
> This changes the behaviour of fail.. might be best to refactor without
> changing behaviour.
> 

Aah, the trick is in cpuhp_next_state() skipping empty states, so we'll
never get there.
