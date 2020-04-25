Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34111B83DC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 07:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDYFtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 01:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDYFtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 01:49:12 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806E420857;
        Sat, 25 Apr 2020 05:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587793752;
        bh=A5I0zjalWHaqyVHBItrDx5bgxBzVTkfvZ+G7hcy05Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgWMAu7xzTzZVCMRjFZ7mYgT4SCLBkj26i+gPxOJCPT72gxS7pCAbi+W7bQAbHwTT
         tcGGOHIAyTAX/v++mLX64K5rNpuyseYZl5zMHPS5Y6gJ6zq7aYNH1WsWu9rTSvZB2n
         NH/kAUYpCCw52tgxubwW4rrPx9rREUZ6NSUM7db8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/3] tracing/kprobes: Fix a double initialization typo
Date:   Sat, 25 Apr 2020 14:49:09 +0900
Message-Id: <158779374968.6082.2337484008464939919.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158779373972.6082.16695832932765258919.stgit@devnote2>
References: <158779373972.6082.16695832932765258919.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo that resulted in an unnecessary double
initialization to addr.

Fixes: c7411a1a126f ("tracing/kprobe: Check whether the non-suffixed symbol is notrace")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_kprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d0568af4a0ef..0d9300c3b084 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -453,7 +453,7 @@ static bool __within_notrace_func(unsigned long addr)
 
 static bool within_notrace_func(struct trace_kprobe *tk)
 {
-	unsigned long addr = addr = trace_kprobe_address(tk);
+	unsigned long addr = trace_kprobe_address(tk);
 	char symname[KSYM_NAME_LEN], *p;
 
 	if (!__within_notrace_func(addr))

