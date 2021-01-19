Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07052FBAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbhASPUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:20:34 -0500
Received: from foss.arm.com ([217.140.110.172]:35418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390887AbhASPLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:11:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1141D6E;
        Tue, 19 Jan 2021 07:10:45 -0800 (PST)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AD673F66E;
        Tue, 19 Jan 2021 07:10:43 -0800 (PST)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     Jianlin.Lv@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: precise log info for kretprobe addr err
Date:   Tue, 19 Jan 2021 23:10:14 +0800
Message-Id: <20210119151014.3822465-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to create kretprobe with the wrong function symbol in tracefs;
The error is triggered in the register_trace_kprobe() and recorded as
FAIL_REG_PROBE issue,

Example:
  $ cd /sys/kernel/debug/tracing
  $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
    bash: echo: write error: Invalid argument
  $ cat error_log
    [142797.347877] trace_kprobe: error: Failed to register probe event
    Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
                       ^

This error can be detected in the parameter parsing stage, the effect of
applying this patch is as follows:

  $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
    bash: echo: write error: Invalid argument
  $ cat error_log
    [415.89]trace_kprobe: error: Retprobe address must be an function entry
    Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
                       ^

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e6fba1798771..3dfd1b6711a3 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
 			flags |= TPARG_FL_RETURN;
 		if (kprobe_on_func_entry(NULL, symbol, offset))
 			flags |= TPARG_FL_FENTRY;
-		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
+		if (is_return && !(flags & TPARG_FL_FENTRY)) {
 			trace_probe_log_err(0, BAD_RETPROBE);
 			goto parse_error;
 		}
-- 
2.25.1

