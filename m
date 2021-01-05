Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E462EA198
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbhAEAsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbhAEAsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:48:10 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF00C061795
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:47:30 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j1so15466437pld.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=hlRh4oR4QpLbEXotkI1bQimJOvMdeHexVCVFkFuCov0=;
        b=ZMoH+a2ePM+uJsxc+YHEYLkWcEvr4qyDvp5ohbqQyYbYXXynBDpPY82/Px5C/Dw2wb
         xYqbaibeqzwww9zQ/+O7PmNK0RAqEfsd9pnR/BGI2ZJfVfPDOz/NksKp0A9f2LMm9w8y
         Hqc9Z01kAVMRFkhwD8tApswEHcq02b5hSf4VVtOtYk49NHvc4CUG/06KkMTIcVJEDOHs
         XmGUydo1Qv1ATaKGJenVulX6tGT+qGlIs6/jab1HIlWtxoB6049FjkGTRw3EfcYknPn6
         0MoOWptCqv0NusJjLOFGGduN7UU01Lk/LtxbNzQF6dd9uMDW92A+5OxJ9QxcuGQYR6ak
         tQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=hlRh4oR4QpLbEXotkI1bQimJOvMdeHexVCVFkFuCov0=;
        b=GL9wpRKzYiEYKJGurP70yhBd2rqgVxJ94ze0iVUTxn2JNgHAjG3wEu2EzDABI/qJG/
         Iykz9ogctvNREKRKEx6AgKfIuBJi4BLfVcNDVuQLyQ+829jKtsCDH4Ratz3P4xsgBp5w
         ohZKak/DXVdTHe+fTfSRC7P8D0pNyH6euNki0RMlpNIycxrxpEEp20oPg9HlG6JoFav5
         SrBX2m8V/C0hPIRuzH/TcZA3Jg4zA6zHYotfJToQ97vkXjXwiMHHYeV3ONwjs4CCthIA
         U10OAowBLj8xAn+UTg+VnIjSgD7KCIh+X0rGS7pFMVcMvz8Bjvi+oqXrz+OnGKtUzBtK
         V/kQ==
X-Gm-Message-State: AOAM533u+hkoKzN+ZXDpW+oy0YaAWqH/WDnrJKBbvjUJXgu1jDqFUH6q
        IBkbW7WoPWARuL8Icj9Ryh4=
X-Google-Smtp-Source: ABdhPJw9PEqwAhVUYHWm5Lr1VgNwOZcwQSPBYRTxhR3LPWVjFWZ1theobGWAhkG9EVtZ8+jSvO4jeA==
X-Received: by 2002:a17:90a:49c5:: with SMTP id l5mr1475905pjm.116.1609807649994;
        Mon, 04 Jan 2021 16:47:29 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p21sm56310706pfn.15.2021.01.04.16.47.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 16:47:29 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: amend SLAB_RECLAIM_ACCOUNT on gfs2 related slab cache
Date:   Tue,  5 Jan 2021 08:47:22 +0800
Message-Id: <1609807642-31552-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

As gfs2_quotad_cachep and gfs2_glock_cachep have registered
the shrinker, amending SLAB_RECLAIM_ACCOUNT when creating
them, which make the slab acount to be presiced.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: add gfs2_glock_cachep for same operation
---
---
 fs/gfs2/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 136484e..23144a7 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -100,7 +100,7 @@ static int __init init_gfs2_fs(void)
 	error = -ENOMEM;
 	gfs2_glock_cachep = kmem_cache_create("gfs2_glock",
 					      sizeof(struct gfs2_glock),
-					      0, 0,
+					      0, SLAB_RECLAIM_ACCOUNT,
 					      gfs2_init_glock_once);
 	if (!gfs2_glock_cachep)
 		goto fail_cachep1;
@@ -136,7 +136,7 @@ static int __init init_gfs2_fs(void)
 
 	gfs2_quotad_cachep = kmem_cache_create("gfs2_quotad",
 					       sizeof(struct gfs2_quota_data),
-					       0, 0, NULL);
+					       0, SLAB_RECLAIM_ACCOUNT, NULL);
 	if (!gfs2_quotad_cachep)
 		goto fail_cachep6;
 
-- 
1.9.1

