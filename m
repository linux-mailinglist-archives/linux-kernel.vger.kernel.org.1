Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36ED2E90AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbhADHCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbhADHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:02:16 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A83C061793
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 23:01:36 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id s21so15862454pfu.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 23:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/SmIjUY1iXgmpYVoTEFRvKyqR5z81Ow+60craOQ1V8=;
        b=eX/7BvY+k8Ogg2yVzYJp4S1E7wxS+1ns6iztHR1qdNGA0tGUFYHIX6VbfvCb80bFFn
         cP54FoMdobERR5RY7H6uMyhUl/qW0RHUbRWsgVXjR/iPwtz348CFIea3xrDoRVa2lFuc
         kDESclSiyB99S7MiaC7PePmiBzmZdrH9o4O/S3+gaQ4KIk9aoqO17qIDhxc4aMfw7Zuz
         3+s+aNHffdQo8PERgbFflMQKiUBCjT3JT7XrhVg1hrxJ3oyvmWh2lDM9pOe+mTLxwQ+G
         T97FRiYo4p/m0IRbeMzD0XRUSXXQ7tQP5zYNdwpDpFTFKc2vhhu5ISpqPvWaZOxsjdDS
         d7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/SmIjUY1iXgmpYVoTEFRvKyqR5z81Ow+60craOQ1V8=;
        b=k3hEA+7e0efzqCOq6Qv+vYgJoRhp3lRPhuLpZW4H+HdJ565Vm/w1daQNIUYGEVMNug
         8GzYOJmKxo1SXN9dpOL7X3VrSs9cFbK34VACpeOT5CRm1i8y92vyYFnk+wVd5XRgKsPn
         vrSfVPJfkWPEg5rWkZitH4chAVXhnZOKO6srG+FAB33qI4kbUZsZW4UyerXYFq58edDf
         SiqG0vAZyBET2bCP9tLVL8IP2EE9rtLzp4LwUt4YycsHcGa/X6koLcUhKgpcWn1pSQM6
         b04ywUe7AgeW9hi++fXXEbjOcUOysQ7IkJ4lTpJPMWZOCiB6+2oK9/fhGBpKWUBeji//
         SvRg==
X-Gm-Message-State: AOAM532SEaEfM+C5TTVVrNGEOiufEHVPrtAD9ldNUZbaZ5iBOKsH9gk7
        c7WafLxmtAmyzDWBNBfn4YteBQ==
X-Google-Smtp-Source: ABdhPJwY5jsG9Aek0pLNoLlUr8MTESblTrmvgVjTEfEY1zFB3mN+RiZLmSk00JPfpWzizO3Zi3ocQw==
X-Received: by 2002:a05:6a00:1481:b029:197:fc39:f646 with SMTP id v1-20020a056a001481b0290197fc39f646mr44458467pfu.57.1609743696095;
        Sun, 03 Jan 2021 23:01:36 -0800 (PST)
Received: from localhost.localdomain ([240e:b1:e401:3::6])
        by smtp.gmail.com with ESMTPSA id v1sm36306648pga.63.2021.01.03.23.01.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:01:35 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/6] hugetlbfs: fix cannot migrate the fallocated HugeTLB page
Date:   Mon,  4 Jan 2021 14:58:39 +0800
Message-Id: <20210104065843.5658-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210104065843.5658-1-songmuchun@bytedance.com>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we only can isolate a active page via isolate_huge_page()
and hugetlbfs_fallocate() forget to mark it as active, we cannot
isolate and migrate those pages.

Fixes: 70c3547e36f5 (hugetlbfs: add hugetlbfs_fallocate())
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/hugetlbfs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b5c109703daa..2aceb085d202 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -737,10 +737,11 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 		/*
 		 * unlock_page because locked by add_to_page_cache()
-		 * page_put due to reference from alloc_huge_page()
+		 * put_page() (which is in the putback_active_hugepage())
+		 * due to reference from alloc_huge_page()
 		 */
 		unlock_page(page);
-		put_page(page);
+		putback_active_hugepage(page);
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
-- 
2.11.0

