Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243A9283073
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJEGup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgJEGup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 02:50:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E271C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 23:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GJUpUtp2rk6q+9JVJzHo0nbgHjeO9RytnpZ6JpQAgIQ=; b=2HR5XK1UxmuXEEEAjsgOQV/M6T
        3D0P1XaP7/oSt7VYo5P7DoLziG8U7C/fZRb3RoP7oJnRPNLh/EWo7X9ug7SxqwPXJcRReNngD4Zu3
        h34xo6OREwrnDitHgrxvYt/LWDSCeUPvuir2qlQwPg53dAIy5M9Mb/jxVsvSbaOJ8USW4FhKls/1a
        WSDGL2TxX+AL+jXUFp+g+6XnAK54vOvR2doXS9b67SrfXJRZeIeehxZEI6tBcmIdGlsmxIHDbjgkZ
        lgJ6cyP6099W+wkkEX2FZ9ukGN4EpzfMvFgxXPNAy7mOmF6MexEs6nKo8Hx6qIJf/+yxSYqiPHjrg
        I5kB4Biw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPKK0-0004BN-L2; Mon, 05 Oct 2020 06:50:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 226F43011C6;
        Mon,  5 Oct 2020 08:49:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CD0729E463C9; Mon,  5 Oct 2020 08:49:59 +0200 (CEST)
Date:   Mon, 5 Oct 2020 08:49:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: Re: [sched/fair] fcf0553db6: netperf.Throughput_Mbps -30.8%
 regression
Message-ID: <20201005064959.GD2628@hirez.programming.kicks-ass.net>
References: <20201004132716.GS393@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004132716.GS393@shao2-debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 09:27:16PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -30.8% regression of netperf.Throughput_Mbps due to commit:
> 
> 
> commit: fcf0553db6f4c79387864f6e4ab4a891601f395e ("sched/fair: Remove meaningless imbalance calculation")

This is the middle of a series that reworks the load balancer. Does this
regression still exist at the end of it?

Which would be around:

  57abff067a08 ("sched/fair: Rework find_idlest_group()")

or possible a little later, Vincent?
