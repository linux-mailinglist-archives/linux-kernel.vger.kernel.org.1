Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2415426B8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgIPAvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIOLk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:40:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45CC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:40:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so1779525pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZTeZgS/HRogQFGvFWOGASfxBZXKDJCSTQPpZUgR/Es=;
        b=vxnijL8mD9fvf864vGCOCOtWI6+tMeoadJgLcONMkLvgHCNOX7kdC9XC/M93DzSeaH
         QGPzRRlkpg27B6cazJeQWQcukneWZzkX3TsmMEKNulhclV6UHsbzVnsPK/v0pmwaQ9PS
         6kv02KQB0aYp44SStbAb+j15rXzKYFiZ7+H+6hZ+xyyepznt5H0/uDGGQt1c6hlgIHlU
         3LU18HP4i4iP29wIDm8jOpJUNZbfzovYBwpQfdofgF8EwvrZGxBy6edMzo0oZIlWN0IF
         PZlGnm0Af0AhMKADYufJz8mXCJ4ak48VmgKSfTH+aKg8OZneNx4RDA7tedMxIyRjfPEE
         JELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZTeZgS/HRogQFGvFWOGASfxBZXKDJCSTQPpZUgR/Es=;
        b=nMmYZro8NGa4XwNzpiGiy0Y7lVlOi8ZhQKiPj8wuqY0sPECR00tMBZZ7oHc2A3pnC7
         +eaYJNNnCIscSD5tfv+Pe3xHCXKDNt1BBx74YleCGrIbUEy4UjT/JNxBgCIybR/QFqJU
         KKs3yhcLJMnScDwFqYlyaQSa3uJmR12y71T1eQ0I50NNiFkrCa3CByaFCFPp+UTkJptM
         OI/Iv3phD26/+oYLhKPgvbYV6ORGKP2NBw27SLYT2Oxrbj9hPIR5HrgksbtH8lijrQzJ
         tKlbKpg0OIPZGs0u6cIs75FlDh9YCHJUAJCGmno0GIh35uabazFG9GDn1focCRApj6jN
         0I0A==
X-Gm-Message-State: AOAM53385ZTqENzLtPolU8UofM0n9Xt/ZLOav5NrJLznHCabELSVy+/Z
        biYvpeFxMhG8XfvZyHllrC/9bw==
X-Google-Smtp-Source: ABdhPJy1tf/Lc997XhgJ4gLpnYAYfclS51OkwLLYh8aJRd2O+CupL1BAPxlxg7PUeTNuwm2T+8BB8A==
X-Received: by 2002:a63:5d07:: with SMTP id r7mr1494562pgb.440.1600170023688;
        Tue, 15 Sep 2020 04:40:23 -0700 (PDT)
Received: from Zs-MacBook-Pro.local.net ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id u14sm13494204pfm.80.2020.09.15.04.40.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 04:40:23 -0700 (PDT)
From:   zangchunxin@bytedance.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chunxin Zang <zangchunxin@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3] mm/vmscan: add a fatal signals check in drop_slab_node
Date:   Tue, 15 Sep 2020 19:40:01 +0800
Message-Id: <20200915114001.79950-1-zangchunxin@bytedance.com>
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
  root 1986319 ... R    18:56 117:27 echo 3 > /proc/sys/vm/drop_caches
  root 2002148 ... R    Aug24 5720:39 echo 3 > /proc/sys/vm/drop_caches
  root 2564666 ... R    18:59 113:58 echo 3 > /proc/sys/vm/drop_caches
  root 2639347 ... R    Sep03 2383:39 echo 3 > /proc/sys/vm/drop_caches
  root 3904747 ... R    03:35 993:31 echo 3 > /proc/sys/vm/drop_caches
  root 4016780 ... R    Aug21 7882:18 echo 3 > /proc/sys/vm/drop_caches

Use bpftrace follow 'freed' value in drop_slab_node:

  root:~# bpftrace -e 'kprobe:drop_slab_node+70 {@ret=hist(reg("bp")); }'
  Attaching 1 probe...
  ^B^C

  @ret:
  [64, 128)        1 |                                                    |
  [128, 256)      28 |                                                    |
  [256, 512)     107 |@                                                   |
  [512, 1K)      298 |@@@                                                 |
  [1K, 2K)       613 |@@@@@@@                                             |
  [2K, 4K)      4435 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [4K, 8K)       442 |@@@@@                                               |
  [8K, 16K)      299 |@@@                                                 |
  [16K, 32K)     100 |@                                                   |
  [32K, 64K)     139 |@                                                   |
  [64K, 128K)     56 |                                                    |
  [128K, 256K)    26 |                                                    |
  [256K, 512K)     2 |                                                    |

We need one path to stop the process.

Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---

	changelogs in v3: 
	1) update the description of the patch.
		v2 named: mm/vmscan: fix infinite loop in drop_slab_node

	changelogs in v2: 
	1) via check fatal signal break loop.

 mm/vmscan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b6d84326bdf2..6b2b5d420510 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -704,6 +704,9 @@ void drop_slab_node(int nid)
 	do {
 		struct mem_cgroup *memcg = NULL;
 
+		if (signal_pending(current))
+			return;
+
 		freed = 0;
 		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
-- 
2.11.0

