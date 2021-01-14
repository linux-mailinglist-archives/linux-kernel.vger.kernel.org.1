Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7B52F5CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbhANJF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbhANJFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:05:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B30C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:05:13 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610615112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IlEKf7Q9GEldunUYi5J37cqclptBkDTukroTPhGZr0E=;
        b=fpoGwrpSxB6KugZjKDgXokLqidoQTau18sbMvJeV3K7FB5TSOS6RSjXadm66vzNVjyVsYP
        SMolvhWdt50D1CpkctVKN8TYI0cTeKfIVF/fMqH7Bi2uHm3EA2ovbkkBcTJQUaqxyYTOI1
        YzVW7+20+9+XbuWDJqCZpz3QpwhR6Sic2U0SYXwgClX7YE0q9Jv0IgETx7x75IPVIS7yD1
        CmXdVLORrTjIoESjh/b5LXSonCMDA64dDdN5ymkWH8WV7fqM8opnxFS0mBAM/JSeUYwAGx
        5ue46m1xM4A03KQoeo5i4hI0yHY069+uLHOYjVX+8djK315F1d0YOfHfa/tEvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610615112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IlEKf7Q9GEldunUYi5J37cqclptBkDTukroTPhGZr0E=;
        b=1m79p3yekei2VoI359ZloAaJuckNwCg9vas4oXT4j/AKrpJw6cHxuRlY2e33MPrAlg0/Ir
        lYmKQf4dC3viOYAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: kmsg_dump: revert msg_print_text() workaround
Date:   Thu, 14 Jan 2021 10:11:11 +0106
Message-Id: <20210114090511.17784-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old msg_print_text() function only filled up to size-1 bytes of
the buffer. A workaround for this quirky behavior was implemented
with commit c9dccacfccc7 ("printk: Do not lose last line in kmsg
buffer dump").

However, with commit 896fbe20b4e2 ("printk: use the lockless
ringbuffer"), msg_print_text() was replaced by record_print_text(),
which will fill the full buffer. Therefore, the workaround is now
incorrectly assuming less data can fit into the buffer. Revert the
workaround.

Fixes: 896fbe20b4e2 ("printk: use the lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 This patch is on top of https://lkml.kernel.org/r/20210113164413.1599-1-john.ogness@linutronix.de
 and possibly could be squashed into that patch. However I recommend
 keeping them separate since they affect kmsg_dump_get_buffer() in
 different ways.

 kernel/printk/printk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 848b56efc9d7..489b9330f7f7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3433,8 +3433,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 
 	/* move first record forward until length fits into the buffer */
 	seq = dumper->cur_seq;
-	while (l >= size && prb_read_valid_info(prb, seq,
-						&info, &line_count)) {
+	while (l > size && prb_read_valid_info(prb, seq, &info, &line_count)) {
 		if (r.info->seq >= dumper->next_seq)
 			break;
 		l -= get_record_print_text_size(&info, line_count, syslog, time);
-- 
2.20.1

