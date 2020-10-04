Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7C282E07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 00:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgJDWOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 18:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgJDWOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 18:14:21 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EFF20797;
        Sun,  4 Oct 2020 22:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601849661;
        bh=lzkQi7fktbNnCc3/dVGPuNZ2jh4wlQ89t/h/kBbdSV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=LXLNMFKpBfOEaEFo+m06IHEh6F53N5h1Rfx1ylL0ac3KY2CMdd+cduax7xdJlJH07
         XRni7FBdNHLxunYkqYT694QqBvfARKNYtXpidppYPNdzLhCpG9OxAEvLuXu2cAsD4P
         /oDoy+EyWa1wlhQxMQS+PGGv+/6eGnZWLlF5djms=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] tracing: Change synthetic event string format to limit printed length
Date:   Sun,  4 Oct 2020 17:14:09 -0500
Message-Id: <b6bdb34e70d970e8026daa3503db6b8e5cdad524.1601848695.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

Change the format for printing synthetic field strings to limit the
length of the string printed even if it's not correctly terminated.

Description from Steve:

I also added this for a bit of paranoid, and probably should be a
separate patch, just to make sure if the string isn't nul terminated,
this will keep it from bleeding pass the end of the string.
---
 kernel/trace/trace_events_synth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 24bc6d61aa40..742ce5f62d6d 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -234,7 +234,7 @@ static const char *synth_field_fmt(char *type)
 	else if (strcmp(type, "gfp_t") == 0)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
-		fmt = "%s";
+		fmt = "%.*s";
 
 	return fmt;
 }
@@ -303,11 +303,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				str_field = (char *)entry + data_offset;
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
+						 STR_VAR_LEN_MAX,
 						 str_field,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;
 			} else {
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
+						 STR_VAR_LEN_MAX,
 						 (char *)&entry->fields[n_u64],
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
-- 
2.17.1

