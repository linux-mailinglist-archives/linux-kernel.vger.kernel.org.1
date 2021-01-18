Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2909F2F9C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbhARJgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbhARJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:22:51 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC073C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:22:10 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id x12so1768476wmk.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hkWRLHOHbnA69ZqWFvUpIIVeHgC2CbanywSC7oN8uXE=;
        b=uXQQtcl2dxthbSBXRYjIkrcPQI0tlYId8LVzD6aku69Meg/Cb5VHsBAUfDaXyqlyNE
         L0LG16fo4mpl7oxowLlMuvAA0pLCbSQDE1fLIa9gXtmWKV0dVKvkMKtH368GR6bm60ib
         UUjsovJ/7NiA9c2e4lDEIS1gCHQA3hMwS+oQKu6DtLKHkzMnwtNztxrV3dqp0TcOrHSH
         Qr9vMAlwwvR0Ppk3IFFcF+XrVrNwfgzYbw+5chQj3BKMMoyRDy7EUZdWAYMfntntTUJa
         Uaw1w2CAI8GOeEWD6RLWo3qOE7+nn4WN6RS9+KyJePm34p5nPezFIwI0ZDJfiurfemnn
         Cnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hkWRLHOHbnA69ZqWFvUpIIVeHgC2CbanywSC7oN8uXE=;
        b=FRHJoJVaR2A6CkysDjt3nxIrUY+Yr37qG66J8Zlrgg/3KG8chsvCfjGsBmXR5KhJbU
         1fKGqLjhJtJLxPxgc+Sxwa99RSNnSYULJamWAAUcKNh6X5St2TTvvVz/KwTpdRQcLzMD
         Xg5gIcdL+VAacU4504qxd43lQ1SvFaT/K59iY4D41eJxb7qyG1Ua6hwHMuI6LJCVcm5B
         LZBjgltll1KdN61iLZ3Vzlzg0tEoVuhNQSGiiP94vV9HSzGEka4LUbWnDgr7XFtdjpO7
         pwzBe9D7PsUu8Mlq1eFoXUZvAxbOOcB+rbGjgvuDI+WsEkg4pkHu00EM07/Crl0uvuG4
         1kKQ==
X-Gm-Message-State: AOAM530xfx2HBravIjin55lYMUlulALrZSpvROkhbPdDPLk9dRs7T8lr
        rq9XRBvBCRaf3GGWwPvvsQ8LOmNztA==
X-Google-Smtp-Source: ABdhPJz/CP9bGY7nHc+SIQfL2A3fIqdDuw/7wztym7OBqCB81VON8CIJFu4EL4SK0b0w9a+W5FeUzqqKbA==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a05:600c:19c7:: with SMTP id
 u7mr9181180wmq.122.1610961729366; Mon, 18 Jan 2021 01:22:09 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:21:58 +0100
In-Reply-To: <20210118092159.145934-1-elver@google.com>
Message-Id: <20210118092159.145934-3-elver@google.com>
Mime-Version: 1.0
References: <20210118092159.145934-1-elver@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH mm 3/4] kfence, arm64: add missing copyright and description header
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing copyright and description header to KFENCE source file.

Signed-off-by: Marco Elver <elver@google.com>
---
If appropriate, to be squashed into:

	arm64, kfence: enable KFENCE for ARM64
---
 arch/arm64/include/asm/kfence.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index 6c0afeeab635..d061176d57ea 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * arm64 KFENCE support.
+ *
+ * Copyright (C) 2020, Google LLC.
+ */
 
 #ifndef __ASM_KFENCE_H
 #define __ASM_KFENCE_H
-- 
2.30.0.284.gd98b1dd5eaa7-goog

