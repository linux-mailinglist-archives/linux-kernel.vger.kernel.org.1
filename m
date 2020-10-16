Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2B28FC75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404223AbgJPCkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393808AbgJPCkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:40:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5F0C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e23so953736wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMrDzdvIowItPCZxwmw+48iBRpQ/wjXi6fymrEYNArc=;
        b=syzN3L/Wp3YBmgLZItyTMxNEiB7mSUwRKg+lARKzCumVW9bP0wC/rA7URPv/3XF2yt
         NrGKLpQo13w4rdDGIqCvUm3OISGfJNWUuhWojJn6f1GySxsY9rQqnNl+nyluowWKlF/w
         /SfnEGkqDMZDKLHzI5YHh1fFjWw5PbMtQKqRUbHCZnkS//gMV2wIk7A2G37nuTKvHADs
         B/zEQmJuo6j1bA3+59r6JaC2HhzekjfyfiImcMg48D1936b52+jSyU3YhSQywN11p6mU
         R867i5PzCvR+idcLzFJMQt7NwJbNlQ98E3Z39zytdEiGac/EIY/UPKeRButIQE62fycf
         qhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMrDzdvIowItPCZxwmw+48iBRpQ/wjXi6fymrEYNArc=;
        b=TaHQPa8rqzdTygmti8vC4oOlV8KHCdiciGa1CBaFpqtf/xnLV/i31+LWcRyUfrbIUl
         D2PwzFpYzQBKHPrPnxR+EKDKSN6hvxnYPM8BCR9Ia6y7rrMznpdv9JHUVp8nP0pcniZE
         GEZ7PsHwy9aAqti8wY2V9VopRs5EOHLOhsRIi0XFejDBe8Xp9hsQLSRmdAm8yma9/17+
         SUbsn7sePoUsZt6YDxZO1/f5yduIXBfdbpl5N7vqHsGEotxo+7MLwnUuEaTZbrXE67Ks
         UFBEHDNnkbzozqKwNZIwmY866NDjTPGaoAfN33L43qWXMahYwSSwQjEoNamHXlkoAmEY
         Lfpw==
X-Gm-Message-State: AOAM5320t5t/cVY0mL959wmJzOaO1d8AZh+xl0bP1PMOAozCqREBJgn2
        tJfDMUKevuBO4IWkPLdPun3HJ9zHulB7Jw==
X-Google-Smtp-Source: ABdhPJy9aBJRo775A0oUO4Y+eGG3JV+yIwLDNGANvDx1gCLPck3vDjMcMFiN3f0sqr3F+s6pCGS/Hw==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr1385922wmc.142.1602816035657;
        Thu, 15 Oct 2020 19:40:35 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id k5sm972649wmb.19.2020.10.15.19.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 19:40:34 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 2/6] refcount: Move refcount_t definition into linux/types.h
Date:   Fri, 16 Oct 2020 04:40:15 +0200
Message-Id: <20201016024019.1882062-3-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016024019.1882062-1-jannh@google.com>
References: <20201016024019.1882062-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to use refcount_t in mm_struct, but if refcount_t is defined in
linux/refcount.h, that header would have to be included in
linux/mm_types.h; that would be wasteful.

Let's move refcount_t over into linux/types.h so that includes can be
written less wastefully.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/refcount.h | 13 +------------
 include/linux/types.h    | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0e3ee25eb156..fd8cf65e4e2f 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -96,22 +96,11 @@
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/limits.h>
+#include <linux/types.h> /* refcount_t is defined here */
 #include <linux/spinlock_types.h>
 
 struct mutex;
 
-/**
- * struct refcount_t - variant of atomic_t specialized for reference counts
- * @refs: atomic_t counter field
- *
- * The counter saturates at REFCOUNT_SATURATED and will not move once
- * there. This avoids wrapping the counter and causing 'spurious'
- * use-after-free bugs.
- */
-typedef struct refcount_struct {
-	atomic_t refs;
-} refcount_t;
-
 #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
 #define REFCOUNT_MAX		INT_MAX
 #define REFCOUNT_SATURATED	(INT_MIN / 2)
diff --git a/include/linux/types.h b/include/linux/types.h
index a147977602b5..34e4e779e767 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -175,6 +175,18 @@ typedef struct {
 } atomic64_t;
 #endif
 
+/**
+ * struct refcount_t - variant of atomic_t specialized for reference counts
+ * @refs: atomic_t counter field
+ *
+ * The counter saturates at REFCOUNT_SATURATED and will not move once
+ * there. This avoids wrapping the counter and causing 'spurious'
+ * use-after-free bugs.
+ */
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
 struct list_head {
 	struct list_head *next, *prev;
 };
-- 
2.29.0.rc1.297.gfa9743e501-goog

