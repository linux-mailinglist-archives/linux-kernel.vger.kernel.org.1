Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1227A2E1997
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgLWIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgLWIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:04:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F74C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:04:05 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id s21so9899252pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YwhKeQ95NsQxO4i1B4M2YvP1DI+YaSx95x3VhWlw4c0=;
        b=Z3p9ls8iU7RsPuqa6E0pHKrw+VfFahKvI/G4pCscJDgbZD3I7rVQe4mY4hVO4k2P4B
         ltT6ecB0vN9YE3JcXLuhsbtB826TEKOYWlE2QYC7ah8pld+3MGvaNa8fOGjdnpelC5Z+
         1p8ipojt0lDJeBVCq1oPg5Or+WPyLlsu5PbtGSjdZ3w71UZa7AAPemC1GAtAvtyw4J16
         Eso7rJ9xlH61h1rY5eZrVSM2vlgZNx3w1kLwRDbPHOYy1cRcH/11W+PyuXIeurEnime3
         uo9Yz0Ng0muKjkxb3cmyitn8I/RGln+wot+TEeazojATMxzCh8BBfXaOVzQePegh4He/
         a9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YwhKeQ95NsQxO4i1B4M2YvP1DI+YaSx95x3VhWlw4c0=;
        b=s4GGqjQNZ5U68Ht90fryJDmFlJYSWAfMuAte+68ORAD82DlLYVfXYSI3GEbynZCSvr
         4Ry6YGM5A5vjoP11JYQ+FBgdhkriyJfirr0LDT1y+j6HymQ6T+AGPxYE/g3eS5PG0jkf
         rt1RE/cTXqjjSkBk5ACNICcCWCZpVtzzowtiM+gDg2Ks9vLQ1UCHkA8PBsb6WSt8eyg4
         rUVTrvhwda+OJREXggXAOQi2yoi1CSXH7QUt9s/HczgaF62IHcq8sHMxxsEwbDeTmo9c
         ylkVUtkElgsQDUq0SBhwd2vdqHpIOMNe/ZBb79Jt8PwevbH3NwJsPysNe/vCxT32uymB
         ZZsw==
X-Gm-Message-State: AOAM532W7YkLy9OHC3hIgZah2COpCt4y1nE9L2mZYFVoKdwmtCE/LSfC
        y98B4AeDQpKIndfIXOrjJzwhEvCLK0T7EA==
X-Google-Smtp-Source: ABdhPJym+vMqd6iwnr4LOe1QbzeKgsfM8RMzZvjWO1mt7guqxTu6K3LZTyO/2YtpSyRGzypACKxcbw==
X-Received: by 2002:a63:4c4b:: with SMTP id m11mr23409784pgl.20.1608710644608;
        Wed, 23 Dec 2020 00:04:04 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id iq3sm21735654pjb.57.2020.12.23.00.04.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2020 00:04:04 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, nirmoy.das@amd.com,
        luben.tuikov@amd.com, Hawking.Zhang@amd.com, le.ma@amd.com,
        yejune.deng@gmail.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: kref_put() may not require a lock.
Date:   Wed, 23 Dec 2020 16:03:54 +0800
Message-Id: <1608710634-5118-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kref_put() can be outside of mutex_lock(),and use amdgpu_ctx_put()
instead of kref_put().

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0350205..af26ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -282,6 +282,15 @@ static void amdgpu_ctx_do_release(struct kref *ref)
 	amdgpu_ctx_fini(ref);
 }
 
+int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
+{
+	if (ctx == NULL)
+		return -EINVAL;
+
+	kref_put(&ctx->refcount, amdgpu_ctx_do_release);
+	return 0;
+}
+
 static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 {
 	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
@@ -289,10 +298,9 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 
 	mutex_lock(&mgr->lock);
 	ctx = idr_remove(&mgr->ctx_handles, id);
-	if (ctx)
-		kref_put(&ctx->refcount, amdgpu_ctx_do_release);
 	mutex_unlock(&mgr->lock);
-	return ctx ? 0 : -EINVAL;
+
+	return amdgpu_ctx_put(ctx);
 }
 
 static int amdgpu_ctx_query(struct amdgpu_device *adev,
@@ -439,15 +447,6 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
 	return ctx;
 }
 
-int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
-{
-	if (ctx == NULL)
-		return -EINVAL;
-
-	kref_put(&ctx->refcount, amdgpu_ctx_do_release);
-	return 0;
-}
-
 void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
 			  struct drm_sched_entity *entity,
 			  struct dma_fence *fence, uint64_t *handle)
-- 
1.9.1

