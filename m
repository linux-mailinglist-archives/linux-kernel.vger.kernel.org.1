Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E92AF29A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgKKNzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:55:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgKKNzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:55:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605102921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Mv7/+C8DQsc2+Lj38MV+vZrIDUrqcNOBS0Xmhkl+V4=;
        b=aVsPn3EkvgmWClNoA4vZ4uSRx9kALDnn2CMTX6CSXYn7zuY84VENHN9EbGYvGP+pKGZgeG
        K6mEXRBPkBIocTn5qFHc6d3CR74DjfMvJCpzsEzjDYYEZo/RejbrgV02EHaSmF04KajTKP
        qlPWAhdMyYSElGngkxK+8TXSbV6xocs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0905AC83;
        Wed, 11 Nov 2020 13:55:21 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/2] printk/console: Allow to disable console output by using console="" or console=null
Date:   Wed, 11 Nov 2020 14:54:50 +0100
Message-Id: <20201111135450.11214-3-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111135450.11214-1-pmladek@suse.com>
References: <20201111135450.11214-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 48021f98130880dd74 ("printk: handle blank console arguments
passed in.") prevented crash caused by empty console= parameter value.

Unfortunately, this value is widely used on Chromebooks to disable
the console output. The above commit caused performance regression
because the messages were pushed on slow console even though nobody
was watching it.

Use ttynull driver explicitly for console="" and console=null
parameters. It has been created for exactly this purpose.

It causes that preferred_console is set. As a result, ttySX and ttyX
are not used as a fallback. And only ttynull console gets registered by
default.

It still allows to register other consoles either by additional console=
parameters or SPCR. It prevents regression because it worked this way even
before. Also it is a sane semantic. Preventing output on all consoles
should be done another way, for example, by introducing mute_console
parameter.

Link: https://lore.kernel.org/r/20201006025935.GA597@jagdpanzerIV.localdomain
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fe64a49344bf..ac440b879a2c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2189,8 +2189,15 @@ static int __init console_setup(char *str)
 	char *s, *options, *brl_options = NULL;
 	int idx;
 
-	if (str[0] == 0)
+	/*
+	 * console="" or console=null have been suggested as a way to
+	 * disable console output. Use ttynull that has been created
+	 * for exacly this purpose.
+	 */
+	if (str[0] == 0 || strcmp(str, "null") == 0) {
+		__add_preferred_console("ttynull", 0, NULL, NULL, true);
 		return 1;
+	}
 
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
-- 
2.26.2

