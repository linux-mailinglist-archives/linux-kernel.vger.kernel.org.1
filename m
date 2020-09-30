Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00127F17D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgI3SlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbgI3SlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:41:01 -0400
Received: from localhost.localdomain (c-98-220-232-140.hsd1.il.comcast.net [98.220.232.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C63D207F7;
        Wed, 30 Sep 2020 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601491260;
        bh=Jk+lhLBY4J+O917qRsnLK5esPmSlb1sjZoXLNQgDzQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iNxBf2ZJTMIu1Db5+mkfHj/CCDBykgFRFxHKZFV+h30rtyBS6HEy51wNRGUfYEWyn
         BW+2SfKDV4uG0uockSW+jtUIP216yVqmOiJFyNDJjzFSeFV3hCAfwTXIltL1Bz6XVp
         nbUdBxopkC9yyn0S2uksfqz6hFkOw+Ejm02VYPfU=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] tracing: Add support for dynamic strings to synthetic events
Date:   Wed, 30 Sep 2020 13:40:52 -0500
Message-Id: <86c164d6476fd1fa9595ec79634b15c25f59e5b0.1601490263.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601490263.git.zanussi@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
In-Reply-To: <cover.1601490263.git.zanussi@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, sythetic events only support static string fields such as:

  # echo 'test_latency u64 lat; char somename[32]' > /sys/kernel/debug/tracing/synthetic_events

Which is fine, but wastes a lot of space in the event.

It also prevents the most commonly-defined strings in the existing
trace events e.g. those defined using __string(), from being passed to
synthetic events via the trace() action.

With this change, synthetic events with dynamic fields can be defined:

  # echo 'test_latency u64 lat; char somename[]' > /sys/kernel/debug/tracing/synthetic_events

And the trace() action can be used to generate events using either
dynamic or static strings:

  # echo 'hist:keys=name:lat=common_timestamp.usecs-$ts0:onmatch(sys.event).test_latency($lat,name)' > /sys/kernel/debug/tracing/events

The synthetic event dynamic strings are implemented in the same way as
the existing __data_loc strings and appear as such in the format file.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 Documentation/trace/events.rst      |  15 +-
 Documentation/trace/histogram.rst   |  18 +++
 kernel/trace/synth_event_gen_test.c |  18 ++-
 kernel/trace/trace_events_hist.c    |   9 ++
 kernel/trace/trace_events_synth.c   | 239 ++++++++++++++++++++++++----
 kernel/trace/trace_synth.h          |   4 +
 6 files changed, 265 insertions(+), 38 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index f792b1959a33..2a5aa48eff6c 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -589,8 +589,19 @@ name::
         { .type = "int",                .name = "my_int_field" },
   };
 
-See synth_field_size() for available types. If field_name contains [n]
-the field is considered to be an array.
+See synth_field_size() for available types.
+
+If field_name contains [n], the field is considered to be a static array.
+
+If field_names contains[] (no subscript), the field is considered to
+be a dynamic array, which will only take as much space in the event as
+is required to hold the array.
+
+Because space for an event is reserved before assigning field values
+to the event, using dynamic arrays implies that the piecewise
+in-kernel API described below can't be used with dynamic arrays.  The
+other non-piecewise in-kernel APIs can, however, be used with dynamic
+arrays.
 
 If the event is created from within a module, a pointer to the module
 must be passed to synth_event_create().  This will ensure that the
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 8408670d0328..b573604deabd 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1776,6 +1776,24 @@ consisting of the name of the new event along with one or more
 variables and their types, which can be any valid field type,
 separated by semicolons, to the tracing/synthetic_events file.
 
+See synth_field_size() for available types.
+
+If field_name contains [n], the field is considered to be a static array.
+
+If field_names contains[] (no subscript), the field is considered to
+be a dynamic array, which will only take as much space in the event as
+is required to hold the array.
+
+A string field can be specified using either the static notation:
+
+  char name[32];
+
+Or the dynamic:
+
+  char name[];
+
+The size limit for either is 256.
+
 For instance, the following creates a new event named 'wakeup_latency'
 with 3 fields: lat, pid, and prio.  Each of those fields is simply a
 variable reference to a variable on another event::
diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 7d56d621ffea..edd912cd14aa 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -242,9 +242,11 @@ static struct synth_field_desc create_synth_test_fields[] = {
 	{ .type = "pid_t",		.name = "next_pid_field" },
 	{ .type = "char[16]",		.name = "next_comm_field" },
 	{ .type = "u64",		.name = "ts_ns" },
+	{ .type = "char[]",		.name = "dynstring_field_1" },
 	{ .type = "u64",		.name = "ts_ms" },
 	{ .type = "unsigned int",	.name = "cpu" },
 	{ .type = "char[64]",		.name = "my_string_field" },
+	{ .type = "char[]",		.name = "dynstring_field_2" },
 	{ .type = "int",		.name = "my_int_field" },
 };
 
@@ -254,7 +256,7 @@ static struct synth_field_desc create_synth_test_fields[] = {
  */
 static int __init test_create_synth_event(void)
 {
-	u64 vals[7];
+	u64 vals[9];
 	int ret;
 
 	/* Create the create_synth_test event with the fields above */
@@ -292,10 +294,12 @@ static int __init test_create_synth_event(void)
 	vals[0] = 777;			/* next_pid_field */
 	vals[1] = (u64)(long)"tiddlywinks";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
-	vals[3] = 1000;			/* ts_ms */
-	vals[4] = raw_smp_processor_id(); /* cpu */
-	vals[5] = (u64)(long)"thneed";	/* my_string_field */
-	vals[6] = 398;			/* my_int_field */
+	vals[3] = (u64)(long)"xrayspecs";	/* dynstring_field_1 */
+	vals[4] = 1000;			/* ts_ms */
+	vals[5] = raw_smp_processor_id(); /* cpu */
+	vals[6] = (u64)(long)"thneed";	/* my_string_field */
+	vals[7] = (u64)(long)"kerplunk";	/* dynstring_field_2 */
+	vals[8] = 398;			/* my_int_field */
 
 	/* Now generate a create_synth_test event */
 	ret = synth_event_trace_array(create_synth_test, vals, ARRAY_SIZE(vals));
@@ -422,13 +426,15 @@ static int __init test_trace_synth_event(void)
 	int ret;
 
 	/* Trace some bogus values just for testing */
-	ret = synth_event_trace(create_synth_test, 7,	/* number of values */
+	ret = synth_event_trace(create_synth_test, 9,	/* number of values */
 				(u64)444,		/* next_pid_field */
 				(u64)(long)"clackers",	/* next_comm_field */
 				(u64)1000000,		/* ts_ns */
+				(u64)(long)"viewmaster",/* dynstring_field_1 */
 				(u64)1000,		/* ts_ms */
 				(u64)raw_smp_processor_id(), /* cpu */
 				(u64)(long)"Thneed",	/* my_string_field */
+				(u64)(long)"yoyos",	/* dynstring_field_2 */
 				(u64)999);		/* my_int_field */
 	return ret;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1b2ef6490229..ee6b27c82350 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3279,6 +3279,15 @@ static int check_synth_field(struct synth_event *event,
 
 	field = event->fields[field_pos];
 
+	/*
+	 * A dynamic string synth field can accept static or
+	 * dynamic. A static string synth field can only accept a
+	 * same-sized static string, which is checked for later.
+	 */
+	if (strstr(hist_field->type, "char[") && field->is_string
+	    && field->is_dynamic)
+		return 0;
+
 	if (strcmp(field->type, hist_field->type) != 0) {
 		if (field->size != hist_field->size ||
 		    field->is_signed != hist_field->is_signed)
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index fa8a99828f41..4b3ec570147a 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -88,7 +88,7 @@ static int synth_event_define_fields(struct trace_event_call *call)
 
 		event->fields[i]->offset = n_u64;
 
-		if (event->fields[i]->is_string) {
+		if (event->fields[i]->is_string && !event->fields[i]->is_dynamic) {
 			offset += STR_VAR_LEN_MAX;
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
@@ -139,6 +139,9 @@ static int synth_field_string_size(char *type)
 	if (len > 3)
 		return -EINVAL;
 
+	if (len == 0)
+		return 0; /* variable-length string */
+
 	strncpy(buf, start, len);
 	buf[len] = '\0';
 
@@ -290,10 +293,25 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 
 		/* parameter values */
 		if (se->fields[i]->is_string) {
-			trace_seq_printf(s, print_fmt, se->fields[i]->name,
-					 (char *)&entry->fields[n_u64],
-					 i == se->n_fields - 1 ? "" : " ");
-			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+			if (se->fields[i]->is_dynamic) {
+				u32 offset, data_offset;
+				char *str_field;
+
+				offset = (u32)entry->fields[n_u64];
+				data_offset = offset & 0xffff;
+
+				str_field = (char *)entry + data_offset;
+
+				trace_seq_printf(s, print_fmt, se->fields[i]->name,
+						 str_field,
+						 i == se->n_fields - 1 ? "" : " ");
+				n_u64++;
+			} else {
+				trace_seq_printf(s, print_fmt, se->fields[i]->name,
+						 (char *)&entry->fields[n_u64],
+						 i == se->n_fields - 1 ? "" : " ");
+				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+			}
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
@@ -325,16 +343,52 @@ static struct trace_event_functions synth_event_funcs = {
 	.trace		= print_synth_event
 };
 
+static unsigned int trace_string(struct synth_trace_event *entry,
+				 struct synth_event *event,
+				 char *str_val,
+				 bool is_dynamic,
+				 unsigned int data_size,
+				 unsigned int *n_u64)
+{
+	unsigned int len = 0;
+	char *str_field;
+
+	if (is_dynamic) {
+		u32 data_offset;
+
+		data_offset = offsetof(typeof(*entry), fields);
+		data_offset += event->n_u64 * sizeof(u64);
+		data_offset += data_size;
+
+		str_field = (char *)entry + data_offset;
+
+		len = strlen(str_val) + 1;
+		strscpy(str_field, str_val, len);
+
+		data_offset |= len << 16;
+		*(u32 *)&entry->fields[*n_u64] = data_offset;
+
+		(*n_u64)++;
+	} else {
+		str_field = (char *)&entry->fields[*n_u64];
+
+		strscpy(str_field, str_val, STR_VAR_LEN_MAX);
+		(*n_u64) += STR_VAR_LEN_MAX / sizeof(u64);
+	}
+
+	return len;
+}
+
 static notrace void trace_event_raw_event_synth(void *__data,
 						u64 *var_ref_vals,
 						unsigned int *var_ref_idx)
 {
+	unsigned int i, n_u64, val_idx, len, data_size = 0;
 	struct trace_event_file *trace_file = __data;
 	struct synth_trace_event *entry;
 	struct trace_event_buffer fbuffer;
 	struct trace_buffer *buffer;
 	struct synth_event *event;
-	unsigned int i, n_u64, val_idx;
 	int fields_size = 0;
 
 	event = trace_file->event_call->data;
@@ -344,6 +398,18 @@ static notrace void trace_event_raw_event_synth(void *__data,
 
 	fields_size = event->n_u64 * sizeof(u64);
 
+	for (i = 0; i < event->n_dynamic_fields; i++) {
+		unsigned int field_pos = event->dynamic_fields[i]->field_pos;
+		char *str_val;
+
+		val_idx = var_ref_idx[field_pos];
+		str_val = (char *)(long)var_ref_vals[val_idx];
+
+		len = strlen(str_val) + 1;
+
+		fields_size += len;
+	}
+
 	/*
 	 * Avoid ring buffer recursion detection, as this event
 	 * is being performed within another event.
@@ -360,10 +426,11 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		val_idx = var_ref_idx[i];
 		if (event->fields[i]->is_string) {
 			char *str_val = (char *)(long)var_ref_vals[val_idx];
-			char *str_field = (char *)&entry->fields[n_u64];
 
-			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
-			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+			len = trace_string(entry, event, str_val,
+					   event->fields[i]->is_dynamic,
+					   data_size, &n_u64);
+			data_size += len; /* only dynamic string increments */
 		} else {
 			struct synth_field *field = event->fields[i];
 			u64 val = var_ref_vals[val_idx];
@@ -522,9 +589,30 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	}
 
 	size = synth_field_size(field->type);
-	if (size <= 0) {
+	if (size < 0) {
 		ret = -EINVAL;
 		goto free;
+	} else if (size == 0) {
+		if (synth_field_is_string(field->type)) {
+			char *type;
+
+			type = kzalloc(sizeof("__data_loc ") + strlen(field->type) + 1, GFP_KERNEL);
+			if (!type) {
+				ret = -ENOMEM;
+				goto free;
+			}
+
+			strcat(type, "__data_loc ");
+			strcat(type, field->type);
+			kfree(field->type);
+			field->type = type;
+
+			field->is_dynamic = true;
+			size = sizeof(u64);
+		} else {
+			ret = -EINVAL;
+			goto free;
+		}
 	}
 	field->size = size;
 
@@ -532,7 +620,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		field->is_string = true;
 
 	field->is_signed = synth_field_signed(field->type);
-
  out:
 	return field;
  free:
@@ -663,6 +750,7 @@ static void free_synth_event(struct synth_event *event)
 		free_synth_field(event->fields[i]);
 
 	kfree(event->fields);
+	kfree(event->dynamic_fields);
 	kfree(event->name);
 	kfree(event->class.system);
 	free_synth_tracepoint(event->tp);
@@ -673,8 +761,8 @@ static void free_synth_event(struct synth_event *event)
 static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 					     struct synth_field **fields)
 {
+	unsigned int i, j, n_dynamic_fields = 0;
 	struct synth_event *event;
-	unsigned int i;
 
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
 	if (!event) {
@@ -696,11 +784,33 @@ static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 		goto out;
 	}
 
+	for (i = 0; i < n_fields; i++)
+		if (fields[i]->is_dynamic)
+			n_dynamic_fields++;
+
+	if (n_dynamic_fields) {
+		event->dynamic_fields = kcalloc(n_dynamic_fields,
+						sizeof(*event->dynamic_fields),
+						GFP_KERNEL);
+		if (!event->dynamic_fields) {
+			free_synth_event(event);
+			event = ERR_PTR(-ENOMEM);
+			goto out;
+		}
+	}
+
 	dyn_event_init(&event->devent, &synth_event_ops);
 
-	for (i = 0; i < n_fields; i++)
+	for (i = 0, j = 0; i < n_fields; i++) {
 		event->fields[i] = fields[i];
 
+		if (fields[i]->is_dynamic) {
+			event->dynamic_fields[j] = fields[i];
+			event->dynamic_fields[j]->field_pos = i;
+			event->dynamic_fields[j++] = fields[i];
+			event->n_dynamic_fields++;
+		}
+	}
 	event->n_fields = n_fields;
  out:
 	return event;
@@ -712,6 +822,10 @@ static int synth_event_check_arg_fn(void *data)
 	int size;
 
 	size = synth_field_size((char *)arg_pair->lhs);
+	if (size == 0) {
+		if (strstr((char *)arg_pair->lhs, "["))
+			return 0;
+	}
 
 	return size ? 0 : -EINVAL;
 }
@@ -1200,10 +1314,9 @@ void synth_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
 EXPORT_SYMBOL_GPL(synth_event_cmd_init);
 
 static inline int
-__synth_event_trace_start(struct trace_event_file *file,
-			  struct synth_event_trace_state *trace_state)
+__synth_event_trace_init(struct trace_event_file *file,
+			 struct synth_event_trace_state *trace_state)
 {
-	int entry_size, fields_size = 0;
 	int ret = 0;
 
 	memset(trace_state, '\0', sizeof(*trace_state));
@@ -1225,8 +1338,20 @@ __synth_event_trace_start(struct trace_event_file *file,
 	}
 
 	trace_state->event = file->event_call->data;
+out:
+	return ret;
+}
+
+static inline int
+__synth_event_trace_start(struct trace_event_file *file,
+			  struct synth_event_trace_state *trace_state,
+			  int dynamic_fields_size)
+{
+	int entry_size, fields_size = 0;
+	int ret = 0;
 
 	fields_size = trace_state->event->n_u64 * sizeof(u64);
+	fields_size += dynamic_fields_size;
 
 	/*
 	 * Avoid ring buffer recursion detection, as this event
@@ -1243,7 +1368,7 @@ __synth_event_trace_start(struct trace_event_file *file,
 		ring_buffer_nest_end(trace_state->buffer);
 		ret = -EINVAL;
 	}
-out:
+
 	return ret;
 }
 
@@ -1276,23 +1401,46 @@ __synth_event_trace_end(struct synth_event_trace_state *trace_state)
  */
 int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 {
+	unsigned int i, n_u64, len, data_size = 0;
 	struct synth_event_trace_state state;
-	unsigned int i, n_u64;
 	va_list args;
 	int ret;
 
-	ret = __synth_event_trace_start(file, &state);
+	ret = __synth_event_trace_init(file, &state);
 	if (ret) {
 		if (ret == -ENOENT)
 			ret = 0; /* just disabled, not really an error */
 		return ret;
 	}
 
+	if (state.event->n_dynamic_fields) {
+		va_start(args, n_vals);
+
+		for (i = 0; i < state.event->n_fields; i++) {
+			u64 val = va_arg(args, u64);
+
+			if (state.event->fields[i]->is_string &&
+			    state.event->fields[i]->is_dynamic) {
+				char *str_val = (char *)(long)val;
+
+				data_size += strlen(str_val) + 1;
+			}
+		}
+
+		va_end(args);
+	}
+
+	ret = __synth_event_trace_start(file, &state, data_size);
+	if (ret)
+		return ret;
+
 	if (n_vals != state.event->n_fields) {
 		ret = -EINVAL;
 		goto out;
 	}
 
+	data_size = 0;
+
 	va_start(args, n_vals);
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
 		u64 val;
@@ -1301,10 +1449,11 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 		if (state.event->fields[i]->is_string) {
 			char *str_val = (char *)(long)val;
-			char *str_field = (char *)&state.entry->fields[n_u64];
 
-			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
-			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+			len = trace_string(state.entry, state.event, str_val,
+					   state.event->fields[i]->is_dynamic,
+					   data_size, &n_u64);
+			data_size += len; /* only dynamic string increments */
 		} else {
 			struct synth_field *field = state.event->fields[i];
 
@@ -1357,29 +1506,46 @@ EXPORT_SYMBOL_GPL(synth_event_trace);
 int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 			    unsigned int n_vals)
 {
+	unsigned int i, n_u64, field_pos, len, data_size = 0;
 	struct synth_event_trace_state state;
-	unsigned int i, n_u64;
+	char *str_val;
 	int ret;
 
-	ret = __synth_event_trace_start(file, &state);
+	ret = __synth_event_trace_init(file, &state);
 	if (ret) {
 		if (ret == -ENOENT)
 			ret = 0; /* just disabled, not really an error */
 		return ret;
 	}
 
+	if (state.event->n_dynamic_fields) {
+		for (i = 0; i < state.event->n_dynamic_fields; i++) {
+			field_pos = state.event->dynamic_fields[i]->field_pos;
+			str_val = (char *)(long)vals[field_pos];
+			len = strlen(str_val) + 1;
+			data_size += len;
+		}
+	}
+
+	ret = __synth_event_trace_start(file, &state, data_size);
+	if (ret)
+		return ret;
+
 	if (n_vals != state.event->n_fields) {
 		ret = -EINVAL;
 		goto out;
 	}
 
+	data_size = 0;
+
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
 		if (state.event->fields[i]->is_string) {
 			char *str_val = (char *)(long)vals[i];
-			char *str_field = (char *)&state.entry->fields[n_u64];
 
-			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
-			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
+			len = trace_string(state.entry, state.event, str_val,
+					   state.event->fields[i]->is_dynamic,
+					   data_size, &n_u64);
+			data_size += len; /* only dynamic string increments */
 		} else {
 			struct synth_field *field = state.event->fields[i];
 			u64 val = vals[i];
@@ -1447,9 +1613,17 @@ int synth_event_trace_start(struct trace_event_file *file,
 	if (!trace_state)
 		return -EINVAL;
 
-	ret = __synth_event_trace_start(file, trace_state);
-	if (ret == -ENOENT)
-		ret = 0; /* just disabled, not really an error */
+	ret = __synth_event_trace_init(file, trace_state);
+	if (ret) {
+		if (ret == -ENOENT)
+			ret = 0; /* just disabled, not really an error */
+		return ret;
+	}
+
+	if (trace_state->event->n_dynamic_fields)
+		return -ENOTSUPP;
+
+	ret = __synth_event_trace_start(file, trace_state, 0);
 
 	return ret;
 }
@@ -1510,6 +1684,11 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 		char *str_val = (char *)(long)val;
 		char *str_field;
 
+		if (field->is_dynamic) { /* add_val can't do dynamic strings */
+			ret = -EINVAL;
+			goto out;
+		}
+
 		if (!str_val) {
 			ret = -EINVAL;
 			goto out;
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index 5166705d1556..6e146b959dcd 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -16,6 +16,8 @@ struct synth_field {
 	unsigned int offset;
 	bool is_signed;
 	bool is_string;
+	bool is_dynamic;
+	bool field_pos;
 };
 
 struct synth_event {
@@ -24,6 +26,8 @@ struct synth_event {
 	char					*name;
 	struct synth_field			**fields;
 	unsigned int				n_fields;
+	struct synth_field			**dynamic_fields;
+	unsigned int				n_dynamic_fields;
 	unsigned int				n_u64;
 	struct trace_event_class		class;
 	struct trace_event_call			call;
-- 
2.17.1

