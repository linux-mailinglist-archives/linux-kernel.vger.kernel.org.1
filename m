Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C22D7617
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406036AbgLKMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406014AbgLKMxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:53:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419BC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 04:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Swfhd6WgUwUnkgWTJy/BehJntsBBalR8+27Yg0XtkW0=; b=gqvLKRIIqqhDppeb3rBg/UepYW
        cM4oxkIMEIFq5rEBoq+MAWlsNvZ3hOG8sudrYvRRjAJJcQz4UeIz259CXtAvNPTvdcY6iK8PZJ4tS
        WY1KA628V/MMpKVd9xm7UlE9uh2ewNGyzy5vHwGGqe/5mnFrj6PBPzvn+dlqweVfup60VTqCaOiSF
        UUFkw5RZx+G/458z2XT7v3DwMtIb+dJO7RCWe9Yn9aSSuKeAQ37Pxfg5WphWFgDO7aEuGTer9Npwu
        1ikALN8H17lMdusmZm8mrxVSgy1fy8oEzmjJyHFf6kYt/lU+X3sVE6VIY+eY05rN7U7esPzwNM+48
        UsGfLYYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knhu1-0003gG-FM; Fri, 11 Dec 2020 12:52:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EF393011E6;
        Fri, 11 Dec 2020 13:52:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 009FD2C12D788; Fri, 11 Dec 2020 13:52:03 +0100 (CET)
Date:   Fri, 11 Dec 2020 13:52:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com, Qian Cai <cai@redhat.com>
Subject: Re: [PATCH 0/2] workqueue: Fix migrate_disable hotplug changes vs
 kworker affinity
Message-ID: <20201211125203.GY2414@hirez.programming.kicks-ass.net>
References: <20201210163830.21514-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210163830.21514-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 04:38:28PM +0000, Valentin Schneider wrote:
> Valentin Schneider (2):
>   stop_machine: Add caller debug info to queue_stop_cpus_work
>   workqueue: Fix affinity of kworkers attached during late hotplug
> 
>  kernel/stop_machine.c |  1 +
>  kernel/workqueue.c    | 24 +++++++++++++++++-------
>  2 files changed, 18 insertions(+), 7 deletions(-)

TJ, would you be okay if I take these through the sched tree that
contain the migrate_disable() patches, such that problem and fix stay
together?
