Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E766269CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgIOD66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgIOD6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:58:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A03AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:58:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 207so2041177ybd.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SFW2h14ECMMfzbUIsG9wID+6ZK02/eLwTYcr5ku/IMk=;
        b=ABVIJhX806jGHQsihIKzkFUUo5qTWDAPwGoVM4EELEx7GxuYd9/3DVkQH0tB+L9/58
         4zUPnndURQxy5TGqlNP8bCSPy0LsWjFlRt06sxcYwvDCf47PjmOp7vEMX74F+Ihl30tM
         Kglcdp5Dz9PhiYi9XZ6YntSvBSF3+djugiHJFHsET1N1FR/HTkBEuJ9MJXivTRCxfr0W
         ELbTvZb8m6xq5PFCQ8k9H4S2NPLSOmLsAtYRyyWNgNfyOYRpjRLd39Th1zgcpHY980Gy
         zzO6XT3FDxKyiz3gkav411niylSDBCCJH/TUS3YLOyoU5Ey/jyEICehafq7SH/a8ElW6
         298Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SFW2h14ECMMfzbUIsG9wID+6ZK02/eLwTYcr5ku/IMk=;
        b=q1BxNkFeKWGfeJ0QXQiXdJz1XQWIKrSqGpE7g0m+taeYOBE3DmZZLKpCEUPR+jXdmu
         3WuQTTxmx8T0Ok62mDCK9+NyKzcPQXHCslbxKwIRz1QmxvO76Z+UvgxmwrdG3rWtPM+u
         p60PddAPbQT4MKP2zB5TE/em6zbPl/DBXbnkR8TEKFlbtsoJGIT9KOpbhoKb5dhg+3jJ
         qwBCgq/goFr58rtnpPaJ/SI7jPB40fvMHYpxRghAUSu58xJedX6IZ4nrc8xyyl1TG3F4
         +ddmhsetFqguASr6YVUdzU8GWHZp2B3vxHHB1f78thKKHlS3JhVdw255RQ1o58G+JoPP
         xVdQ==
X-Gm-Message-State: AOAM532c3IDTDN48c5C4y+LJPE+LFZhGhTB7Hxwo7ZhkM1Yv1qTPhfz5
        s/iLsKjUw+0C69RgLUwiwxwGCLXIVw8y3A==
X-Google-Smtp-Source: ABdhPJwUTN/q5oIZgo9BR3mgcGZqMpJPurbhBbHip39SJ5emScGzGYX2IC7yh46SEHu0YQRihBfnbKwONFvC+A==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:be13:: with SMTP id
 h19mr27646628ybk.50.1600142319270; Mon, 14 Sep 2020 20:58:39 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:58:24 -0700
In-Reply-To: <20200915035828.570483-1-davidgow@google.com>
Message-Id: <20200915035828.570483-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200915035828.570483-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v14 1/5] Add KUnit Struct to Current Task
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

In order to integrate debugging tools like KASAN into the KUnit
framework, add KUnit struct to the current task to keep track of the
current KUnit test.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935..9df9416c5a40 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1203,6 +1203,10 @@ struct task_struct {
 #endif
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.28.0.618.gf4bc123cb7-goog

