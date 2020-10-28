Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2B29D45B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgJ1Vvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:51:41 -0400
Received: from casper.infradead.org ([90.155.50.34]:44160 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgJ1Vvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2SDn0M9nv4bcedmTJRWAQlXu0K5RKkS42iU0N8vEXgU=; b=G21GnSZbpM6NCtTezkcR78B+0u
        RNexbqEXd49aKPg8kAXOypkrq4KHX8M4DSTyLuX2Vk4HWkAktL1UfXkKNR2lHKUii32dJXhcpw+sd
        akfj4+Apt+QhBDZUcc3jQyO+v7awHhq3Yh00EpmrfsVZa6fSzFn4xqGb9YjPPVwUBg37S3XIQNlxr
        IkpRR3a7z2AWJpg9Xw/pES8IJ0Kfr/S+ljQwAuklwtHYc/+JYzkIIKnaKKiIr6bUQthvafLGqCl8J
        n4yGdSnDsVfXW0FXhLZwzFS11g47itqs5lI/zjrPKze1rI6Hb/rh7UEwZ+NX4v5yUaqbr9QtLTUs/
        UUtJPkgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXmqL-0005Y9-7E; Wed, 28 Oct 2020 14:54:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD2203006D0;
        Wed, 28 Oct 2020 15:54:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FA942B064B32; Wed, 28 Oct 2020 15:54:28 +0100 (CET)
Date:   Wed, 28 Oct 2020 15:54:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v3 6/6] rcu/tree: Use irq_work_queue_remote()
Message-ID: <20201028145428.GE2628@hirez.programming.kicks-ass.net>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.584884062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028111221.584884062@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:07:13PM +0100, Peter Zijlstra wrote:
> AFAICT we only need/use irq_work_queue_on() on remote CPUs, since we
> can directly access local state.  So avoid the IRQ_WORK dependency and
> use the unconditionally available irq_work_queue_remote().
> 
> This survives a number of TREE01 runs.

OK, Paul mentioned on IRC that while it is extremely unlikely, this code
does not indeed guarantee it will not try to IPI self.

I'll try again.
