Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7955282E00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgJDWOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 18:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgJDWOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 18:14:19 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554662078D;
        Sun,  4 Oct 2020 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601849658;
        bh=JIUXDmy/1aNoWz4WvgrW31MCPtFNO2+yugX85WHhq1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NrtY994rBIe4LnmCaJJAidx5SOXFH2EicTrz4kPNQpoFoiEliQkf+5DNreARTse/f
         6lumlLCdIWvB7nwB1NMUBfUEq+qC+bD0cfN9yZNxAubv0HkX5Ftj64srtfyowPSpzm
         GByV2WzThA/DGnC7/GTrOP+N7Q2md2YfCHymJM9g=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] tracing: Add README information for synthetic_events file
Date:   Sun,  4 Oct 2020 17:14:07 -0500
Message-Id: <3c7f178cf95aaeebc01eda7d95600dd937233eb7.1601848695.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry with a basic description of events/synthetic_events along
with a simple example.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3f2533adae72..73fd0e0c0f39 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5249,7 +5249,12 @@ static const char readme_msg[] =
 	"\t        trace(<synthetic_event>,param list)  - generate synthetic event\n"
 	"\t        save(field,...)                      - save current event fields\n"
 #ifdef CONFIG_TRACER_SNAPSHOT
-	"\t        snapshot()                           - snapshot the trace buffer\n"
+	"\t        snapshot()                           - snapshot the trace buffer\n\n"
+#endif
+#ifdef CONFIG_SYNTH_EVENTS
+	"  events/synthetic_events\t- Create/append/remove/show synthetic events\n"
+	"\t  Write into this file to define/undefine new synthetic events.\n"
+	"\t     example: echo 'myevent u64 lat; char name[]' >> synthetic_events\n"
 #endif
 #endif
 ;
-- 
2.17.1

