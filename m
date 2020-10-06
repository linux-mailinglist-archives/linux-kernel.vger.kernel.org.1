Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08143284E15
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgJFOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgJFOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF3B21531;
        Tue,  6 Oct 2020 14:35:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3d-002zH4-46; Tue, 06 Oct 2020 10:35:13 -0400
Message-ID: <20201006143512.983073039@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:35:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [for-linus][PATCH 15/15] tracing: Remove a pointless assignment
References: <20201006143446.182666356@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The variable 'len' has been assigned a value but is not used after that.
So, remove the assignement.

Link: https://lkml.kernel.org/r/20200930184303.22896-1-sudipm.mukherjee@gmail.com

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 73fd0e0c0f39..0806fa9f2815 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6667,7 +6667,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 		written = -EFAULT;
 	} else
 		written = cnt;
-	len = cnt;
 
 	if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->triggers)) {
 		/* do not add \n before testing triggers, but add \0 */
-- 
2.28.0


