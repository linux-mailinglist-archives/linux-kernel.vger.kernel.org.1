Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C27273757
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgIVA1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729237AbgIVA1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:27:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA86B23A9C;
        Tue, 22 Sep 2020 00:27:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKW96-001rcd-Nu; Mon, 21 Sep 2020 20:27:00 -0400
Message-ID: <20200922002700.619690196@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 20:26:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hulk Robot <hulkci@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Yan <yanaijie@huawei.com>
Subject: [for-linus][PATCH 8/8] bootconfig: init: make xbc_namebuf static
References: <20200922002620.231334654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>

This eliminates the following sparse warning:

init/main.c:306:6: warning: symbol 'xbc_namebuf' was not declared.
Should it be static?

Link: https://lkml.kernel.org/r/20200915070324.2239473-1-yanaijie@huawei.com

Reported-by: Hulk Robot <hulkci@huawei.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 038128b2a755..e880b4ecb314 100644
--- a/init/main.c
+++ b/init/main.c
@@ -304,7 +304,7 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 #ifdef CONFIG_BOOT_CONFIG
 
-char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
-- 
2.28.0


