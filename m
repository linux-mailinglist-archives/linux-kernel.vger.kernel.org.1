Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444C1242615
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 09:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHLHbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 03:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHLHbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:31:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0074C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:31:24 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597217482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YofpqSOF/UGO547plTvkbsfR7W3OberlsWlzCgj1gBk=;
        b=rMPiSHAr97tQGqEdZEFIfuwL++cEZjVMpAlI67F2zJpcLn2L9GzEmzOtxmudpfJkZz6JQK
        Fu59vVo1Xyx1ojzcJD/WPQx1LoUrrp84a0/urz1I5t6Us+Nzxqoul8SXE45IVdAprd6vOn
        Wyb3YK6LAUsGPEMp6UYHgBRwTO6lkARnSSAf8EMgtobvoY3fK3jrl1AsDfQcPKQ0pgvtrM
        48Xqy7+mqpGsQzLj8BEqHIi40saNshA0yZw2pd1dKBBQMkfZWxVP5vcCDLAHLpW7uHYbxN
        +/iBCr0jNHPIQWs7To8+AanzEIgimoq4xHm9Scw4+gWQmC0zdlY1SRGRc83omQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597217482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YofpqSOF/UGO547plTvkbsfR7W3OberlsWlzCgj1gBk=;
        b=4mMUjBHd2h5KH4ai8p6dCVmDl0+rmm7gOo8VQTd641JNuA2WBv2dYZWMiw3pXoEP6PodA4
        JMcKWWEevCQ7gLAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH][next] printk: reduce LOG_BUF_SHIFT range for H8300
Date:   Wed, 12 Aug 2020 09:37:22 +0206
Message-Id: <20200812073122.25412-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .bss section for the h8300 is relatively small. A value of
CONFIG_LOG_BUF_SHIFT that is larger than 19 will create a static
printk ringbuffer that is too large. Limit the range appropriately
for the H8300.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 based on next-20200811

 init/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index d6a0b31b13dc..2a5df1cf838c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -682,7 +682,8 @@ config IKHEADERS
 
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
-	range 12 25
+	range 12 25 if !H8300
+	range 12 19 if H8300
 	default 17
 	depends on PRINTK
 	help
-- 
2.20.1

