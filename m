Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936A52E2C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgLYUVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbgLYUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:00 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6760C061786
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:19 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 81so4512396ioc.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vW7/20ptve7EUcFm0eKYUCbL553gEx1dPJx5d8ByB14=;
        b=j0032Mgh+RvEm5RsGGvP1ppJDpZ/zN2RVLaQkW62z4kWf0dTtp4sD5ngcO73Hs9MEH
         GKhtDMixSArYAI3bIefK6JepnTR4NBAPaC2ixTib5uTk0Q2/nrxzYfuZrkiztdo8HJeA
         w7wZp0mpMGkP26rrY/qpFo7CM2mAa119dwoDJ+y/ZPIWewU/EWkVUESivsXimXOCo593
         15QeypBBXCWxMhFZNlPHdmNUE3n+FNIDetFHWaVK6zJaBOoSs9w+Jjg+0Z98e/QdF9wr
         0/Hcd6CADIQR6XAoQsUo8xWl7z56AG8Uk7ovd7ruqhf5+4bc8sy3WhoHyi2Y/SOdXqcb
         NI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vW7/20ptve7EUcFm0eKYUCbL553gEx1dPJx5d8ByB14=;
        b=Y6/lo4GsXOL/gr5Vllc00L3ebnlfJ4td/TvuTBb7qqQCd+EF0GjnDNqxB2jDBuR8Mc
         SVdAz8kJNWhFs6LzCxOFearlJD2Ni2ZlS5ZPD9FZKFoyDtMWAUcHD9BJvS12O4PbnX3x
         8xYGJhROMDLVxv+hobajvCsektOgISh/GSlwHrnyG7DUIzbah9jFbg71yjXq+ggo68SW
         AShgkKNtDLYPCCixRFpnfC4Is+w4pCuWIe84a/J6053NZ/CtRGaH+KCPV4XVvW+dieN7
         2qzdw+1fc/gOEEPZgerFRrs1wKYpRV3gQCkvon5xmXAIEcJGRdm4pab/eN7NDZZpcdus
         YkAQ==
X-Gm-Message-State: AOAM531PhpIZI0y/y/vNlR2oM+MkJ6A5gwPGWctErP+k9mK1eQmFtw1B
        IZYz1imBNGx5KcgY7qh7paM=
X-Google-Smtp-Source: ABdhPJxIwh6NShElJrJ27tggoEk8uKABMWRPCZWHTbszVFfpbLExKnIz42RJwP+rXKfIg3MEbv1gzg==
X-Received: by 2002:a05:6638:296:: with SMTP id c22mr30970012jaq.65.1608927619269;
        Fri, 25 Dec 2020 12:20:19 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:18 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 04/19] dyndbg: accept null site in ddebug_match_site
Date:   Fri, 25 Dec 2020 13:19:29 -0700
Message-Id: <20201225201944.3701590-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make ddebug_match_site() tolerate null site.

1- move format and line-number check code to the top of the function,
   since they don't use/check site info.

2- test site pointer:
   If its null, we return early, skipping 3:
      If the query tests against missing site info, fail the match.
      otherwize site matches.

3- rest of function (checking site vs query) is unchanged.

ddebug_match_site is agnostic re' module, because it's tested already
by the caller, where it is known from debug_tables.  If a query
constrains module, forex: "module drm*", non-matching modules are
skipped entirely in caller, so we can ignore it here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d9a0527ec842..bb9279c8cbfd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -142,21 +142,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 static int ddebug_match_site(const struct ddebug_query *query,
 			     const struct _ddebug *dp)
 {
-	struct _ddebug_callsite *dc = dp->site;
-
-	/* match against the source filename */
-	if (query->filename &&
-	    !match_wildcard(query->filename, dc->filename) &&
-	    !match_wildcard(query->filename,
-			    kbasename(dc->filename)) &&
-	    !match_wildcard(query->filename,
-			    trim_prefix(dc->filename)))
-		return false;
-
-	/* match against the function */
-	if (query->function &&
-	    !match_wildcard(query->function, dc->function))
-		return false;
+	struct _ddebug_callsite *dc;
 
 	/* match against the format */
 	if (query->format) {
@@ -178,6 +164,29 @@ static int ddebug_match_site(const struct ddebug_query *query,
 	    dp->lineno > query->last_lineno)
 		return false;
 
+	dc = dp->site;
+	if (!dc) {
+		/* site info has been dropped, so query cannot test these fields */
+		if (query->filename || query->function)
+			return false;
+		else
+			return true;
+	}
+
+	/* match against the source filename */
+	if (query->filename &&
+	    !match_wildcard(query->filename, dc->filename) &&
+	    !match_wildcard(query->filename,
+			    kbasename(dc->filename)) &&
+	    !match_wildcard(query->filename,
+			    trim_prefix(dc->filename)))
+		return false;
+
+	/* match against the function */
+	if (query->function &&
+	    !match_wildcard(query->function, dc->function))
+		return false;
+
 	return true;
 }
 
@@ -207,7 +216,7 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_callsite *dc = dp->site;
+			struct _ddebug_callsite *dc;
 
 			if (!ddebug_match_site(query, dp))
 				continue;
-- 
2.29.2

