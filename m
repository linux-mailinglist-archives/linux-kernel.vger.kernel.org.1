Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D517E2D2DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgLHO6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgLHO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:58:30 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555BDC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QhrUYq49bSuAo1dMLqIMqOl4H3E7qyXyy50oBZwc848=; b=vzyXrRgssGaCQwAHJHtWWK2e7K
        2DTPj0ahGGdUc13MoKFzt18oHHAWdSbbtez31WOfnrIbZJfF9sxzrLBJvw1R7O7tp/H+ZZ38C5w9g
        rBR2IvWaVCnWUNXaCyH1/c3bdULS/HzqwBVdqSwCrRs6G0nK5BE7mwVa5OkuDZvNjfefP75y3oghf
        jHyr+8hEVCb/zIixPwS070eS9UZDXcKB4qL+QmfZ2ruMWMjV41teFaFIa4s3VbIQRwCDJgvw0zbU+
        xVP5AxNB5TrFv0Evhy1sEQoxa9gxfWcXUZGPx74Ts5amdibEmMxwKssmfpydIsegdaWW16Rja8IIl
        HY3oM8sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmeQy-0002BJ-S7; Tue, 08 Dec 2020 14:57:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E92B304BAE;
        Tue,  8 Dec 2020 15:57:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63DED21ADBEA0; Tue,  8 Dec 2020 15:57:43 +0100 (CET)
Date:   Tue, 8 Dec 2020 15:57:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2 0/5] locking/rwsem: Rework reader optimistic spinning
Message-ID: <20201208145743.GF2414@hirez.programming.kicks-ass.net>
References: <20201121041416.12285-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121041416.12285-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:14:11PM -0500, Waiman Long wrote:
> Waiman Long (5):
>   locking/rwsem: Pass the current atomic count to
>     rwsem_down_read_slowpath()
>   locking/rwsem: Prevent potential lock starvation
>   locking/rwsem: Enable reader optimistic lock stealing
>   locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED
>   locking/rwsem: Remove reader optimistic spinning

So I've munged the lot onto the other rwsem patches and skipped #4, I've
not even boot tested them (will go do so shortly).

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core

