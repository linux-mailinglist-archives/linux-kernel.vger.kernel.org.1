Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939D5284E11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgJFOfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgJFOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 490D82087E;
        Tue,  6 Oct 2020 14:35:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3b-002zBk-93; Tue, 06 Oct 2020 10:35:11 -0400
Message-ID: <20201006143511.159147822@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:34:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 04/15] tracing: Save normal string variables
References: <20201006143446.182666356@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

String variables created as field variables and save variables are
already handled properly by having their values copied when set.  The
same isn't done for normal variables, but needs to be - simply saving
a pointer to a string contained in an old event isn't sufficient,
since that event's data may quickly become overwritten and therefore a
string pointer to it could yield garbage.

This change uses the same mechanism as field variables and simply
appends the new strings to the existing per-element field_var_str[]
array allocated for that purpose.

Link: https://lkml.kernel.org/r/1c1a03798b02e67307412a0c719d1bfb69b13007.1601848695.git.zanussi@kernel.org

Fixes: 02205a6752f2 (tracing: Add support for 'field variables')
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.28.0


