Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC92869D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgJGVJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJGVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:09:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C91C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vyE86oabM9baijKIhOcxLJ3NuZI3IAA8m24Vc4mZcXI=; b=ZAgyTzlb8qgwVgcdaPNWWRn+8s
        eAA/+uUZ3ea1NQwU7v3BTtEoO7bxqhwpL0EEDm5RLEyBVtk1TpdCUrrw5UY/HibzwdKCVehTpW1SZ
        M7BpXpR4TVG932oo1SOlB3zt2w8zHXv0IsYFx0ntHGGnGZ6pun0/yE4JzFiP8wTQvk0ATWxSPDiRS
        y0BGdhKl9F036WeyRfIGl0dn0xsgYlMCSrxh2XogUNWtLd/rkExo9MB9Dq+HTroVwxoApNDwSqNUq
        wliVq3WNv/F8JBJSE0Q57a8cQyIgr2sGKwCONfdUvA9/wZewp3vxm8cpkAldzpJkFqlXqfIQ/QX4A
        scG4ysRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQGg7-0006O6-Sr; Wed, 07 Oct 2020 21:08:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F284300B22;
        Wed,  7 Oct 2020 23:08:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F3A52B2CAB82; Wed,  7 Oct 2020 23:08:50 +0200 (CEST)
Date:   Wed, 7 Oct 2020 23:08:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201007210850.GQ2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
 <jhjpn5tn8mz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjpn5tn8mz.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 08:22:44PM +0100, Valentin Schneider wrote:
> +		struct task_struct *curr = class->peek_next_task(rq);

If you look at the core-sched patches they have something very similar
:-)
