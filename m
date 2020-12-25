Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6BD2E2C41
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgLYUVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 15:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgLYUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 15:21:32 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B647C061796
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:22 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e7so869686ile.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 12:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZyXyy5ebcIqXYTvry0IPKskaZfn8cGguZp5SpDDXoRM=;
        b=RxjNCEf8KMhY0iDflNU3dkynyyBVPZQpEYdMEJLfmiyFD45vviqJbJyY7maAIdU7hv
         F8ZRmKfnyCQPckWvIcIhgvKcbkpB5+W5bXChHIQXzoudNYPhsfD3JRQUEZXyNCuGUcBE
         N/3X9f4yZPrrjVIIa/jDGpCk93AO57UX6594eBpBU6kjSNa4itHl2HuZC+dZlZndbKcK
         LvEGOMTnZHcDxNYO+5xz9MVge4G8w1yoFbg5gbLPih10wMmz1jsQK+WaQ816i8+dU0JE
         VRyDCfFHbbmGnz2QujZCFrLZRru4sqb9u0Gm99AIPYPdgF/QhGOzTMBXoPVZyVn0wQOk
         i8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZyXyy5ebcIqXYTvry0IPKskaZfn8cGguZp5SpDDXoRM=;
        b=n4I4YYqAXxfo1o1X9eY17qnT9KpCUXVBFunWy1bSRaU4dzJRk+NdQSSs5fxQQd6kL+
         AE9q97sUg5s/PQs5yWHNiO7I38abo+wkVMBe6rrHmp8bOx5DE60LDJL90ndUVnLA816l
         3yi7mOXcbpccoZKpRZuB+n4H6CfE8sbYerCDzgk22LB0cX9EB6W6Q+64IXWB/4D6edaj
         Oq4mJ4fogHf9Jt7jqpMQaF5t2x/i8hTVCkkO07HrJg3GD80PSGgxXUO0bw7jyArQCmYs
         Spov66nY4qJIIhWybK7XRq5oT0NxF+s5qA38dt9EOPorNJg34BBRx36oruWjt8VpU0Sw
         O95A==
X-Gm-Message-State: AOAM532zi1tvb02fMef2pHUdQA87gOCdmXQwFRR9qJx9am/MEs/ZHVkt
        HmYql1+lCUa0GZZtgCvzQ5c=
X-Google-Smtp-Source: ABdhPJyv2/jcmxICmY3MYCrf77HIZoeWn2XQVVhakGEyup0HpGoYqsZ06r4IDfWvzAme/O1KbY34Pw==
X-Received: by 2002:a92:de09:: with SMTP id x9mr34147963ilm.257.1608927621788;
        Fri, 25 Dec 2020 12:20:21 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e1sm28380401iod.17.2020.12.25.12.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 12:20:21 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v2 07/19] dyndbg: accept null site in dynamic_emit_prefix
Date:   Fri, 25 Dec 2020 13:19:32 -0700
Message-Id: <20201225201944.3701590-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 prints use site->member, protect them with if site.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5422cef58130..190a796da03a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -628,15 +628,19 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
-		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->modname);
-	if (dp->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
-		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->function);
+
+	if (desc) {
+		if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+			pos += snprintf(buf + pos, remaining(pos), "%s:",
+					desc->modname);
+		if (dp->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+			pos += snprintf(buf + pos, remaining(pos), "%s:",
+					desc->function);
+	}
 	if (dp->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				dp->lineno);
+
 	if (pos - pos_after_tid)
 		pos += snprintf(buf + pos, remaining(pos), " ");
 	if (pos >= PREFIX_SIZE)
-- 
2.29.2

