Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC61E3203
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 00:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391760AbgEZWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 18:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389342AbgEZWFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:05:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B953E20870;
        Tue, 26 May 2020 22:05:36 +0000 (UTC)
Date:   Tue, 26 May 2020 18:05:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Message-ID: <20200526180535.0370eb90@gandalf.local.home>
In-Reply-To: <20200526180437.45aed950@gandalf.local.home>
References: <20200526212826.4097888-1-songliubraving@fb.com>
        <20200526213913.GG2483@worktop.programming.kicks-ass.net>
        <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
        <20200526215415.GH2483@worktop.programming.kicks-ass.net>
        <20200526180437.45aed950@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 18:04:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> In the early days there was a lot of issues with recursions, but I added a
> lot of recursion protection since then. I'll give this patch a spin and see
> if I can make it crash.

I also have some patches that make both perf and the trace directory
visible by function tracing. I'll see if I can dig them out too.

-- Steve
