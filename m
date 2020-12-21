Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259932E0229
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgLUVpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgLUVpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:45:17 -0500
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B8B224F9;
        Mon, 21 Dec 2020 21:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608587076;
        bh=Hr/JkIdrYmoFCydJTzdSji9MrBJufVA584mXrtnyb7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YhEXj+aiZWsYiFsKPYWSthjck52OPuU2fdTEsbAxG3/Ey/gfbDIVynDxuyXprsIxG
         ChwblAj4s9Xzvr4M1QjBEzFPOntSTsoCFe4tAJ+XS6abp4IlHOZ/QAKdV2BeYG7l0I
         zP/Ga79XMRBIS1klg8F1VkloWwq1D6WaV19StlvbckteAlCvz1hKjVbITVttDEdGoS
         BX5rYWX2Rxa8m7fVg6ISTrhUivn2iRPGoVYjzXJ/7bK4qa9ffp5ZNtoVXT+cApPm4n
         VOIgIx/RUfSHwXsAdLAvJRqeX9pxsrbpG7FlKmm2cbyXqhv5jDus8CT0Y7jeZImlwh
         Hm+UPGRhHQV8Q==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] tracing/dynevent: Delegate parsing to create function
Date:   Mon, 21 Dec 2020 15:44:27 -0600
Message-Id: <ed8253656f1b421a59ed2549864f3e58dd9427bf.1608586464.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1608586464.git.zanussi@kernel.org>
References: <cover.1608586464.git.zanussi@kernel.org>
In-Reply-To: <cover.1608586464.git.zanussi@kernel.org>
References: <cover.1608586464.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Delegate command parsing to each create function so that the
command syntax can be customized.

This requires changes to the kprobe/uprobe/synthetic event handling,
which are also included here.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
[ zanussi@kernel.org: added synthetic event modifications ]
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c              | 23 ++----------
 kernel/trace/trace.h              |  3 +-
 kernel/trace/trace_dynevent.c     | 35 +++++++++++-------
 kernel/trace/trace_dynevent.h     |  4 +--
 kernel/trace/trace_events_synth.c | 60 +++++++++++++++++++++++--------
 kernel/trace/trace_kprobe.c       | 33 +++++++++--------
 kernel/trace/trace_probe.c        | 17 +++++++++
 kernel/trace/trace_probe.h        |  1 +
 kernel/trace/trace_uprobe.c       | 17 +++++----
 9 files changed, 120 insertions(+), 73 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eb5205e48733..e9cde7a3e0a6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9426,30 +9426,11 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 }
 EXPORT_SYMBOL_GPL(ftrace_dump);
 
-int trace_run_command(const char *buf, int (*createfn)(int, char **))
-{
-	char **argv;
-	int argc, ret;
-
-	argc = 0;
-	ret = 0;
-	argv = argv_split(GFP_KERNEL, buf, &argc);
-	if (!argv)
-		return -ENOMEM;
-
-	if (argc)
-		ret = createfn(argc, argv);
-
-	argv_free(argv);
-
-	return ret;
-}
-
 #define WRITE_BUFSIZE  4096
 
 ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos,
-				int (*createfn)(int, char **))
+				int (*createfn)(const char *))
 {
 	char *kbuf, *buf, *tmp;
 	int ret = 0;
@@ -9497,7 +9478,7 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 			if (tmp)
 				*tmp = '\0';
 
-			ret = trace_run_command(buf, createfn);
+			ret = createfn(buf);
 			if (ret)
 				goto out;
 			buf += size;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e448d2da0b99..98211637e545 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1830,10 +1830,9 @@ extern int tracing_set_cpumask(struct trace_array *tr,
 
 #define MAX_EVENT_NAME_LEN	64
 
-extern int trace_run_command(const char *buf, int (*createfn)(int, char**));
 extern ssize_t trace_parse_run_command(struct file *file,
 		const char __user *buffer, size_t count, loff_t *ppos,
-		int (*createfn)(int, char**));
+		int (*createfn)(const char *));
 
 extern unsigned int err_pos(char *cmd, const char *str);
 extern void tracing_log_err(struct trace_array *tr,
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4f967d5cd917..dc971a68dda4 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -31,23 +31,31 @@ int dyn_event_register(struct dyn_event_operations *ops)
 	return 0;
 }
 
-int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
+int dyn_event_release(const char *raw_command, struct dyn_event_operations *type)
 {
 	struct dyn_event *pos, *n;
 	char *system = NULL, *event, *p;
-	int ret = -ENOENT;
+	int argc, ret = -ENOENT;
+	char **argv;
+
+	argv = argv_split(GFP_KERNEL, raw_command, &argc);
+	if (!argv)
+		return -ENOMEM;
 
 	if (argv[0][0] == '-') {
-		if (argv[0][1] != ':')
-			return -EINVAL;
+		if (argv[0][1] != ':') {
+			ret = -EINVAL;
+			goto out;
+		}
 		event = &argv[0][2];
 	} else {
 		event = strchr(argv[0], ':');
-		if (!event)
-			return -EINVAL;
+		if (!event) {
+			ret = -EINVAL;
+			goto out;
+		}
 		event++;
 	}
-	argc--; argv++;
 
 	p = strchr(event, '/');
 	if (p) {
@@ -63,7 +71,7 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 		if (type && type != pos->ops)
 			continue;
 		if (!pos->ops->match(system, event,
-				argc, (const char **)argv, pos))
+				argc - 1, (const char **)argv + 1, pos))
 			continue;
 
 		ret = pos->ops->free(pos);
@@ -71,21 +79,22 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 			break;
 	}
 	mutex_unlock(&event_mutex);
-
+out:
+	argv_free(argv);
 	return ret;
 }
 
-static int create_dyn_event(int argc, char **argv)
+static int create_dyn_event(const char *raw_command)
 {
 	struct dyn_event_operations *ops;
 	int ret = -ENODEV;
 
-	if (argv[0][0] == '-' || argv[0][0] == '!')
-		return dyn_event_release(argc, argv, NULL);
+	if (raw_command[0] == '-' || raw_command[0] == '!')
+		return dyn_event_release(raw_command, NULL);
 
 	mutex_lock(&dyn_event_ops_mutex);
 	list_for_each_entry(ops, &dyn_event_ops_list, list) {
-		ret = ops->create(argc, (const char **)argv);
+		ret = ops->create(raw_command);
 		if (!ret || ret != -ECANCELED)
 			break;
 	}
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index d6f72dcb7269..7754936b57ee 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -39,7 +39,7 @@ struct dyn_event;
  */
 struct dyn_event_operations {
 	struct list_head	list;
-	int (*create)(int argc, const char *argv[]);
+	int (*create)(const char *raw_command);
 	int (*show)(struct seq_file *m, struct dyn_event *ev);
 	bool (*is_busy)(struct dyn_event *ev);
 	int (*free)(struct dyn_event *ev);
@@ -97,7 +97,7 @@ void *dyn_event_seq_start(struct seq_file *m, loff_t *pos);
 void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
 void dyn_event_seq_stop(struct seq_file *m, void *v);
 int dyn_events_release_all(struct dyn_event_operations *type);
-int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type);
+int dyn_event_release(const char *raw_command, struct dyn_event_operations *type);
 
 /*
  * for_each_dyn_event	-	iterate over the dyn_event list
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 5a8bc0b421f1..b2588a5650c9 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -62,7 +62,7 @@ static void synth_err(u8 err_type, u8 err_pos)
 			err_type, err_pos);
 }
 
-static int create_synth_event(int argc, const char **argv);
+static int create_synth_event(const char *raw_command);
 static int synth_event_show(struct seq_file *m, struct dyn_event *ev);
 static int synth_event_release(struct dyn_event *ev);
 static bool synth_event_is_busy(struct dyn_event *ev);
@@ -1383,18 +1383,30 @@ int synth_event_delete(const char *event_name)
 }
 EXPORT_SYMBOL_GPL(synth_event_delete);
 
-static int create_or_delete_synth_event(int argc, char **argv)
+static int create_or_delete_synth_event(const char *raw_command)
 {
-	const char *name = argv[0];
-	int ret;
+	char **argv, *name = NULL;
+	int argc = 0, ret = 0;
+
+	argv = argv_split(GFP_KERNEL, raw_command, &argc);
+	if (!argv)
+		return -ENOMEM;
+
+	if (!argc)
+		goto free;
+
+	name = argv[0];
 
 	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
 		ret = synth_event_delete(name + 1);
-		return ret;
+		goto free;
 	}
 
 	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
+free:
+	argv_free(argv);
+
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
@@ -1403,7 +1415,7 @@ static int synth_event_run_command(struct dynevent_cmd *cmd)
 	struct synth_event *se;
 	int ret;
 
-	ret = trace_run_command(cmd->seq.buffer, create_or_delete_synth_event);
+	ret = create_or_delete_synth_event(cmd->seq.buffer);
 	if (ret)
 		return ret;
 
@@ -1939,23 +1951,43 @@ int synth_event_trace_end(struct synth_event_trace_state *trace_state)
 }
 EXPORT_SYMBOL_GPL(synth_event_trace_end);
 
-static int create_synth_event(int argc, const char **argv)
+static int create_synth_event(const char *raw_command)
 {
-	const char *name = argv[0];
-	int len;
+	char **argv, *name;
+	int len, argc = 0, ret = 0;
+
+	argv = argv_split(GFP_KERNEL, raw_command, &argc);
+	if (!argv) {
+		ret = -ENOMEM;
+		return ret;
+	}
 
-	if (name[0] != 's' || name[1] != ':')
-		return -ECANCELED;
+	if (!argc)
+		goto free;
+
+	name = argv[0];
+
+	if (name[0] != 's' || name[1] != ':') {
+		ret = -ECANCELED;
+		goto free;
+	}
 	name += 2;
 
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
-		if (len == 0)
-			return -EINVAL;
+		if (len == 0) {
+			ret = -EINVAL;
+			goto free;
+		}
 		name += len;
 	}
-	return __create_synth_event(argc - 1, name, argv + 1);
+
+	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
+free:
+	argv_free(argv);
+
+	return ret;
 }
 
 static int synth_event_release(struct dyn_event *ev)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b29f92c51b1a..1c1f089191e4 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -35,7 +35,7 @@ static int __init set_kprobe_boot_events(char *str)
 }
 __setup("kprobe_event=", set_kprobe_boot_events);
 
-static int trace_kprobe_create(int argc, const char **argv);
+static int trace_kprobe_create(const char *raw_command);
 static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev);
 static int trace_kprobe_release(struct dyn_event *ev);
 static bool trace_kprobe_is_busy(struct dyn_event *ev);
@@ -711,7 +711,7 @@ static inline void sanitize_event_name(char *name)
 			*name = '_';
 }
 
-static int trace_kprobe_create(int argc, const char *argv[])
+static int __trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
 	 * Argument syntax:
@@ -908,20 +908,25 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	goto out;
 }
 
-static int create_or_delete_trace_kprobe(int argc, char **argv)
+static int trace_kprobe_create(const char *raw_command)
+{
+	return trace_probe_create(raw_command, __trace_kprobe_create);
+}
+
+static int create_or_delete_trace_kprobe(const char *raw_command)
 {
 	int ret;
 
-	if (argv[0][0] == '-')
-		return dyn_event_release(argc, argv, &trace_kprobe_ops);
+	if (raw_command[0] == '-')
+		return dyn_event_release(raw_command, &trace_kprobe_ops);
 
-	ret = trace_kprobe_create(argc, (const char **)argv);
+	ret = trace_kprobe_create(raw_command);
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
 static int trace_kprobe_run_command(struct dynevent_cmd *cmd)
 {
-	return trace_run_command(cmd->seq.buffer, create_or_delete_trace_kprobe);
+	return create_or_delete_trace_kprobe(cmd->seq.buffer);
 }
 
 /**
@@ -1082,7 +1087,7 @@ int kprobe_event_delete(const char *name)
 
 	snprintf(buf, MAX_EVENT_NAME_LEN, "-:%s", name);
 
-	return trace_run_command(buf, create_or_delete_trace_kprobe);
+	return create_or_delete_trace_kprobe(buf);
 }
 EXPORT_SYMBOL_GPL(kprobe_event_delete);
 
@@ -1885,7 +1890,7 @@ static __init void setup_boot_kprobe_events(void)
 		if (p)
 			*p++ = '\0';
 
-		ret = trace_run_command(cmd, create_or_delete_trace_kprobe);
+		ret = create_or_delete_trace_kprobe(cmd);
 		if (ret)
 			pr_warn("Failed to add event(%d): %s\n", ret, cmd);
 
@@ -1979,8 +1984,7 @@ static __init int kprobe_trace_self_tests_init(void)
 
 	pr_info("Testing kprobe tracing: ");
 
-	ret = trace_run_command("p:testprobe kprobe_trace_selftest_target $stack $stack0 +0($stack)",
-				create_or_delete_trace_kprobe);
+	ret = create_or_delete_trace_kprobe("p:testprobe kprobe_trace_selftest_target $stack $stack0 +0($stack)");
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function entry.\n");
 		warn++;
@@ -2001,8 +2005,7 @@ static __init int kprobe_trace_self_tests_init(void)
 		}
 	}
 
-	ret = trace_run_command("r:testprobe2 kprobe_trace_selftest_target $retval",
-				create_or_delete_trace_kprobe);
+	ret = create_or_delete_trace_kprobe("r:testprobe2 kprobe_trace_selftest_target $retval");
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function return.\n");
 		warn++;
@@ -2075,13 +2078,13 @@ static __init int kprobe_trace_self_tests_init(void)
 				trace_probe_event_call(&tk->tp), file);
 	}
 
-	ret = trace_run_command("-:testprobe", create_or_delete_trace_kprobe);
+	ret = create_or_delete_trace_kprobe("-:testprobe");
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
 	}
 
-	ret = trace_run_command("-:testprobe2", create_or_delete_trace_kprobe);
+	ret = create_or_delete_trace_kprobe("-:testprobe2");
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d2867ccc6aca..ec589a4612df 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1134,3 +1134,20 @@ bool trace_probe_match_command_args(struct trace_probe *tp,
 	}
 	return true;
 }
+
+int trace_probe_create(const char *raw_command, int (*createfn)(int, const char **))
+{
+	int argc = 0, ret = 0;
+	char **argv;
+
+	argv = argv_split(GFP_KERNEL, raw_command, &argc);
+	if (!argv)
+		return -ENOMEM;
+
+	if (argc)
+		ret = createfn(argc, (const char **)argv);
+
+	argv_free(argv);
+
+	return ret;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 2f703a20c724..7ce4027089ee 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -341,6 +341,7 @@ struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
 int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b);
 bool trace_probe_match_command_args(struct trace_probe *tp,
 				    int argc, const char **argv);
+int trace_probe_create(const char *raw_command, int (*createfn)(int, const char **));
 
 #define trace_probe_for_each_link(pos, tp)	\
 	list_for_each_entry(pos, &(tp)->event->files, list)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3cf7128e1ad3..e6b56a65f80f 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -34,7 +34,7 @@ struct uprobe_trace_entry_head {
 #define DATAOF_TRACE_ENTRY(entry, is_return)		\
 	((void*)(entry) + SIZEOF_TRACE_ENTRY(is_return))
 
-static int trace_uprobe_create(int argc, const char **argv);
+static int trace_uprobe_create(const char *raw_command);
 static int trace_uprobe_show(struct seq_file *m, struct dyn_event *ev);
 static int trace_uprobe_release(struct dyn_event *ev);
 static bool trace_uprobe_is_busy(struct dyn_event *ev);
@@ -530,7 +530,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
  * Argument syntax:
  *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET[%return][(REF)] [FETCHARGS]
  */
-static int trace_uprobe_create(int argc, const char **argv)
+static int __trace_uprobe_create(int argc, const char **argv)
 {
 	struct trace_uprobe *tu;
 	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
@@ -716,14 +716,19 @@ static int trace_uprobe_create(int argc, const char **argv)
 	return ret;
 }
 
-static int create_or_delete_trace_uprobe(int argc, char **argv)
+int trace_uprobe_create(const char *raw_command)
+{
+	return trace_probe_create(raw_command, __trace_uprobe_create);
+}
+
+static int create_or_delete_trace_uprobe(const char *raw_command)
 {
 	int ret;
 
-	if (argv[0][0] == '-')
-		return dyn_event_release(argc, argv, &trace_uprobe_ops);
+	if (raw_command[0] == '-')
+		return dyn_event_release(raw_command, &trace_uprobe_ops);
 
-	ret = trace_uprobe_create(argc, (const char **)argv);
+	ret = trace_uprobe_create(raw_command);
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
-- 
2.17.1

