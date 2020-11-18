Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D0D2B770F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgKRHj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgKRHj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:39:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2378C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GiHrAlh1tLEfMQgzXhaQ8GsJ8zIMpmOXVFJJO0ZgE0U=; b=f4nPyA2Mei+uVPIo2mhqPVsFNl
        IeqTmUm94hRNG478x1HMf8C7kboqgkQDcRWFKmMF5d4ZaMVzDK1w1pA6fzUH0RLbKcsRiX6mJEFoR
        6UqloReXWasBASjWS0xH9pmxbo1zLiaCzy1lrL+A30qCEVfQmX5C0sr91AOPDk3t7o4GY+SFJKe5Y
        93LVTqZElw7VT64LS5SxU2uvupV5aeY2xFo8ifhdLmGrubif1GRCz1TIrL6staOnpOy0po7SDUrtv
        YbnsNE78uFmCeG2g4M8TUl82f6JWv2U+1f8AuMmsICYcq6ZkI8MgfkWIi9QX65E/JUnqxohlnCR13
        icgmeO8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfI4F-0000LO-Sh; Wed, 18 Nov 2020 07:39:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC2913019CE;
        Wed, 18 Nov 2020 08:39:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC271200DCACF; Wed, 18 Nov 2020 08:39:47 +0100 (CET)
Date:   Wed, 18 Nov 2020 08:39:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/5] context_tracking: Flatter archs not using
 exception_enter/exit() v3
Message-ID: <20201118073947.GQ3121392@hirez.programming.kicks-ass.net>
References: <20201117151637.259084-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117151637.259084-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:16:32PM +0100, Frederic Weisbecker wrote:
> Frederic Weisbecker (5):
>       context_tracking: Introduce HAVE_CONTEXT_TRACKING_OFFSTACK
>       context_tracking:  Don't implement exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
>       sched: Detect call to schedule from critical entry code
>       context_tracking: Only define schedule_user() on !HAVE_CONTEXT_TRACKING_OFFSTACK archs
>       x86: Support HAVE_CONTEXT_TRACKING_OFFSTACK

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
