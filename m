Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260D41DB2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 14:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgETMFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 08:05:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETMFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=38+C5Zoh655MjDoYal0GbmhQ7BoxPfmu6rmjyrpKqf0=; b=nBiynwC+G9IbOG9lMv9Zy7crdl
        AQrm5dA/+vHlhFNZPqfj4eL6H6tdDccbv4DYukMm7wGEW3W8L4PyyqBR29pA/ynFeDM1GNxYjOLuU
        Ei0Swoik7D3D3V025LhGyFzsstlXX+02BiP5+8Mdu4obZtHUqYbs72fyz/wXe4uDGF9cJT50+JRtW
        WKnxupe6b9Zv4vbceE05FsEq8CHbvLuaob+eRi77QvdZV7Rqg9935SUKZdb/F2SK25zYVLHUyJJHM
        JagSPdbrEVII0RIME2a1H61bdIKh7LtTBGEQpw6IPpmnWiUz+Pb1vqkB8szovp7x5okJrflXHVWiX
        Qy7UkS1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbNSy-0007YR-Mt; Wed, 20 May 2020 12:04:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D101530067C;
        Wed, 20 May 2020 14:04:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A81425E3797C; Wed, 20 May 2020 14:04:50 +0200 (CEST)
Date:   Wed, 20 May 2020 14:04:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/8] locking: Introduce local_lock()
Message-ID: <20200520120450.GL317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201912.1564477-2-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:19:05PM +0200, Sebastian Andrzej Siewior wrote:
> +/**
> + * DEFINE_LOCAL_LOCK - Define and initialize a per CPU local lock
> + * @lock:	Name of the lock instance
> + */
> +#define DEFINE_LOCAL_LOCK(lvar)					\
> +	DEFINE_PER_CPU(struct local_lock, lvar) = { INIT_LOCAL_LOCK(lvar) }
> +
> +/**
> + * DECLARE_LOCAL_LOCK - Declare a defined per CPU local lock
> + * @lock:	Name of the lock instance
> + */
> +#define DECLARE_LOCAL_LOCK(lvar)				\
> +	DECLARE_PER_CPU(struct local_lock, lvar)

So I think I'm going to argue having these is a mistake. The local_lock
should be put in a percpu structure along with the data it actually
protects.


> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +# define LL_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }

That wants to be:

	.dep_map = {
		.name = #lockname,
		.wait_type_inner = LD_WAIT_SPIN,
	}

> +#else
> +# define LL_DEP_MAP_INIT(lockname)
> +#endif
