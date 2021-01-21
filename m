Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D177E2FF71D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbhAUVXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbhAUVWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:22:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAE6C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N+f+tQQSy+KftLzBnxx9MOKq4XwwRYGXJai/iz+5TuE=; b=1Vu1xzOa20dCnK/HZPGqSsUviO
        VL/2fonrG6kWopPZ4wvgnoqpqlq3plWvsUi4nOnIAEWfb9CJWR7z8yHi4V5s7LGHddeW2dgXNW+ez
        C9OgMjBNgmH+lEsrNyLKU8b7oCoeW7dWOqNrU9PYeJmgRvVL9CxP/VDNtQpU6+TKH9rz7pYSX1/Qd
        dc4MefUwXy6wEBuYZPU8cPLDHyUM6I8VWS94xxATIeEdJMLCs70bXxvLGNmu9mPTEuuxcvFTQopnc
        qzF0re7gFb3uJ2LTn0phAic5AhImqzfXkjMt5g8aG8bPSZoueir0HmGwvfdHjQFE7uc6/swsJXCYt
        ghlpwSzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2hP7-0002K8-C6; Thu, 21 Jan 2021 21:22:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAAC8984219; Thu, 21 Jan 2021 22:22:04 +0100 (CET)
Date:   Thu, 21 Jan 2021 22:22:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/7] preempt: Tune preemption flavour on boot v4
Message-ID: <20210121212204.GA16371@worktop.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118141223.123667-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:12:15PM +0100, Frederic Weisbecker wrote:
> * Uninline __static_call_return0 on all flavours since its address is
> always needed on DEFINE_STATIC_CALL()

obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
