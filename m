Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB1F2B4381
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgKPMSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgKPMSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:18:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B96C0613CF;
        Mon, 16 Nov 2020 04:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bQMq5TZF86IM/5Y94jT9C5QIrKLF+iu+uQmY1bh2ZzQ=; b=eSQGkQEayKHgS/hoe3uDgFONQ3
        Yx3Ye2/ArnTKwvDcz2D218ytbiMgxdS0bbWfiBz8QeeRvkZQ0O4rztVu5HZf9xGCumpsHiwSFSD+H
        paVr3v8GPt4dfe6X+b31/j3tAFcg4wCSf68QkPbhqsiU7bkECtPA6pZjYd6FmPEQAluQOcTeWqCF3
        IAnSgq2PdxWz1exvOeZ/5ONexQjsFidRpjCZ5audNW0X4a20/jahfZugICLYZSMJUyUOIy9V9M7lq
        NIaJzH2pTgxAXElk7Jx8JdPKBqXA7T6sLwZBMobBCleos4MCeD5Bwb+QzPe632b7nSMkNUcmPtavH
        LQQ3Q2oA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kedSB-0005Ul-Eg; Mon, 16 Nov 2020 12:17:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9FFA307062;
        Mon, 16 Nov 2020 13:17:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE60220299B60; Mon, 16 Nov 2020 13:17:48 +0100 (CET)
Date:   Mon, 16 Nov 2020 13:17:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch 10/19] preempt: Cleanup the macro maze a bit
Message-ID: <20201116121748.GD3121378@hirez.programming.kicks-ass.net>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.864469886@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113141733.864469886@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 03:02:17PM +0100, Thomas Gleixner wrote:

> -#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
> -				 | NMI_MASK))
> +#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())


> +#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> -#define in_task()		(!(preempt_count() & \
> -				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))

How horrible is the code-gen? Because preempt_count() is
raw_cpu_read_4() and at least some old compilers will refuse to CSE it
(consider the this_cpu_read_stable mess).
