Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1076519D990
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404088AbgDCOz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 10:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404068AbgDCOzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:55:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17E12082F;
        Fri,  3 Apr 2020 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585925724;
        bh=O9zmHtXDsVIDhiiv7680He3JLjdSgkyAK+ej9aYwnO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mK8KOhn9nKA1nrJ7+jwAr9uc+qPEK9kK2k4AE20Qu2dkdV/0Zo+F9Em7ZThslKAk9
         AsDJgew4rVJ5BiU1zl1IjpnsdAMEfPR9Sm261XNMqXl9rMcey9wfvWK/LWqbsDO9xa
         lZBgtnhcvn4u6BMhSkfv0H2ka+5gMY/ylxc7lj0s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 07/31] perf/core: Add PERF_RECORD_CGROUP event
Date:   Fri,  3 Apr 2020 11:54:19 -0300
Message-Id: <20200403145443.24774-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
References: <20200403145443.24774-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

To support cgroup tracking, add CGROUP event to save a link between
cgroup path and id number.  This is needed since cgroups can go away
when userspace tries to read the cgroup info (from the id) later.

The attr.cgroup bit was also added to enable cgroup tracking from
userspace.

This event will be generated when a new cgroup becomes active.
Userspace might need to synthesize those events for existing cgroups.

Committer testing:

From the resulting kernel, using /sys/kernel/btf/vmlinux:

  $ pahole perf_event_attr | grep -w cgroup -B5 -A1
  	__u64                      write_backward:1;     /*    40:27  8 */
  	__u64                      namespaces:1;         /*    40:28  8 */
  	__u64                      ksymbol:1;            /*    40:29  8 */
  	__u64                      bpf_event:1;          /*    40:30  8 */
  	__u64                      aux_output:1;         /*    40:31  8 */
  	__u64                      cgroup:1;             /*    40:32  8 */
  	__u64                      __reserved_1:31;      /*    40:33  8 */
  $

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
[staticize perf_event_cgroup function]
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Zefan Li <lizefan@huawei.com>
Link: http://lore.kernel.org/lkml/20200325124536.2800725-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/uapi/linux/perf_event.h |  13 +++-
 kernel/events/core.c            | 111 ++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 397cfd65b3fe..de95f6c7b273 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -381,7 +381,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1012,6 +1013,16 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				id;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d22e4ba59dfa..994932d5e474 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -387,6 +387,7 @@ static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
+static atomic_t nr_cgroup_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4608,6 +4609,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_dec(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_dec(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_dec(&nr_task_events);
 	if (event->attr.freq)
@@ -7735,6 +7738,105 @@ void perf_event_namespaces(struct task_struct *task)
 			NULL);
 }
 
+/*
+ * cgroup tracking
+ */
+#ifdef CONFIG_CGROUP_PERF
+
+struct perf_cgroup_event {
+	char				*path;
+	int				path_size;
+	struct {
+		struct perf_event_header	header;
+		u64				id;
+		char				path[];
+	} event_id;
+};
+
+static int perf_event_cgroup_match(struct perf_event *event)
+{
+	return event->attr.cgroup;
+}
+
+static void perf_event_cgroup_output(struct perf_event *event, void *data)
+{
+	struct perf_cgroup_event *cgroup_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	u16 header_size = cgroup_event->event_id.header.size;
+	int ret;
+
+	if (!perf_event_cgroup_match(event))
+		return;
+
+	perf_event_header__init_id(&cgroup_event->event_id.header,
+				   &sample, event);
+	ret = perf_output_begin(&handle, event,
+				cgroup_event->event_id.header.size);
+	if (ret)
+		goto out;
+
+	perf_output_put(&handle, cgroup_event->event_id);
+	__output_copy(&handle, cgroup_event->path, cgroup_event->path_size);
+
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+out:
+	cgroup_event->event_id.header.size = header_size;
+}
+
+static void perf_event_cgroup(struct cgroup *cgrp)
+{
+	struct perf_cgroup_event cgroup_event;
+	char path_enomem[16] = "//enomem";
+	char *pathname;
+	size_t size;
+
+	if (!atomic_read(&nr_cgroup_events))
+		return;
+
+	cgroup_event = (struct perf_cgroup_event){
+		.event_id  = {
+			.header = {
+				.type = PERF_RECORD_CGROUP,
+				.misc = 0,
+				.size = sizeof(cgroup_event.event_id),
+			},
+			.id = cgroup_id(cgrp),
+		},
+	};
+
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (pathname == NULL) {
+		cgroup_event.path = path_enomem;
+	} else {
+		/* just to be sure to have enough space for alignment */
+		cgroup_path(cgrp, pathname, PATH_MAX - sizeof(u64));
+		cgroup_event.path = pathname;
+	}
+
+	/*
+	 * Since our buffer works in 8 byte units we need to align our string
+	 * size to a multiple of 8. However, we must guarantee the tail end is
+	 * zero'd out to avoid leaking random bits to userspace.
+	 */
+	size = strlen(cgroup_event.path) + 1;
+	while (!IS_ALIGNED(size, sizeof(u64)))
+		cgroup_event.path[size++] = '\0';
+
+	cgroup_event.event_id.header.size += size;
+	cgroup_event.path_size = size;
+
+	perf_iterate_sb(perf_event_cgroup_output,
+			&cgroup_event,
+			NULL);
+
+	kfree(pathname);
+}
+
+#endif
+
 /*
  * mmap tracking
  */
@@ -10781,6 +10883,8 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_inc(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_inc(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_inc(&nr_task_events);
 	if (event->attr.freq)
@@ -12757,6 +12861,12 @@ static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(jc);
 }
 
+static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
+{
+	perf_event_cgroup(css->cgroup);
+	return 0;
+}
+
 static int __perf_cgroup_move(void *info)
 {
 	struct task_struct *task = info;
@@ -12778,6 +12888,7 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
 struct cgroup_subsys perf_event_cgrp_subsys = {
 	.css_alloc	= perf_cgroup_css_alloc,
 	.css_free	= perf_cgroup_css_free,
+	.css_online	= perf_cgroup_css_online,
 	.attach		= perf_cgroup_attach,
 	/*
 	 * Implicitly enable on dfl hierarchy so that perf events can
-- 
2.21.1

