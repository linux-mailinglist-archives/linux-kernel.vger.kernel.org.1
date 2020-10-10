Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843CC28A3D7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbgJJWzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbgJJT1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:27:21 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB6C20679;
        Sat, 10 Oct 2020 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602343684;
        bh=Ly78V45HlJ9h9aQECLefFDkS/vAb5EUVXh26UqvN/zU=;
        h=From:To:Cc:Subject:Date:From;
        b=11l+q9nI/BajFfRJX9gU9aOYc6kMt9R8NRLCixSUIKGBXDs55RakvsFFqbH/pUWwY
         SOZB6WaNDYZjXlbcdQTIhLjvvSvGJvi1N0uAlnrDup+9yT9OPcuNHhmQiYk84lHZkO
         KAbNT7+SZUk2mzqa/0hs6sM+eN8qZP1zgdP8gWPI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH  0/1] tracing/boot: Add alloc_snapshot for instance option
Date:   Sun, 11 Oct 2020 00:28:00 +0900
Message-Id: <160234368056.400560.6282640165007466754.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch to add ftrace[.instance.INSTANCE].alloc_snapshot option
to allocate snapshot buffer for specific isntance. Actually, this has
been described in Documentation/trace/boottime-trace.rst but I forgot
to implement it. (Maybe I confused it with kernel.alloc_snapshot)

Anyway, it is better to have this option with currnet ftrace implementation,
because if user sets ftrace.instance.X.event.*.*.actions = "snapshot" and
ftrace.instance.X.tracer at same bootconfig, the snapshot buffer always
removed (even if the tracer is not a max-tracer).
This seems buggy, but I'm not sure the reason why.

So if someone wants to use snapshot event action with e.g. function tracer,
they must use this option. For example,

ftrace.instance.foo {
	tracer = function
	event.signal.signal_deliver {
		enable
		actions = "snapshot if sig = 7"
	}
	alloc_snapshot
}

Steve and Tom, would you know why tracing_set_tracer() removes
snapshot buffer even if the tracer is not a max-tracer?

int tracing_set_tracer(struct trace_array *tr, const char *buf)
{
...
#ifdef CONFIG_TRACER_MAX_TRACE
        had_max_tr = tr->allocated_snapshot;

        if (had_max_tr && !t->use_max_tr) {
                /*
                 * We need to make sure that the update_max_tr sees that
                 * current_trace changed to nop_trace to keep it from
                 * swapping the buffers after we resize it.
                 * The update_max_tr is called from interrupts disabled
                 * so a synchronized_sched() is sufficient.
                 */
                synchronize_rcu();
                free_snapshot(tr);
        }
#endif
}

It seems had_max_tr is true even if the previous tracer is nop and
snapshot buffer was traced by snapshot trigger action.

This actually causes a problem except for the boot time tracing,
for example,

1) boot kernel with nop tracer
2) add snapshot trigger action to an event
   (snapshot buffer is allocated here)
3) set function tracer to current tracer
   (snapshot buffer is freed)
4) run the tracer
   -> the event trigger can not take a snapshot.


Thank you,

---

Masami Hiramatsu (1):
      tracing/boot: Add ftrace.instance.*.alloc_snapshot option


 kernel/trace/trace_boot.c |    6 ++++++
 1 file changed, 6 insertions(+)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
