Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63402E9CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhADS1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:27:32 -0500
Received: from foss.arm.com ([217.140.110.172]:43988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbhADS1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:27:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CD991FB;
        Mon,  4 Jan 2021 10:26:46 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420B53F70D;
        Mon,  4 Jan 2021 10:26:45 -0800 (PST)
Date:   Mon, 4 Jan 2021 18:26:42 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20210104182642.xglderapsfrop6pi@e107158-lin>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
 <20200908131954.GA147026@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908131954.GA147026@lorien.usersys.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/20 09:19, Phil Auld wrote:
> Hi Quais,
> 
> On Mon, Sep 07, 2020 at 12:02:24PM +0100 Qais Yousef wrote:
> > On 09/02/20 09:54, Phil Auld wrote:
> > > > 
> > > > I think this decoupling is not necessary. The natural place for those
> > > > scheduler trace_event based on trace_points extension files is
> > > > kernel/sched/ and here the internal sched.h can just be included.
> > > > 
> > > > If someone really wants to build this as an out-of-tree module there is
> > > > an easy way to make kernel/sched/sched.h visible.
> > > >
> > > 
> > > It's not so much that we really _want_ to do this in an external module.
> > > But we aren't adding more trace events and my (limited) knowledge of
> > > BPF let me to the conclusion that its raw tracepoint functionality
> > > requires full events.  I didn't see any other way to do it.
> > 
> > I did have a patch that allowed that. It might be worth trying to upstream it.
> > It just required a new macro which could be problematic.
> > 
> > https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
> > 
> > With the above I could attach using bpf::RAW_TRACEPOINT mechanism.
> >
> 
> Yeah, that could work. I meant there was no way to do it with what was there :)
> 
> In our initial attempts at using BPF to get at nr_running (which I was not
> involved in and don't have all the details...) there were issues being able to
> keep up and losing events.  That may have been an implementation issue, but
> using the module and trace-cmd doesn't have that problem. Hopefully you don't
> see that using RAW_TRACEPOINTs.

So I have a proper patch for that now, that actually turned out to be really
tiny once you untangle exactly what is missing.

Peter, bpf programs aren't considered ABIs AFAIK, do you have concerns about
that?

Thanks

--
Qais Yousef

-->8--

From cf81de8c7db03d62730939aa902579339e2fc859 Mon Sep 17 00:00:00 2001
From: Qais Yousef <qais.yousef@arm.com>
Date: Wed, 30 Dec 2020 22:20:34 +0000
Subject: [PATCH] trace: bpf: Allow bpf to attach to bare tracepoints

Some subsystems only have bare tracepoints (a tracepoint with no
associated trace event) to avoid the problem of trace events being an
ABI that can't be changed.

From bpf presepective, bare tracepoints are what it calls
RAW_TRACEPOINT().

Since bpf assumed there's 1:1 mapping, it relied on hooking to
DEFINE_EVENT() macro to create bpf mapping of the tracepoints. Since
bare tracepoints use DECLARE_TRACE() to create the tracepoint, bpf had
no knowledge about their existence.

By teaching bpf_probe.h to parse DECLARE_TRACE() in a similar fashion to
DEFINE_EVENT(), bpf can find and attach to the new raw tracepoints.

Enabling that comes with the contract that changes to raw tracepoints
don't constitute a regression if they break existing bpf programs.
We need the ability to continue to morph and modify these raw
tracepoints without worrying about any ABI.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/trace/bpf_probe.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index cd74bffed5c6..a23be89119aa 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -55,8 +55,7 @@
 /* tracepoints with more than 12 arguments will hit build error */
 #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
 
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+#define __BPF_DECLARE_TRACE(call, proto, args)				\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
@@ -64,6 +63,10 @@ __bpf_trace_##call(void *__data, proto)					\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
 }
 
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
@@ -111,6 +114,11 @@ __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
 	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
 
+#undef DECLARE_TRACE
+#define DECLARE_TRACE(call, proto, args)				\
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
+	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
+
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
 #undef DEFINE_EVENT_WRITABLE
-- 
2.25.1

