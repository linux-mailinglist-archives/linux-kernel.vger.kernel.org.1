Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BBC28D008
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgJMOSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbgJMOSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:18:06 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763C2247FF;
        Tue, 13 Oct 2020 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602598686;
        bh=/0aBTneVkZoEaETwwf8RMvyDjIipKWOw+WYbAv0Uig8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iv/3yM0c7EUhRA2VmTs/t1X4CPADG7syLM36wqjXQ+Xa0Z5H1e6bvAZaQ0SgkvFVw
         4s4f3oEohd9er7Jb/XmoyMrNiWlW2CINiqzxsEJoBbi0asJUvsBvElZFrfITGutEhI
         G2nCK79o72fsQgM2rFgDt2tfTpHt77DubLLO6SiE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] tracing: Check that the synthetic event and field names are legal
Date:   Tue, 13 Oct 2020 09:17:54 -0500
Message-Id: <c4d4bb59d3ac39bcbd70fba0cf837d6b1cedb015.1602598160.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
In-Reply-To: <cover.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
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

