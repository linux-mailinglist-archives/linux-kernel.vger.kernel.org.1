Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FFF28311F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJEHwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:52:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C546C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 00:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kQD4/+GHLTI2vl6Qa3BGsZpfghTWh9K/7MHOnahIPWA=; b=Ad0lv/gpVg4Q5ghNTeTJnwcMph
        XSOY85e/Gf4ghk4fZkPyMp3gXy33r1BlMdd/TI5VZksBqJs/UsbpKxjwsVPUT3rWXti/QNC4x7Qly
        2woyuhahSEHLyaBNYueDAXmA0u1AXPsLVV3uD1mF1Of8keTOyT1FapQx3S/7sfBGlwe/s+bcQbIAI
        vzg+EQNAwpj3O71M0cq3MwmyNAElMFEdMfuiGFbOYehcCEr0jR/gzn0kKMNa39F1vUAC6W/Nxw9Un
        QndhGxJvPKwV4xZA2trymT0abd6MFIvhtSyFFj3TbL1/gbl/DZ3gD21fu5RSbBQiXgo9R6KJGaK7a
        HpcBNj5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPLI0-0001zV-My; Mon, 05 Oct 2020 07:52:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6059B3013E5;
        Mon,  5 Oct 2020 09:52:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C2D122BBB6D7; Mon,  5 Oct 2020 09:52:06 +0200 (CEST)
Date:   Mon, 5 Oct 2020 09:52:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, svens@linux.ibm.com
Subject: Re: [WARNING] kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
Message-ID: <20201005075206.GI2651@hirez.programming.kicks-ass.net>
References: <20200917131647.2b55ebb1@gandalf.local.home>
 <20200930181323.GF2628@hirez.programming.kicks-ass.net>
 <20201002135644.7903d0e5@gandalf.local.home>
 <20201002181313.GM29142@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002181313.GM29142@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 08:13:13PM +0200, Peter Zijlstra wrote:
> > checks within the irq disabling to get rid of the using cpu pointers within
> > preemptable code warnings
> 
> Ah, I think I lost a s/__this_cpu_read/raw_cpu_read/ somewhere. The
> thing is, if we're preemptible/migratable it will be 0 on both CPUs and
> it doesn't matter which 0 we read. If it is !0, IRQs will be disabled
> and we can't get migrated.

Aargh, this isn't in fact correct, and that means I have to revert:

  fddf9055a60d ("lockdep: Use raw_cpu_*() for per-cpu variables")

The trouble is that on a bunch of architectures we can read the other
CPUs variable from the new CPU, long after the old CPU has continued
executing things.

So this really needs to be this_cpu_read(). Luckily Sven has already
fixed s390, but let me go audit all the other archs.
