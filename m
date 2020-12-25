Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848392E2C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgLYUVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgLYUVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:21 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE239C061794
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:20 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id k8so4611549ilr.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jpWWkFpvEtEyrxfJXUVW7ZZ9ZiMofOIXA68fPxSYXwA=;
        b=pZ/srH5a0vurXWW5/H5nrNsFhwQGEa8Eams66rnAXpR6PfChIskdr4x1W+lhz4b1eN
         H67oGQciyz7U7X+RgmVbaA2owuiV8S2jIruZAsreD8KbMFVV/3YMZavWchvVYwz1ihqs
         JvKP6rTtjZI9lp9NR+bD2H1Z23DBe6yPwuWNQd3exgrUZG+tIjTLbl7vrrVczIldYGcJ
         4qxd3duwQ2mGFFC2IAifL87PQVEVFwPD8vyf7uuZ0NpC5V+HGoAwUKPyaOHEYLgz+uNZ
         RS+kkCjeYGE5HIoSmD5GdvhisuvgPoSmsLh6Y1Rnzc+DSTTBmpQ7KizoT4ZwJxy6UV7Z
         i+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jpWWkFpvEtEyrxfJXUVW7ZZ9ZiMofOIXA68fPxSYXwA=;
        b=ayZ2aonU1z8gwKgxRRlGs4kRQiM5RJjFAmhdoOCSpKkF3G7Per7Nd+rh+FRUe/RMEr
         Z54FSkIvoRWRo1yGc8veaL9P04sMl9r12OWBox8TUfapK1Nq83coXwKHgn1TFQ6OB3d0
         Cyxbh6ZHgQyI+FG8Y05VowaQ67it34NjwiI9cKNmimLvUGAQ/fIeTIKqp7XIySeX8KS2
         xPsYufLl94nLFybXtYbHMnBVJCatkCsaVfuSkZ2kkMBIuszPF/oOhbfvrvd+WGoxQbNz
         93t9d2SBtHT6OpDSuD1+35J+Lfn98zodOpTTTlpF1R87AEJv/S72mGmuxAS585BV1FbD
         CmIw==
X-Gm-Message-State: AOAM5318RGrLX3yVjIhCFduZyZ0tG0g1qdY58m1cOqWoIX5nnT7k7nVQ
        RTStxa/qo0iMoQWp/fj+dbM=
X-Google-Smtp-Source: ABdhPJwbzgBodeoCokip1Yuq4YiawOyJoBWjKlqr0f+OWNDd82V+TTFReL/8QQO0kXbvFYZjEiWj8g==
X-Received: by 2002:a92:ce47:: with SMTP id a7mr35289873ilr.261.1608927620138;
        Fri, 25 Dec 2020 12:20:20 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:19 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 05/19] dyndbg: hoist ->site out of ddebug_match_site
Date:   Fri, 25 Dec 2020 13:19:30 -0700
Message-Id: <20201225201944.3701590-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A coming change adds _get/_put abstraction on the site pointer, to
allow managing site info more flexibly.  The get/put pattern is best
done at a single lexical scope, where its more obviously correct, so
hoist the ->site ref out of ddebug_match_site, and pass it in instead.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index bb9279c8cbfd..050c65142d9b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -140,10 +140,9 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static int ddebug_match_site(const struct ddebug_query *query,
-			     const struct _ddebug *dp)
+			     const struct _ddebug *dp,
+			     const struct _ddebug_callsite *dc)
 {
-	struct _ddebug_callsite *dc;
-
 	/* match against the format */
 	if (query->format) {
 		if (*query->format == '^') {
@@ -164,7 +163,6 @@ static int ddebug_match_site(const struct ddebug_query *query,
 	    dp->lineno > query->last_lineno)
 		return false;
 
-	dc = dp->site;
 	if (!dc) {
 		/* site info has been dropped, so query cannot test these fields */
 		if (query->filename || query->function)
@@ -216,9 +214,9 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_callsite *dc;
+			struct _ddebug_callsite *dc = dp->site;
 
-			if (!ddebug_match_site(query, dp))
+			if (!ddebug_match_site(query, dp, dc))
 				continue;
 
 			nfound++;
-- 
2.29.2

