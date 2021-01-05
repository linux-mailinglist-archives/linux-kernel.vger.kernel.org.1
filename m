Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A572EB299
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbhAES3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbhAES33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:29:29 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D0C0617A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:22 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id r1so154887wmn.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=L2nfB5IDe6UR5zw3FZON/Z4AbH3dOVMSon2hvUv5xm8=;
        b=bRtGkcqXoe/bYVma5AcnnGEw1YbmPZW7e5RZXt5m1DN0wQ9mvEH4lwvMIKdWFu4pK0
         gUbgLnCx+fZ9UPd+dvdcgg9Li0HTeBQOJLIaB+1EZgkC+J8Hqs5lDgOR5xNVOiBm26P3
         jbqkhqEe7I2Ens74zeOsbOmJPbG/DNqEhlSfd3HTqf9FbJ/EsmPHLRmbu3in6OgZji8S
         /WW5QKCaOxuXsbSEuZ5ZuXa6BS7q2MwZcaNyQwhHpcPaGbcQ3zZpZYW84NWjyRw+5hqG
         xVADG0uids3vUoGlqxxeXHkD8gJeVLIyGbNVXR5qPlikY/okOEcDp1UK/bbzGd1wm0J2
         7F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L2nfB5IDe6UR5zw3FZON/Z4AbH3dOVMSon2hvUv5xm8=;
        b=A6m6KSsMDy1leUyWExcgKwTRnCUSTM3BTkFP99AtrGeLc41J6vWO5yyrGe1MmtDAxt
         szi55VEKtTlkFn/R1UB6m48C43zktfrOieZWjFgWt2qn7bFj5JgXRoOAdvTVs8vCr78H
         LnU9pHik2pdF78PVBJAh0jtjNL3hJqhp+uzOAkUJclTwZowGaJ61ZkDPc3fTjFn7Zk9b
         FvykauUL5JUuwAZ1+Qfj3hdevd0M6Y3q2dOYyHACtRUErbljZRgmoaBmT1un9gOpGzc+
         B+nJ/Ts836TIU13GayVQbuBOgA1O8BQONC2Nj4Gnr6k/GxJP9gPQdCnjmliyYUO4s03N
         UGow==
X-Gm-Message-State: AOAM530PxS4jExW8xeM5zb1ZPeKYX1mu4VPb69S6esNEC2pOoKM3RuF1
        Dnk3A2TRC2ttTwc6mvxAk0ptA8P12lQ0PKkr
X-Google-Smtp-Source: ABdhPJxm3lGUAgt1hjvEO/hnJ/HMsTuIHIRoW/Dg0H1aF9WW7wHG1xDYIpDPY8Dcc0/roDN0xvdsNxb67+kdPpfe
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:f18a:: with SMTP id
 h10mr893184wro.244.1609871300796; Tue, 05 Jan 2021 10:28:20 -0800 (PST)
Date:   Tue,  5 Jan 2021 19:27:51 +0100
In-Reply-To: <cover.1609871239.git.andreyknvl@google.com>
Message-Id: <a37dab02f89ad93cc986a87866da74fb8be1850d.1609871239.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 07/11] kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

It might not be obvious to the compiler that the expression must be
executed between writing and reading to fail_data. In this case, the
compiler might reorder or optimize away some of the accesses, and
the tests will fail.

Add compiler barriers around the expression in KUNIT_EXPECT_KASAN_FAIL.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I046079f48641a1d36fe627fc8827a9249102fd50
---
 lib/test_kasan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index dd3d2f95c24e..b5077a47b95a 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -79,7 +79,9 @@ static void kasan_test_exit(struct kunit *test)
 				NULL,				\
 				&resource,			\
 				"kasan_data", &fail_data);	\
+	barrier();						\
 	expression;						\
+	barrier();						\
 	KUNIT_EXPECT_EQ(test,					\
 			fail_data.report_expected,		\
 			fail_data.report_found);		\
-- 
2.29.2.729.g45daf8777d-goog

