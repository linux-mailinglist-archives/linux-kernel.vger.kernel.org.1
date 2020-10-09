Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13C1288C68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbgJIPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389231AbgJIPRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:17:19 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39362222D9;
        Fri,  9 Oct 2020 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602256638;
        bh=pqbdPnMML7SpyoGS3xqUMZMoHcLQfnfK9Yd8Fb4EB9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RAY1X/OJOYQlriiS7FZuFBkg2Zro6HZ0gQ3nsmCfPu97I6LBVUQDusKj5NdnnqMrs
         Q4lt2HYBS0nwuf2cIKoN556nH7/esK9vvrLnuxDB19BO6bFIjseva3z+0xevUqiLnZ
         m72HNzxTlX88SsyWvwLTSm2AOXBui0evA/2kVEZk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] tracing: Check that the synthetic event and field names are legal
Date:   Fri,  9 Oct 2020 10:17:09 -0500
Message-Id: <82b1b533c54f83bb7cd466a32244533717c8f291.1602255803.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
In-Reply-To: <cover.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the is_good_name() function used by probe events to make sure
synthetic event and field names don't contain illegal characters and
cause unexpected parsing of synthetic event commands.

Fixes: 4b147936fa50 (tracing: Add support for 'synthetic' events)
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
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

