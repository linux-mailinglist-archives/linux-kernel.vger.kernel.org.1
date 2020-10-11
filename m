Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378BC28A757
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbgJKM2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 08:28:17 -0400
Received: from albireo.enyo.de ([37.24.231.21]:59862 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387809AbgJKM2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 08:28:17 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kRaSP-0007ye-GW; Sun, 11 Oct 2020 12:28:09 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kRaSP-0004Lt-Be; Sun, 11 Oct 2020 14:28:09 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mark Wielaard <mark@klomp.org>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-toolchains@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Phillips\, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Additional debug info to aid cacheline analysis
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
        <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
        <20201008070231.GS2628@hirez.programming.kicks-ass.net>
        <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
        <20201008212259.gdhlwdswn5pu4zos@two.firstfloor.org>
        <20201010205836.GA2666@wildebeest.org>
        <87h7r1x8kp.fsf@mid.deneb.enyo.de>
        <20201011122336.GC2666@wildebeest.org>
Date:   Sun, 11 Oct 2020 14:28:09 +0200
In-Reply-To: <20201011122336.GC2666@wildebeest.org> (Mark Wielaard's message
        of "Sun, 11 Oct 2020 14:23:36 +0200")
Message-ID: <874kn1x7za.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Wielaard:

> On Sun, Oct 11, 2020 at 02:15:18PM +0200, Florian Weimer wrote:
>> * Mark Wielaard:
>> 
>> > Yes, that would work. I don't know what the lowest supported GCC
>> > version is, but technically it was definitely fixed in 4.10.0, 4.8.4
>> > and 4.9.2. And various distros would probably have backported the
>> > fix. But checking for 5.0+ would certainly give you a good version.
>> >
>> > How about the attached?
>> 
>> Would it be possible to test for the actual presence of the bug, using
>> -fcompare-debug?
>
> Yes, that was discussed in the original commit message, but it was decided
> that disabling it unconditionaly was easier. See commit 2062afb4f.

I think the short test case was not yet available at the time of the
Linux commit.  But then it may not actually detect the bug in all
affected compilers.

Anyway, making this conditional on the GCC version is already a clear
improvement.
