Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1B2B5C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgKQKDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgKQKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:03:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W2njV6qhptTum2pwSbaYEbLR9rpBDr/wEbfn1YCvGgQ=; b=stBQ+PfRjKzf4sOn1dlxYMmkBL
        3Og3Kq7jEsLgNOgLEygY1uiYt5KhIRn69aof6VRQhCGD0WE5hYuR0gb8qrvTVWHzKF+pnSezeuswJ
        TzRwSaNOUJ0jEnql+lZTuB4nWLLpLZyJEScgI0jM+q5+Fkd4SZ/kLg73rL53/AtoNGXm1etoj7F8k
        xwW/9ZuusUBlU6vDsQZIGcbjBwDyFv983/oCWRaDU8nEKUFZsiP3fKLp45rF5HciYKfTRzyDdmofU
        4HGuOcnih+asxzJOtNb+mMnEyjLzqBqG5gJL8NVcUShdjYEh5JU6y4JgdJoEzstEC+8iUfen+kwsi
        2wiXYCuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kexpB-0007cK-Ef; Tue, 17 Nov 2020 10:02:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1A473060AE;
        Tue, 17 Nov 2020 11:02:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8773720116732; Tue, 17 Nov 2020 11:02:56 +0100 (CET)
Date:   Tue, 17 Nov 2020 11:02:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] locking-selftest: add option to proceed through
 unexpected failures
Message-ID: <20201117100256.GC3121406@hirez.programming.kicks-ass.net>
References: <20201113230048.1200162-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113230048.1200162-1-jim.cromie@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:00:48PM -0700, Jim Cromie wrote:
> Locking selftest is currently (v.5.10-rc3) seeing 14 unexpected failures.
> Add option to not disable debug_locks, so as to let it reveal any
> locking flaws in new unrelated work.

I'm assuming this is the arm64 fallout? Mark anything I can do to help
you there?

The reasoning doesn't make sense though; if it can't pass the selftest,
then why would you trust any further reports?
