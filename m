Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE6F303B96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392462AbhAZL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391224AbhAZJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:32:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC185C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LDC30rpEcAbHdhutlQsUsirJW7ovALxs1FGVVx0GKr4=; b=rDekEOwXF9rOvHeIf7jMuNmkux
        xUU0FwthSBnzWwhDDFd+pG09q3NLObZhAXR78Da/r1Rl+IjtHUtfKRz/e3XraPwAkeW+MKkszWzSL
        sHD1ZteR/tMJHM+TA2729a3EKCkmRJm6PqvOCsQno/IgiOKeD/CYw7OKhdqrPesbnfNNzZXvkehfn
        IvEeBZNVldLgFNG5iAI6G//cKmq3v7usjOdVd2vrmBmtY4A8Qs0sw3EKS/8+rV1vduu89qYrp45N6
        tw0Aqwv+b4uLwx5mu3TLvx6s6zietI9Np8WeGPOhsPb3pEp1S2pfyL+zB65p8oVWV6yWcvgV+p3Lb
        LVSYsy1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Kfn-005MfQ-9w; Tue, 26 Jan 2021 09:30:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A49CA3059C6;
        Tue, 26 Jan 2021 10:30:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 886CC20297EDB; Tue, 26 Jan 2021 10:30:06 +0100 (CET)
Date:   Tue, 26 Jan 2021 10:30:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 5/7] rbtree, uprobes: Use rbtree helpers
Message-ID: <YA/hHg8mH+e6cGOs@hirez.programming.kicks-ass.net>
References: <20210125150953.679129361@infradead.org>
 <20210125151314.888570583@infradead.org>
 <20210126055949.wriil3xj7wx5peed@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126055949.wriil3xj7wx5peed@offworld>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 09:59:49PM -0800, Davidlohr Bueso wrote:
> On Mon, 25 Jan 2021, Peter Zijlstra wrote:
> 
> > Reduce rbtree boilerplate by using the new helpers.
> 
> This reminds me of:
> 
> https://lore.kernel.org/lkml/20200207180305.11092-6-dave@stgolabs.net/
> 
> Would a walk optimization (list+rbtree) serve here? Not sure how big
> the uprobes_trees gets.

Oh, that's patch set is horrible.. You can do a linked list with the
unused node pointers directly.

  https://en.wikipedia.org/wiki/Threaded_binary_tree

So instead of using NULL for the empty rb_{left,right} pointers, use
pointers with the LSB set to differentiate them from regular leaf
pointers.

Other than that, threaded rb-trees would be awesome. I've meant to
implement them a number of times but never had the time to do the
tree-wide clean up of the rb_tree API to enable them.
