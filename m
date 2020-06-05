Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BEF1EFDC7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgFEQ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgFEQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:43 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3DC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:43 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 69so8072625otv.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYtAZ5QlAGw56NO8DMrkHIfBFpiJejMfNnjHKer63uY=;
        b=CLfmJ9tCvR17+MWtk7zR20Y/CU30NWeoqlwd6yOvhd2GWyap99VU7Z/sooHtK2i+F5
         d4FpIFXdUyeVp0uoEi9aZdYBnc0MdfMjsq9fks2TpcSzm3Brz3zPAMrdYSx6Ftur/be8
         vuUHCF6rAeS0+fGUwFrS0hm9cRxXbb5v1k3iv5lHBOXfeOQWK2sdlTR7gye4rN2JiIvw
         7Fr3yAYgY4lK58G6ykDmlFuZqqshpSVanYirOcp7SJngKJbXSc73aCVkrBUZnWP41jP3
         ezUzEtz/KgT4pqbppz9QccOUC9rZcXScaycEa6G1UqFRqGvz5cDmtJPLtojUZRwAjS+Q
         2MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYtAZ5QlAGw56NO8DMrkHIfBFpiJejMfNnjHKer63uY=;
        b=aJsU6X6CrF/9StLp53UeLFwFXVv39oh17M7HTsOErbGLJZJUa15fkleIQ74r6PysCU
         5BW59FpQmzeEZD4eDyNN2ue9NY4ABiZ1k12648aBlpydEGg4DlbS9FDtUTJ+uxICrv2w
         QPGMo4BN8STWAmmhPIC+sWKQOrnhM70Va+bM8PjobC9s7x460MqH598h21dzM2UyUCdl
         6sveoMWGwOT0TcCGzn/iZBdxpMiNwkPPRqeXRxTYdfiib+7GlCWyBJEdDeJEXWOd1s0Z
         GrhnfEHxOge3rWRn00X43CmBzZNieYaVIiYrOn4hHbjROpfyNS0Wda7UXPoC8TPIsoJc
         EUjg==
X-Gm-Message-State: AOAM5309MiO9zatPktnjzBNsS2uZ43NCHque86YPPWFeExEWoekQ4p/C
        ybCUjR+wkA25nGR8uYhGwj8=
X-Google-Smtp-Source: ABdhPJzN5U/Z4+1jF+93j85cyVdrDeuf+b0VuRbOpyy39SO6KtSU7ilQZm2dgSnZENHzcQ/hjX7xGg==
X-Received: by 2002:a05:6830:54:: with SMTP id d20mr8622649otp.281.1591374462687;
        Fri, 05 Jun 2020 09:27:42 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:42 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 05/16] dyndbg: fix overcounting of ram used by dyndbg
Date:   Fri,  5 Jun 2020 10:26:34 -0600
Message-Id: <20200605162645.289174-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

during dyndbg init, verbose logging prints its ram overhead.  It
counted strlens of struct _ddebug's 4 string members, in all callsite
entries, which would be approximately correct if each had been
mallocd.  But they are pointers into shared .rodata; for example, all
10 kobject callsites have identical filename, module values.

Its best not to count that memory at all, since we cannot know they
were linked in because of CONFIG_DYNAMIC_DEBUG=y, and we want to
report a number that reflects what ram is saved by deconfiguring it.

Also fix wording and size under-reporting of the __dyndbg section.

Heres my overhead, on a virtme-run VM on a fedora-31 laptop:

  dynamic_debug:dynamic_debug_init: 260 modules, 2479 entries \
    and 10400 bytes in ddebug tables, 138824 bytes in __dyndbg section

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e17d4e2661d8..25cc1eb86d96 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1017,7 +1017,6 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
-	int verbose_bytes = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
@@ -1028,9 +1027,6 @@ static int __init dynamic_debug_init(void)
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
-
 		if (strcmp(modname, iter->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
@@ -1047,9 +1043,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
+		 (int)(entries * sizeof(struct _ddebug)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.26.2

