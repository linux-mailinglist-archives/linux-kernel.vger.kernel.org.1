Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC64244145
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 00:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHMWax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 18:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgHMWax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:30:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9833C204EC;
        Thu, 13 Aug 2020 22:30:52 +0000 (UTC)
Date:   Thu, 13 Aug 2020 18:30:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] bootconfig: Fix off-by-one in xbc_node_compose_key_after()
Message-ID: <20200813183050.029a6003@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

While reviewing some patches for bootconfig, I noticed the following
code in xbc_node_compose_key_after():

	ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
		       depth ? "." : "");
	if (ret < 0)
		return ret;
	if (ret > size) {
		size = 0;
	} else {
		size -= ret;
		buf += ret;
	}

But snprintf() returns the number of bytes that would be written, not
the number of bytes that are written (ignoring the nul terminator).
This means that if the number of non null bytes written were to equal
size, then the nul byte, which snprintf() always adds, will overwrite
that last byte.

	ret = snprintf(buf, 5, "hello");
	printf("buf = '%s'\n", buf);
	printf("ret = %d\n", ret);

produces:

	buf = 'hell'
	ret = 5

The string was truncated without ret being greater than 5.
Test (ret >= size) for overwrite.

Cc: stable@vger.kernel.org
Fixes: 76db5a27a827c ("bootconfig: Add Extra Boot Config support")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a5f701161f6b..42735f2b8860 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -248,7 +248,7 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 			       depth ? "." : "");
 		if (ret < 0)
 			return ret;
-		if (ret > size) {
+		if (ret >= size) {
 			size = 0;
 		} else {
 			size -= ret;
