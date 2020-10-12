Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCA28C224
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbgJLUSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbgJLUSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:18:18 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC64208D5;
        Mon, 12 Oct 2020 20:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602533898;
        bh=/0aBTneVkZoEaETwwf8RMvyDjIipKWOw+WYbAv0Uig8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=BQqP6OhqHvC9fRrWH9VR7Uk4T+U2QNPxPnxCPYDX6P9f3DihJI8ZpG+yzUxKfvWr8
         KrTzGmpYCiYgecXj2czZrugUqthNPTqroEDIg5EcOe6Q8qfdgMRCAfv9OKFbDTT/LZ
         f0WaD9Pi3z0bOOCM7OZCvKjOFsO6EOiK3BdH8zdg=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] tracing: Check that the synthetic event and field names are legal
Date:   Mon, 12 Oct 2020 15:18:05 -0500
Message-Id: <c4d4bb59d3ac39bcbd70fba0cf837d6b1cedb015.1602533267.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the is_good_name() function used by probe events to make sure
synthetic event and field names don't contain illegal characters and
cause unexpected parsing of synthetic event commands.

Fixes: 4b147936fa50 (tracing: Add support for 'synthetic' events)
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index b19e2f4159ab..8c9d6e464da0 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -572,6 +572,10 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		ret = -ENOMEM;
 		goto free;
 	}
+	if (!is_good_name(field->name)) {
+		ret = -EINVAL;
+		goto free;
+	}
 
 	if (field_type[0] == ';')
 		field_type++;
@@ -1112,6 +1116,11 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 
 	mutex_lock(&event_mutex);
 
+	if (!is_good_name(name)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	event = find_synth_event(name);
 	if (event) {
 		ret = -EEXIST;
-- 
2.17.1

