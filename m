Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625F728A750
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 14:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbgJKMYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 08:24:31 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:55642 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgJKMYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 08:24:30 -0400
Received: from librem (deer0x15.wildebeest.org [172.31.17.151])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 1EE5530291AC;
        Sun, 11 Oct 2020 14:24:24 +0200 (CEST)
Received: by librem (Postfix, from userid 1000)
        id 783EAC1BBF; Sun, 11 Oct 2020 14:23:36 +0200 (CEST)
Date:   Sun, 11 Oct 2020 14:23:36 +0200
From:   Mark Wielaard <mark@klomp.org>
To:     Florian Weimer <fw@deneb.enyo.de>
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
Message-ID: <20201011122336.GC2666@wildebeest.org>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
 <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
 <20201008070231.GS2628@hirez.programming.kicks-ass.net>
 <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
 <20201008212259.gdhlwdswn5pu4zos@two.firstfloor.org>
 <20201010205836.GA2666@wildebeest.org>
 <87h7r1x8kp.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7r1x8kp.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 02:15:18PM +0200, Florian Weimer wrote:
> * Mark Wielaard:
> 
> > Yes, that would work. I don't know what the lowest supported GCC
> > version is, but technically it was definitely fixed in 4.10.0, 4.8.4
> > and 4.9.2. And various distros would probably have backported the
> > fix. But checking for 5.0+ would certainly give you a good version.
> >
> > How about the attached?
> 
> Would it be possible to test for the actual presence of the bug, using
> -fcompare-debug?

Yes, that was discussed in the original commit message, but it was decided
that disabling it unconditionaly was easier. See commit 2062afb4f.

Cheers,

Mark
