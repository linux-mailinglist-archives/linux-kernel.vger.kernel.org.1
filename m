Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027362A8505
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbgKERg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKERgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:36:55 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:36:55 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id s35so326373pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NKcLFiU6H4GCkdzhjrWYozH3+gc+OUwyZmQoL2qAyo4=;
        b=jI1WCZDJ6CthwcncnI2OsCn26dz8xinJlftWX3aG62O94VRWOdr6u3XNHojmtHVy0S
         1Qt6j0/CWQiEfjtJjpnGz2F+zzrnNx/DzA93SZkKLUONE4gYvUYTqiU8C7SKBCLVGyZK
         GH4ZDDqKAiKdpfPp4swZAGqK7nBJeSfCHYz3HaKxfC/iOsLOa9630qMv7Ew8sKoxd96G
         MCMODi19AYzXkpitAvtHk5TLN7eV/DeJlWARbgcwdv7pt1DShA9J4KRWYmYH/ABu00MK
         FS37X4SkIU5fSDeuoSLP5TdNtJlabrG2Yj9XoDdv4rJMwPyHr4vUroek/LeznmSr71z7
         Iozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NKcLFiU6H4GCkdzhjrWYozH3+gc+OUwyZmQoL2qAyo4=;
        b=mDus7OY7PzqoSGSQe4WaU+cI/SUlyUUDia8pGbh8Q2C+JTv/aewFKk9asaWf/TDhIQ
         9zbNJhlcgxlCsz/0yUUcMMT0M9Dg/Y06jgXsnt8Ktif6TTqO6khO1JjFULiC5k6dAydU
         WHodM+JFZVia/mgz0K0rOicSNXmnW0ZEvAIX7Jr40QrLLbJPPnPLIG/8DRoWaHTtcJf7
         izVIv/Oy7x81nkyWp89JNyx3+OpBlQhUfbjaAqoofz2+63ZLtHTKBju1cmrHQ0t8XAB5
         VMl968wwfBxh5xZE3UmnL1/ZNE4/A90b0MWSwfEA2NDLx9UB4eONeM9rvvDY14PEq3pS
         RH/Q==
X-Gm-Message-State: AOAM532jiF1aIFYTMxpGJQSfIV1iyLjETzZY3SEvc70ft4SiA8m8jH43
        3DlAjxudwXzbLGsaM3AZEcGXiV3hrAo=
X-Google-Smtp-Source: ABdhPJwf33qw/yGX0h0BuGDoO5yxwO6nzn2tEG/Or9w+aOg3/nSsSG5F7fQP4eVquvLQ8O0/FWoc/g==
X-Received: by 2002:a17:902:b410:b029:d6:b42c:7af9 with SMTP id x16-20020a170902b410b02900d6b42c7af9mr3396359plr.21.1604597815142;
        Thu, 05 Nov 2020 09:36:55 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id u5sm584940pgj.28.2020.11.05.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:36:54 -0800 (PST)
Date:   Thu, 5 Nov 2020 23:06:46 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, intel-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/vgem: replace idr_init() by idr_init_base()
Message-ID: <20201105173646.GA41732@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init() uses base 0 which is an invalid identifier. The new function
idr_init_base allows IDR to set the ID lookup from base 1. This avoids
all lookups that otherwise starts from 0 since 0 is always unused.

References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
Changes since v1:
   - Changes suggested by Daniel Vetter:
     1. Correct typo in patch summary
     2. cc intel-gfx to get the patch through CI bot test

 drivers/gpu/drm/vgem/vgem_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index 17f32f550dd9..2902dc6e64fa 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -233,7 +233,7 @@ int vgem_fence_signal_ioctl(struct drm_device *dev,
 int vgem_fence_open(struct vgem_file *vfile)
 {
 	mutex_init(&vfile->fence_mutex);
-	idr_init(&vfile->fence_idr);
+	idr_init_base(&vfile->fence_idr, 1);
 
 	return 0;
 }
-- 
2.25.1

