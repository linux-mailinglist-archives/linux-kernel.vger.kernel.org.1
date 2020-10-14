Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED04D28E783
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgJNTqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNTqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:46:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6353BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3xpygiCiurmA1P7ABSbAkyvSiy9WK/xyVg/hrK3R8uI=; b=HLFvR36znUO54i4KhqBChMOQUp
        gUZOi4Kgy6Uz6Z3RtxqLQhF3k5BEqF7IBd05usOANRBfus7IWwK/mVT37o8nn1zY0v/sGKdp37ix6
        xxDjbl+dgzE7rXJHdcXmi8O2/mqKohhD0NAldEWk3S5fH9U2E5msRxp7RUoxpH7UuAjorarJPmkyU
        jYxpgsE3zQyS0cg2eW1bYa6rCVJG8cYetHV+0b54n8MmdAZlBZwtb8GnI+OAPd3kGi+ZhnY1Ou9SQ
        KBTA4MUuLJX3EW4VkR0R9Sdt2ilQvytfC46VIVNa7WMyM+WJdGCIRpKywoSGpYOLxLkQRGujhSXxB
        V3uhmdbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSmjJ-0001wi-LJ; Wed, 14 Oct 2020 19:46:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AC14980F54; Wed, 14 Oct 2020 21:46:30 +0200 (CEST)
Date:   Wed, 14 Oct 2020 21:46:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sched/cpupri: Cleanup cpu priority vector handling
Message-ID: <20201014194630.GB2974@worktop.programming.kicks-ass.net>
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922083934.19275-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:39:32AM +0200, Dietmar Eggemann wrote:
> Two of the 102 elements of the cpu priority vector, among them the one
> for MAX_PRIO (140) representing the IDLE task, are never used.
> 
> Remove them and adapt the cpupri implementation accordingly.
> 
> Dietmar Eggemann (2):
>   sched/cpupri: Remove pri_to_cpu[CPUPRI_IDLE]
>   sched/cpupri: Remove pri_to_cpu[1]

Thanks!, I've also got a few more patches on top, I'll post them
separately.
