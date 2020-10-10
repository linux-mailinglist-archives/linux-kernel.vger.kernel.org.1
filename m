Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD64F28A2CE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbgJJW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:31 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:40750 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388243AbgJJU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 16:59:32 -0400
Received: from librem (deer0x15.wildebeest.org [172.31.17.151])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 14B693000661;
        Sat, 10 Oct 2020 22:59:23 +0200 (CEST)
Received: by librem (Postfix, from userid 1000)
        id 1973CC0289; Sat, 10 Oct 2020 22:58:36 +0200 (CEST)
Date:   Sat, 10 Oct 2020 22:58:36 +0200
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
Message-ID: <20201010205836.GA2666@wildebeest.org>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
 <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
 <20201008070231.GS2628@hirez.programming.kicks-ass.net>
 <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
 <20201008212259.gdhlwdswn5pu4zos@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20201008212259.gdhlwdswn5pu4zos@two.firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 08, 2020 at 02:23:00PM -0700, Andi Kleen wrote:
> > Basically you simply want to remove this line in the top-level
> > Makefile:
> > 
> > DEBUG_CFLAGS    := $(call cc-option, -fno-var-tracking-assignments)
> 
> It looks like this was needed as a workaround for a gcc bug that was there
> from 4.5 to 4.9.
> 
> So I guess could disable it for 5.0+ only. 

Yes, that would work. I don't know what the lowest supported GCC
version is, but technically it was definitely fixed in 4.10.0, 4.8.4
and 4.9.2. And various distros would probably have backported the
fix. But checking for 5.0+ would certainly give you a good version.

How about the attached?

Cheers,

Mark
--TB36FDmn/VVEgNH/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Only-add-fno-var-tracking-assignments-workaround-for.patch"

From 48628d3cf2d829a90cd6622355eada1b30cb10c1 Mon Sep 17 00:00:00 2001
From: Mark Wielaard <mark@klomp.org>
Date: Sat, 10 Oct 2020 22:47:21 +0200
Subject: [PATCH] Only add -fno-var-tracking-assignments workaround for old GCC
 versions.

Some old GCC versions between 4.5.0 and 4.9.1 might miscompile code
with -fvar-tracking-assingments (which is enabled by default with -g -O2).
commit 2062afb4f added -fno-var-tracking-assignments unconditionally to
workaround this. But newer versions of GCC no longer have this bug, so
only add it for versions of GCC before 5.0.

Signed-off-by: Mark Wielaard <mark@klomp.org>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f84d7e4ca0be..4f4a9416a87a 100644
--- a/Makefile
+++ b/Makefile
@@ -813,7 +813,9 @@ KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
 KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
 endif
 
-DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
+# Workaround https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801
+# for old versions of GCC.
+DEBUG_CFLAGS	:= $(call cc-ifversion, -lt, 0500, $(call cc-option, -fno-var-tracking-assignments))
 
 ifdef CONFIG_DEBUG_INFO
 ifdef CONFIG_DEBUG_INFO_SPLIT
-- 
2.18.4


--TB36FDmn/VVEgNH/--
