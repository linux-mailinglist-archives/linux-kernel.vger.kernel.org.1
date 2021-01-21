Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE22FE70B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbhAUKDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:03:32 -0500
Received: from gentwo.org ([3.19.106.255]:52768 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbhAUKCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:02:45 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 5E6563F04E; Thu, 21 Jan 2021 10:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 5C1C43EFF6;
        Thu, 21 Jan 2021 10:01:57 +0000 (UTC)
Date:   Thu, 21 Jan 2021 10:01:57 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Bharata B Rao <bharata@linux.ibm.com>
cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        vbabka@suse.cz, shakeelb@google.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
In-Reply-To: <20210121053003.GB2587010@in.ibm.com>
Message-ID: <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
References: <20201118082759.1413056-1-bharata@linux.ibm.com> <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com> <20210121053003.GB2587010@in.ibm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021, Bharata B Rao wrote:

> > The problem is that calculate_order() is called a number of times
> > before secondaries CPUs are booted and it returns 1 instead of 224.
> > This makes the use of num_online_cpus() irrelevant for those cases
> >
> > After adding in my command line "slub_min_objects=36" which equals to
> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> > , the regression diseapears:
> >
> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
>
> Should we have switched to num_present_cpus() rather than
> num_online_cpus()? If so, the below patch should address the
> above problem.

There is certainly an initcall after secondaries are booted where we could
redo the calculate_order?

Or the num_online_cpus needs to be up to date earlier. Why does this issue
not occur on x86? Does x86 have an up to date num_online_cpus earlier?


