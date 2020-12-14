Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD17D2D9A84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408376AbgLNPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgLNPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:02:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CFCC061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gQ8my8J+l/a7Fgwka54XyIRI3TWb+M+nmKWvz9kJzqA=; b=KjF0BD3xpn7idtU8wdpMstJYkf
        Zg+Xpj9GqHgEy/MwZMb6mj0CunLx64ktWe05XTkdJYzq3qharxYduhrx6/dWxqJJKlHEKIOabDiMV
        1JJcQdkVSlV5xD3eO8vityHN1I4qB6wid0AHB+IC2c35/EeINYhu1TMlaTl+W3H3D9XYSr/GVKb5X
        WNgoCOrQ4e6mvDpVzCKqmi5FIVYQiABsxCG7T/ARQUghZofx651gg7OYh8wyZD5/N0+JGYrtV6/YO
        xUtFGRuQgKuhcTYpdZfdGMNr/Wc5XonXbN3fxVA66VtIcpk2UEXP7Dkg6QlnxCIdPCyVKMTa6BukU
        WoNAysUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kopLd-0006ab-Bi; Mon, 14 Dec 2020 15:01:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6385E302753;
        Mon, 14 Dec 2020 16:01:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35A8721ADBDD5; Mon, 14 Dec 2020 16:01:11 +0100 (CET)
Date:   Mon, 14 Dec 2020 16:01:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201214150111.GY3021@hirez.programming.kicks-ass.net>
References: <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net>
 <20201211174442.GU3040@hirez.programming.kicks-ass.net>
 <20201211204337.GX3371@techsingularity.net>
 <20201211221905.GV3040@hirez.programming.kicks-ass.net>
 <20201211225002.GY3371@techsingularity.net>
 <CAKfTPtDBX+scBZiYtDSkXYn7SKDoGYWJiMpCiUvdW1XFz-Fb-Q@mail.gmail.com>
 <20201214093122.GX3040@hirez.programming.kicks-ass.net>
 <20201214123632.GZ3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214123632.GZ3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:36:32PM +0000, Mel Gorman wrote:
> As the merge window is open, it's inevitable that this will need to be
> evaluated against 5.11-rc1 when all the current batch of scheduler code
> has been merged. Do you mind splitting your prototype into three patches
> and slap some sort of changlog on them?

Sure, I'm afraid it's a little more than 3, but I'll get on it.
