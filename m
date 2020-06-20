Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF32025DA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 20:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgFTSIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 14:08:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36162 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgFTSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id 97so9857181otg.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4vaC8jH1uAkf0e4xv8Z3CqlZMc6lIX3fCOrUzVEUYI=;
        b=IvSvx8RLqAx668hJIDPc8odfM/hnmNbKvEg4vxvsH0aQH/mCj+9tAiQan9bK5L3//l
         w4/uVq2WL416UCXXZVyRPz0bI73J9kXCDsDbZRhnY3ARcl+Cff62FigzeL8959Ud8XZz
         868OZ40leILgpVS20QUuu1v88UFNq0yyJRq3T9xitJvRCxvhU6yJYjf+47HZ/zW+9TTN
         uvH3IhVokW28ZOynLUAlpKt5e7jZiU0md2dOWQoF0yXdsHQEXGc7VfotBxRyC6kLd7gT
         VEKNY8WJwzw9M/NCcoIQHU3928ak736GZJdB5P5ax9eh39BWzdw2xx8QxEjGybwM/d4a
         T1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4vaC8jH1uAkf0e4xv8Z3CqlZMc6lIX3fCOrUzVEUYI=;
        b=sHjLvH4c/nmxFKYaHcxfzXUf31LhPfRKYEaDQ+PLDlpnsPcR1mlmPnQUbomaJCRpv+
         PLoJ23WuEV2m4ndfdpExQfXG76c0EYH/c4djw9r3MKma3z6l0vIKejGqPea3xES4kjkd
         oIi+FcxTPJ75/KDuni4YNbcSYgv8CuklZLQ02JcjUZrXxMx+7M3iExLorm9/MpHQgPAP
         Dk3vBaRUFMbfWcB2tM2PicDmtRhr8sVZ1U3V1rUAJ9yV4py8GproQYTOf3kd+7LA+CPF
         2N8C6X79t/yxMKXazWPUAO1G8ReXeV5llxmznLe5i1t1cSwByfQC36J6gNWNEOCCd7+z
         o0aw==
X-Gm-Message-State: AOAM530srqdHqNukZpQe8ggWCdoGWUE/8t3M/VZ3qixg4n1uTR+I3JO4
        7/kYC2A5dQrRGmea2O6eHAk=
X-Google-Smtp-Source: ABdhPJwXa4SRPsu8WuqsKuNDROSAFRI182kur6a+1PIAN7S0g3GBqJUpLFAwmq85ZV/IAgLLzOHz9A==
X-Received: by 2002:a9d:39b6:: with SMTP id y51mr7201139otb.175.1592676429268;
        Sat, 20 Jun 2020 11:07:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:08 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 07/17] dyndbg: fix a BUG_ON in ddebug_describe_flags
Date:   Sat, 20 Jun 2020 12:06:33 -0600
Message-Id: <20200620180643.887546-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ddebug_describe_flags() currently fills a caller provided string buffer,
after testing its size (also passed) in a BUG_ON.  Fix this by
replacing them with a known-big-enough string buffer wrapped in a
struct, and passing that instead.

Also simplify ddebug_describe_flags() flags parameter from a struct to
a member in that struct, and hoist the member deref up to the caller.
This makes the function reusable (soon) where flags are unpacked.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9b2445507988..0cb5679f6c54 100644
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
@@ -147,7 +147,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	char flagbuf[10];
+	struct flagsbuf fbuf;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -204,8 +204,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			v2pr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp, flagbuf,
-						       sizeof(flagbuf)));
+				 ddebug_describe_flags(dp->flags, &fbuf));
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

