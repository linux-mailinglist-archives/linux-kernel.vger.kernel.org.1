Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACAC28A713
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 13:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgJKLHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 07:07:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:34095 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgJKLHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 07:07:49 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09BB4NkW006661;
        Sun, 11 Oct 2020 06:04:24 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09BB4Kuw006658;
        Sun, 11 Oct 2020 06:04:20 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 11 Oct 2020 06:04:20 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
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
        "Phillips, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Additional debug info to aid cacheline analysis
Message-ID: <20201011110420.GO2672@gate.crashing.org>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net> <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com> <20201008070231.GS2628@hirez.programming.kicks-ass.net> <50338de81b34031db8637337f08b89b588476211.camel@klomp.org> <20201008212259.gdhlwdswn5pu4zos@two.firstfloor.org> <20201010205836.GA2666@wildebeest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010205836.GA2666@wildebeest.org>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Oct 10, 2020 at 10:58:36PM +0200, Mark Wielaard wrote:
> On Thu, Oct 08, 2020 at 02:23:00PM -0700, Andi Kleen wrote:
> > So I guess could disable it for 5.0+ only. 
> 
> Yes, that would work. I don't know what the lowest supported GCC
> version is, but technically it was definitely fixed in 4.10.0, 4.8.4
> and 4.9.2.

Fwiw, GCC 4.10 was renamed to GCC 5 before it was released (it was the
first release with the new version number scheme).  Only old development
versions (that no one should use) identify as 4.10.

> And various distros would probably have backported the
> fix. But checking for 5.0+ would certainly give you a good version.

Yes, esp. since some versions of 4.9 and 4.8 are still buggy.  No one
should use any version for which a newer bug-fix release has long been
available, but do you want to deal with bugs from people who do not?


Segher
