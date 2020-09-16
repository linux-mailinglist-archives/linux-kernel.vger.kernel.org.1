Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22E226BA60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgIPCzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIPCzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:55:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C750C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 19:55:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so3095577pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 19:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTi1bz/tNmHVuu7oLrOOBbXmUuoclSjfaqrPNU15+RI=;
        b=wIor56g4jSJd8m3CWJVND6M3Jxtu1f4k0CylDYEO7tbYOb9GqZnNF+bXJ8+zdsldDo
         rvaL+iLtIZjaEBlbmiFP/WBY9tOF2NUVjPvzQq4J8Uq89daUZmb3s9wwEylEN/QhcrsI
         Bsj17QbobPuzBm0j9E9h7f2oOETf0r3Koxrw7hXRdLhFHf0YGqgHPHabUQhGOJzU8jh2
         balUXpa59ZeEzyFettlQe6jNa9yi9erPOggSg6CnbuOLIsZyjgAGYhQtqEODquZ7ld/1
         Xd0rqpl8PQPpNK3Nf2LHl70N5+f2D/nAdWJ4W+b37NZVHYIk+f6LXGymhYc6YH/wO+ku
         boDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vTi1bz/tNmHVuu7oLrOOBbXmUuoclSjfaqrPNU15+RI=;
        b=Mev7O8oROZeGyPC85BavSeO3h0UBvYHP7SG+E4S6nOfndofOk8uB57TdVX9mzqxNXu
         Z47yKBFglAWyOapBasFuavIz8HFTCvxXh4TJooalOLBei1pyiOWkaEp35uSVP/fFopv7
         LlU0HnZoG5Uk7oV0aGM2CkzHmRWlPbxVipJJffUSK/Tkf6sOr3r3zMNRpANtsU4ExWXr
         iubI+f1cscbUFYzSYAleMCNvAP9bIw7UyJXuxXAdw3xwvJgD9bi++XS9UM4oNt1tQdfU
         JBSFeLylxkJp346wkFYilOswklP7fS0RCgE7BB40PR444pLUYvmiv53oVfNfv6ZII3Ja
         URsg==
X-Gm-Message-State: AOAM532lmN7h4H/Mkx4d6VqbfU9f7M7AzhZEScl5MwDX9dybOOxDq4x9
        4q9XnRIgDvfwphLn8ZhoGVhnfQ==
X-Google-Smtp-Source: ABdhPJywHpl7whwPi3zY9xJFRe/KEASmy6QCZtHGlysB6R9q7ULw51gMymiAv8mc0m+dJZkwcsoV3w==
X-Received: by 2002:a65:6658:: with SMTP id z24mr16870061pgv.367.1600224918804;
        Tue, 15 Sep 2020 19:55:18 -0700 (PDT)
Received: from Zs-MacBook-Pro.local.net ([103.136.220.71])
        by smtp.gmail.com with ESMTPSA id s129sm14677603pfb.39.2020.09.15.19.55.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 19:55:18 -0700 (PDT)
From:   zangchunxin@bytedance.com
To:     akpm@linux-foundation.org
Cc:     chris@chrisdown.name, vbabka@suse.cz, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chunxin Zang <zangchunxin@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5] mm/vmscan: add a fatal signals check in drop_slab_node
Date:   Wed, 16 Sep 2020 10:53:59 +0800
Message-Id: <20200916025359.70203-1-zangchunxin@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunxin Zang <zangchunxin@bytedance.com>

On our server, there are about 10k memcg in one machine. They use memory
very frequently. We have observed that drop_caches can take a
considerable amount of time, and can't stop it.

There are two reasons:
1. There is somebody constantly generating more objects to reclaim
  on drop_caches, result the 'freed' always bigger than 10.
2. The process has no chance to process signals.

We can get the following info through 'ps':

 root:~# ps -aux | grep drop
 root  357956 ... R    Aug25 21119854:55 echo 3 > /proc/sys/vm/drop_caches
 root 1771385 ... R    Aug16 21146421:17 echo 3 > /proc/sys/vm/drop_caches

Add a bail out on the fatal signals in the main loop so that the
operation can be terminated by userspace.

Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
	changelogs in v5:
	1) v4 patch used wrong branch, very apologies about that.

	changelogs in v4:
    changelogs in v3:
    1) Fix some descriptive problems pointed out by Michal Hocko.
        v2 named: mm/vmscan: fix infinite loop in drop_slab_node

    changelogs in v2:
    1) via check fatal signal break loop.

 mm/vmscan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b6d84326bdf2..c3ed8b45d264 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -704,6 +704,9 @@ void drop_slab_node(int nid)
 	do {
 		struct mem_cgroup *memcg = NULL;
 
+		if (fatal_signal_pending(current))
+			return;
+
 		freed = 0;
 		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
-- 
2.11.0

