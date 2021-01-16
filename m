Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A2B2F8FA2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 23:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbhAPWLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 17:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbhAPWKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 17:10:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5510722D75;
        Sat, 16 Jan 2021 22:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610835005;
        bh=5jSZTdncwbDwBj7VAjrWMlgjCqKLR7rKVzIK8UcQiJY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QxfFEF+8wT0tnA3OgQi2RxH/KnSjVQhL2LIIIPWMc4inF8qsj0I5dlG1hTgt7ShRn
         coizL8dTtGmZAgSUSXEXJ16Xw6AKr+LzxsnArykwRWliL8/DSyWhX5OxBLP6aL4/d7
         gatwb/MKcRBPBtm0VlT0pHVjBM1O2hzGQhH+o0foCG2sDN8GSJB/fPz1inDuH2Z4wY
         mtUXVmatPgYay5AyO02HyaXZjNmw7n5vw1EdVY0QGDb+spHzvb7+AR1usBl6guIac6
         RxIZWtIBHwnUgA/ZHdETFNV6PAKJwd4C+nXZ6vaxeH5hNAug53E/Xd7X9li7eSEAMj
         lhNxQqiuN6dUA==
From:   Timur Tabi <timur@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 2/2] mm/page_poison: use unhashed address in hexdump for check_poison_mem()
Date:   Sat, 16 Jan 2021 16:09:50 -0600
Message-Id: <20210116220950.47078-3-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210116220950.47078-1-timur@kernel.org>
References: <20210116220950.47078-1-timur@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that print_hex_dump() is capable of printing unhashed addresses,
use that feature in the code that reports memory errors.  Hashed
addresses don't tell you where the corrupted page actually is.

Signed-off-by: Timur Tabi <timur@kernel.org>
---
 mm/page_poison.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index 65cdf844c8ad..4902f3261ee4 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -67,7 +67,7 @@ static void check_poison_mem(unsigned char *mem, size_t bytes)
 	else
 		pr_err("pagealloc: memory corruption\n");
 
-	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1, start,
+	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_UNHASHED, 16, 1, start,
 			end - start + 1, 1);
 	dump_stack();
 }
-- 
2.25.1

