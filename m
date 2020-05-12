Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446071CF599
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgELNXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 09:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgELNXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:23:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E816820730;
        Tue, 12 May 2020 13:23:48 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jYUst-0006O8-Rv; Tue, 12 May 2020 09:23:47 -0400
Message-ID: <20200512132347.742114772@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 12 May 2020 09:23:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 1/3] tools/bootconfig: Fix apply_xbc() to return zero on success
References: <20200512132317.343672858@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The return of apply_xbc() returns the result of the last write() call, which
is not what is expected. It should only return zero on success.

Link: https://lore.kernel.org/r/20200508093059.GF9365@kadam

Fixes: 8842604446d1 ("tools/bootconfig: Fix resource leak in apply_xbc()")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 001076c51712..0efaf45f7367 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -337,6 +337,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 		pr_err("Failed to apply a boot config magic: %d\n", ret);
 		goto out;
 	}
+	ret = 0;
 out:
 	close(fd);
 	free(data);
-- 
2.26.2


