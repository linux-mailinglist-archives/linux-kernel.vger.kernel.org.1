Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7223BB6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 15:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgHDNwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 09:52:31 -0400
Received: from foss.arm.com ([217.140.110.172]:44196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgHDNw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:52:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951F931B;
        Tue,  4 Aug 2020 06:52:27 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C88B3F718;
        Tue,  4 Aug 2020 06:52:26 -0700 (PDT)
References: <20200731192016.7484-1-valentin.schneider@arm.com> <20200731192016.7484-3-valentin.schneider@arm.com> <20200804112631.GG2657@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/3] sched/doc: Document capacity aware scheduling
In-reply-to: <20200804112631.GG2657@hirez.programming.kicks-ass.net>
Date:   Tue, 04 Aug 2020 14:52:21 +0100
Message-ID: <jhjbljqikmi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/08/20 12:26, peterz@infradead.org wrote:
> On Fri, Jul 31, 2020 at 08:20:15PM +0100, Valentin Schneider wrote:
>> Add some documentation detailing the concepts, requirements and
>> implementation of capacity aware scheduling across the different scheduler
>> classes.
>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  Documentation/scheduler/index.rst          |   1 +
>>  Documentation/scheduler/sched-capacity.rst | 439 +++++++++++++++++++++
>
> How about I make this a .txt file and remove all that unreadable rst
> nonsense?

I wouldn't mind *too* much, all diagrams are ASCII-based and the rest would
just be plain text.

I get that the whole backtick thing is a bit annoying, but it's only there for
symbols that aren't functions (since "foo()" gets automagically detected as
a C reference), and because they aren't functions I would've gone for some
other form of emphasis anyway (quotes or asterisks or something).

That said, Ingo picked it up early and it's already gone in via the
sched/core PR.
