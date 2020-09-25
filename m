Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB002279320
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgIYVSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgIYVSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:18:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A86D208B6;
        Fri, 25 Sep 2020 21:18:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kLv6h-002CsX-Ny; Fri, 25 Sep 2020 17:18:19 -0400
Message-ID: <20200925211206.423598568@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 25 Sep 2020 17:12:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 0/3 v2] tracing/mm: Add tracepoint_enabled() helper function for headers
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracepoints are not safe to be called directly from header files as they may
be included by C code that has CREATE_TRACE_POINTS defined, and this would
cause side effects and possibly break the build in hard to debug ways. Not
to mention it also will bloat the code being in commonly used inline
functions.

Instead, it is recommended to call a tracepoint helper function that is
defined in a C file that calls the tracepoint. But we would only want this
function to be called if the tracepoint is enabled, as function calls add
overhead.

The trace_<tracepoint>_enabled() function is also not safe to be called in a
header file as it is created by the tracepoint header, which suffers the
same fate if CREATE_TRACE_POINTS is defined. Instead, the tracepoint needs
to be declared as an extern, and the helper function can test the static key
to call the helper function that calls the tracepoint.

This has been done by open coding the tracepoint extern and calling the
static key directly:

 commit 95813b8faa0cd ("mm/page_ref: add tracepoint to track down page reference manipulation")
 commit 7f47d8cc039f ("x86, tracing, perf: Add trace point for MSR accesses")

does this (back in 2015). Now we have another use case, so a helper function
should be created to keep the internals of the tracepoints from being spread
out in other subsystems.

 Link: https://lore.kernel.org/r/20200922125113.12ef1e03@gandalf.local.home

This adds tracepoint_enabled() helper macro and DECLARE_TRACEPOINT() macro
to allow this to be done without exposing the internals of the tracepoints.

The first patch adds the infrastructure, the second converts page_ref over
to it, and third converts over msr.h.

Steven Rostedt (VMware) (3):
      tracepoints: Add helper to test if tracepoint is enabled in a header
      mm/page_ref: Convert the open coded tracepoint enabled to the new helper
      x86: Use tracepoint_enabled() for msr tracepoints instead of open coding it

----

Changes since v1 (https://lore.kernel.org/r/20200924170928.466191266@goodmis.org):

 - Fixed using "trace_enabled()" instead of "tracepoint_enabled()"
   (Mathieu Desnoyers reported)

 - Reworded to include comments about bloating the kernel when tracepoints
   are used in commonly used inlined functions.

 - Added the msr update as well.


 Documentation/trace/tracepoints.rst | 27 ++++++++++++++++++++++++
 arch/x86/include/asm/msr.h          | 18 +++++++---------
 include/linux/page_ref.h            | 42 ++++++++++++++++++-------------------
 include/linux/tracepoint-defs.h     | 34 ++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 31 deletions(-)
