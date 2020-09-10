Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8070B26541C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgIJVvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbgIJMi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:38:57 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B42520C09;
        Thu, 10 Sep 2020 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741523;
        bh=8gKKD/n/aC0dNUujjPiJ2/C+SWzJMIBaw/u5skGiLl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUNPSnT1Tql0/xtOFjJ7MSDjVl+slyvWyZXsHk/9I9lK/4ErYWKy4LX32IrNNSHAq
         g+9s+Z6bEHZL24J+cO+711tyFLa9SzDdW19YfWZPIITuC/NqBvW985QEqEKXLef7KE
         OFmQR4JHOzpz2lV2GdMwUFKc5gxUFnMoM9AUcaqY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/6] kprobes: Init kprobes in early_initcall
Date:   Thu, 10 Sep 2020 21:38:39 +0900
Message-Id: <159974151897.478751.8342374158615496628.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159974150897.478751.17933810682730471522.stgit@devnote2>
References: <159974150897.478751.17933810682730471522.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init kprobes feature in early_initcall as same as jump_label and
dynamic_debug does, so that we can use kprobes events in earlier
boot stage.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2880cdf37c47..7d1fbdaa7a08 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2528,7 +2528,7 @@ static int __init init_kprobes(void)
 		init_test_probes();
 	return err;
 }
-subsys_initcall(init_kprobes);
+early_initcall(init_kprobes);
 
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,

