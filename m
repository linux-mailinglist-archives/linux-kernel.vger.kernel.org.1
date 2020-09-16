Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E758426CB38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgIPUYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgIPR2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:28:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E8DC0698E0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z9WWijjbR2uBiL+KUZRKbMWPO3w9bu66TpFyviEWxgU=; b=KzrqmxbsJhALZYZchk5+ye8x0L
        UrPqUzSFf4IuLfor+B3fpLQc02EPdViLN6Lz1Y/u7Cm0FUUr19SUlz7D0qhwdArn6mtXBA0cnbI06
        4CROo9MfiWJbpoMRtDXk+JCWQBbDiX2S/i1EcFAeAhbgGFxD/hNsb8MgSM92nM61AlS2zyBUaCOzY
        2vaBYs/XPwmlXLsvKgvpkfFxngKEOlqSmAJoK6ZYuAWCUkStMM9UCrYI71Q1EcTchVELijBHhtxrt
        7LZNFtgHFHoBxsjv8Hza8N31NWfiQj0bxubOYCQMPagfLHcyv2SqIESmuXjhQ2qGW6AQEBgkj4shd
        5q5uUg6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIVxl-0008P9-T4; Wed, 16 Sep 2020 11:51:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E0583012DF;
        Wed, 16 Sep 2020 13:50:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10CE321242349; Wed, 16 Sep 2020 13:50:58 +0200 (CEST)
Date:   Wed, 16 Sep 2020 13:50:57 +0200
From:   peterz@infradead.org
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2] lockdep: Allow tuning tracing capacity constants.
Message-ID: <20200916115057.GO2674@hirez.programming.kicks-ass.net>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
 <0f7233f7-a04a-e9c9-7920-3a170cc97e4b@i-love.sakura.ne.jp>
 <CACT4Y+bjPr=64Lq1-ARD6T=K9LmC_Aor4BRXPcZVtUU8vF0oGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bjPr=64Lq1-ARD6T=K9LmC_Aor4BRXPcZVtUU8vF0oGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:28:19PM +0200, Dmitry Vyukov wrote:
> On Fri, Sep 4, 2020 at 6:05 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > Hello. Can we apply this patch?
> >
> > This patch addresses top crashers for syzbot, and applying this patch
> > will help utilizing syzbot's resource for finding other bugs.
> 
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> 
> Peter, do you still have concerns with this?

Yeah, I still hate it with a passion; it discourages thinking. A bad
annotation that blows up the lockdep storage, no worries, we'll just
increase this :/

IIRC the issue with syzbot is that the current sysfs annotation is
pretty terrible and generates a gazillion classes, and syzbot likes
poking at /sys a lot and thus floods the system.

I don't know enough about sysfs to suggest an alternative, and haven't
exactly had spare time to look into it either :/

Examples of bad annotations is getting every CPU a separate class, that
leads to nr_cpus! chains if CPUs arbitrarily nest (nr_cpus^2 if there's
only a single nesting level).
