Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DA328A2E0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgJJW7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:42 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:42086 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgJJWDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:03:09 -0400
Received: from librem (deer0x15.wildebeest.org [172.31.17.151])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 8235A3000661;
        Sat, 10 Oct 2020 23:52:23 +0200 (CEST)
Received: by librem (Postfix, from userid 1000)
        id 85F18C03E5; Sat, 10 Oct 2020 23:51:35 +0200 (CEST)
Date:   Sat, 10 Oct 2020 23:51:35 +0200
From:   Mark Wielaard <mark@klomp.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20201010215135.GB2666@wildebeest.org>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
 <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
 <20201008070231.GS2628@hirez.programming.kicks-ass.net>
 <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
 <20201008212259.gdhlwdswn5pu4zos@two.firstfloor.org>
 <20201010205836.GA2666@wildebeest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010205836.GA2666@wildebeest.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 10:58:36PM +0200, Mark Wielaard wrote:
> Yes, that would work. I don't know what the lowest supported GCC
> version is, but technically it was definitely fixed in 4.10.0, 4.8.4
> and 4.9.2. And various distros would probably have backported the
> fix. But checking for 5.0+ would certainly give you a good version.
> 
> How about the attached?

Looks like vger just throws away emails with patch attachements.  How
odd.  I'll try sending it as reply to this message with git-send-email.

Cheers,

Mark

