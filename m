Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A202CB227
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgLBBNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:13:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgLBBNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:13:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDC0B21D7E;
        Wed,  2 Dec 2020 01:13:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kkGhh-002W2h-Mc; Tue, 01 Dec 2020 20:13:09 -0500
Message-ID: <20201202011309.569371712@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Dec 2020 20:12:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 1/3] bootconfig: Load size and checksum in the footer as le32
References: <20201202011224.839590843@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Load the size and the checksum fields in the footer as le32
instead of u32. This will allow us to apply bootconfig to the
cross build initrd without caring the endianness.

Link: https://lkml.kernel.org/r/160583934457.547349.10504070298990791074.stgit@devnote2

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 20baced721ad..32b2a8affafd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -288,8 +288,8 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 found:
 	hdr = (u32 *)(data - 8);
-	size = hdr[0];
-	csum = hdr[1];
+	size = le32_to_cpu(hdr[0]);
+	csum = le32_to_cpu(hdr[1]);
 
 	data = ((void *)hdr) - size;
 	if ((unsigned long)data < initrd_start) {
-- 
2.28.0


