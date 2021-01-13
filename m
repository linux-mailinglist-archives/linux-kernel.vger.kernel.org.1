Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C02F4C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbhAMNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbhAMNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:51:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1ABC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:50:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r7so2197789wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 05:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwXBYrJM9qKVPKPYtJI8yjhIvV2KkPeDmKoz+CVJlHc=;
        b=bzpYCMGS5z3k4l3WIeo2Lh33CM8JjhujxkGFpyyyNRzNKJzzpnLue0cnZxMh4x6oHf
         eCVl8OSG9Axe1NHmrz+kB6NPuOorAFrwhuNw47MacCmBu0o3Pl3ky2OqtASCKwWM8WIH
         U9tV1BZt2YEuhGsFV/az7bC5o2QzPVwDZqlBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwXBYrJM9qKVPKPYtJI8yjhIvV2KkPeDmKoz+CVJlHc=;
        b=TQs4Fe2+9S4wJFBAN+Je0UPRLSmJhVwV7MmLV6ZaJ9PmkXX4I4ciZgDwazmalwiipz
         QAWm/p5HfbwJ4ZlcV17ZiaP1Aob1n5eDs5H0+LpvxqesoshS3r4maQsVi32uKdm9kK/P
         +9Eu9HaC7vhLtgCgsaiRU4MolQlsI1TDGFZWy+oZKOc4ctYwllkmupSplJ0b30+5jsBx
         BhAe90VEBxcOChAah1MOhMkR8KexQlimRXxVVuvbxDS1W5AdbswgZo6wP8vlmg0T6Oq/
         riucyXWdK3GKhGCxzBuzvbs4HPGZQE/k3e+LXkMfAbG9rYfqT+opz8nMufep8/8kh41Q
         mEag==
X-Gm-Message-State: AOAM530WfIveCFHnT7yOtBiHa5aq7nnQgcSwrWV3MrSN69MQsRCaVUZG
        sxAmaQm/FFLGQlNQkILpRFyvF5b5GXMYh1Fo
X-Google-Smtp-Source: ABdhPJzGWphNJohoIPnV14YY+wwm9p1rbZynTvRFgZcJcJLGZeKlK5X9RsGhgorT4nwIxWDzFr/YtA==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr2841613wrw.62.1610545820608;
        Wed, 13 Jan 2021 05:50:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u17sm3011205wmj.35.2021.01.13.05.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 05:50:19 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 1/2] mm/dmapool: Use might_alloc()
Date:   Wed, 13 Jan 2021 14:50:08 +0100
Message-Id: <20210113135009.3606813-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that my little helper has landed, use it more. On top of the
existing check this also uses lockdep through the fs_reclaim
annotations.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
--
v2: git add everything ... :-/
---
 mm/dmapool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index a97c97232337..f3791532fef2 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/poison.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/spinlock.h>
@@ -319,7 +320,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	size_t offset;
 	void *retval;
 
-	might_sleep_if(gfpflags_allow_blocking(mem_flags));
+	might_alloc(mem_flags);
 
 	spin_lock_irqsave(&pool->lock, flags);
 	list_for_each_entry(page, &pool->page_list, page_list) {
-- 
2.29.2

