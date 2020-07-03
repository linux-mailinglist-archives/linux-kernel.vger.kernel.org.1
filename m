Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B483D214082
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 22:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGCUv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgGCUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:51:59 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA93C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 13:51:59 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1jrSf4-00057k-B1; Fri, 03 Jul 2020 16:51:54 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id F3887560110; Fri,  3 Jul 2020 16:51:53 -0400 (EDT)
Date:   Fri, 3 Jul 2020 16:51:53 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200703205153.GA19901@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
 <20200703090226.GV4800@hirez.programming.kicks-ass.net>
 <20200703104033.GK117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703104033.GK117543@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 12:40:33PM +0200, Peter Zijlstra wrote:
 
 > So ARM/Power/etc.. can speculate the load such that the
 > task_contributes_to_load() value is from before ->on_rq.
 > 
 > The compiler might similar re-order things -- although I've not found it
 > doing so with the few builds I looked at.
 > 
 > So I think at the very least we should do something like this. But i've
 > no idea how to reproduce this problem.
 > 
 > Mel's patch placed it too far down, as the WF_ON_CPU path also relies on
 > this, and by not resetting p->sched_contributes_to_load it would skew
 > accounting even worse.

looked promising the first few hours, but as soon as it hit four hours
of uptime, loadavg spiked and is now pinned to at least 1.00

	Dave
