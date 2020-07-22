Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB92228D67
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbgGVBRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 21:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731570AbgGVBRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:17:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6542176B;
        Wed, 22 Jul 2020 01:17:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jy3OK-005s7n-HR; Tue, 21 Jul 2020 21:17:52 -0400
Message-ID: <20200722011752.413388509@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 21 Jul 2020 21:16:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [PATCH 01/23 v3] tools lib traceevent: Add API to read time information from kbuffer
References: <20200722011628.925541477@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Add the functions kbuffer_subbuf_timestamp() and kbuffer_ptr_delta() to get
the timing data stored in the ring buffer that is used to produced the time
stamps of the records.

This is useful for tools like trace-cmd to be able to display the content of
the read data to understand why the records show the time stamps that they
do.

Link: http://lore.kernel.org/linux-trace-devel/20200625100516.365338-2-tz.stoyanov@gmail.com

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ Ported from trace-cmd.git ]
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/kbuffer-parse.c | 28 ++++++++++++++++++++++++++++
 tools/lib/traceevent/kbuffer.h       |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
index 27f3b07fdae8..583db99aee94 100644
--- a/tools/lib/traceevent/kbuffer-parse.c
+++ b/tools/lib/traceevent/kbuffer-parse.c
@@ -546,6 +546,34 @@ int kbuffer_load_subbuffer(struct kbuffer *kbuf, void *subbuffer)
 	return 0;
 }
 
+/**
+ * kbuffer_subbuf_timestamp - read the timestamp from a sub buffer
+ * @kbuf:      The kbuffer to load
+ * @subbuf:    The subbuffer to read from.
+ *
+ * Return the timestamp from a subbuffer.
+ */
+unsigned long long kbuffer_subbuf_timestamp(struct kbuffer *kbuf, void *subbuf)
+{
+	return kbuf->read_8(subbuf);
+}
+
+/**
+ * kbuffer_ptr_delta - read the delta field from a record
+ * @kbuf:      The kbuffer to load
+ * @ptr:       The record in the buffe.
+ *
+ * Return the timestamp delta from a record
+ */
+unsigned int kbuffer_ptr_delta(struct kbuffer *kbuf, void *ptr)
+{
+	unsigned int type_len_ts;
+
+	type_len_ts = read_4(kbuf, ptr);
+	return ts4host(kbuf, type_len_ts);
+}
+
+
 /**
  * kbuffer_read_event - read the next event in the kbuffer subbuffer
  * @kbuf:	The kbuffer to read from
diff --git a/tools/lib/traceevent/kbuffer.h b/tools/lib/traceevent/kbuffer.h
index ed4d697fc137..5fa8292e341b 100644
--- a/tools/lib/traceevent/kbuffer.h
+++ b/tools/lib/traceevent/kbuffer.h
@@ -49,6 +49,8 @@ int kbuffer_load_subbuffer(struct kbuffer *kbuf, void *subbuffer);
 void *kbuffer_read_event(struct kbuffer *kbuf, unsigned long long *ts);
 void *kbuffer_next_event(struct kbuffer *kbuf, unsigned long long *ts);
 unsigned long long kbuffer_timestamp(struct kbuffer *kbuf);
+unsigned long long kbuffer_subbuf_timestamp(struct kbuffer *kbuf, void *subbuf);
+unsigned int kbuffer_ptr_delta(struct kbuffer *kbuf, void *ptr);
 
 void *kbuffer_translate_data(int swap, void *data, unsigned int *size);
 
-- 
2.26.2


