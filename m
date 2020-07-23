Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3189F22ADB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgGWL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 07:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgGWL2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:28:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722E8C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YgkYb9+mXjx9AMiNkQHw9z5f5bsoHW0FayfQqrx0gm0=; b=EUBfvEjYINo6zYXuS9AtgTymxc
        sEF9uWBo6EyK2/TPvNKF85iyrdfBvpdqDIzEwuz4kuiewJP/ezm3Mf2KAl1UyNBCA7aXRv6dgiJ1L
        IHfr2HvF06zF20qFJWNjoeI6CSfKMDi4enYRs/uTES1Klo9qQa5tPfSWkPdI+MpRdJCQcESoVC4sJ
        CVet2ZxMAYHrQDUIadl07rmXJxx18/EeiFZzjKNgqBI1sVFqvidM3x00NVNm/2TbB3pSK+ZQChQ45
        VV7GdFGp631uydfecF15dCkgst18fi5KZtepSH6EmHHsQag0JLzB0vJNFREoD3asWQZxLemIaZOWM
        VD7lExUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyZOL-00013u-Sb; Thu, 23 Jul 2020 11:28:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E49B9821EE; Thu, 23 Jul 2020 13:27:57 +0200 (CEST)
Date:   Thu, 23 Jul 2020 13:27:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>, Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: [PATCH for 5.9 1/3] futex: introduce FUTEX_SWAP operation
Message-ID: <20200723112757.GN5523@worktop.programming.kicks-ass.net>
References: <20200722234538.166697-1-posk@posk.io>
 <20200722234538.166697-2-posk@posk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722234538.166697-2-posk@posk.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 04:45:36PM -0700, Peter Oskolkov wrote:
> This patchset is the first step to open-source this work. As explained
> in the linked pdf and video, SwitchTo API has three core operations: wait,
> resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
> that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
> on top of which user-space threading libraries can be built.

The PDF and video can go pound sand; you get to fully explain things
here.

What worries me is how FUTEX_SWAP would interact with the future
FUTEX_LOCK / FUTEX_UNLOCK. When we implement pthread_mutex with those,
there's very few WAIT/WAKE left.

Also, why would we commit to an ABI without ever having seen the rest?

On another note: wake_up_process_prefer_current_cpu() is a horrific
function name :/ That's half to a third of the line limit.
