Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926A22FD71A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbhATRcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388828AbhATRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:31:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD05C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yzAxe3sMWnWr7VcTH/YVHmDCsx4+TBkz57gTfUzD9C4=; b=fqxgOl/2+SzdiXQrGVd3p/Fd/7
        ZlLj3Kx/Twup7EfzlA3kZ2e5urbUKxQ2JFF+Mn0VJe58RnTpRoK23YfWAjKa9T+XbaXY6OkpHYtDc
        dr/w55umROq9rYYXezotgE/k+s0JEuMwOevXZMJqBSDYUNMeG4OAjhKgqTROubYAHSvlFRdUL27uY
        w/zjv2c6pTOqtjP3vLOuG5g+MK+jsdjL2rAC+h9J9e3cFFb+siGKN8aCH4G/fg6MqWVo2YHOZRUr3
        W8KHPGxRAkpnHoTxmW8Elf11AzVK2w51e86LRcuW8NIeITQe+KxRscmXcqZ2y4STKBL9Z6ZiK1odl
        Q1F3Gx3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2HJh-0001mF-02; Wed, 20 Jan 2021 17:30:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2BBB303271;
        Wed, 20 Jan 2021 18:30:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DA672CEAD197; Wed, 20 Jan 2021 18:30:45 +0100 (CET)
Date:   Wed, 20 Jan 2021 18:30:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 2/4] cpu/hotplug: CPUHP_BRINGUP_CPU exception in fail
 injection
Message-ID: <YAhoxQxFmcEH3Pin@hirez.programming.kicks-ass.net>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-3-git-send-email-vincent.donnefort@arm.com>
 <YAgo+zMrbFjJ/meF@hirez.programming.kicks-ass.net>
 <20210120151723.GA284273@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120151723.GA284273@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 03:17:24PM +0000, Vincent Donnefort wrote:
> On Wed, Jan 20, 2021 at 01:58:35PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 11, 2021 at 05:10:45PM +0000, vincent.donnefort@arm.com wrote:

> > > +	if (cpuhp_is_atomic_state(fail) ||
> > > +	    (fail == CPUHP_BRINGUP_CPU && st->state > CPUHP_BRINGUP_CPU))
> > >  		return -EINVAL;
> > 
> > Should we instead disallow failing any state that has .cant_stop ?
> 
> We would reduce the scope of what can be tested: bringup_cpu() and
> takedown_cpu() are both marked as "cant_stop". Still, those callbacks are
> allowed to fail.

Fair enough. I suppose we can add an additional cant_fail field, but I'm
not sure that's worth the effort over this.
