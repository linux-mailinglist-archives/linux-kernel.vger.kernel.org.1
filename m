Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22B22E2C40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgLYUVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbgLYUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:32 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217EBC061798
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:23 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p187so4560791iod.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WlUqGz04/AZhio1pj6TdwhDJTIK2u0wMJ0rAzb4lbew=;
        b=D3Hcyo7k1Hgx/uGyqToyW4/x3VasRvH5WG3qr+noqYX4H4T4EDCy8W+2A/i9nwhPsZ
         RKDfQpRDy14+uR0QWsrahn0DWocEQIhQzAsE2Hwa27gtUV6QSWZdv7AHYssc7YAfmdrd
         /0DVNAEDFE8lpwBAmdL6nQ+Ce5y+hKHSsDyWYmrirE4wLZ44OdSuTwzyO+TEQ6VhP/fz
         uedFxx9BRGxVXoo8dTgS9JZ6Hhxl9fpM8CUd70cu46R3p4YkBx1zk7kTJbDOgl0mY6IJ
         1d5iAcjpR6EOb+8WhQZJRKBGm2+6uUEqB1hTe7LDlulah9X9dtiHqyBrvcWoGk5aUxG1
         0H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WlUqGz04/AZhio1pj6TdwhDJTIK2u0wMJ0rAzb4lbew=;
        b=Tj+mSnK7Iip2REyPlUOFxQLQa+YncFWqM5/PkupbUIKE4DJwJ8aYYJoX/5of0nJkDT
         hVJXc8rGqNgTLKctFv7i1b4RpahcJ4JD3B/Z2aDACIU8Rf5Vqmhf3kLPR81vC2Q2Tk+H
         6nRoNW3zKwn9ljMi9kA2iI5Tu5F+L3AVOHhmK89fLdjRQ59Ix95nuH50+gBpSvx7L+R+
         peGGf7l5taFMrgtdLfxWzkxVCT9Qsjsw7jTO1heGfqEqsypyWiccRKqJtF0g+GvJdokg
         B0KWC9IcHCMrTQ8//TMHdDD8pG5yBKA8i4eKe1xbbVR6P0AfUfbsxtLCf+oHJvQ3hgls
         BL3g==
X-Gm-Message-State: AOAM531+uswrTocr+Bm/N8esJHigHrOtfGni6cf1ovfmCPwzRZo4efEV
        mqALa93p1rx4BcVtStNkAuU=
X-Google-Smtp-Source: ABdhPJyfj+Sw7E/P3qPxDwNo648EaCkvxL5BLiNNT97unbr5K+wkxAdARNnaoWztfcF0SeYOTClX0w==
X-Received: by 2002:a05:6602:314b:: with SMTP id m11mr29302175ioy.165.1608927622496;
        Fri, 25 Dec 2020 12:20:22 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:22 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 08/19] dyndbg: accept null site in ddebug_proc_show
Date:   Fri, 25 Dec 2020 13:19:33 -0700
Message-Id: <20201225201944.3701590-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accept a ddebug record with a null site pointer, and write abbreviated
output for that record that doesn't include site info (but does
include line-number, since that can be used in >control queries).
Also add a 2nd header line with a template for the new output.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 190a796da03a..f6d8137e4a46 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -915,18 +915,27 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m,
-			 "# filename:lineno [module]function flags format\n");
+			 "#: filename:lineno [module]function flags format\n"
+			 "#| [module]:lineno flags format\n"
+			);
 		return 0;
 	}
 
 	dc = dp->site;
-
-	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dc->filename), dp->lineno,
-		   iter->table->mod_name, dc->function,
-		   ddebug_describe_flags(dp->flags, &flags));
-	seq_escape(m, dp->format, "\t\r\n\"");
-	seq_puts(m, "\"\n");
+	if (dc) {
+		seq_printf(m, "%s:%u [%s]%s =%s \"",
+			   trim_prefix(dc->filename), dp->lineno,
+			   iter->table->mod_name, dc->function,
+			   ddebug_describe_flags(dp->flags, &flags));
+		seq_escape(m, dp->format, "\t\r\n\"");
+		seq_puts(m, "\"\n");
+	} else {
+		seq_printf(m, "[%s]:%u =%s \"",
+			   iter->table->mod_name, dp->lineno,
+			   ddebug_describe_flags(dp->flags, &flags));
+		seq_escape(m, dp->format, "\t\r\n\"");
+		seq_puts(m, "\"\n");
+	}
 
 	return 0;
 }
-- 
2.29.2

