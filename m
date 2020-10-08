Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B242871B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgJHJiC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Oct 2020 05:38:02 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:43594 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJHJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:38:02 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2020 05:38:02 EDT
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id E1828300160F;
        Thu,  8 Oct 2020 11:32:32 +0200 (CEST)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id 945F440007BE; Thu,  8 Oct 2020 11:32:32 +0200 (CEST)
Message-ID: <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
Subject: Re: Additional debug info to aid cacheline analysis
From:   Mark Wielaard <mark@klomp.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Cc:     linux-toolchains@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <andi@firstfloor.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Date:   Thu, 08 Oct 2020 11:32:32 +0200
In-Reply-To: <20201008070231.GS2628@hirez.programming.kicks-ass.net>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
         <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
         <20201008070231.GS2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2020-10-08 at 09:02 +0200, Peter Zijlstra wrote:
> Some time ago, I had my intern pursue the other 2 approaches for
> > symbolization. The one I see as most promising is by using the DWARF
> > information (no BPF needed). The good news is that I believe we do not
> > need more information than what is already there. We just need the
> > compiler to generate valid DWARF at most optimization levels, which I
> > believe is not the case for LLVM based compilers but maybe okay for
> > GCC.
> 
> Right, I think GCC improved a lot on this front over the past few years.
> Also added Andi and Masami, who have worked on this or related topics.

For GCC Alexandre Oliva did a really thorough write up of all the
various optimization and their effect on debugging/DWARF:
https://www.fsfla.org/~lxoliva/writeups/gOlogy/gOlogy.html

GCC using -fvar-tracking and -fvar-tracking-assignments is pretty good
at keeping track of where variables are held (in memory or registers)
when in the program, even through various optimizations.

-fvar-tracking-assignments is the default with -g -O2.
Except for the upstream linux kernel code. Most distros enable it
again, but you do want to enable it by hand when building from the
upstream linux git repo.

Basically you simply want to remove this line in the top-level
Makefile:

DEBUG_CFLAGS    := $(call cc-option, -fno-var-tracking-assignments)

Cheers,

Mark
