Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7F26C14D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 12:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgIPKBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 06:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIPKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:00:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D53C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 03:00:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so3684780pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTKM9QuKkaPGqtUV+sgdxsS+sauamtAwYDBe99O9veY=;
        b=W/CybB0aDEi03zEZMzNc5Gk8+FAroM0TOHUoMJTbHAXDeTLVq/CI+pzbtFPz8oiyIb
         +uKwz1uh8sYbDTiD17dINRgdWBvTEbFWLEksIXBysH3TCI5gGklRYR8FiG1kyfjMUEk7
         t/PHvkBeBLulci1WpfRg/+By3Cuqwaxsd6dfPXu5XtbgfeJF68mqeisCPybocTZqioFX
         oRryMf3CdmJh8mKB3HiyjsFwzicPfmYQSwXPq7AEmeEtpQNs8VLDPoWVfNRsfdwwt0X2
         mhCsaHCJoDQloVCPYW7Cv+nzSq9lejGiPtLV/qw1pNMxiOVRMAdLJxdoqNHNwuUBuJxz
         tAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTKM9QuKkaPGqtUV+sgdxsS+sauamtAwYDBe99O9veY=;
        b=FoSN8XTSFWXb2wyz/Fy5ADLrtKltgl5EFpMrajyy1qTdE1jZU9Idvv/6VV6bjZf/bL
         +f7Ubyliau1VwiC82a9gfMhAiJOgOEtZ20y+hIjBQcoD2jhNNE8jf86yXS9S2eT4MkW1
         Y1tDQGM/GWxS8Z8tgbn0eCSI8C+uD2q69bQ3QQPK8LSwmyf3bBcliFQST9E5LEksCXEQ
         XWogbVZXJ5pQsoWRM2YI0A2UsIhcmvwV6ilR6r+ljrd7sIK5EKz9LkkaJzm/vDWyyAgx
         BVEw9opyXFqs632YuY3/TX6fUsq7irFmeWj3DFMQWqdjrlgm/Z0gJ5RwLShcVZO0zZ2D
         JS+A==
X-Gm-Message-State: AOAM533340N2sQgt0Dd6XivtoW0HBoytmch+/YwTC8GxR1IDTeaJp8Yt
        SVzmaRgtenYqdY2FrXaRiIc1Kw==
X-Google-Smtp-Source: ABdhPJxhAwoiQyjmcC9wFN2dsD+S/qSBFzxov9l4tp7W0GvhuYI8p6+kJbO6Yk51V7MMg091MQYaog==
X-Received: by 2002:a62:301:0:b029:13c:1611:6528 with SMTP id 1-20020a6203010000b029013c16116528mr21670404pfd.8.1600250441876;
        Wed, 16 Sep 2020 03:00:41 -0700 (PDT)
Received: from bogon.bytedance.net ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id y3sm17205748pfb.18.2020.09.16.03.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 03:00:41 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        rdunlap@infradead.org
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 1/2] mm: memcontrol: Fix missing suffix of workingset_restore
Date:   Wed, 16 Sep 2020 18:00:29 +0800
Message-Id: <20200916100030.71698-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We forget to add the suffix to the workingset_restore string, so
fix it. And also update the documentation of cgroup-v2.rst.

Fixes: 170b04b7ae49 ("mm/workingset: prepare the workingset detection infrastructure for anon LRU")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 changelog in v6:
 1. There is no version of v1-v5.

 Documentation/admin-guide/cgroup-v2.rst | 25 ++++++++++++++++++-------
 mm/memcontrol.c                         |  4 ++--
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6be43781ec7f..baa07b30845e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1324,15 +1324,26 @@ PAGE_SIZE multiple when read back.
 	  pgmajfault
 		Number of major page faults incurred
 
-	  workingset_refault
-		Number of refaults of previously evicted pages
+	  workingset_refault_anon
+		Number of refaults of previously evicted anonymous pages.
 
-	  workingset_activate
-		Number of refaulted pages that were immediately activated
+	  workingset_refault_file
+		Number of refaults of previously evicted file pages.
 
-	  workingset_restore
-		Number of restored pages which have been detected as an active
-		workingset before they got reclaimed.
+	  workingset_activate_anon
+		Number of refaulted anonymous pages that were immediately
+		activated.
+
+	  workingset_activate_file
+		Number of refaulted file pages that were immediately activated.
+
+	  workingset_restore_anon
+		Number of restored anonymous pages which have been detected as
+		an active workingset before they got reclaimed.
+
+	  workingset_restore_file
+		Number of restored file pages which have been detected as an
+		active workingset before they got reclaimed.
 
 	  workingset_nodereclaim
 		Number of times a shadow node has been reclaimed
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75cd1a1e66c8..0e85a054017f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1574,9 +1574,9 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_ANON));
 	seq_buf_printf(&s, "workingset_activate_file %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_FILE));
-	seq_buf_printf(&s, "workingset_restore %lu\n",
+	seq_buf_printf(&s, "workingset_restore_anon %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_RESTORE_ANON));
-	seq_buf_printf(&s, "workingset_restore %lu\n",
+	seq_buf_printf(&s, "workingset_restore_file %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_RESTORE_FILE));
 	seq_buf_printf(&s, "workingset_nodereclaim %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_NODERECLAIM));
-- 
2.20.1

