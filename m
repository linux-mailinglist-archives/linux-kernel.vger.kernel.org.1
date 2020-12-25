Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C68A2E2C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgLYUVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgLYUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:20:59 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E9C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:19 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e7so869597ile.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyJyBMo6E3FidjXCeo8q7aE3vxwKgDtyjurVdC0kQF4=;
        b=aiEd/74X0GF98SxzyJwCiEb+FL8UNcdl1GHsJEG4PB+DiH0e7QxpE14BRTdSSrXNV/
         jkFwPeUI2n6dPPvBTcpniNIDT01ZaiPf6z259h4mWMkhfpjsdmdVsUvueS2QSusvt9I+
         QAzqAliNMV+dPApjL96M/B/YkdHACkIf/0X4ertW+xedHd3obmA69c8z6Y5KYyf6zZpQ
         MDjWRNmoxnJualU7m2P2tg5oEXVOzS/KPhfKhXHQCUQBQDjPhC2w/RmP+qYpQFN5ceBz
         vEWGBqy82Qm0qArMaje2RPR1xGoaX2LiVZiGQDObe4de/l5IPmBu6yynyhZ1Z0xP2T1n
         sWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyJyBMo6E3FidjXCeo8q7aE3vxwKgDtyjurVdC0kQF4=;
        b=TahCEx++VzLZESGb2PTm8aL/7Q40H1qrcAtaabf0Rv9nKPWYnfi1Xz4XDWP9NKpoF0
         M7hGJetR6tiZDoytJ3+Eg671T+P/kXXnvTptfW688towZfmBObFdXpXyPGHUXM4fnLjR
         MSHhbORqLnAn+rjl+5HG4IZj/Sv2F6yz/QnwyzR9l9QVatLNum6oIgR0qmQZ6Vt6/eNE
         aPvFa1bwMz2tjcpqv/HZwteBTXOIbuzUBPdlBto6Np6s1WfVXn6mt6w//R6Gr+fU1w8M
         E21l1OGfOGWePbSNeVk+CxBDWWj6sA4CaGrfH3d0zU64DjIGWdvfFK7b+R1ymtsS64aS
         oc9w==
X-Gm-Message-State: AOAM5330/43ENNY78goWOb+YAGvICX4E0O2DeKvgHIxo8JNI1gN7cCtG
        oEtHbDlxEKQ2PHkl1W2CmFI=
X-Google-Smtp-Source: ABdhPJwzKw2bbNQvODSiRLBm9D0iYkk4MAOS96azAjNCURHXZ+25+aFlHmFH31EdWKh4A6oZtNnI7A==
X-Received: by 2002:a92:d1ce:: with SMTP id u14mr34739665ilg.128.1608927618495;
        Fri, 25 Dec 2020 12:20:18 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:18 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 03/19] dyndbg: refactor part of ddebug_change to ddebug_match_site
Date:   Fri, 25 Dec 2020 13:19:28 -0700
Message-Id: <20201225201944.3701590-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all the site-match logic into a separate function, reindent the
code, and replace the continues with return falses.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 75 ++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fb8e0b288f89..d9a0527ec842 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -139,6 +139,48 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		 query->first_lineno, query->last_lineno);
 }
 
+static int ddebug_match_site(const struct ddebug_query *query,
+			     const struct _ddebug *dp)
+{
+	struct _ddebug_callsite *dc = dp->site;
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
+	/* match against the format */
+	if (query->format) {
+		if (*query->format == '^') {
+			char *p;
+			/* anchored search. match must be at beginning */
+			p = strstr(dp->format, query->format+1);
+			if (p != dp->format)
+				return false;
+		} else if (!strstr(dp->format, query->format))
+			return false;
+	}
+
+	/* match against the line number range */
+	if (query->first_lineno &&
+	    dp->lineno < query->first_lineno)
+		return false;
+	if (query->last_lineno &&
+	    dp->lineno > query->last_lineno)
+		return false;
+
+	return true;
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -167,38 +209,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			struct _ddebug *dp = &dt->ddebugs[i];
 			struct _ddebug_callsite *dc = dp->site;
 
-			/* match against the source filename */
-			if (query->filename &&
-			    !match_wildcard(query->filename, dc->filename) &&
-			    !match_wildcard(query->filename,
-					   kbasename(dc->filename)) &&
-			    !match_wildcard(query->filename,
-					   trim_prefix(dc->filename)))
-				continue;
-
-			/* match against the function */
-			if (query->function &&
-			    !match_wildcard(query->function, dc->function))
-				continue;
-
-			/* match against the format */
-			if (query->format) {
-				if (*query->format == '^') {
-					char *p;
-					/* anchored search. match must be at beginning */
-					p = strstr(dp->format, query->format+1);
-					if (p != dp->format)
-						continue;
-				} else if (!strstr(dp->format, query->format))
-					continue;
-			}
-
-			/* match against the line number range */
-			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
-				continue;
-			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			if (!ddebug_match_site(query, dp))
 				continue;
 
 			nfound++;
-- 
2.29.2

