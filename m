Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2937F1A690F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgDMPos convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Apr 2020 11:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbgDMPor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:44:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95DE220656;
        Mon, 13 Apr 2020 15:44:46 +0000 (UTC)
Date:   Mon, 13 Apr 2020 11:44:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?5a6L54mn5pil?= <songmuchun@bytedance.com>
Cc:     mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: add __init to sched_init_granularity
 functions
Message-ID: <20200413114444.5db76182@gandalf.local.home>
In-Reply-To: <CAMZfGtUY_GLXZ4jV4s0UZqsVF0W57dzUh0wVGynXYCy3CMN4iA@mail.gmail.com>
References: <20200406074750.56533-1-songmuchun@bytedance.com>
        <CAMZfGtUY_GLXZ4jV4s0UZqsVF0W57dzUh0wVGynXYCy3CMN4iA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 23:07:03 +0800
宋牧春 <songmuchun@bytedance.com> wrote:

> > -void sched_init_granularity(void)
> > +void __init sched_init_granularity(void)
> >  {
> >         update_sysctl();
> >  }
> > --
> > 2.11.0
> >  
> 
> Ping guys. Any suggestions?

Seems fine, but not that big of an issue as it's a very small function.

ffffffff81136880 <sched_init_granularity>:
ffffffff81136880:       e8 7b b3 ac 00          callq  ffffffff81c01c00 <__fentry__>
                        ffffffff81136881: R_X86_64_PLT32        __fentry__-0x4
ffffffff81136885:       e9 86 86 ff ff          jmpq   ffffffff8112ef10 <update_sysctl>
ffffffff8113688a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)


But anyway, it can save 16 bytes of memory in the running kernel.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
