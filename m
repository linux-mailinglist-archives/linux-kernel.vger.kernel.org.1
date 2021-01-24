Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A4A301EBC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 21:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbhAXU2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 15:28:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbhAXU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 15:28:11 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611520049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7EolLNJ81oKX0Hu1psCaLPJ70xwpXFEr+Tx05n3Sagc=;
        b=V2wa8pzz7CUNisTIOgYQ+sEw2PdqCByY5Zi8yg4Qu8hxWz++sJ0qlv5OtZ+7VrjkxWwM/k
        iWwvuu4mH2wWnHBV2TpUbfYKWYVWIOafTut1Kns0zQCaLUfVx35pn9U/Zl1KcIcltHVgpy
        6cgq+z7dGOeRr6iI8wfIdAK8j8RVc28i1NracpTIL1F0Puu1NpSioX1+CNrKbfeekIlHZr
        6+qvEwJ9dPMM64HhZOBvT2QDB2ffTCPGj9rcakz/NqnksstDwbGMLfGXRVyblbUKiltAgb
        ydY6uzi3GWlFDDdNBNLelP0Fbo05BBDwqrMdmoU1OhyPbAab8qnw54mpoHSRiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611520049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7EolLNJ81oKX0Hu1psCaLPJ70xwpXFEr+Tx05n3Sagc=;
        b=gKIpoKT2PIshlLY07/L27Dg87nLYveyrLGJj8242qjtXFGRl1D1oCcs0h7AOziheTLD90t
        g3VM2Bs1J18IVZBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: fix string termination for record_print_text()
Date:   Sun, 24 Jan 2021 21:33:28 +0106
Message-Id: <20210124202728.4718-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f0e386ee0c0b ("printk: fix buffer overflow potential for
print_text()") added string termination in record_print_text().
However it used the wrong base pointer for adding the terminator.
This led to a 0-byte being written somewhere beyond the buffer.

Use the correct base pointer when adding the terminator.

Fixes: f0e386ee0c0b ("printk: fix buffer overflow potential for print_text()")
Reported-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6639a0cfe0ac..5a95c688621f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1398,7 +1398,7 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
 	 * not counted in the return value.
 	 */
 	if (buf_size > 0)
-		text[len] = 0;
+		r->text_buf[len] = 0;
 
 	return len;
 }
-- 
2.20.1

