Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14048285EF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgJGMTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgJGMTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:19:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4787EC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GxyJCysyyUFn2SBni14w9VVCXVN2WYHlRgV6TdcztK4=; b=CzL4xp9rIsOOHuuO3kmXgeKOm0
        edC731oH5PJfuVz1WVFhQABbEWd+1LrcIjGvTJjs0gE734g5BFImGd+u8Df+DGeODmYDT8XgXvEGG
        Ji6+QzQrvv/k4nlv07rWcTPWFd33nWq8n+rK9kBp9qSBAl4Ti4OWKhvo18+NB+x31/DOhnmsKZJnv
        7alVKUQCX9wPk0CiLvyVly9J72pJxJQMQLRhyaHOaOSLe8B4zMTNh4lE2uqIA873+oBjmPisjA16W
        x0IVmX1IHtK63QDoIXpJ1mNw00sMxYzdWWHkqI3RdWQNJsrIJYeLr7vD9prGK5Np4gJfqVQsOCPcV
        1LqNhaFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ8Q0-0007vd-Ow; Wed, 07 Oct 2020 12:19:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 758D7300B22;
        Wed,  7 Oct 2020 14:19:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6026029AD6647; Wed,  7 Oct 2020 14:19:39 +0200 (CEST)
Date:   Wed, 7 Oct 2020 14:19:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201007121939.GE2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007120401.11200-1-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:04:01PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Many people are still relying on pre built distribution kernels and so
> distributions have to provide mutliple kernel flavors to offer different
> preemption models. Most of them are providing PREEMPT_NONE for typical
> server deployments and PREEMPT_VOLUNTARY for desktop users.

Is there actually a benefit to NONE? We were recently talking about
removing it.

The much more interesting (runtime) switch (IMO) would be between
VOLUNTARY and PREEMPT.
