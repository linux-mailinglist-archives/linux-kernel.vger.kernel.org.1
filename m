Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43AD2F9C79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbhARJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbhARJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:22:46 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350EAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:22:05 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l7so16002441qvp.15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=QzGOv73ZFTudUcHTOtMvLbaz7ljjqIpJFfG6qI+sI6U=;
        b=X6NZCPTBA0MLtyfOsSc4T6WCOKT6Vu8X96m8uttmeTIoEZk1WlYwaTI1G7HnwWPaGM
         C9JwaP4knEZ+K1/cWKzAKbPKPFS0TaYSQMZaOYd99HTe3knZ2Z2MDj8TTj/z01Ed+QDj
         d9gCObF/0soZyQPQojVTlDJeZ0xWxUvLjKAtqqrGAvqBREkPPNToRqIO73NwQMFB7pae
         K4SBwcR4LuLbgqnVwpy7wF8YMo2BNEQu5UglRw7wMmUyEFtYEXf7Mk6mD4PvSOQe8lDX
         xPBPEfp4yrCGbzJ5uYDCsgg8sJj92cHsbmQS6Ds6/MbIovLHovhXwUxLlVQrpbMlC2p+
         mqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=QzGOv73ZFTudUcHTOtMvLbaz7ljjqIpJFfG6qI+sI6U=;
        b=l3eHiIrnO+kihu/zYVh64Fy8VDYRFuhHmmdK3vHL1m99cH+hP4ldh0BX4wXGtNGhqN
         jrmL5kE5TfyRhGs3CcELLZelzYNWv/yEF4JebevSoC/CtISuttjK6wyywWnwBLpxnuuJ
         iBzIJGgOBDVtEseSdK2QZMxMPQyLyPEnujQMM2zs/zhTwcDNnvO9lUuoQq4HleNu3VUp
         lch3QbVHXb1rYME0SYlrrlVFC5PrMU6eBtV3tnO63LamRjulQEPkdtH10ifT+p+8aXTW
         RSt39L3QCzgnZH0hXbTlMjPEIZtbohLqkQOwy7coXDdzIb+Pzn5P2xVnAqVygEQnJF5Z
         F0YA==
X-Gm-Message-State: AOAM530fRpwe6/5ue0uZ1Vxxgj8zJ1SElMougBwcYsNi/SMHLpNNZbYC
        NHFCxjh7n9eWZppzl8yOnmxMWHHdzg==
X-Google-Smtp-Source: ABdhPJx+3xkjI1jXn9mZj3Qy2H/cCLEH37rxUjjfAZC8c3/tlUM9r+fDtU5g01+zeu+zN8zscX35Ykd70A==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:ad4:43ea:: with SMTP id f10mr23237470qvu.52.1610961724181;
 Mon, 18 Jan 2021 01:22:04 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:21:56 +0100
Message-Id: <20210118092159.145934-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH mm 1/4] kfence: add missing copyright and description headers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing copyright and description headers to KFENCE source files.

Signed-off-by: Marco Elver <elver@google.com>
---
If appropriate, to be squashed into:

	mm: add Kernel Electric-Fence infrastructure
---
 include/linux/kfence.h | 6 ++++++
 mm/kfence/core.c       | 5 +++++
 mm/kfence/kfence.h     | 6 ++++++
 mm/kfence/report.c     | 5 +++++
 4 files changed, 22 insertions(+)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index c2c1dd100cba..a70d1ea03532 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -1,4 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Kernel Electric-Fence (KFENCE). Public interface for allocator and fault
+ * handler integration. For more info see Documentation/dev-tools/kfence.rst.
+ *
+ * Copyright (C) 2020, Google LLC.
+ */
 
 #ifndef _LINUX_KFENCE_H
 #define _LINUX_KFENCE_H
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index a5f8aa410a30..cfe3d32ac5b7 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KFENCE guarded object allocator and fault handling.
+ *
+ * Copyright (C) 2020, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kfence: " fmt
 
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 97282fa77840..1accc840dbbe 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -1,4 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Kernel Electric-Fence (KFENCE). For more info please see
+ * Documentation/dev-tools/kfence.rst.
+ *
+ * Copyright (C) 2020, Google LLC.
+ */
 
 #ifndef MM_KFENCE_KFENCE_H
 #define MM_KFENCE_KFENCE_H
diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 1996295ae71d..901bd7ee83d8 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KFENCE reporting.
+ *
+ * Copyright (C) 2020, Google LLC.
+ */
 
 #include <stdarg.h>
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

