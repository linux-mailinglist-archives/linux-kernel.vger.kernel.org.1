Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36B82E33F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 04:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgL1Dkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 22:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgL1Dks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 22:40:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43B0C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 19:40:07 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j1so5044303pld.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 19:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=9ZsnfsGx/6gHWwdeAQR/Y1wC6ZOL+ifFY18pxrPRUEw=;
        b=A9mbgVpvoxv7dwRg8HojV/1OGTzSMg2bvoHDpRg4SmiOCnsvLG/CpH+yFGG8Oqebcs
         4+oJK0qj9hd3wYueeoHrAtyNHgKk0wEgl3z9TaXqts/+JetP5976x86f3dJTP9+yI692
         MzjIhUKQcYOtKhc01hWFcOa4z7Gm+hWS83yX4t+iPQF7voLmQwJaNYj75ilaOJZP+3UN
         PZzgWEzc6GLxOy7LDoxdf/fRC4sgAs3UVClgIWuG/1uwJeOYrj2lqwdYt9wxrA3oAQD8
         2kaayrY6dt0ZpQ1udHtX447iOq6hE6TUIrQLZAwO0eLOjyH5PUco73xMCBag2twhkkjF
         uTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=9ZsnfsGx/6gHWwdeAQR/Y1wC6ZOL+ifFY18pxrPRUEw=;
        b=MzZbBeBv2usSsOar2YUowe04YGUd694DNbSn3VOosvVcGtath4YNoZ72qqN1d64j5E
         aWi05dOsg34n+w0vYOAPdi/BxBqrqc7wLohjxIXOUkS69BluVds1D0YoM3XZGk0I9l8i
         gguStkX9k5rd50rAOdLa2bwoh/A3bqWXRzKJPRGlLuiqL5YyGGYS296R4aN9B6/RXT+s
         aVnqK58NwBugpWqn/lmucVowc3IOi2iK2CwB7cDl0EA5oilC3I6ldcmF3syPs2R1jxLu
         tBXx3gnJMLekHyBdEhEiScHOawXSU/H5/P2vkDSTWb1XpJe0/91t2zEHYlmPqAVxsboK
         FWHQ==
X-Gm-Message-State: AOAM532HxSdX6/NyDmsny/OY+qNgX0J4pIibz+ALPrw1L7E1J1VoTehY
        2+FNEXWw++DEFMo3gWiNU7Y=
X-Google-Smtp-Source: ABdhPJwrxI3bvYN86x7BwRmVUvO2jrAglTpnL7ojzNKFZOjZxuj4wK4wp+4ucbPH4OVERWdSpFRJsA==
X-Received: by 2002:a17:90b:203:: with SMTP id fy3mr19546124pjb.231.1609126807161;
        Sun, 27 Dec 2020 19:40:07 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 5sm34320527pff.125.2020.12.27.19.40.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Dec 2020 19:40:06 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: amend SLAB_RECLAIM_ACCOUNT on gfs2_quotad_cachep
Date:   Mon, 28 Dec 2020 11:40:00 +0800
Message-Id: <1609126800-19953-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

As gfs2_quotad_cachep has registered the shrinker, amending
SLAB_RECLAIM_ACCOUNT when create gfs2_quotad_cachep, which
make the slab acount to be presiced.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/gfs2/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 136484e..db39de9 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -136,7 +136,7 @@ static int __init init_gfs2_fs(void)
 
 	gfs2_quotad_cachep = kmem_cache_create("gfs2_quotad",
 					       sizeof(struct gfs2_quota_data),
-					       0, 0, NULL);
+					       0, SLAB_RECLAIM_ACCOUNT, NULL);
 	if (!gfs2_quotad_cachep)
 		goto fail_cachep6;
 
-- 
1.9.1

