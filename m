Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9342C8D35
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgK3Sp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgK3Sp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:45:58 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C66C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:45:18 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id hk16so120770pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIvRWRD6HO9Oyw/EUUNnRsPAJrYWyVDF1THvKv1y1Fs=;
        b=XOBUgBSxf/RjmEDHYrQQqkosaTnSRzD/gEoFQsf2TfV7Qhq6ZqopwGLYemFfX4OiFz
         naKFMfyA59z/3Q2/3hv4fsZXKcVO3f5rC/njOA3H+V2Hk4nQ29Oc3kNs7LfQTw6HX++C
         AYtuvb50a7aG85F5m143rG2qaPa4sR92AWkKyESmMs/S2tZ+0bbvxZoWmCsYXEwnG83B
         +kKQ5d2GHEtUT0BNEIOGdqUeAw5bTroRkTE3jy7KAmrNexKOOQTU+/I5sL9dViqyYpp6
         hCko6oO6/IAObPbfwVPOsiW81CEC6xyQw9CXMs+gYzWuCyAL3x8anIV0yo1WjQ3rzWg2
         jklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIvRWRD6HO9Oyw/EUUNnRsPAJrYWyVDF1THvKv1y1Fs=;
        b=cMvRypvPg5ibVmsVznpCvK79CJQapWnkviYfsRAD3nUpOa90yKY1/l1tZz6eTbQ7Lq
         sX72tqxGbPbrnoO9uiHLLT/mdM7cEyQDgwXKoZd3/rKVwn9SSKy0BDbwV0iGIe+/Ofjq
         3NojljkXFDKzFsZ8p5SL1Ekz0EJf9OGl6spnE84xQwNEI22yHvfmcMSYBX9v8ecV4nxw
         lAWsfTGtxe3l8jOtJaBQLbQOu2DY7xnYpAf96SaQlY0HSZmviEo8PIOeYiWr9VnS/DxD
         2UotpB9nc2uxAlbgGV8ti3NXJC3lYBrjqNMuGqgfezXGMemu7ChE5MvtSvDpfAVsQhAF
         xstw==
X-Gm-Message-State: AOAM531+Jr9HleC1IW113E5oyvLARYxvF+bPBrOSJp3SCR3pUZcV/Cnc
        voabGvjtDQ/7feOQHHJBCQo=
X-Google-Smtp-Source: ABdhPJxvCrP6PxH+CF1f23dBvytjEh+ZRfcFjJ3c4wvmKIvc0hy4G2IgWeRVpMC7iot8YYQKAojfYw==
X-Received: by 2002:a17:90b:198a:: with SMTP id mv10mr184697pjb.5.1606761917654;
        Mon, 30 Nov 2020 10:45:17 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id r11sm154390pjo.1.2020.11.30.10.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:45:16 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vdavydov.dev@gmail.com, ktkhai@virtuozzo.com, guro@fb.com,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: list_lru: hold nlru lock to avoid reading transient negative nr_items
Date:   Mon, 30 Nov 2020 10:45:14 -0800
Message-Id: <20201130184514.551950-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When investigating a slab cache bloat problem, significant amount of
negative dentry cache was seen, but confusingly they neither got shrunk
by reclaimer (the host has very tight memory) nor be shrunk by dropping
cache.  The vmcore shows there are over 14M negative dentry objects on lru,
but tracing result shows they were even not scanned at all.  The further
investigation shows the memcg's vfs shrinker_map bit is not set.  So the
reclaimer or dropping cache just skip calling vfs shrinker.  So we have
to reboot the hosts to get the memory back.

I didn't manage to come up with a reproducer in test environment, and the
problem can't be reproduced after rebooting.  But it seems there is race
between shrinker map bit clear and reparenting by code inspection.  The
hypothesis is elaborated as below.

The memcg hierarchy on our production environment looks like:
                root
               /    \
          system   user

The main workloads are running under user slice's children, and it creates
and removes memcg frequently.  So reparenting happens very often under user
slice, but no task is under user slice directly.

So with the frequent reparenting and tight memory pressure, the below
hypothetical race condition may happen:

    CPU A                            CPU B                         CPU C
reparent
    dst->nr_items == 0
                                 shrinker:
                                     total_objects == 0
    add src->nr_items to dst
    set_bit
                                     retrun SHRINK_EMPTY
                                     clear_bit
                                                                  list_lru_del()
reparent again
    dst->nr_items may go negative
    due to current list_lru_del()
    on CPU C
                                 The second run of shrinker:
                                     read nr_items without any
                                     synchronization, so it may
                                     see intermediate negative
                                     nr_items then total_objects
                                     may return 0 conincidently

                                     keep the bit cleared
    dst->nr_items != 0
    skip set_bit
    add scr->nr_item to dst

After this point dst->nr_item may never go zero, so reparenting will not
set shrinker_map bit anymore.  And since there is no task under user
slice directly, so no new object will be added to its lru to set the
shrinker map bit either.  That bit is kept cleared forever.

How does list_lru_del() race with reparenting?  It is because
reparenting replaces childen's kmemcg_id to parent's without protecting
from nlru->lock, so list_lru_del() may see parent's kmemcg_id but
actually deleting items from child's lru, but dec'ing parent's nr_items,
so the parent's nr_items may go negative as commit
2788cf0c401c268b4819c5407493a8769b7007aa ("memcg: reparent list_lrus and
free kmemcg_id on css offline") says.

Can we move kmemcg_id replacement after reparenting?  No, because the
race with list_lru_del() may result in negative src->nr_items, but it
will never be fixed.  So the shrinker may never return SHRINK_EMPTY then
keep the shrinker map bit set always.  The shrinker will be always
called for nonsense.

Can we synchronize list_lru_del() and reparenting?  Yes, it could be
done.  But it seems we need introduce a new lock or use nlru->lock.  But
it sounds complicated to move kmemcg_id replacement code under nlru->lock.
And list_lru_del() may be called quite often to exacerbate some hot
path, i.e. dentry kill.

So, it sounds acceptable to synchronize reading nr_items to avoid seeing
intermediate negative nr_items given the simplicity and it is typically
just called by shrinkers when counting the freeable objects.

The patch is tested with some shrinker intensive workloads, no
noticeable regression is soptted.

Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/list_lru.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 5aa6e44bc2ae..5c128a7710ff 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -178,10 +178,17 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 	struct list_lru_one *l;
 	unsigned long count;
 
-	rcu_read_lock();
+	/*
+	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
+	 * we have to use IRQ-safe primitives here to avoid deadlock.
+	 *
+	 * Hold the lock to prevent from seeing transient negative
+	 * nr_items value.
+	 */
+	spin_lock_irq(&nlru->lock);
 	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
 	count = READ_ONCE(l->nr_items);
-	rcu_read_unlock();
+	spin_unlock_irq(&nlru->lock);
 
 	return count;
 }
-- 
2.26.2

