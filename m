Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02022DBF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgLPLlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:41:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43186 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:41:35 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kpVAp-0004DA-Rc; Wed, 16 Dec 2020 11:40:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix spelling mistake in Kconfig "infinit" -> "infinite"
Date:   Wed, 16 Dec 2020 11:40:51 +0000
Message-Id: <20201216114051.12056-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d5a19413d4f8..2c22444d5b9b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -545,7 +545,7 @@ config KPROBE_EVENTS_ON_NOTRACE
 	  using kprobe events.
 
 	  If kprobes can use ftrace instead of breakpoint, ftrace related
-	  functions are protected from kprobe-events to prevent an infinit
+	  functions are protected from kprobe-events to prevent an infinite
 	  recursion or any unexpected execution path which leads to a kernel
 	  crash.
 
-- 
2.29.2

