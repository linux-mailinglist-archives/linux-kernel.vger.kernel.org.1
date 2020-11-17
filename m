Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023C72B6736
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgKQOQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:16:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35466C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HsUNgNf8PqCeaSKY0peEPzFgYbCaF/oYBGZNPhw49po=; b=Th4WCCcvO6LBDbtX+H+QC5+RT5
        OuHOBTVYZdG0AFAgrmmP1to5jWRvkJ1phRTaFxWqgwvtUOvawE+Ip2gf1+OaiQgNdGIJpK/c50zFt
        j/eT0c0xek0cBAsQJOdHtP3xsRz9epic5N5IkFdDsdtQXicATl66Z/sbKohBw9mHtfaMlvh1wLz53
        hPB/Zj8yhYkOme55U3uR2YS7x94HvQW/bnMOCnFLlAYQkINznORddSK1X8J+H7THqjzX3Yn7Xi4F2
        w4W0yQxpzgw/0/LTC2gSsRuGw8kz6+EeFXONKHzaqDuW9CmqTnUToayamaTAJH7q3BH2PjN3Klei1
        aURbLbaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf1mA-0000pq-9X; Tue, 17 Nov 2020 14:16:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A17223060AE;
        Tue, 17 Nov 2020 15:16:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A4FD203E65AE; Tue, 17 Nov 2020 15:16:03 +0100 (CET)
Date:   Tue, 17 Nov 2020 15:16:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/3] sched/numa: Allow a floating imbalance between NUMA
 nodes
Message-ID: <20201117141603.GM3121392@hirez.programming.kicks-ass.net>
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117134222.31482-3-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 01:42:21PM +0000, Mel Gorman wrote:
> This patch revisits the possibility that NUMA nodes can be imbalanced
> until 25% of the CPUs are occupied. The reasoning behind 25% is somewhat
> superficial -- it's half the cores when HT is enabled.  At higher
> utilisations, balancing should continue as normal and keep things even
> until scheduler domains are fully busy or over utilised.

Do we want to make that shift depend on the actual SMT factor?
