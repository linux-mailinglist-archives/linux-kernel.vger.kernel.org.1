Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE52254AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 01:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGSXLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 19:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgGSXLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:46 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B5C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:46 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id x2so2852108oog.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkgReu4uLlVBlNTDs8QZopFyhdzwcA17+5bR+t3NK9U=;
        b=S7T1ZmNXlmTbPlweRfEWEcPlu9731RP5qVwkLlrBl1zyEJGbahltNezuCtJILGkJ5u
         O0aRMSYetM1hgb1Vr8bsjXXe6oadAk8MvdaDVHzrBfSX2icirA9L8TbEvQPggUL7V9xR
         xNWiMrh7h4gX21Vtz03I8O6D3RHn9j6lnLBeJv6Evs/jYIuuN7m3OgEAGuRiJILKkgQa
         hpZ/Hm/wmSQcZq8LOwx2jLyVO3C7PrbKX+tUABczYR6MX0R6zDgTytWYBSgzZKc+em35
         cFCsxTX7PRIBB65Qeo+joLvRRywnNAEsMOJujaoN5pKpjM5mgMW5l2zRakNf8Do6zvtr
         NVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkgReu4uLlVBlNTDs8QZopFyhdzwcA17+5bR+t3NK9U=;
        b=heXusukq718bREC/2VBDhOZ+JUmY06MwH04M9lpwgVznTffj+EkAs+V6+qLoXyoMSK
         XFtMLpK1A0bD+5jrmUwL/HZEcG0itolfBtsk/+NEZCzU9UtCqzPOrqBYdi2h1HDmvQZZ
         xn8GifXipIuKri7ZKo0TvZHjgpKVh2VlNgvQNvU2nVrN49SLNspDqeQ/QwgQTs2GBP/m
         yCl11M1qxUvbHHy7yDUNBIFkoRRkVDYXIMBlAwm4Tc36RivNLvgqQ6txiyBKWtHLxvAq
         nu6328RfnvuOPnI/JTlHgq1qqoWqR6eAFzzUVjfAqrN7kFy4QFGSUc4DX3NPT6WsPL4o
         18wg==
X-Gm-Message-State: AOAM5302BLe5mEfprjq9+tDoC75pZOpMPyddGWHi+zrIQbshu23MoFiH
        FUt847tfx2PE10fr206ubYA=
X-Google-Smtp-Source: ABdhPJzvUXfu4hCyjNn4Nr5CpbsBpCD11u62sGjUTROnVT+U515H5mmu2cQ3oUaGDrLOEjenKCWKRQ==
X-Received: by 2002:a4a:acc9:: with SMTP id c9mr17706447oon.0.1595200305956;
        Sun, 19 Jul 2020 16:11:45 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 15/18] dyndbg: combine flags & mask into a struct, simplify with it
Date:   Sun, 19 Jul 2020 17:10:55 -0600
Message-Id: <20200719231058.1586423-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flags & mask are used together everywhere, and are passed around
together between multiple functions; they belong together in a struct,
call that struct flag_settings.

Use struct flag_settings to rework 3 functions:
 - ddebug_exec_query - declares query and flag-settings,
   		     calls other 2, passing flags
 - ddebug_parse_flags - fills flag_settings and returns
 - ddebug_change - test all callsites against query,
   		   modify passing sites.

benefits:
 - bit-banging always needs flags & mask, best together.
 - simpler function signatures
 - 1 less parameter, less stack overhead

no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fad6c34c930d..c983049e986d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -62,6 +62,11 @@ struct ddebug_iter {
 	unsigned int idx;
 };
 
+struct flag_settings {
+	unsigned int flags;
+	unsigned int mask;
+};
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -141,7 +146,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			unsigned int flags, unsigned int mask)
+			 struct flag_settings *modifiers)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -190,14 +195,14 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & mask) | flags;
+			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(flags & _DPRINTK_FLAGS_PRINT))
+				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (flags & _DPRINTK_FLAGS_PRINT)
+			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
@@ -431,11 +436,9 @@ static int ddebug_parse_query(char *words[], int nwords,
  * flags fields of matched _ddebug's.  Returns 0 on success
  * or <0 on error.
  */
-static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
-			       unsigned int *maskp)
+static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 {
-	unsigned flags = 0;
-	int op = '=', i;
+	int op, i;
 
 	switch (*str) {
 	case '+':
@@ -452,7 +455,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
 			if (*str == opt_array[i].opt_char) {
-				flags |= opt_array[i].flag;
+				modifiers->flags |= opt_array[i].flag;
 				break;
 			}
 		}
@@ -461,30 +464,30 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			return -EINVAL;
 		}
 	}
-	vpr_info("flags=0x%x\n", flags);
+	vpr_info("flags=0x%x\n", modifiers->flags);
 
-	/* calculate final *flagsp, *maskp according to mask and op */
+	/* calculate final flags, mask based upon op */
 	switch (op) {
 	case '=':
-		*maskp = 0;
-		*flagsp = flags;
+		/* modifiers->flags already set */
+		modifiers->mask = 0;
 		break;
 	case '+':
-		*maskp = ~0U;
-		*flagsp = flags;
+		modifiers->mask = ~0U;
 		break;
 	case '-':
-		*maskp = ~flags;
-		*flagsp = 0;
+		modifiers->mask = ~modifiers->flags;
+		modifiers->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", *flagsp, *maskp);
+	vpr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+
 	return 0;
 }
 
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
-	unsigned int flags = 0, mask = 0;
+	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -496,7 +499,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &flags, &mask)) {
+	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -505,7 +508,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, flags, mask);
+	nfound = ddebug_change(&query, &modifiers);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.26.2

