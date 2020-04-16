Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14511ABEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505911AbgDPK7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 06:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505840AbgDPK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:58:54 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF972C02C444
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NtnNGmlGPTwRKZ1Q+5wTjwAsOTAHrQj/JuJqY7+2rjs=; b=BjSDPCBYfWFThRkvm8iktpdgsb
        BllI6Ng/MvrX+cIT6yk9JffYzKqQSUZfIq2Nzc/aWuDAUxgZgtwNvJZhyzcDcerjBJ521lUQNdhnN
        Xqt9kDecKhmh2/d+M2awlwYeFF/pZc8OzXGblW6YDMzKs/G8Nx9/jXyBag/M5ZHVAD/uIrNse1qUv
        YoNuO16q5fxILiD+1TooTGxJ8VoCl+hRo59KTv/pm9HerLlx990iDzJB2Ilhi9chzz23KOnYcdtqT
        Vp6nVXsnaBD3tdX7ap/eIZp6GOmHr2OM/S8EZKwDjALsJbrM3O+gJMXo7n4oczhdCf8POEjim3CrI
        I6vV0muQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP2E2-0005MF-5N; Thu, 16 Apr 2020 10:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B729F30477A;
        Thu, 16 Apr 2020 12:58:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C3232B0DC745; Thu, 16 Apr 2020 12:58:28 +0200 (CEST)
Date:   Thu, 16 Apr 2020 12:58:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 0/9] sched: Streamline select_task_rq() &
 select_task_rq_fair()
Message-ID: <20200416105828.GN20730@hirez.programming.kicks-ass.net>
References: <20200415210512.805-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415210512.805-1-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:05:03PM +0100, Valentin Schneider wrote:
> Valentin Schneider (9):
>   sched/fair: find_idlest_group(): Remove unused sd_flag parameter
>   sched/debug: Make sd->flags sysctl read-only
>   sched: Remove checks against SD_LOAD_BALANCE
>   sched/topology: Kill SD_LOAD_BALANCE
>   sched: Add WF_TTWU, WF_EXEC wakeup flags

How about I queue two first 5, and you rework these last few?

>   sched: Kill select_task_rq()'s sd_flag parameter
>   sched/fair: Dissociate wakeup decisions from SD flag value
>   sched/fair: Split select_task_rq_fair want_affine logic
>   sched/topology: Define and use shortcut pointers for wakeup sd_flag scan


