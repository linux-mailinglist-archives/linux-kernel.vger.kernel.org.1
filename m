Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8B31E4A99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391404AbgE0QnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 12:43:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59174 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391358AbgE0QnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/NR+tWQXI7ShSCqCpSQ3tqpGU8MPz+hHbfEP5s550KY=; b=3lHzTLtpG1Xp4RHgxteMHqoueD
        lvFnMqfitcxUXeZcOIxR59B4LrfStEwFYL7YoutZ8SR45ExlNmR7NT1epzEbwuMiL3qBWS+Xs3hk6
        2ZejasBqaOa3h11u6jKtRqvbfUnjJ5M/er3EMowEC9VJbFknun4lNuchgTYSrUWDGlTKqOhepIJRE
        5f4qVLJi3spimqZogWUBaTi9V+j0WeOS2S8o54nqTtWZeRL+EOBIONrak53mbiSVtahW2Ri7ZfTTP
        9YQlwoj4+2pn6fEQPJA2rlgEC2O/xkhGK5lhqTOmgG2YRskVKmpD3hfpSksedtywOO6qpUg6Um5jE
        Q8xlSHvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdz91-00031O-25; Wed, 27 May 2020 16:43:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D24EA307643;
        Wed, 27 May 2020 18:43:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4EE92023E7C7; Wed, 27 May 2020 18:43:05 +0200 (CEST)
Date:   Wed, 27 May 2020 18:43:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de
Subject: Re: [PATCH 0/6] x86/entry,lockdep: Improve IRQ state tracking
Message-ID: <20200527164305.GB706495@hirez.programming.kicks-ass.net>
References: <20200527154527.233385756@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527154527.233385756@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 05:45:27PM +0200, Peter Zijlstra wrote:
> Ahmed and Sebastian wanted additional lockdep_assert*() macros and ran
> into header hell.
> 
> Move the IRQ state into per-cpu variables, which removes the dependency on
> task_struct, which is what generated the header-hell.
> 
> And fix IRQ state tracking to not be affected by lockdep_off() (it really
> should not have been anyway) and extends IRQ state tracking across (x86)
> NMIs.

After having it run kernel builds for a while, I've got a realy weird
(false-positive) lockdep_assert_irqs_enabled() trigger.

So something isn't quite right. I'll prod at it some moar.
