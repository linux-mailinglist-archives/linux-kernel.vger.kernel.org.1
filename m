Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F7E284B1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgJFLrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgJFLrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:47:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93845C061755;
        Tue,  6 Oct 2020 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tuRA8scDdkQhnVOcX0Z5HzRcuC00AyBXe2RRLJQ0MjE=; b=laLFyGeOuYTMnks2gAJDQv9lwY
        TRv0DOUxxAJIYJN6diART2Hm+TZcmo61t4kavf/SrF8cKaPXuGTyJYUw/m2WmPArWEor/cTdBpRQ6
        6KyXW4THOj5DwpfydhXsbXY9Zi89gDPvFNyb6B9E0XGvQXhjCzkOu4qzL8IXYHGQkTB6xJ1nojTbL
        njXNENoRLnTllePML6iLy+eAIULAYYPq0hP6OXT5aWc5S3xyIFgis5cjSegBvqWbk3s+yQrwxgPTo
        bq/VWNT7f5MNg/WuUbIJWLBA3HlL0/2hKYuK0gI2LQYmxvnO8XiZxAosZCn9PWs2VbrJ3v8d6l4op
        lN6MQaeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPlR2-0005xo-W8; Tue, 06 Oct 2020 11:47:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23BF13050F0;
        Tue,  6 Oct 2020 13:47:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 113012011672A; Tue,  6 Oct 2020 13:47:10 +0200 (CEST)
Date:   Tue, 6 Oct 2020 13:47:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-toolchains@vger.kernel.org, Will Deacon <will@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        torvalds@linux-foundation.org
Subject: Control Dependencies vs C Compilers
Message-ID: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Let's give this linux-toolchains thing a test-run...

As some of you might know, there's a bit of a discrepancy between what
compiler and kernel people consider 'valid' use of the compiler :-)

One area where this shows up is in implicit (memory) ordering provided
by the hardware, which we kernel people would like to use to avoid
explicit fences (expensive) but which the compiler is unaware of and
could ruin (bad).

During the last LPC we had a session on that; find here:

  https://linuxplumbersconf.org/event/7/contributions/821/

With recordings of the event here:

  https://youtu.be/FFjV9f_Ub9o?t=89

That presentation covers 3 different implicit dependencies and various
ways in which a compiler can ruin the game. For this thread, I'd like to
limit things to just control-dependencies. We can start separate threads
for the other issues.

In short, the control dependency relies on the hardware never
speculating stores (instant OOTA) to provide a LOAD->STORE ordering.
That is, a LOAD must be completed to resolve a conditional branch, the
STORE is after the branch and cannot be made visible until the branch is
determined (which implies the load is complete).

However, our 'dear' C language has no clue of any of this.

So given code like:

	x = *foo;
	if (x > 42)
		*bar = 1;

Which, if literally translated into assembly, would provide a
LOAD->STORE order between foo and bar, could, in the hands of an
evil^Woptimizing compiler, become:

	x = *foo;
	*bar = 1;

because it knows, through value tracking, that the condition must be
true.

Our Documentation/memory-barriers.txt has a Control Dependencies section
(which I shall not replicate here for brevity) which lists a number of
caveats. But in general the work-around we use is:

	x = READ_ONCE(*foo);
	if (x > 42)
		WRITE_ONCE(*bar, 1);

Where READ/WRITE_ONCE() cast the variable volatile. The volatile
qualifier dissuades the compiler from assuming it knows things and we
then hope it will indeed emit the branch like we'd expect.


Now, hoping the compiler generates correct code is clearly not ideal and
very dangerous indeed. Which is why my question to the compiler folks
assembled here is:

  Can we get a C language extention for this?

And while we have a fair number (and growing) existing users of this in
the kernel, I'd not be adverse to having to annotate them.

Any suggestions from the compiler people present on how they'd like to
provide us this feature?

Even just being able to detect this going wrong would be a step forward.

 ~ Peter
