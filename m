Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40AA2F4D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAMOnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbhAMOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:43:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA38BC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:42:37 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610548955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fj88E4Kjvnw1x0rsUVu+x2lWiR9tSl/7uxT/V662qo4=;
        b=K+Xv8OqlRYo4Q2mZsyqj+5hu8XbTXzuvf+Fr5hbDMutjzXp6d4a7ARjN5hwicTieQbkO6B
        3rufam2vXqqNF1LNryPP+0LkFKPEASyo06iBf3zPKiWVFDSc1FNrzaVcDqfV9mXNBtKFtl
        nCqEg70a+Z64mxhB0fBmyfKB4BjIdFl2jM5/DnBeyPDmhwAserDa1dnY5Qz3jfSC5VNzNA
        p4vURXK2R5ez8eria5wOsi3tJAfSL4mibcVKz+/bp9IjcuGIHEgtsUJ9EsDEudliQZrbKH
        Vow27uwIlf+eMCZXq9mZdhuBWAazJ4++dbFpUNIP9ygapuCrnokjBxcRyzQ3IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610548955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fj88E4Kjvnw1x0rsUVu+x2lWiR9tSl/7uxT/V662qo4=;
        b=nctvjqMXS6fCaacHeyEXLuBR/gWwknxfDYtFYByO+es3VXTPwS5/VeRgDSp/cEuVnXMnh2
        75YATH7omjc56TDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: ringbuffer: fix line counting
Date:   Wed, 13 Jan 2021 15:48:34 +0106
Message-Id: <20210113144234.6545-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counting text lines in a record simply involves counting the number
of newline characters (+1). However, it is searching the full data
block for newline characters, even though the text data can be (and
often is) a subset of that area. Since the extra area in the data
block was never initialized, the result is that extra newlines may
be seen and counted.

Restrict newline searching to the text data length.

Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 6704f06e0417..8a7b7362c0dd 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1718,7 +1718,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
 
 	/* Caller interested in the line count? */
 	if (line_count)
-		*line_count = count_lines(data, data_size);
+		*line_count = count_lines(data, len);
 
 	/* Caller interested in the data content? */
 	if (!buf || !buf_size)
-- 
2.20.1

