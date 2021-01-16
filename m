Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D102F8E0D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbhAPROF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbhAPRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:22 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5F6C061343
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 07:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lEkmXUGH1YNwygH6nrMd02lMU+09Eibdw952KwXXOg4=; b=ZeIf15YlVFCWTr1mJcvBAYNsl7
        hPSuVkaEKAz0N2k8fNsjQXf+huRm5Gmd5W7pWIlzZ06G1zNr8KAPpqqHNUj26UR7r/53nMWfqYk1r
        thzI9BRsGoW3jJXFOoKtg/QQFe3kuoSv3gmu9BIxzpyz9z/d4Ha1KeCFJdoTc+IBGxhrNz52lmXSh
        F4CdGyZ3LfQFEdsJyxgtZ67FxQRkzbrrmqbtSnalzkFwU8MTRilSPYIcx8uPv3GNOnyQ/QMyKHImK
        9lCjvUDdfS3icHfZ7e/Itbn2zRN+Yab4xGZKPMS4x0YbGw2kdPJ9isUpWKmfMiBGWXySrGTUQ3eME
        BIjP5TOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0nSj-0005tv-B6; Sat, 16 Jan 2021 15:26:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 629E23010CF;
        Sat, 16 Jan 2021 16:25:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22F7C202A3F5A; Sat, 16 Jan 2021 16:25:58 +0100 (CET)
Date:   Sat, 16 Jan 2021 16:25:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH 0/8] sched: Fix hot-unplug regressions
Message-ID: <YAMFhsXamvCT2tzM@hirez.programming.kicks-ass.net>
References: <20210116113033.608340773@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116113033.608340773@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 12:30:33PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> These patches (no longer 4), seems to fix all the hotplug regressions as per
> nearly a 100 18*SRCU-P runs over-night.
> 
> I did clean up the patches, so possibly I wrecked it again. I've started new
> runs and will again leave them running over-night.

Hurph... I've got one splat from this version, one I've not seen before:

[   68.712848] Dying CPU not properly vacated!
...
[   68.744448] CPU1 enqueued tasks (2 total):
[   68.745018]  pid: 14, name: rcu_preempt
[   68.745557]  pid: 18, name: migration/1

Paul, rcu_preempt, is from rcu_spawn_gp_kthread(), right? Afaict that
doesn't even have affinity.. /me wonders HTH that ended up on the
runqueue so late.

