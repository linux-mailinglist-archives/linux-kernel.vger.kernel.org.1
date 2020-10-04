Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0086A282E03
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 00:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgJDWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 18:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgJDWOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 18:14:17 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFE42078A;
        Sun,  4 Oct 2020 22:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601849656;
        bh=B+dFFMWcp40PJg650sB48Fs22vUJWnZ5MwrtEeFsO3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dy2eIyIj4/f8P0oiMXAxLI3QJ6DEkEsGO36T6pQ7ydonKbzbY63euubfJCoVX9MQm
         UjzwRV0PnBy+MZLvAz1os5iXL1k0kb04zB4S69Iee0TQC2nF6qULN2d7nnKNpuwpsn
         nMT/xnU07yvNSnrKRyBOpYRe/V9Q92PeaO8miRpI=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] tracing: Save normal string variables
Date:   Sun,  4 Oct 2020 17:14:05 -0500
Message-Id: <1c1a03798b02e67307412a0c719d1bfb69b13007.1601848695.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

String variables created as field variables and save variables are
already handled properly by having their values copied when set.  The
same isn't done for normal variables, but needs to be - simply saving
a pointer to a string contained in an old event isn't sufficient,
since that event's data may quickly become overwritten and therefore a
string pointer to it could yield garbage.

This change uses the same mechanism as field variables and simply
appends the new strings to the existing per-element field_var_str[]
array allocated for that purpose.

Fixes: 02205a6752f2 (tracing: Add support for 'field variables')
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 34 ++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 3b22e2122d1a..812bc5f94b5c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -147,6 +147,8 @@ struct hist_field {
 	 */
 	unsigned int			var_ref_idx;
 	bool                            read_once;
+
+	unsigned int			var_str_idx;
 };
 
 static u64 hist_field_none(struct hist_field *field,
@@ -349,6 +351,7 @@ struct hist_trigger_data {
 	unsigned int			n_keys;
 	unsigned int			n_fields;
 	unsigned int			n_vars;
+	unsigned int			n_var_str;
 	unsigned int			key_size;
 	struct tracing_map_sort_key	sort_keys[TRACING_MAP_SORT_KEYS_MAX];
 	unsigned int			n_sort_keys;
@@ -1396,7 +1399,12 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 		}
 	}
 
-	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str;
+	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str +
+		hist_data->n_var_str;
+	if (n_str > SYNTH_FIELDS_MAX) {
+		hist_elt_data_free(elt_data);
+		return -EINVAL;
+	}
 
 	BUILD_BUG_ON(STR_VAR_LEN_MAX & (sizeof(u64) - 1));
 
@@ -3653,6 +3661,7 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 {
 	struct trace_array *tr = hist_data->event_file->tr;
 	unsigned long flags = 0;
+	int ret;
 
 	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX + TRACING_MAP_VARS_MAX))
 		return -EINVAL;
@@ -3667,7 +3676,12 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 	if (WARN_ON(hist_data->n_vars > TRACING_MAP_VARS_MAX))
 		return -EINVAL;
 
-	return __create_val_field(hist_data, val_idx, file, var_name, expr_str, flags);
+	ret = __create_val_field(hist_data, val_idx, file, var_name, expr_str, flags);
+
+	if (hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
+		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
+
+	return ret;
 }
 
 static int create_val_fields(struct hist_trigger_data *hist_data,
@@ -4394,6 +4408,22 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 		hist_val = hist_field->fn(hist_field, elt, rbe, rec);
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
+
+			if (hist_field->flags & HIST_FIELD_FL_STRING) {
+				unsigned int str_start, var_str_idx, idx;
+				char *str, *val_str;
+
+				str_start = hist_data->n_field_var_str +
+					hist_data->n_save_var_str;
+				var_str_idx = hist_field->var_str_idx;
+				idx = str_start + var_str_idx;
+
+				str = elt_data->field_var_str[idx];
+				val_str = (char *)(uintptr_t)hist_val;
+				strscpy(str, val_str, STR_VAR_LEN_MAX);
+
+				hist_val = (u64)(uintptr_t)str;
+			}
 			tracing_map_set_var(elt, var_idx, hist_val);
 			continue;
 		}
-- 
2.17.1

