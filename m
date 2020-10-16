Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D428A28FD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgJPEUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgJPEUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:20:07 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31ABF207F7;
        Fri, 16 Oct 2020 04:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602822007;
        bh=EXYxSzP1dW1W1QkWIS5axK2An/3LamYPWK/R5ZAIkZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SNuWuziniXSnCaUiTQYLlDGJhEuQG7IKExo9YPlaWpkCv4CpsBTl2gEc15oXOysB
         St2DYAMjoZ1/QGJjsnzBE67TGj+asuBTKeaVIweYyS/Uavz+CI+qauqh9ReVG/sHsG
         tTQV9eFsgsu1e4Iq4GkKZraKMY4Jj30TBLuD4P+A=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Remove __init from __trace_early_add_new_event()
Date:   Fri, 16 Oct 2020 13:20:02 +0900
Message-Id: <160282200251.139169.7719782610210850019.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015235444.6f222746@gandalf.local.home>
References: <20201015235444.6f222746@gandalf.local.home>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 720dee53ad8d ("tracing/boot: Initialize per-instance event
list in early boot") removes __init from __trace_early_add_events()
but __trace_early_add_new_event() still has __init and will cause a
section mismatch.

Remove __init from __trace_early_add_new_event() as same as
__trace_early_add_events().

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 851ab37058dd..e705f06c68c6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2498,7 +2498,7 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
  * for enabling events at boot. We want to enable events before
  * the filesystem is initialized.
  */
-static __init int
+static int
 __trace_early_add_new_event(struct trace_event_call *call,
 			    struct trace_array *tr)
 {

