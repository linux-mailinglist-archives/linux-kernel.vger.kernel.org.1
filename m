Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72813295DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897559AbgJVLqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897549AbgJVLqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:46:00 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B44CC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:46:00 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id l23so257584wmg.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=g50aig4WnJQhcCcuXsue/eYMQH3ofUeze+geEk++93U=;
        b=bPOv1QmJAqZktVvHJiV+yk2zbOBavLjjtNVCEZz0JrLi1K7ts0HhoffZY6VJhPEm+6
         nzE4p9cJIaPmBT9cZ6eBUazQMBEqHP1Wdupj2KwrjXgi5CiQgnZQ5U17WjCWnaleSQ5L
         ppXzojlHdZRD76NAEvR879HIU1fK8I0w0ecmtpbnGQkEGWybyq5rEtIpG3HkFC9Dr/Eg
         yp9tEFHTch2axeX1YT7WxSWsJe9JFCo3LRy1mzAzE/MKzMXcFcmi2SnscQwlKd+G846W
         qjz/B7UXG7XhopA0rBrYzOETGYq93hBv2OavD9+89ds3PAFYx9jRsDYFUIktGVcYVc6y
         yGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g50aig4WnJQhcCcuXsue/eYMQH3ofUeze+geEk++93U=;
        b=nqeflBvQZYXlebXMI4gDBFcUgVATX80VU/hHb1At31aQuehTKvnBd+nkSvsIpZRo0J
         LwAnbuNlobbMQLzg5cfxJuU+GyjudMihEFOEirgycNVEPPKiG8BqVArR9Rayb3CLM7ZI
         YgZbRfJ7hlG7bJJCtuTOOOHxlJw9DK+fbAsiCsznDvGft2ZRChjVIhpdGz+JOxQ3zV2c
         p8Jqs8DHJi97Oqti5wqwYB4ReHICsJ1rz3WvlAr947Zy2g9X6HzBSUJPFkogf7fgUMoE
         uzOnNq3jurRVtPZ5AIl3odf2NebvLI6NF5G5Rwyl2a8J7NXTQ4j8pPCI8eRHy8zqB3LK
         0mnw==
X-Gm-Message-State: AOAM5324Up2e/BKoUhJfYa6hjLYujLVphmHS+BMZ9NT/Tews02hVfJhN
        7rKV6UC39TAksZ1lk8jjtatld1/GtQ==
X-Google-Smtp-Source: ABdhPJxwS9tqRQ5Oq12NOaAFPq3KZysd89kUzKfoWaM1cIuRpe7HMM/dcrJ3wnfTnBvT4nXS74TUjW/dGw==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a5d:6551:: with SMTP id z17mr2295237wrv.266.1603367158475;
 Thu, 22 Oct 2020 04:45:58 -0700 (PDT)
Date:   Thu, 22 Oct 2020 13:45:53 +0200
In-Reply-To: <20201022114553.2440135-1-elver@google.com>
Message-Id: <20201022114553.2440135-2-elver@google.com>
Mime-Version: 1.0
References: <20201022114553.2440135-1-elver@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 2/2] kcsan: Never set up watchpoints on NULL pointers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid setting up watchpoints on NULL pointers, as otherwise we would
crash inside the KCSAN runtime (when checking for value changes) instead
of the instrumented code.

Because that may be confusing, skip any address less than PAGE_SIZE.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/encoding.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index f03562aaf2eb..64b3c0f2a685 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -48,7 +48,11 @@
 
 static inline bool check_encodable(unsigned long addr, size_t size)
 {
-	return size <= MAX_ENCODABLE_SIZE;
+	/*
+	 * While we can encode addrs<PAGE_SIZE, avoid crashing with a NULL
+	 * pointer deref inside KCSAN.
+	 */
+	return addr >= PAGE_SIZE && size <= MAX_ENCODABLE_SIZE;
 }
 
 static inline long
-- 
2.29.0.rc1.297.gfa9743e501-goog

