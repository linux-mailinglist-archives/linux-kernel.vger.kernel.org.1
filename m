Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95B6290D69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgJPVsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbgJPVse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:48:34 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A950221EB;
        Fri, 16 Oct 2020 21:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602884913;
        bh=7qR4V0J+0o/Mkgp19j/LDB3qo11FY8b5Zze0OljgHwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=2NxDCqmqYqm3bzsNkBWtD2Z4jMkpZ1XkAks2cmiE4UVw4a2rF5trfPptekbeucJFd
         lcVd74nd7GsCaf4MNDaqd0xpZyHOkeYJXWsP0t8HlGDb6WGWpwxTqeXhKNaFiljqOJ
         G7/7ZMfZq4/yTMCmqhmur3Hfiwi7MJiJVkR77LV0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] tracing: Update synth command errors
Date:   Fri, 16 Oct 2020 16:48:24 -0500
Message-Id: <839b078ba3e31a3fcd82ff3a4e6c483ba5cfe7db.1602883818.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602883818.git.zanussi@kernel.org>
References: <cover.1602883818.git.zanussi@kernel.org>
In-Reply-To: <cover.1602883818.git.zanussi@kernel.org>
References: <cover.1602883818.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since array types are handled differently, errors referencing them
also need to be handled differently.  Add and use a new
INVALID_ARRAY_SPEC error.  Also remove INVALID_FIELD since it can
better be handled using CMD_INCOMPLETE, and remove CMD_TOO_LONG, since
it's no longer used.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2333025ef31e..f48964bdd66e 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -28,8 +28,7 @@
 	C(TOO_MANY_FIELDS,	"Too many fields"),		\
 	C(INCOMPLETE_TYPE,	"Incomplete type"),		\
 	C(INVALID_TYPE,		"Invalid type"),		\
-	C(INVALID_FIELD,	"Invalid field"),		\
-	C(CMD_TOO_LONG,		"Command too long"),
+	C(INVALID_ARRAY_SPEC,	"Invalid array specification"),
 
 #undef C
 #define C(a, b)		SYNTH_ERR_##a
@@ -643,6 +642,10 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	size = synth_field_size(field->type);
 	if (size < 0) {
 		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
+		if (array)
+			synth_err(SYNTH_ERR_INVALID_ARRAY_SPEC, errpos(field_name));
+		else
+			synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
@@ -1191,7 +1194,7 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	}
 
 	if (i < argc) {
-		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
+		synth_err(SYNTH_ERR_CMD_INCOMPLETE, errpos(argv[i]));
 		ret = -EINVAL;
 		goto err;
 	}
-- 
2.17.1

