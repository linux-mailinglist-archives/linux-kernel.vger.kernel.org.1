Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C25282DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 00:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgJDWOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 18:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgJDWOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 18:14:14 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E4B206DD;
        Sun,  4 Oct 2020 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601849653;
        bh=dv/UrIG0Wy4zsy6DZWaXKSqClmZ6PKIEK8cok93s6q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nQfsxWAIhy/VRk3Uogk7OC4e73gIN9lAOch4wvaEkX80hu8tNBzceVkWWQHkub8PG
         F5YWSOuCaQ9JFfm8q2PdwWq2iLVaNqWCU7fg+2tf/RmvXQY6ovLVAWzcPlKZ3R6KLY
         wrZ59ez65Ppb91aWaqomrNKAx/d4nNCyi3y+6w9A=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] tracing: Change STR_VAR_MAX_LEN
Date:   Sun,  4 Oct 2020 17:14:03 -0500
Message-Id: <6adfd1668ac1fd8670bd58206944a762061a5559.1601848695.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32 is too small for this value, and anyway it makes more sense to use
MAX_FILTER_STR_VAL, as this is also the value used for variable-length
__strings.

Tested-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 2 ++
 kernel/trace/trace_synth.h       | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1b2ef6490229..3b22e2122d1a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1398,6 +1398,8 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 
 	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str;
 
+	BUILD_BUG_ON(STR_VAR_LEN_MAX & (sizeof(u64) - 1));
+
 	size = STR_VAR_LEN_MAX;
 
 	for (i = 0; i < n_str; i++) {
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index ac35c45207c4..5166705d1556 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -7,7 +7,7 @@
 #define SYNTH_SYSTEM		"synthetic"
 #define SYNTH_FIELDS_MAX	32
 
-#define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
+#define STR_VAR_LEN_MAX		MAX_FILTER_STR_VAL /* must be multiple of sizeof(u64) */
 
 struct synth_field {
 	char *type;
-- 
2.17.1

