Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3652D400B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgLIKfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgLIKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:35:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02C4C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bn6UsPytD7lpWNeuioAnbtJ+q/2aZig8GGGqPYhd8gM=; b=c7IXiJVKfVftOvjKl/bT4YGFrd
        5EU7I2Ktu0ECjXF+SMVBCG+z/G2hpX5XG/48T/mO2pjvGhemfgUgbYSeGACHTb2rQPGciagZJLkiu
        R4DFZv5UxoEVO59NDE07IZDZKs0Mm81rVHm0IUrFTS5vF4ypD42dztt6GacvikKZ03jOvge2fIKPj
        yNVDqW2dxEreSNgA+0vhjiJ2IEQSBFBqWpJnSW3FMqeKIWhW2cP3TTGak3r0zztAU0Xrwr+Xv6WJL
        o9096ncn8kjmlJrvULnmCqoN18aHaXgZhdsxaOtf2JRPIrQMmvMGAq2KxX0uDZDDr26lhW/4iAFlL
        /MExpBvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmwnj-0005PK-U8; Wed, 09 Dec 2020 10:34:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9217E305C10;
        Wed,  9 Dec 2020 11:34:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B92220812B8F; Wed,  9 Dec 2020 11:34:27 +0100 (CET)
Date:   Wed, 9 Dec 2020 11:34:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 4/9] softirq: Make softirq control and processing RT
 aware
Message-ID: <20201209103427.GK2414@hirez.programming.kicks-ass.net>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.114951971@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170805.114951971@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:55PM +0100, Thomas Gleixner wrote:
> +void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> +{
> +	unsigned long flags;
> +	int newcnt;
> +
> +	WARN_ON_ONCE(in_hardirq());
> +
> +	/* First entry of a task into a BH disabled section? */
> +	if (!current->softirq_disable_cnt) {
> +		if (preemptible()) {

This reminds me of that migrate_disable() thing that didn't work, and
has similar problems.

	preempt_disable();
	local_bh_disable();
	preempt_enable();
	spin_lock(&foo);

is valid (albeit daft) code that will now malfunction.

> +			local_lock(&softirq_ctrl.lock);


