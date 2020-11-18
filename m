Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78B2B7619
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 07:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKRF7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 00:59:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:56700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgKRF7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 00:59:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A321AC24;
        Wed, 18 Nov 2020 05:59:02 +0000 (UTC)
Date:   Tue, 17 Nov 2020 21:35:56 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Message-ID: <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201118030429.23017-6-longman@redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020, Waiman Long wrote:

>The column "CS Load" represents the number of pause instructions issued
>in the locking critical section. A CS load of 1 is extremely short and
>is not likey in real situations. A load of 20 (moderate) and 100 (long)
>are more realistic.
>
>It can be seen that the previous patches in this series have reduced
>performance in general except in highly contended cases with moderate
>or long critical sections that performance improves a bit. This change
>is mostly caused by the "Prevent potential lock starvation" patch that
>reduce reader optimistic spinning and hence reduce reader fragmentation.
>
>The patch that further limit reader optimistic spinning doesn't seem to
>have too much impact on overall performance as shown in the benchmark
>data.
>
>The patch that disables reader optimistic spinning shows reduced
>performance at lightly loaded cases, but comparable or slightly better
>performance on with heavier contention.

I'm not overly worried about the lightly loaded cases here as the users
(mostly thinking mmap_sem) most likely won't care for real workloads,
not, ie: will-it-scale type things.

So at SUSE we also ran into this very same problem with reader optimistic
spinning and considering the fragmentation went with disabling it, much
like this patch - but without the reader optimistic lock stealing bits
you have. So far nothing has really shown to fall out in our performance
automation. And per your data a single reader spinner does not seem to be
worth the added complexity of keeping reader spinning vs ripping it out.

Thanks,
Davidlohr
