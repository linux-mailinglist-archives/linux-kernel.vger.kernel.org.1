Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF628C866
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 07:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbgJMFz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 01:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388748AbgJMFz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 01:55:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F63C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 22:55:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so16047205pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 22:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uZWssBn5eUTFawt61tuJrHSMXVH7Qnpybc1ygwQBFuU=;
        b=D1QZBEhqvkYbJkKhH3J6t7wQkI/3Sti9IEUnIgRByPBe/P8SQEXML26pwrKz6ZacNv
         4mTzRfxGdmYSuReHpAT/j3u51Mr5s/8pAI/E2buJlfKVRtXfTx6lUCK53zOb5dzALboZ
         8JoknF0fRFTA+WZsTl84E2rdYi+0EGegQ5ni4eAEVvRlpsupbcNRcgGigQc8D6+raRjZ
         nP1zPLjQAbk8wYYV9mtT/5wTjLFtKcXl5pVa/+o2cniyTNnNbT8g5YPuF7diOoOHpaQ6
         Vk8+V14d179fHi5V+iiWLzqR9TFUtnWt234znKFQZyuIYIxGraIHGyq8R38NvVheSzwX
         Et0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uZWssBn5eUTFawt61tuJrHSMXVH7Qnpybc1ygwQBFuU=;
        b=ABZRsnPX4QW8EUYRXi3m3regrmAbBLrPPW6SeV12pSDxtsXqa/6XmKPKU5erD1nGd/
         lvLXuVu1sTiZslzgA7aBcZltH0ChXBWDtqIo8t65y21ZfWGZYztaTnW0Vi27EXHm9Q+h
         Pr77iDY6TFFPkd+uC/9Tu14cQ+48/HG7B5Ldp2uGgIBvA9OzfJO9toAwXL0LzASVvCsQ
         FB9W05YkYMSs07DADtwcOKGXLYurW9etki6GSTRoxW3A3ANDN7/kUWKUqAQyjUHTexMD
         aH+rFXGKToXDeow1or2XQrc5mNKoIJuMhoqlBs9S9/J/eP4Y07At6Tgl4vzmpWl0QHq6
         ZtNw==
X-Gm-Message-State: AOAM531T42zA5Ofpklmm5Igi7I0ktY8nOejq0hWVM7xaVPIN5v7k/lKE
        /rqy35Wxn3wjMIxAbtFvT3xlyNilktItpQ==
X-Google-Smtp-Source: ABdhPJz65GwSnVPF95Zgkq/u1tY9AzSu/NXMKwOBKFnuOb/xXOwgeYLRNt5ENkFVajAiuOivLTf4ZA==
X-Received: by 2002:a62:92c5:0:b029:156:6a7f:ccff with SMTP id o188-20020a6292c50000b02901566a7fccffmr2410518pfd.39.1602568526425;
        Mon, 12 Oct 2020 22:55:26 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c15sm7585458pgg.77.2020.10.12.22.55.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 22:55:25 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] tracing: add tgid into common field
Date:   Tue, 13 Oct 2020 13:54:54 +0800
Message-Id: <20201013055454.52634-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want to trace a specific mutil-threaded process, which may
create threads dynamically. Currently it is not easy to trace all its
threads, because we can only filter these threads out by using
common_pid.

This patch adds the tgid into the common field as well, with which we
can easily filter this mutil-threaded process out. E.g.

$ cd /sys/kernel/debug/tracing
$ echo 'common_tgid == 4054' > events/sched/sched_wakeup/filter
$ cat trace_pipe
          python-4057    [005] d... 48003.898560: sched_wakeup: comm=python pid=4054 prio=120 target_cpu=002
          python-4054    [002] dNs. 48003.932906: sched_wakeup: comm=kworker/2:2 pid=130 prio=120 target_cpu=002
          python-4054    [002] dNH. 48003.932907: sched_wakeup: comm=cat pid=4084 prio=120 target_cpu=004
          python-4055    [003] d... 48004.816596: sched_wakeup: comm=python pid=4054 prio=120 target_cpu=002

With record-tgid set into trace_options, we can show the tgid,

$ echo record-tgid > trace_options
$ cat trace_pipe
          python-4054    (   4054) [002] d... 48166.611771: sched_wakeup: comm=python pid=4055 prio=120 target_cpu=004
          python-4057    (   4054) [005] d... 48166.611776: sched_wakeup: comm=python pid=4054 prio=120 target_cpu=002
          python-4055    (   4054) [004] d... 48166.611848: sched_wakeup: comm=python pid=4054 prio=120 target_cpu=002

After that change, tgid_map is only used by saved_tgid, which may be
used by some user tools, so I just keep it as-is.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/trace_events.h | 1 +
 kernel/trace/trace.c         | 1 +
 kernel/trace/trace_events.c  | 1 +
 kernel/trace/trace_output.c  | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5c6943354049..3725c05f0b01 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -67,6 +67,7 @@ struct trace_entry {
 	unsigned char		flags;
 	unsigned char		preempt_count;
 	int			pid;
+	int			tgid;
 };
 
 #define TRACE_EVENT_TYPE_MAX						\
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3e5de717df2..c2423efaac2c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2445,6 +2445,7 @@ tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
 
 	entry->preempt_count		= pc & 0xff;
 	entry->pid			= (tsk) ? tsk->pid : 0;
+	entry->tgid			= (tsk) ? tsk->tgid : 0;
 	entry->type			= type;
 	entry->flags =
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a85effb2373b..9a5adcecf245 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -182,6 +182,7 @@ static int trace_define_common_fields(void)
 	__common_field(unsigned char, flags);
 	__common_field(unsigned char, preempt_count);
 	__common_field(int, pid);
+	__common_field(int, tgid);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 000e9dc224c6..e04dd45267c7 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -591,7 +591,7 @@ int trace_print_context(struct trace_iterator *iter)
 	trace_seq_printf(s, "%16s-%-7d ", comm, entry->pid);
 
 	if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
-		unsigned int tgid = trace_find_tgid(entry->pid);
+		unsigned int tgid = entry->tgid;
 
 		if (!tgid)
 			trace_seq_printf(s, "(-------) ");
-- 
2.17.1

