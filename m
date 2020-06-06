Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B7E1F0494
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 06:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgFFEEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 00:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFFED6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 00:03:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DF5C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 21:03:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e20so14113432ybc.23
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 21:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=og6aLJN4ELJf8ujcyhVHLwiOkETXN2fux8N+5uOmros=;
        b=Yw2TjbZfqO7BR8Z+rdQauW0blSDY61NfK6iq+vipx19CT8oOy3nxvfW0lXAlzm5j7I
         4F5eZVvaQDY+lFonPbBEAESzserEOWIFcD2LpZzu2Azo3gMlcFpj2kYOg9b/P252oKhz
         D0C4/GIgHjTo9o7xtCmqggR9L6JEFCUSJ5zyeeKTSwpWdiscYNRs8bOIByVWGGcpvlIL
         tYhab6ooLvqETdhEgMHobEisGMzF/+R9+fNSwQptVOo445XTEJYg8TwnoshnHJVVG9wY
         hkTeqofaDtiu1PuRhg5pynNx0D+mA1NjtOKQRSZ1WulmcSq5kAe2awqRMuQPS7oMkRmU
         weww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=og6aLJN4ELJf8ujcyhVHLwiOkETXN2fux8N+5uOmros=;
        b=WYZRXn0/wr3dRSUILONJAO0T+vCDRfaL6UVB3iyMBOevIUG8u9dop/FTHJrFUGVDuu
         j8CpEzKSEYDiSMag7xsVoN9p8DI8vMtkY5h57pf/nCS/xPQ5LJ4LuKpQj31wQmCDGHhi
         zQi4LmtTlcNMXVnT8oGoc1XE9cSeOUWd65dOy/jnoLVmDhoof+e83Ekxp8UciikpCCoW
         l5BnBUwTGdo0PyTokwKQXtZTqaCue1Q8RiCHgLh2obZ7XA3h1iePh+ese5NB1HlT6cl+
         bB4wG7IhNRv/ebNAoE9Od2Dm4gUDvEr60gQAtgHXxI7bMK3Z2Fo1U22LNzREBB8X0oHl
         khTQ==
X-Gm-Message-State: AOAM5328Mv72Xzb67WtDNGYH8XkGpaD06pOh1MM0x5gfR4c4ra7Q2Fn3
        OSuIG6LD+yyWmK8VeLRO77x7gvg2I6uclg==
X-Google-Smtp-Source: ABdhPJzPXTXIY3eyePHEYSuFSmhdKtJr3OV90MeGFlPhv6dE6T5rySReWu7+/kP8N0kSIMpNQ86sDpckpeKS1Q==
X-Received: by 2002:a25:7ac2:: with SMTP id v185mr21268882ybc.278.1591416236401;
 Fri, 05 Jun 2020 21:03:56 -0700 (PDT)
Date:   Fri,  5 Jun 2020 21:03:45 -0700
In-Reply-To: <20200606040349.246780-1-davidgow@google.com>
Message-Id: <20200606040349.246780-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v8 1/5] Add KUnit Struct to Current Task
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        David Gow <davidgow@google.com>
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
Signed-off-by: David Gow <davidgow@google.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..e50c568a8dc7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1188,6 +1188,10 @@ struct task_struct {
 	unsigned int			kasan_depth;
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.27.0.278.ge193c7cf3a9-goog

