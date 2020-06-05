Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EEB1EFDC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgFEQ1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 12:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgFEQ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:45 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7515CC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:45 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u23so8049244otq.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JeaZBXJYtncPxzUzQInqJnGmrXVU2TzSAlaFgBRQfY=;
        b=QtnU4K9R0fquLypDJOMOYdsWqfMXsxuKy4gkifGn8jTZ6/3SfxDTXnPiQhkYRmQzkx
         nifpi5W5YbUx9KS90GziWc83hCTEm7Hvz0kSekYh+x6kYGcysKMa2rgNEqlJcguPnND+
         /Wd3LwWqHyTSji16qmbUJxKK5UxP3Mi8YVCtgbayZkKK6mDbQyvYa+EPDTJXsQwGxF4b
         ixef2xGBzXZoKnEacUAGalagzX9Jizb7AdKCcHUoueTuTM/Qgrk+yIWt7Wd9rZXiQK9q
         +9GIgnRLFQhekCjaFiYxINYYdRrCSKy+D/CMzv6MbqHOE8Nk0NJkq0tat58rg/p0pDv9
         3qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JeaZBXJYtncPxzUzQInqJnGmrXVU2TzSAlaFgBRQfY=;
        b=imzWZyb1nXnPcizuWt9iYHStkzWFGnP4pSEZ2zSkXlVHO456lshUDtqFfimSAvI5tF
         bwx+I3CldrCdVHZLxt3ztXGszz6Y594oN38ED9Y0L+QGCVIoIZmo4BL51g846MHvSGUV
         yQMvyNPERCVK/1N1vM2TYqsoDBPhwVp5aqcijQn3Seqqt/cb5cuYQ03jK+geHcZh8X7u
         rRrACsDYqw1WBhRWm+8mAtkJi1HoPea+E7ZepeQvEcHgUONcUulf5ZGCVSywrQ06eWcU
         9dFrnfWZ0sWW9CPs3gibhVOa/y41eMxBSdJcrATRW3BawTwBossG77Dc3++ihl0H95oQ
         hRng==
X-Gm-Message-State: AOAM5325BE3P3C0N5C/vA5rXRIYPEuQvSG8n028amR51o5GOtRqMfwV8
        sLSzgxNLHvfavOlDjF1TsIg=
X-Google-Smtp-Source: ABdhPJw3cCW/R7/1J8zt1o9Jk265PiZTXem7esHe/ZeqzU0L4JqCmXzlt9XVMgxn2nhUUIKan6NWdA==
X-Received: by 2002:a9d:640a:: with SMTP id h10mr8561124otl.323.1591374464809;
        Fri, 05 Jun 2020 09:27:44 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:44 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 06/16] dyndbg: fix a BUG_ON in ddebug_describe_flags
Date:   Fri,  5 Jun 2020 10:26:35 -0600
Message-Id: <20200605162645.289174-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddebug_describe_flags currently fills a caller provided string buffer,
after testing its size (also passed) in a BUG_ON.  Fix this by
replacing them with a known-big-enough string buffer wrapped in a
struct, and passing that instead.

Also simplify the flags parameter, and instead de-ref the flags struct
in the caller; this makes the function reusable (soon) where flags are
unpacked.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 25cc1eb86d96..08b8c9c04a17 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -87,22 +87,22 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_NONE, '_' },
 };
 
+struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
+
 /* format a string into buf[] which describes the _ddebug's flags */
-static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
-				    size_t maxlen)
+static char *ddebug_describe_flags(unsigned int flags, struct flagsbuf *fb)
 {
-	char *p = buf;
+	char *p = fb->buf;
 	int i;
 
-	BUG_ON(maxlen < 6);
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
-		if (dp->flags & opt_array[i].flag)
+		if (flags & opt_array[i].flag)
 			*p++ = opt_array[i].opt_char;
-	if (p == buf)
+	if (p == fb->buf)
 		*p++ = '_';
 	*p = '\0';
 
-	return buf;
+	return fb->buf;
 }
 
 #define vnpr_info(lvl, fmt, ...)				\
@@ -141,13 +141,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			unsigned int flags, unsigned int mask)
+			unsigned int pflags, unsigned int mask)
 {
 	int i;
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	char flagbuf[10];
+	struct flagsbuf flags;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -190,22 +190,21 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & mask) | flags;
+			newflags = (dp->flags & mask) | pflags;
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(flags & _DPRINTK_FLAGS_PRINT))
+				if (!(pflags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (flags & _DPRINTK_FLAGS_PRINT)
+			} else if (pflags & _DPRINTK_FLAGS_PRINT)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
 			v2pr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp, flagbuf,
-						       sizeof(flagbuf)));
+				 ddebug_describe_flags(dp->flags, &flags));
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -814,7 +813,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	char flagsbuf[10];
+	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
@@ -825,7 +824,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(dp, flagsbuf, sizeof(flagsbuf)));
+		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
-- 
2.26.2

