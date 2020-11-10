Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62C22ADC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgKJQyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:54:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D647BC0613CF;
        Tue, 10 Nov 2020 08:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/JW7zAEu/KyseFbd/mCJ5aW5DZyjb1JOiwJRbD3FVQ4=; b=VdE0VP5eqGUaDz03LJcUy3ywtP
        xBJck1yjad/JJJbZBQbGOcy7b+GlfmrMobVKa0WJBa5XbHM3T9ujOy3dMeJLcxM3vneLJyFoSs9kL
        C/MacVsw/Kj5ug26UAh8M1vUy5ojVxKSyTYrBogrGH5m3lENVJHmVS8PB/q5vgHJZdY6D65/MpIje
        3GqkDxIPIZ9g3lNbKCuPWtK8sTX4+0u3b9n4uAgaAznULT4jixHZ3G93LsO8i+nLmwnIwIiRv17PV
        QX6eddC7ueuZRahT9OUhuw9H9i8tSfNx6HX9iNRZpytv+9Xy9H3B6UOsVSJ/2RftBaikvYHfVT6Q7
        dohB4l0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcWuB-00082z-8r; Tue, 10 Nov 2020 16:54:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ECC67301324;
        Tue, 10 Nov 2020 17:54:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9A192BDD3975; Tue, 10 Nov 2020 17:54:01 +0100 (CET)
Date:   Tue, 10 Nov 2020 17:54:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] sched/debug: fix memory corruption caused by
 multiple small reads of flags
Message-ID: <20201110165401.GN2594@hirez.programming.kicks-ass.net>
References: <20201029151103.373410-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029151103.373410-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:11:03PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Reading /proc/sys/kernel/sched_domain/cpu*/domain0/flags mutliple times
> with small reads causes oopses with slub corruption issues because the kfree is
> free'ing an offset from a previous allocation. Fix this by adding in a new
> pointer 'buf' for the allocation and kfree and use the temporary pointer tmp
> to handle memory copies of the buf offsets.

Thanks!
