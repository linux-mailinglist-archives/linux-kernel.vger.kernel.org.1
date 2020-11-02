Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC62A2C7D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKBOSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgKBOQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:16:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377BDC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UD/OkCMd1FoU3EgKfSru1bYvN7JBNcEWgNchKvRXMSM=; b=W+zuVylnGl4SAsNM85FlVkuMLf
        iBAwv+Ow46wK0I0qTRTpgV4fXAxHAJlvx8bR6cX2taNKpNPlT+9kOLWDmQEy+L/wyDSAXc8wF38gF
        u0HyEM9cwy/o8uDy09QdzPHgRS2BAInsivfWoryyGEHYg+tKYRuzcxJyVwdeWwbqLfDYgidYg+OoL
        v1xQHlMtgujMNSrk7N9f/EfKFX05/rXu97E8PAovxV63g3SfA4lwN9dDVQqdEMmhb8OFtWAcj/FOB
        UOtY+uY5OX6YH82efGC5rnB5949UAyH0kWoJfKQL4mmwFuWUvcv1RabS6GnsowFQGxZ4IFOk5goU7
        DFoRgHDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZadJ-00083a-2u; Mon, 02 Nov 2020 14:16:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEAFE3011E6;
        Mon,  2 Nov 2020 15:16:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 929D72BEF6301; Mon,  2 Nov 2020 15:16:25 +0100 (CET)
Date:   Mon, 2 Nov 2020 15:16:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2 0/4] perf: Fix perf_event_attr::exclusive rotation
Message-ID: <20201102141625.GX2594@hirez.programming.kicks-ass.net>
References: <20201029162719.519685265@infradead.org>
 <20201031234418.GE3380099@krava>
 <20201102035238.GI466880@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102035238.GI466880@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 07:52:38PM -0800, Andi Kleen wrote:
> The main motivation is actually that the "multiple groups" algorithm
> in perf doesn't work all that great: it has quite a few cases where it
> starves groups or makes the wrong decisions. That is because it is very
> difficult (likely NP complete) problem and the kernel takes a lot
> of short cuts to avoid spending too much time on it.

The event scheduling should be starvation free, except in the presence
of pinned events.

If you can show starvation without pinned events, it's a bug.

It will also always do equal or better than exclusive mode wrt PMU
utilization. Again, if it doesn't it's a bug.

Please provide concrete examples for these two cases, or stop spreading
FUD like this.
