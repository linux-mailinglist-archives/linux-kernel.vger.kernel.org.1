Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475462B8023
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgKRPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:10:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C1EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=id+ldJSEd3FN4RHA8ZXZu9HnCEDNI/S7zVswGvLfq5E=; b=rJOX5Uw/+BClSII5qfNrlQEKOC
        wdIyBzYOm1pbxY85QEJT5jPxU78/vrwml69I2Ly3mLTlnPO0XsZ2ffe2c2HCYZyfyM+iPz/G+DKJe
        mi/MZk3myKofdiyQdKsBLHc5vc9TiEm8riNyU8/ZJEORDKw/kCzpTZgCo2+41e8qIvak+Btm/OzuA
        4op6maivyJwThZP08f+4IqSCU60fX/LY0P5wzvGjyFE14CW3DUyqfwxn3BpERxsh4j/dAGfL5iSDl
        ARC7YJjYOkEsW7Eu7BFzDWhb8HkBnjUlgcpKilBzwYP7x7QdOFi+071+Fm961b0fq3VxqSD6rp1hX
        cIttCDBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfP6X-0006NQ-55; Wed, 18 Nov 2020 15:10:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60A86301959;
        Wed, 18 Nov 2020 16:10:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 479E520126362; Wed, 18 Nov 2020 16:10:38 +0100 (CET)
Date:   Wed, 18 Nov 2020 16:10:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
Message-ID: <20201118151038.GX3121392@hirez.programming.kicks-ass.net>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
 <0eb519fa-e77b-b655-724a-4e9eecc64626@i-love.sakura.ne.jp>
 <6933e938-f219-5e13-aee6-fe4de87eb43e@i-love.sakura.ne.jp>
 <81ab0ffd-6e80-c96c-053a-b1b4fe8694c1@i-love.sakura.ne.jp>
 <20201118142357.GW3121392@hirez.programming.kicks-ass.net>
 <1778f2e5-0a0c-2c6e-2c83-fe51d938e8a2@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1778f2e5-0a0c-2c6e-2c83-fe51d938e8a2@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:30:05PM +0900, Tetsuo Handa wrote:
> The problem is that we can't know what exactly is consuming these resources.
> My question is do you have a plan to make it possible to know what exactly is
> consuming these resources.

I'm pretty sure it's in /proc/lockdep* somewhere.

IIRC you were suffering from "MAX_LOCKDEP_ENTRIES too low!", which you
find in alloc_list_entry(), that's used in add_lock_to_list(), which in
turn is used in check_prev_add() to add to ->locks_after and
->locks_before.

/me frobs in lockdep_proc.c and finds l_show() uses locks_after,
l_show() is the implementation for /proc/lockdep.

So something like:

$ grep "^ ->" /proc/lockdep | wc -l
5064

Should be roughly half (it only shows the forward dependencies) the
number of list_entries used.

/proc/lockdep_stats: direct dependencies:                 11886 [max: 32768]

gives the number of list_entries used

Trick then is finding where they all go, because as you can see, my
machine is nowhere near saturated, even though it's been running a few
days.

So, go forth and analyize your problem.
