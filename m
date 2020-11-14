Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473C52B2E06
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKNPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 10:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgKNPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:35:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E5022281;
        Sat, 14 Nov 2020 15:35:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kdxZr-000Hlm-Ag; Sat, 14 Nov 2020 10:34:59 -0500
Message-ID: <20201114153459.217023454@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 14 Nov 2020 10:32:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tosk Robot <tencent_os_robot@tencent.com>,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [for-next][PATCH 4/4] tracing: Remove the useless value assignment in
 test_create_synth_event()
References: <20201114153221.050150744@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of variable ret is overwritten on the delete branch in the
test_create_synth_event() and we care more about the above error than
this delete portion. Remove it.

Link: https://lkml.kernel.org/r/1605283360-6804-1-git-send-email-kaixuxia@tencent.com

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/synth_event_gen_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index edd912cd14aa..a4b4bbf8c3bf 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -307,7 +307,7 @@ static int __init test_create_synth_event(void)
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
-	ret = synth_event_delete("create_synth_test");
+	synth_event_delete("create_synth_test");
 
 	goto out;
 }
-- 
2.28.0


