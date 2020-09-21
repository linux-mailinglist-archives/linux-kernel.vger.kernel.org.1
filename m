Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDC273262
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgIUTEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgIUTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:04:44 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2C6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:04:44 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id k13so3532975oor.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZaMWZkyD8w8bty+lVoe4etb5iUiplZyQSMlVzME0xz8=;
        b=KskV0v9UTZuxKjXqc4/UbAuDGOEFQvjHrt2gHad4619sJ6hEy6/AVasy83fo+yUTLr
         Vb4P0E1nO73lfv96wxu0eudAtcsEXNAU1J0HtlyOKWvzhBA1poIfvjN3CJWdWb53Lw/7
         Jw+TSmXUqyRSTPnqdDvndx3VYaYwBPtgoqAOw1Bdulr8wQwzVJMReW3bI13qIBxXHfz6
         rHT6cobNqvEfvASZcLrbzRWIz2cRJfU2uRXRDegkjn1mSvjLXlXiGz0aGiCWyi9Przsq
         N02SkG/3m5Rxx2WO5SZ89R705tyYOtW/BgfAS9XhvsyYtRMMLLpLASULhR+IHyFTMB9v
         ztVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZaMWZkyD8w8bty+lVoe4etb5iUiplZyQSMlVzME0xz8=;
        b=nfcxijUWsNrDI7PNqDrFFoxjMtgzIEYN79rU1eXJHBsfxhTxCHAP09S3T3c6ZmHXdH
         GXfoVyTzLwWcvAgTcpjNCtqOjqgXD8iYW+zfduYiWymWaiA+5BsUmFEMIdT41/zGK7My
         mp4Cio6V1emHKDBwetIWpfceY5RJpBQqQRIwR7ekucTTE3gYtUs+1AwYTJTR2zUj1ZrU
         55Dz3YQZkmq+SL6GDVFLG0mI2r96Ib3oP+D7JrNsjTtCra5fZD/Rbhxg0wqo0zXZayb3
         MGpDStTOjaytyPF9iGaHysTOzbMjYS6x2fnbm+OonEbBHMffWIjVSf6cij6W2Xp+Mbj3
         DH0g==
X-Gm-Message-State: AOAM530HKKCQX28OEAW5KMdY3549xHxE+g3FwxAIzcTeXkLJsWDahlCU
        VnJ8jZ4XQoPao7jsNyv6nhE36as/UuhuMA==
X-Google-Smtp-Source: ABdhPJyypDYMNMXL1xYA8OXor0d1etd2LTg7IBsNF/AhDsUQin02opkaJEaq7lWRsbcDrsOqdu0RmA==
X-Received: by 2002:a4a:ad05:: with SMTP id r5mr548487oon.37.1600715083420;
        Mon, 21 Sep 2020 12:04:43 -0700 (PDT)
Received: from frodo.comcast.net ([2601:284:8203:5970::2931])
        by smtp.googlemail.com with ESMTPSA id f1sm7426493ooq.12.2020.09.21.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 12:04:42 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] dyndbg: use keyword, arg varnames for query term pairs
Date:   Mon, 21 Sep 2020 13:04:33 -0600
Message-Id: <20200921190433.1149521-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921190433.1149521-1-jim.cromie@gmail.com>
References: <20200921190433.1149521-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

optimize for clarity by replacing word[i,i+1] refs with temps.
no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 90ddf07ce34fe..23e7dd967b0e6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -387,10 +387,13 @@ static int ddebug_parse_query(char *words[], int nwords,
 		query->module = modname;
 
 	for (i = 0; i < nwords; i += 2) {
-		if (!strcmp(words[i], "func")) {
-			rc = check_set(&query->function, words[i+1], "func");
-		} else if (!strcmp(words[i], "file")) {
-			if (check_set(&query->filename, words[i+1], "file"))
+		char *keyword = words[i];
+		char *arg = words[i+1];
+
+		if (!strcmp(keyword, "func")) {
+			rc = check_set(&query->function, arg, "func");
+		} else if (!strcmp(keyword, "file")) {
+			if (check_set(&query->filename, arg, "file"))
 				return -EINVAL;
 
 			/* tail :$info is function or line-range */
@@ -406,18 +409,18 @@ static int ddebug_parse_query(char *words[], int nwords,
 				if (parse_linerange(query, fline))
 					return -EINVAL;
 			}
-		} else if (!strcmp(words[i], "module")) {
-			rc = check_set(&query->module, words[i+1], "module");
-		} else if (!strcmp(words[i], "format")) {
-			string_unescape_inplace(words[i+1], UNESCAPE_SPACE |
+		} else if (!strcmp(keyword, "module")) {
+			rc = check_set(&query->module, arg, "module");
+		} else if (!strcmp(keyword, "format")) {
+			string_unescape_inplace(arg, UNESCAPE_SPACE |
 							    UNESCAPE_OCTAL |
 							    UNESCAPE_SPECIAL);
-			rc = check_set(&query->format, words[i+1], "format");
-		} else if (!strcmp(words[i], "line")) {
-			if (parse_linerange(query, words[i+1]))
+			rc = check_set(&query->format, arg, "format");
+		} else if (!strcmp(keyword, "line")) {
+			if (parse_linerange(query, arg))
 				return -EINVAL;
 		} else {
-			pr_err("unknown keyword \"%s\"\n", words[i]);
+			pr_err("unknown keyword \"%s\"\n", keyword);
 			return -EINVAL;
 		}
 		if (rc)
-- 
2.26.2

