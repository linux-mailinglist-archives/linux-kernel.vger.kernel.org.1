Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB4241608
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 07:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHKFjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 01:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgHKFjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 01:39:36 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BDC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:39:36 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id e30so9645430pfj.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 22:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7T9CW/c7Zee0z3O+ssd8ugkXYgOmzh7dNULbFDDyxII=;
        b=ex3UMkvioGZcSdjkSZ3VMaDVrsMH7gLRv9mL8dE32SHnMS1Vp6aG8/WmhbdmLvhphx
         /1v5a5fB7wj+oPV+Oc932ItwZvqnOIfEfLFYIw2mw2xZ/BV4hxWbi6NbevXGJb6p/hAZ
         yLXIEGEadjNF+sz9Jmv4UDGjcUqUtFOw6QCS1DZ+FEz5mJ3M3jghYEh5nD/PUf70urZp
         sps9PvRiVV4Y8ga4E2mUIRkSVKdrG6kuk49HDExd1cDp6dbef6FbORjBCLjcD9mRJnpo
         UBL2v5FhX6Svv1k+vhVgCBzqe6WharEZ3d2Bd9kDkP7a6TkrmwopneVNZXXmKHG73Y36
         zofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7T9CW/c7Zee0z3O+ssd8ugkXYgOmzh7dNULbFDDyxII=;
        b=bSkgLTjxLZJWWf973p/0xg1FgRg5Ez3Xm288cXoODYVL9i4I1pYO0QldZCEPuYKdqU
         tGrhlng45JTWGNo4LRvKQKjlRP8BH2qIeOEumBRzJP2DCqaw4CAtE/bpoNUwK5l0pKNZ
         OHKnUJLT3aFpRD0sS0cSfhYmoade0GrL5V3/SCDUL2NVMAx+hnyYXT4v0RNYOzxcqiV3
         SWOps4R05dV4nf+wQ6o1FKri/iMHFBwDOnP0Cu+iEIqLRImOLmbx/ZhOOVXapIegTSlh
         gHzZ5dhclYzkDvSOHtiXUVCFOogQ+ulKVfKazte3/Z1uvZELb9JPC5Mim7fiOtwbjlQw
         PLQQ==
X-Gm-Message-State: AOAM532V7MSoUhp/TnY1iiO+gymmaOy7Y9CBUjXb5ZdxLtax+ivDAe4K
        j0Hw9GVd5PTHWt9+utXtY209BCRB1xoQow==
X-Google-Smtp-Source: ABdhPJyfog1oEdqhl3BDs/ZjD/wVYqou+PSwo2789g+sgcAektkcXd/V0M+4Yhqyd+fqVdDQRSewJ+BIlw1fHw==
X-Received: by 2002:a17:90b:3684:: with SMTP id mj4mr2854429pjb.195.1597124376232;
 Mon, 10 Aug 2020 22:39:36 -0700 (PDT)
Date:   Mon, 10 Aug 2020 22:39:10 -0700
In-Reply-To: <20200811053914.652710-1-davidgow@google.com>
Message-Id: <20200811053914.652710-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200811053914.652710-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v12 1/6] Add KUnit Struct to Current Task
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
index f92d03087b5c..3db26aa88971 100644
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
2.28.0.236.gb10cc79966-goog

