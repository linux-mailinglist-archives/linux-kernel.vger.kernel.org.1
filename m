Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D17C2E2C43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgLYUVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgLYUVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:37 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36770C0617A0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:29 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id v3so4610174ilo.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MO7/t3dlktGOY+JeG9dff+wym9XTwOfko8AazjcITNY=;
        b=tBD8FN1fDZbNc+c2lffI3gp7oZ5RR018wR7ZJucnxVAqK/AKOYF9CJBoPBQ3gIBlZ/
         xtpZdBAIA6JvwOGDYy4piKzn+q6Jf3GfKEmzk+mjMbSfc9rr1TR6owN42cx0DsEXniln
         RaEKUCmFLfSJ6nnRTbwXl8jHZmp6mZYUUYeLCEtOAhr0Zfklptm215kdEuiJwP/7f/+p
         aoFbzkbyUeNHkf1Tub3/IjFr5LlP1RtrmMNO8h13fqUiZ9x/QezQIYQGE+fa9abvcX8R
         CGNqVJNlQ8uDiidbAiep62ai+EIHC0fJTT2yLyeAWfegGi9qNjurxwz0RB/pZuhCDbHa
         Q23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MO7/t3dlktGOY+JeG9dff+wym9XTwOfko8AazjcITNY=;
        b=ozNLsUWH4G2sutoriHXgqRrqi4zEovwmmCJH9YRzcy7075zSEU/fsgU9fdo5IUSdST
         DqLGlr7znC6LIaOLAEBc0xAy/AHaYYk0Z2Yb3+OoEgHNSZfjz56B7rrLRUgu7x965q8E
         gYpj5WRaCU9lzPfyYa4kbl6wYPT3Vd3kiATH1TuCohUG1Nz9dERFCcegyrmsALv9Hdpf
         b+3MvYMXJ7m+kW+Ee/vuIf2i5ocgOkiemlr+Y4WllxfkCCESVWkzqsORjIxBCBBxv6Fa
         ZRsJVbaVxfDUbyrpYt1YbWZhogevh7kMF5rnYgtsNtbf9CtTWA3d+f9/i/GKiL6shcsA
         3c8g==
X-Gm-Message-State: AOAM5306uvKsmt4bW6BkmLtgUNG/qk+25CpJnHJTJajzS4CsL0ou2SYQ
        Ljlrs5a0JrRv/rPFsiqVKJI=
X-Google-Smtp-Source: ABdhPJz3RSDtunumTuTjJQ3VVIAKozlqJZlHlLp1/qwnLWyimJusow0Yf4uyid0MBdm+JQcwA5xKrw==
X-Received: by 2002:a92:d8c4:: with SMTP id l4mr33510187ilo.38.1608927628623;
        Fri, 25 Dec 2020 12:20:28 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:28 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 15/19] dyndbg: add ddebug_site_get/put api with pass-thru impl
Date:   Fri, 25 Dec 2020 13:19:40 -0700
Message-Id: <20201225201944.3701590-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that site info is optional, abstract it so we can manage it more
flexibly later.  Change all site users to use ddebug_site_get(p)
instead, which just returns ->site.  ddebug_site_put is called to
balance gets, it currently does nothing.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8ad9be28f38e..25f49515c235 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -144,6 +144,14 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		 query->first_lineno, query->last_lineno);
 }
 
+static struct _ddebug_callsite *ddebug_site_get(struct _ddebug *dp)
+{
+	return dp->site;
+}
+static inline void ddebug_site_put(struct _ddebug *dp)
+{
+}
+
 static int ddebug_match_site(const struct ddebug_query *query,
 			     const struct _ddebug *dp,
 			     const struct _ddebug_callsite *dc)
@@ -242,13 +250,13 @@ static int ddebug_change(const struct ddebug_query *query,
 			struct _ddebug_callsite *dc = dp->site;
 
 			if (!ddebug_match_site(query, dp, dc))
-				continue;
+				goto skipsite;
 
 			nfound++;
 
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
-				continue;
+				goto skipsite;
 
 			ddebug_alter_site(dp, modifiers);
 
@@ -264,6 +272,9 @@ static int ddebug_change(const struct ddebug_query *query,
 					  dt->mod_name, dp->lineno,
 					  ddebug_describe_flags(dp->flags, &fbuf),
 					  dp->format);
+
+		skipsite:
+			ddebug_site_put(dp);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -633,11 +644,11 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
+static char *__dynamic_emit_prefix(struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
-	const struct _ddebug_callsite *desc = dp->site;
+	const struct _ddebug_callsite *desc;
 
 	*buf = '\0';
 
@@ -653,6 +664,7 @@ static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	if (!(dp->flags & _DPRINTK_FLAGS_INCL_ANYSITE))
 		return buf;
 
+	desc = ddebug_site_get(dp);
 	if (desc) {
 		if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 			pos += snprintf(buf + pos, remaining(pos), "%s:",
@@ -670,6 +682,8 @@ static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	if (pos >= PREFIX_SIZE)
 		buf[PREFIX_SIZE - 1] = '\0';
 
+	ddebug_site_put(dp);
+
 	return buf;
 }
 
@@ -952,7 +966,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
-	dc = dp->site;
+	dc = ddebug_site_get(dp);
+
 	if (dc) {
 		seq_printf(m, "%s:%u [%s]%s =%s \"",
 			   trim_prefix(dc->filename), dp->lineno,
@@ -968,6 +983,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		seq_puts(m, "\"\n");
 	}
 
+	ddebug_site_put(dp);
+
 	return 0;
 }
 
-- 
2.29.2

