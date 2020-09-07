Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BA72603F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgIGR44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:56:56 -0400
Received: from foss.arm.com ([217.140.110.172]:33118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgIGLUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:20:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C31B911D4;
        Mon,  7 Sep 2020 04:02:27 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9DF33F66E;
        Mon,  7 Sep 2020 04:02:26 -0700 (PDT)
Date:   Mon, 7 Sep 2020 12:02:24 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200902135423.GB93959@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902135423.GB93959@lorien.usersys.redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/20 09:54, Phil Auld wrote:
> > 
> > I think this decoupling is not necessary. The natural place for those
> > scheduler trace_event based on trace_points extension files is
> > kernel/sched/ and here the internal sched.h can just be included.
> > 
> > If someone really wants to build this as an out-of-tree module there is
> > an easy way to make kernel/sched/sched.h visible.
> >
> 
> It's not so much that we really _want_ to do this in an external module.
> But we aren't adding more trace events and my (limited) knowledge of
> BPF let me to the conclusion that its raw tracepoint functionality
> requires full events.  I didn't see any other way to do it.

I did have a patch that allowed that. It might be worth trying to upstream it.
It just required a new macro which could be problematic.

https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b

With the above I could attach using bpf::RAW_TRACEPOINT mechanism.

Cheers

--
Qais Yousef
