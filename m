Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F1B26B6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgIPAIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgIOO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:28:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C617C061221
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:27:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id e4so1343871pln.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vhjnhaOBNypT0J1caJeAb0BF+ROLuuFdlB5WaLOXWw=;
        b=dTQmO6eKwduT7IaIh4/3GtHGWGXulgiVyvo2tcuLJKe4T8M1CUzMgkss5IffOi6IqT
         GbVXsPhP6n6MZSyyXBzDuTlaczde+R2addAWfJ4X6ol6rjBTo0FZPAtgdCIn+qI8jmSc
         Cc3MqrYmn7lvDnH2KviU1J01FNR46KrC8zJKV8JMCpYLThIEiUgKtoscqDPlNfUAspSY
         frbzNx+MmCx9EWDBhGa+fFpHUlbeFDaJMbhQP2JCHA7fqNOmC3gD4keSwLJ9NG8woET0
         gVUS2Afhrp8ZCp3U2vR3fOfQ+PH8IIC9XOItqeGg8wv9KEix8ZHHOgZaYjQBhsC8gWdP
         JGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vhjnhaOBNypT0J1caJeAb0BF+ROLuuFdlB5WaLOXWw=;
        b=cCGhZ+d2d4wnD306IHGxSVeL/IkzYS/bGX5kbcOLb8dvfLFUwEF234tf7rp52woIFr
         wT0x2pU3xm0XygV61AUWqJd4ccrW/ovF45UEGYA0GnaRjYqfeWCZZ9cjdaIjUayMomG6
         IK/ZK9o5Okjtw5eFsVnIb3VWNYxj9mIhrTO31mF6vMs9gIVwEH0jO3+mIFnxFt938Sfy
         nPwxN72NPKFyZKwQa/neqcx+lQnYHzZunGHYEbaJqFRu/Q63iqQwv4vUaUApmYjp7I2X
         63BMJ+YGlSYQiTZIRvsdbcKs/qNPGg+bifuPydbWIqoaTPtTt++X9S/zf8tLkgXHj45T
         F/4g==
X-Gm-Message-State: AOAM532D55HLQTgL76SYkkGqF39z8DthD5EDFH5OfPyIJxkPQhM20VTa
        TpTYzU0qS1r4B3IebxVNHDGfgg==
X-Google-Smtp-Source: ABdhPJw12ixCnD+C0yvcpiXBUPv8NOwFo2xCyijS3BEGCK93LIB7TvFraxv5Y3HdSHelDvkDyLH6AA==
X-Received: by 2002:a17:90a:ead8:: with SMTP id ev24mr4174614pjb.89.1600176469553;
        Tue, 15 Sep 2020 06:27:49 -0700 (PDT)
Received: from Zs-MacBook-Pro.local.net ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id a13sm9644029pfl.184.2020.09.15.06.27.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:27:48 -0700 (PDT)
From:   zangchunxin@bytedance.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chunxin Zang <zangchunxin@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4] mm/vmscan: add a fatal signals check in drop_slab_node
Date:   Tue, 15 Sep 2020 21:27:41 +0800
Message-Id: <20200915132741.84869-1-zangchunxin@bytedance.com>
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

	changelogs in v4:
	changelogs in v3: 
	1) Fix some descriptive problems pointed out by Michal Hocko.
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

