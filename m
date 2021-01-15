Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50C12F83F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbhAOSTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388567AbhAOSRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:43 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4C4C0617BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 190so8232519wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdXKnDa6lvIb811vAIyU+syK3ZIQA1yBtXwMvcVTZ1I=;
        b=NQSMyoh8n63rM3uQJJJSde6hMFXcBhFL3jjHN2XG3bUDERwDZuGBn6aChRJvncceeY
         Nl1812QytdqWcMvSlIWSZs3R/Dee0ZfLy+TxyNAcZlqt6u3FC25PoPHIIpzxaW3Etaew
         Je9/kvEYITSeRo+yfUIOy7BxqSCKpBZf6t8yfDvYcGiqz0B0zS6dHCvl6gyJtydwQxOH
         OtO89GlReKUeFDHPErBHe2G1TQ6xlV1T8MAB2twrcAPKywjZ5rSkCRwMMuD9WwvGjlNX
         NeHbSKC+bRET3FbGuC79UjlPm8Kydr/Uvx+Cp2uLfDQTA7IU/vKzsW39bEFUhAqIl9Gm
         cxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdXKnDa6lvIb811vAIyU+syK3ZIQA1yBtXwMvcVTZ1I=;
        b=RaNmWX9iV1o0xurZh2BLmycDQBcOk/N6v2+IvQxoJuJ0N25D1VFqHyTXnzRAMBIh4b
         mQ8B0QJTh693t22R7n7qzHYtM5ypGjh334LF8/iCtLdcwz1gx12IiP/Fhcl+8iX6ZM/x
         BuUE4WoP1wFTh/8ZYmyrdJOCCQ6T0qcSaSDyGuGqF2bQ3kTT32Sjk1MLRJ4XY/KE8kjj
         T/btnvx3IhV/wyS3sz5vknMcwzq0u/lleXVpS3O/4Mg8XV+dYzBvPtc3qG1XSigKns+H
         2sbKzZZGk+RJTSQIXU3JnH8GD/QugL4PH3aCjujKcqcU7uCRknm99dmExIne9zMhajYT
         TVfQ==
X-Gm-Message-State: AOAM532Lfvvc8UYnGabkYMRFzbrUZga/oXu7HxC3zetgF3+xcjNCWIeM
        WpHHssRlYILT5AMepPbKDdBBrQ==
X-Google-Smtp-Source: ABdhPJx4NtGILv95iDZVo/kBmSY+uqOCH7ceKa8UeLHrPa4hZE9zW2fYatEf47XO+P2w6X6gSd5LyA==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr9753170wme.11.1610734602115;
        Fri, 15 Jan 2021 10:16:42 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 26/29] drm/nouveau/nouveau_svm: Remove unused variable 'ret' from void function
Date:   Fri, 15 Jan 2021 18:15:58 +0000
Message-Id: <20210115181601.3432599-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_svm.c: In function ‘nouveau_pfns_map’:
 drivers/gpu/drm/nouveau/nouveau_svm.c:810:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 4f69e4c3dafde..84c5bf53fe967 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -807,7 +807,6 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 		 unsigned long addr, u64 *pfns, unsigned long npages)
 {
 	struct nouveau_pfnmap_args *args = nouveau_pfns_to_args(pfns);
-	int ret;
 
 	args->p.addr = addr;
 	args->p.size = npages << PAGE_SHIFT;
@@ -815,8 +814,8 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 	mutex_lock(&svmm->mutex);
 
 	svmm->vmm->vmm.object.client->super = true;
-	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
-				npages * sizeof(args->p.phys[0]), NULL);
+	nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
+			  npages * sizeof(args->p.phys[0]), NULL);
 	svmm->vmm->vmm.object.client->super = false;
 
 	mutex_unlock(&svmm->mutex);
-- 
2.25.1

