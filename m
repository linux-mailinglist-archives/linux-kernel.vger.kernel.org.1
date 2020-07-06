Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A7D216155
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 00:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGFWLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 18:11:42 -0400
Received: from foss.arm.com ([217.140.110.172]:50892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgGFWLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:11:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E901C0A;
        Mon,  6 Jul 2020 15:11:41 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E873F718;
        Mon,  6 Jul 2020 15:11:39 -0700 (PDT)
References: <cover.1594062828.git.yu.c.chen@intel.com> <20200706200049.GB5523@worktop.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][RFC] Makes sd->flags sysctl writable
In-reply-to: <20200706200049.GB5523@worktop.programming.kicks-ass.net>
Date:   Mon, 06 Jul 2020 23:11:32 +0100
Message-ID: <jhj7dvg8faj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/07/20 21:00, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 03:36:13AM +0800, Chen Yu wrote:
>> It was found that recently the flags of sched domain could
>> not be customized via sysctl, which might make it a little
>> inconenient for performance tuning/debugging.
>
> What specific goals do you have? This is a debug interface.

Also, while the update_top_cache_domain() call on sysctl write may work,
you're back to square one as soon as you go through a hotplug cycle, which
is icky.

That said, I second Peter in that I'm curious as to what you're really
using this interface for. Manually hacking the default / arch topology
flags is a bit tedious, but it's doable.
