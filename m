Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3815B2F6510
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbhANPrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhANPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:47:48 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CDAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m5so3407078pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RmtGecZ1HuAFo8Kfgv5uBlJyLrepmKZJhRqM03bSdVg=;
        b=qumZiAWVt/VTHOjz1f0JmOOaDowqm1gYUg7o3Q6NEvkyOiWrIXaZFg6URcyr3xb05r
         JC3vsZdgPCP4khbsG5e+VWDKUoo5IlYSKEbLSK6jdSZzlDEKLq2zNmPCV29hSmPPtybp
         JZIRk+b4lXbvE3zRqNq1WpVbkzc68wA7RljOvXAicKUsdHM9cXG7dhiKa0b4f2dfVeHz
         pgTPFJiZu6iiWeDh5kNk5xrWzxMO3X4iLXrA0gtZ/GfVGEs84f4u8GXZgHKD1mrKp5pn
         +ToEvzwbwXGzuYl6G8hTqF7NqfiIDyMZ5jEWiUN22Ah1PrJUCmNhSIlbYGoSia/op+7W
         doFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RmtGecZ1HuAFo8Kfgv5uBlJyLrepmKZJhRqM03bSdVg=;
        b=MA3Sma/eKHTTpCkozrkqqr+6AWkQBQlqD3UKDc4TQAaeocK3emf3C9K52QiwVM1a+w
         O/NqEOXjvKFKMN2+c+bBVTRXkeLit2RpbS5lRegAnEkaWfjoVRAgxcCoGJt1wNfNLOu9
         7kQGQomnq412ML7ljx1dAMdzXiYG7V1uqoegWxjsUfKHw5X1l9FBnD1jUXNcsFTZjfVI
         T9kEZYwz1O5oc0PPSGYhFdRvkls0s2gai0ERETpNBPZMwJmAqm3Lq1wCrS/FlYD31vtL
         Pcf/eIvI6Gvscc6epYv5Kxunsp4u5qqsB+iQmiP2N0mIo7KvA0ps76471JRrXQuXhJG8
         dN2w==
X-Gm-Message-State: AOAM531bYe1FuaFE5jRWBbsuBEJaEcKAtcAZkdsqxkYbKfD7QNa2GZT3
        Y9Cdnfm5Ux5ik24cFY5gyanyKQ==
X-Google-Smtp-Source: ABdhPJwbAEqurqexYLTgB2TO0nDVbtQZvsI84SeUh8X5Pj4Jh4KmXbnVdeAzeFTqZcMcLJAs17QP/g==
X-Received: by 2002:a17:902:44:b029:de:17d0:4fcb with SMTP id 62-20020a1709020044b02900de17d04fcbmr8237829pla.64.1610639227665;
        Thu, 14 Jan 2021 07:47:07 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id t2sm6403204pga.45.2021.01.14.07.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:47:07 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 4/6] perf c2c: Fix argument type for percent()
Date:   Thu, 14 Jan 2021 23:46:44 +0800
Message-Id: <20210114154646.209024-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114154646.209024-1-leo.yan@linaro.org>
References: <20210114154646.209024-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For percent(), its arguments are defined as integer type; this is not
consistent with its consumers which pass arguments with u32 type.

Thus this patch makes argument type as u32 for percent().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 7aaccea00883..7702f9599162 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -876,7 +876,7 @@ static struct c2c_stats *total_stats(struct hist_entry *he)
 	return &hists->stats;
 }
 
-static double percent(int st, int tot)
+static double percent(u32 st, u32 tot)
 {
 	return tot ? 100. * (double) st / (double) tot : 0;
 }
-- 
2.25.1

