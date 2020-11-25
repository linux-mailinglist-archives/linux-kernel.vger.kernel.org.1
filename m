Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB622C4889
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgKYThf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgKYThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:37:31 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF2FC061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:21 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id m9so3252534iox.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGMS/KmYTKfdKa5mao6KQL50Vv4NG7QbaRbgc4LfYSo=;
        b=Xf+OemJsMg096pz+jboLsU3wkp8YxQwP58ep5om6NXA3u5h6j2Mp6Beln4U+QUxA/v
         TKUyjf5VCvuteIL3AANR763snEt48Ae3fki1RkgFeTTKEPJcBb2szvsPZXFlMcAiaXBy
         a29jJ4NhD+MrtOAP0KdYtx+0dWQJ1E0RV7yDz5rAU1Q0XfDZv05E05v0GukflvK9L8mn
         tNb3nwUkKaJvtpD1dPBSIK4n5iguCP+fyGAwgqwn7YFqx3DZiZ61TeUI/+u6J7U8J/ii
         dO/Lv0FKHY8Dty7q43ktHv2n4aXQL8S2+eXvC2WdHPjYTwzXcgaT9+bVNmaubDZh7HH6
         rkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGMS/KmYTKfdKa5mao6KQL50Vv4NG7QbaRbgc4LfYSo=;
        b=DLoBbzCNsVoHWB8KFimIsrbRU2P5ydiXk+aagpUnclbr+oDDwCYHUk4Zy1vPSOMGJb
         bUUrnFC36Bh/8xVXrkrTepFjR7om4STPnUoROYGWsz5x//YT+OuswtrMi5c+MQfcIeuW
         LeBuTtslDAOChKn6U41AMPnyIRS68EQbWxNpKKK8xWgXRj3kNP9iEhhUfEdPjaHvEN+z
         sVmkTki7Su0nC+a98vEuIXbvOf8GxFyU9iupYeTZLEjPR+s+uiNmRqhorvw0mW+otYZT
         4uDGfMFpMeD89HDdkWYtSiGRaeFHkge7HBGxLbtT2KLrbND+AC3UiEE4wt8F6ojNaqpP
         gahA==
X-Gm-Message-State: AOAM531iqnMl5gM0qSv6TLsupC5uR3RIgHiSic80txEgRaphRlGF3DFX
        +xnrUpzuniMKYibqZv5TRec=
X-Google-Smtp-Source: ABdhPJxkqvqKjeWkSVtPjU2cJU82WEDRmYodw7vEJZXpubZ16DbnWzShqB9wm/1daFMLICozbhkP4A==
X-Received: by 2002:a6b:c3c5:: with SMTP id t188mr3929469iof.209.1606333040740;
        Wed, 25 Nov 2020 11:37:20 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id f8sm1435548ioc.24.2020.11.25.11.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:37:20 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-mm@kvack.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dyndbg: count repetition in __dyndbg_callsite fields.
Date:   Wed, 25 Nov 2020 12:36:21 -0700
Message-Id: <20201125193626.2266995-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201125193626.2266995-1-jim.cromie@gmail.com>
References: <20201125193626.2266995-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __dyndbg_callsite section is basically a flat db-table, an array
of struct _ddebug_callsite[]s.  Its data is inherently hierarchical
and sorted, so a field-wise run-length encoding would compress well.

Add counters and code to test 3 fields of consecutive callsites for
repeated values.  The results inform a compression estimate.

 dyndbg: 2605 entries. repeated entries: 2369 module 2231 file 1147 func

Thats (91%, 86%, 44%) repeated values in those pointers/columns, on my
i7 laptop build.  With a zero-overhead markup, like LSB-stealing, we
could mark the differing tails of consecutive records, and get 11/24
compression on init/main pr_debugs.

For a slightly apples-to-oranges comparison (text vs pointers),
`gzip /proc/dynamic_debug/control` achieves 6/1 compression.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2e4a39c349a5..5980d44ff2f8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1081,11 +1081,12 @@ static int __init dynamic_debug_init_control(void)
 
 static int __init dynamic_debug_init(void)
 {
-	struct _ddebug *iter, *iter_start;
+	struct _ddebug *iter, *iter_start, *prev = NULL;
 	const char *modname = NULL;
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
+	int modreps = 0, funcreps = 0, filereps = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1099,7 +1100,16 @@ static int __init dynamic_debug_init(void)
 	iter = __start___dyndbg;
 	modname = iter->site->modname;
 	iter_start = iter;
-	for (; iter < __stop___dyndbg; iter++) {
+	for (prev = iter; iter < __stop___dyndbg; iter++) {
+		if (entries) {
+			if (prev->site->modname == iter->site->modname)
+				modreps++;
+			if (prev->site->function == iter->site->function)
+				funcreps++;
+			if (prev->site->filename == iter->site->filename)
+				filereps++;
+			prev++; /* one behind iter */
+		}
 		entries++;
 		if (strcmp(modname, iter->site->modname)) {
 			modct++;
@@ -1122,6 +1132,9 @@ static int __init dynamic_debug_init(void)
 		 (int)(entries * sizeof(struct _ddebug)),
 		 (int)(entries * sizeof(struct _ddebug_callsite)));
 
+	vpr_info("%d entries. repeated entries: %d module %d file %d func\n",
+		 entries, modreps, filereps, funcreps);
+
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
 		pr_warn("ddebug_query param name is deprecated, change it to dyndbg\n");
-- 
2.28.0

