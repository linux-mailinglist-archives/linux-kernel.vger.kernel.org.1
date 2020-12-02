Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03182CBD22
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgLBMhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbgLBMhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:37:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC6C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aMsFarl+jDNhDGrkVJU4Z7rtyi8DqLbGMaMEmcevA9A=; b=BmqNP1/kSGbpNbtcb3h9aeOohN
        1KW/nJsBXNQZCmjsDzkHLK1LW2Cl+AObAAsH7v8KdksmfyAkVRzrFza57n36kfQlQQlftPnoCphm5
        y/EAYGCZRNFPPpRerig+SaEnxhd//+in+MsPGpxaB/DrF/jntN6Ird6TEe3Yb46m64PPxeiXTNycz
        lkMCKpezTVb5z/lj0nLN5aFV+cZLtvYcaqsbsqu/n8gomV0zfh3c09Ed7uotn8/Gys6TxLWI8TCqy
        pyCntiSjRGuSA5nivgnLtcKMt9b8zFwkX+uA1i+eybdaTiFmcHcNIVT3TBJAp1I5OKMoCX0nTV06H
        NxLuH3eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkRNL-0005Zh-R6; Wed, 02 Dec 2020 12:36:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 132D63059DD;
        Wed,  2 Dec 2020 13:36:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE6EB2143477A; Wed,  2 Dec 2020 13:36:48 +0100 (CET)
Date:   Wed, 2 Dec 2020 13:36:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 4/5] irqtime: Move irqtime entry accounting after irq
 offset incrementation
Message-ID: <20201202123648.GI3021@hirez.programming.kicks-ass.net>
References: <20201202115732.27827-1-frederic@kernel.org>
 <20201202115732.27827-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115732.27827-5-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:57:31PM +0100, Frederic Weisbecker wrote:
> IRQ time entry is currently accounted before HARDIRQ_OFFSET or
> SOFTIRQ_OFFSET are incremented. This is convenient to decide to which
> index the cputime to account is dispatched.
> 
> Unfortunately it prevents tick_irq_enter() from being called under
> HARDIRQ_OFFSET because tick_irq_enter() has to be called before the IRQ
> entry accounting due to the necessary clock catch up. As a result we
> don't benefit from appropriate lockdep coverage on tick_irq_enter().
> 
> To prepare for fixing this, move the IRQ entry cputime accounting after
> the preempt offset is incremented. This requires the cputime dispatch
> code to handle the extra offset.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
