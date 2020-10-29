Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE35029F38C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgJ2RpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgJ2RpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:45:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49543C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pvU0bRFf+ee7irAw16XQaow82QX7EAUSTiYdzLn5zrE=; b=sh0WB4GKC+nrPMlviGyB+ZMr0j
        0Ehh07Ah7xMcFb9AVCQ2TC9cM9N2jHDgMrm1ROJhXSxZ7TNRu6InQOKUZdawX2PE7YyREQZI9R6jq
        XQRQT9KGhQFPH2omKMXuPMtFIyXcHUh9rKqe8tTStdRqsBS35PJWmtpoRPoFGC6kVmFG71DP3XzR6
        Vbwx7myGI59xHo6VrmmBJYPNFazPWbfN4qMLIvDKHSvMsDZke8MFXy/x9NzYhBLYJVFdd6rC2k/0E
        CG8eYWSs8Nbq55fG78zFod51p0ngVogHrVytSIrffRgkwZCLLp2M9bTTaoFVzHxcn4ZqPU04qpIo1
        rVYfFPXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYByk-0000jt-H0; Thu, 29 Oct 2020 17:44:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E424B3070F9;
        Thu, 29 Oct 2020 18:44:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFC52203C53DB; Thu, 29 Oct 2020 18:44:49 +0100 (CET)
Date:   Thu, 29 Oct 2020 18:44:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 19/19] sched: Comment affine_move_task()
Message-ID: <20201029174449.GW2628@hirez.programming.kicks-ass.net>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.866412704@infradead.org>
 <jhj8sbpov3y.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj8sbpov3y.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 04:27:45PM +0000, Valentin Schneider wrote:
> I too must have been thinking too much about ponies lately.

> - * pending affinity completion is preceded an uninstallion of
> + * pending affinity completion is preceded by an uninstallation of

Hah!, took me a few tries to figure out wth 'by' had to do with ponies.
Reading be hard ;-)
