Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19471284E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgJFOfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgJFOfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F342C204EF;
        Tue,  6 Oct 2020 14:35:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3a-002zAm-VJ; Tue, 06 Oct 2020 10:35:10 -0400
Message-ID: <20201006143510.855470216@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:34:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 02/15] tracing: Change STR_VAR_MAX_LEN
References: <20201006143446.182666356@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

32 is too small for this value, and anyway it makes more sense to use
MAX_FILTER_STR_VAL, as this is also the value used for variable-length
__strings.

Link: https://lkml.kernel.org/r/6adfd1668ac1fd8670bd58206944a762061a5559.1601848695.git.zanussi@kernel.org

Tested-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.28.0


