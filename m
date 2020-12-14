Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A107C2D9B99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407971AbgLNP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgLNP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:59:54 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFAFC0613D3;
        Mon, 14 Dec 2020 07:59:13 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v67so15962774ybi.1;
        Mon, 14 Dec 2020 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=D96YB791WIxmPDEX0dM0+WooRGFJ0en+NE1jV1jbsew=;
        b=nsLLdDmAtmAGnalEGtnnq5OeHUbkgd33pzeoL5wiU5K7YaNZdSdv8kRsjaE+nhMy+Y
         urOSO9wPdFdUMuJ1mlK3bQc28owHNPKEdx2nbC0hmf+0aD/mLtNy1D3yBOySlT0mGdBQ
         NSqBVl4m3RPKh/f2NMRBCsf4VniJEfZB+K1mXUKN1lhsEmVJNtNi3H1KwuUJRJYhyeoa
         6eN1to41riRvjy/qQ7VF/bMBf5FAA33SIHIYOUyYqMsx2yAElv4haYrblSrt+6p/Idku
         BA3Oacl4xYZEIkWs4HZKNWu7F8CYdv2apwRA3t+5RhCNPe/YZ5t7zTKlWHs/+Z8aU6TN
         hrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=D96YB791WIxmPDEX0dM0+WooRGFJ0en+NE1jV1jbsew=;
        b=PrHgT4DBcwRDX2bAodGWSL/qgVcmU/+JvgDa93RNY7ndTT/EvMq7abAKW5NWwTjm0f
         CqMusLGr4GQLnrGOwREt4Qhgm40xqHTZDuAGYxadF0SACwZ45abIuiGn8SnCwyjMAqMQ
         zhWd88jcNFW0PJ0CbXE8sDCYj1soq+TsPqclCDmlYcXBSkGRcc6VJvZW5MFZFkInOohu
         IJwY03apVQrAxQZX2+SjvPi9Goodw/usW4j+kB26Zqy42I4OkxESg1QyXLNC7LBtbA4Q
         sJaQLO5ArDWArp4NA0mXXIl2hPICz1jLbb/s7ygoEfMtZzqlR90cOcIs8wxqPY109BDb
         MteQ==
X-Gm-Message-State: AOAM533u//zyCIXEaSs4lxb5BoPGH0CwkSTH5YtviAuvRS1rBxAEAnU6
        gMETKJhDlJ6Qi3bj1QRYRtKv70vw3ZjVoiGu7gevgBs515ptew==
X-Google-Smtp-Source: ABdhPJyXTV9DRuzFBusId2cDnorHEr1r38aW4pu6qrco+Dvg+HvOFbejY+Uku/2A4OnO0DMfLzEyMlNXTsCY0+orJLQ=
X-Received: by 2002:a05:6902:100f:: with SMTP id w15mr34570378ybt.25.1607961552836;
 Mon, 14 Dec 2020 07:59:12 -0800 (PST)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 14 Dec 2020 18:59:02 +0300
Message-ID: <CADxRZqzXQRYgKc=y-KV=S_yHL+Y8Ay2mh5ezeZUnpRvg+syWKw@mail.gmail.com>
Subject: [sparc64] ftrace: kernel startup-tests unaligned access
To:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Enabled ftrace startup tests on a sparc64 test VM/LDOM:

$ diff -u <(gzip -dc ~/dmesg/config-5.10.0.gz) <(gzip -dc /proc/config.gz)
--- /dev/fd/63  2020-12-14 16:19:38.239372599 +0300
+++ /dev/fd/62  2020-12-14 16:19:38.235372433 +0300
@@ -2842,7 +2842,10 @@
 # CONFIG_TRACEPOINT_BENCHMARK is not set
 # CONFIG_RING_BUFFER_BENCHMARK is not set
 # CONFIG_TRACE_EVAL_MAP_FILE is not set
-# CONFIG_FTRACE_STARTUP_TEST is not set
+CONFIG_FTRACE_SELFTEST=y
+CONFIG_FTRACE_STARTUP_TEST=y
+CONFIG_EVENT_TRACE_STARTUP_TEST=y
+# CONFIG_EVENT_TRACE_TEST_SYSCALLS is not set
 # CONFIG_RING_BUFFER_STARTUP_TEST is not set
 # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
 # CONFIG_KPROBE_EVENT_GEN_TEST is not set


Got the following results with kernel boot logs:

Dec 14 13:48:15 kernel: clocksource: jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Dec 14 13:48:15 kernel: futex hash table entries: 65536 (order: 9,
4194304 bytes, linear)
Dec 14 13:48:15 kernel: Running postponed tracer tests:
Dec 14 13:48:15 kernel: Testing tracer function:
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
trace_function+0x40/0x140
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a24]
trace_function+0x44/0x140
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
trace_function+0x40/0x140
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a24]
trace_function+0x44/0x140
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
trace_function+0x40/0x140
Dec 14 13:48:15 kernel: PASSED
Dec 14 13:48:15 kernel: Testing dynamic ftrace: PASSED
...
Dec 14 13:48:15 kernel: Testing event workqueue_execute_end:
Dec 14 13:48:15 kernel: log_unaligned: 194175 callbacks suppressed
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47faa4]
trace_event_raw_event_workqueue_execute_end+0x44/0xa0
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47fab0]
trace_event_raw_event_workqueue_execute_end+0x50/0xa0
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47faa4]
trace_event_raw_event_workqueue_execute_end+0x44/0xa0
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47fab0]
trace_event_raw_event_workqueue_execute_end+0x50/0xa0
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47faa4]
trace_event_raw_event_workqueue_execute_end+0x44/0xa0
Dec 14 13:48:15 kernel: OK
...
Dec 14 13:48:15 kernel: Testing event sched_waking: OK
Dec 14 13:48:15 kernel: Testing event sched_kthread_stop_ret:
Dec 14 13:48:15 kernel: log_unaligned: 401755 callbacks suppressed
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c538]
function_test_events_call+0x84/0x188
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c53c]
function_test_events_call+0x88/0x188
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c538]
function_test_events_call+0x84/0x188
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c53c]
function_test_events_call+0x88/0x188
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c538]
function_test_events_call+0x84/0x188
Dec 14 13:48:15 kernel: OK
Dec 14 13:48:15 kernel: Testing event sched_kthread_stop: OK
...

full log is at  https://gist.github.com/mator/a44eb39d5103aaaea2f1b2f3856c391d

Looking at the most encountered function list in dmesg (journalctl -b
-k) output:

$ zgrep 'Kernel unaligned access at TPC' kernel-ftrace.log.gz | awk
'{print $NF}' | cut -f1 -d'+' | sort  | uniq -c
    313 function_test_events_call
      4 trace_event_raw_event_kmem_alloc
      4 trace_event_raw_event_kmem_free
      1 trace_event_raw_event_mm_page
      1 trace_event_raw_event_mm_page_alloc
      2 trace_event_raw_event_rcu_utilization
      5 trace_event_raw_event_sched_switch
      3 trace_event_raw_event_timer_class
      2 trace_event_raw_event_timer_expire_entry
      8 trace_event_raw_event_workqueue_execute_end
      2 trace_event_raw_event_workqueue_execute_start
      5 trace_function

Can someone look for unaligned access at least in
function_test_events_call() to fix it?

Thanks.
