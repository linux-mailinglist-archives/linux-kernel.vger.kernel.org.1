Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CDD2F4FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbhAMQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbhAMQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:23:17 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48F8C0617B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:21 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id l3so1826410qvr.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0oH7aBBGG/x9vXdKvNsdbcmQExRVmREsCFEoJWJ3HWQ=;
        b=tYlSj+QTWutTDH5gzQYUyaice5go9l3cv899Fm94zOUhM2UTC+6sCkV198NX7X4rLv
         9P+W9aeX0vY5gLC78glAsyk9S3f57B4otPPj9GIGen1A2xt7t4epZxu83cYwXAWrkGjC
         AUEkcM3Klpy9VDwCuFSD/blehpXrwf+MLutxOK+4OfHwXFn1u65iYPeU7Qfxl+UsCnYB
         dfbKOj5/BntajGohSBWAJTDkIsXdaljcno+BVlkyqblGW366u2PTCDZJUqXsCrTsA7JO
         vqmKERfAQL7Lp4kcq2GP5H/689JwgXw18RbDGPxZm5vERM1+FjZ1qvjOFbctixc57qqE
         LbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0oH7aBBGG/x9vXdKvNsdbcmQExRVmREsCFEoJWJ3HWQ=;
        b=Dd6X0yZfymTTmAgg14NBOO1E7xhjVx+8Ok0pq6opawDUo9q5+rXgOwDIXeW16iIRuz
         p6uxVVMBhU6at97gK8tEqqu7QjPyFaUvQZf0tYkK+vxZOZ4qXWkzx+pZI5m0c5nwXJ6Y
         khP1oQ+h63s+gGpUTPQHtIz4wb9IB/DhaPy1NlCOpyTERVMQN7hs+gekV98lbwK7N+Nq
         259pz0UA5XhFoYe3TR5FCapZqgSre7WCovtmoXX352OCt1/qKMZ1C4RxdDVu7ONthQ/R
         d4Vw+1b0SajonR6UymoC12/tgKGQMYqYtr735PwzY/3fisVc3a8UrowQysnoTjWaXeEb
         gexw==
X-Gm-Message-State: AOAM532TiFa/K3uGHwQxxI7jlgqXa8JrGeNssqjBxVyNCrjIFTJQzxWt
        bhi6IwSmSMXTXg6Nx9pFP4aDWT+Wm15bhfVi
X-Google-Smtp-Source: ABdhPJxOje2p0FQHseszOF0PAnCpvRA/kj/HPWxbgfjb/sC79Qvgl/QNJ2+aV/+6IFs0+UXkGQqNeZaxA4gv48Fr
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:cc12:: with SMTP id
 r18mr2847745qvk.51.1610554941000; Wed, 13 Jan 2021 08:22:21 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:41 +0100
In-Reply-To: <cover.1610554432.git.andreyknvl@google.com>
Message-Id: <654bdeedde54e9e8d5d6250469966b0bdf288010.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 14/14] kasan: don't run tests when KASAN is not enabled
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't run KASAN tests when it's disabled with kasan.mode=off to avoid
corrupting kernel memory.

Link: https://linux-review.googlesource.com/id/I6447af436a69a94bfc35477f6bf4e2122948355e
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index d9f9a93922d5..0c8279d9907e 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -47,6 +47,9 @@ static bool multishot;
  */
 static int kasan_test_init(struct kunit *test)
 {
+	if (!kasan_enabled())
+		return -1;
+
 	multishot = kasan_save_enable_multi_shot();
 	hw_set_tagging_report_once(false);
 	return 0;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

