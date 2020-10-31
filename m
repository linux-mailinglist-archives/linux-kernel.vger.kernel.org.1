Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0552A1443
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 09:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJaI6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 04:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgJaI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 04:57:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA0C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 01:57:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b19so4212595pld.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KK1Ejal8cUthETqfeGqpiSRrWUR+BrbQ+JBbY+sbNlU=;
        b=aZErVyHdGIpPhOR5fCNIVRzVAZs8VV2vtrwWqEN4XRa3dfpIa1yMmy80FN8HxW1aDx
         m039GaDqJ7eGIsQruBQYqfpbTah+BsXT60QaDMJxyTmt7kkSwrDgVIkkDhZkYeYPS29a
         arEqOXCZWRzjxblUA6bEtMYp+YtW+yBIkE3fb2ZxlpNEftytbppwiMhVi7PM6/jz0CVR
         m55aZB2bVgew6L6bkUTUfZxSzkaWzjISouAakRT7JGJzGtQXHWsVa7g/uHNHvf3cOXEg
         BMtY5MVjoqsjD3/PTNK2VH8oNR/BUAa89mvies6jxi+88asrET0+OPrKaEKBWQSla+LH
         hJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KK1Ejal8cUthETqfeGqpiSRrWUR+BrbQ+JBbY+sbNlU=;
        b=ltSfUSOqpcLS59y+OsIxTOvGKIxuA1qxtiQxxX/vqhiig+CewHG+2uojXQc8ZBYbVY
         vZa6saH4LdI72tyVd358lHOIVjETHhoRkyuU33jeH8cLODVpfHSfaTw0W5K+YrL0nhk1
         QqJpXtFifdIjCWVY2Z1huKIP3P0SoGID0TIruA8oda6A2TcOlCYziTSvSSQgjB19Ik/H
         EEukaC9uo9bpd3je+bAWhtVhaYu0LNFAt2fgwneVwAg337AQEEWJy9Mej6OCvly4q+jT
         ziyBeym6V3PqJwNcyqLklBZTeQq8RzLqqF2YB076NH+Y86+t8ixcFuWaPcDuvZG55Y/p
         lPEw==
X-Gm-Message-State: AOAM5322ACX89po/HKLEK1TO38n/38rGhVtBQvR6btHEVCmnIqu9869s
        t2JQ27+4JTbKN+poQAgPIoo=
X-Google-Smtp-Source: ABdhPJx1+Q+Ey0ZqwOGpdm3M3juT0j7RoRXEHNKhNZVatogyxonlW8aeJMdYmzr/U3z/vFZDo8AKjw==
X-Received: by 2002:a17:90a:ba8d:: with SMTP id t13mr7318723pjr.38.1604134653009;
        Sat, 31 Oct 2020 01:57:33 -0700 (PDT)
Received: from localhost (42-3-19-186.static.netvigator.com. [42.3.19.186])
        by smtp.gmail.com with ESMTPSA id a21sm8133961pfg.68.2020.10.31.01.57.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Oct 2020 01:57:32 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] tracing: Fix the checking of stackidx in __ftrace_trace_stack
Date:   Sat, 31 Oct 2020 16:57:14 +0800
Message-Id: <20201031085714.2147-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The array size is FTRACE_KSTACK_NESTING, so the index FTRACE_KSTACK_NESTING
is illegal too. And fix two typos by the way.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 528971714fc6..1e190bcd0d59 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2750,7 +2750,7 @@ trace_event_buffer_lock_reserve(struct trace_buffer **current_rb,
 	/*
 	 * If tracing is off, but we have triggers enabled
 	 * we still need to look at the event data. Use the temp_buffer
-	 * to store the trace event for the tigger to use. It's recusive
+	 * to store the trace event for the trigger to use. It's recursive
 	 * safe and will not be recorded anywhere.
 	 */
 	if (!entry && trace_file->flags & EVENT_FILE_FL_TRIGGER_COND) {
@@ -2952,7 +2952,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
 
 	/* This should never happen. If it does, yell once and skip */
-	if (WARN_ON_ONCE(stackidx > FTRACE_KSTACK_NESTING))
+	if (WARN_ON_ONCE(stackidx >= FTRACE_KSTACK_NESTING))
 		goto out;
 
 	/*
-- 
2.17.1

