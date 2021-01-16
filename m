Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D702F8D20
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbhAPLoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbhAPLoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:44:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1592C061757
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 03:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0S7aTLnOpdE5r+G1zemiEs+dI4RjPxgUI8YvRh2QX/E=; b=im/VdLP9hOhy1Sb4h1IlW4UWqR
        5JpMNHrn+HKZkFhVYxgHdy+E9DbEjioXrLBc6oJdhtBiSkj95CQGtUlY7oh+WP8j4/8Gfn06XZyHF
        C+sR/qcJSXwTZhjX8UJU8wSPM8jIEX3aMJZ8ka+ubPNjGTBh/ZupczQvFS7DcM96cdFtdMvabuzd/
        OSzU65/tpZlGD+3lPySFe8xHN4+s34iqYgCA46Y9KK4+okNLaWo/sWUZcgDA3wQnt/khIkF2DmX5H
        vXGobxQlM/gvD1czfRtYGv+d0AzvxsRqCa2GIvkJB3g0aE1efcavLNEj53W+ktnpMsS7JFXJSyAmC
        ixlVLzdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0jyz-0002Cz-5i; Sat, 16 Jan 2021 11:43:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFAF830768E;
        Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 15D9020297EDB; Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Message-ID: <20210116113033.608340773@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 16 Jan 2021 12:30:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 0/8] sched: Fix hot-unplug regressions
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches (no longer 4), seems to fix all the hotplug regressions as per
nearly a 100 18*SRCU-P runs over-night.

I did clean up the patches, so possibly I wrecked it again. I've started new
runs and will again leave them running over-night.

Paul, if you could please also throw your monster machine at it.


