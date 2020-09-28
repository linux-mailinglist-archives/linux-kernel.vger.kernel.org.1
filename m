Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC5227AA29
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgI1JCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1JCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:02:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D50C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JC69PFZHwhcQINGVLis8MFtngUVCRlgWy9cisHR+b1o=; b=nD81SSjnDz+xKVR0dwrgT3OX9w
        ZI5R4ZFD0tqZhtT9a/IdKkYi4dh+NhHOw6T5RRUqbZDjmnr68TZI+mYnNd4r1RKTvWko2pQDMZFaT
        XJVbrtSFxdmqBEw1DeGtxZW+PsRIfk7WbCvzhZua2IsGXZswZmQemoz3Bji7UWnYGUM5U7zqYwQ+q
        9VmwJ0ZZbX7UdcY0lZYGEIhFK9ICoBaqdV22VkGa3VXbEbVLRx4gR0iaSKhs7eABcLjoeP3ebMEwk
        BU5VeFLsC2VZMSAvo2rvbLr/irbxaJd5z/Ecq3sTa4YKdtgQLU74q8ZAlttQAzhqmNB8Ra+L44BvK
        ifsmSOEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMp2X-00006i-UD; Mon, 28 Sep 2020 09:01:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 743D8300F7A;
        Mon, 28 Sep 2020 11:01:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5713F200D90B3; Mon, 28 Sep 2020 11:01:43 +0200 (CEST)
Date:   Mon, 28 Sep 2020 11:01:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com
Subject: Re: [External] Re: [PATCH 2/2] sched: mark
 PRINTK_DEFERRED_CONTEXT_MASK in __schedule()
Message-ID: <20200928090143.GA2628@hirez.programming.kicks-ass.net>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
 <20200928073202.GA2611@hirez.programming.kicks-ass.net>
 <40ab934e-5b8b-735b-da65-3043efab9fdc@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40ab934e-5b8b-735b-da65-3043efab9fdc@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 04:54:53PM +0800, Chengming Zhou wrote:
> 
> 在 2020/9/28 下午3:32, Peter Zijlstra 写道:
> > On Mon, Sep 28, 2020 at 12:11:30AM +0800, Chengming Zhou wrote:
> >> The WARN_ON/WARN_ON_ONCE with rq lock held in __schedule() should be
> >> deferred by marking the PRINTK_DEFERRED_CONTEXT_MASK, or will cause
> >> deadlock on rq lock in the printk path.
> > It also shouldn't happen in the first place, so who bloody cares.
> 
> Yes, but if our box deadlock just because a WARN_ON_ONCE, we have to
> reboot : (

You have to reboot anyway to get into the fixed kernel.

> So these WARN_ON_ONCE have BUG_ON effect ?  Or we should change to use
> BUG_ON ?

Or use a sane printk implementation, I never suffer this.
