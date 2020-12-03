Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8C2CCAD5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgLCAEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727536AbgLCAEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606953760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5DH0t8qqaEn3RqUMO5KivnbVKgQ9Z9+5Q+gHm3Vh9Tw=;
        b=Vs1OZRrHBr0DmWHtswqw0hdfydg4vOswOGeJbOyAIBowDtnc5tJOZAANZHXf3bAiuULPmh
        nui5VFUWyaZpnO0uToe2zrNyjUkOmrSDy3tYeXsVSjyu2Hyv7gQBC2yR7XiJzslvCIZU3c
        gMgH6y/EVKSj6bBZ2tsldqG2wci2p4w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-9f7CXbwgNq-txd-wPO_KuA-1; Wed, 02 Dec 2020 19:02:38 -0500
X-MC-Unique: 9f7CXbwgNq-txd-wPO_KuA-1
Received: by mail-qt1-f199.google.com with SMTP id x62so172730qtd.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 16:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DH0t8qqaEn3RqUMO5KivnbVKgQ9Z9+5Q+gHm3Vh9Tw=;
        b=W0fATMAgopqym9IWvbhdcT/hmpDlpLvSsMQWMx3ULKLZSwrgqo2HgNug242FEnfVxa
         YDqcTLtsxankZCgfoHfmKFQyoJJonBCRjf3PW2CfxatTsAJCI8M07HQgNo9UmyZN+7x3
         3kK9qwFpDkAbIFmXraOAHws0eaUMqxCH7bnIuxV7NuZJJCgI7AQ3NxCvHeDQSg4XnujX
         4BOQ9bav2UnGRJsm1n5bMn4G0UbI/G1CaSKQUGImSafWlVZwnqeiXM4y1dnwnoivfSXP
         l74BSVPyF0+E9Xj8VNZtdpMBSrAizaEjvwyHcQ27KU1MkSWqO4qyZChdj325ChUeFcxJ
         64dg==
X-Gm-Message-State: AOAM533NMmCTKacFQv0zXNGe/htMWM26l1FenrBVnUpkCTCmcEGh6Ea/
        5Z/4iqe4HzKtxF0wOxhxF9T2VL1ODAjlJI5YuV8+S3BpCWPuF2Ip7djQR4geBh3qhgf2Fmvj3tb
        DbLEBmJ0EMZRh4njFn86uvcJ+
X-Received: by 2002:ae9:de03:: with SMTP id s3mr368150qkf.218.1606953757241;
        Wed, 02 Dec 2020 16:02:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk/AL4kcxqZ1ogOOJxv1t1HGunHRRWZ5UdQ0lVVre8JW7SManmMIHEc30+Z/HknHhrJOet2A==
X-Received: by 2002:ae9:de03:: with SMTP id s3mr368133qkf.218.1606953757014;
        Wed, 02 Dec 2020 16:02:37 -0800 (PST)
Received: from dev.jcline.org ([2605:a601:a638:b301:9966:d978:493:6a3d])
        by smtp.gmail.com with ESMTPSA id y3sm222428qkl.110.2020.12.02.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 16:02:35 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH] drm/nouveau: avoid a use-after-free when BO init fails
Date:   Wed,  2 Dec 2020 19:02:20 -0500
Message-Id: <20201203000220.18238-1-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau_bo_init() is backed by ttm_bo_init() and ferries its return code
back to the caller. On failures, ttm_bo_init() invokes the provided
destructor which should de-initialize and free the memory.

Thus, when nouveau_bo_init() returns an error the gem object has already
been released and the memory freed by nouveau_bo_del_ttm().

Fixes: 019cbd4a4feb ("drm/nouveau: Initialize GEM object before TTM object")
Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 787d05eefd9c..d30157cc7169 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -211,10 +211,8 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int align, uint32_t domain,
 	}
 
 	ret = nouveau_bo_init(nvbo, size, align, domain, NULL, NULL);
-	if (ret) {
-		nouveau_bo_ref(NULL, &nvbo);
+	if (ret)
 		return ret;
-	}
 
 	/* we restrict allowed domains on nv50+ to only the types
 	 * that were requested at creation time.  not possibly on
-- 
2.28.0

