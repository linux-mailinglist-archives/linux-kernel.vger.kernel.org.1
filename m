Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241A92F83F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbhAOSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388650AbhAOSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:18:08 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88613C0617BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k10so8220798wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+QQ91dB4nAV9iX95BjLXpaQb9N2TCvRIGQTNY+K7sU=;
        b=yL85iXlSpJyIEsW9uR5KjI1ME5UqZGtzQv4FY99XBi+FD088mPsLJUgEUFKevvrlE9
         ksl9DXvhysqqBdDc7ZadLjyb25WhWQ3i98QOp0XqAdIZxIWspprCXgzshIS98HW4wMGh
         I+dGjog07idrdB7GQ459SKQnXFCQ4I9gK+KFnSmHEK1XhiM5kcv9UoCyCxCQC61JS0ll
         ++XOFxnTRs1eBVYdPEs8eE+RG4iiu7oN+whS/TdHU+B6/+ipOqkC164lqBL+udM5S+Pe
         D+5z0HQ/r2jtn0PRy9nwsj2+X61EY1IqPKGMyzXLvzaeE1LhdUG1dXwChy5gE9CV1QlA
         lmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+QQ91dB4nAV9iX95BjLXpaQb9N2TCvRIGQTNY+K7sU=;
        b=Bhr3uoe97FSDqezm/kGoTgbyrsIQ3nEur5k8XD81mF1wh8hONQA52h0DrLem/FnzNk
         qagI4r56+Tlq0aNa5v/e+bohy05OhHGw+jFt/5QgF3Opp00ciSQv5mL8nhbMM+7DuQTC
         xEQqWPFyUva3YSCYvN7jHTM64LRdxJ46cbN3HcF/o1szUBNwF9ZFmDh9XvI39AJIRzrg
         /Xmijc4ybbiB661WCzhI5BMg7K67fN0jl/gBBil7cdHKYXk4PBe9ojg5ZD9/OXITrWXa
         AqAPe3+jbx9K04UPa2/qDNERWMTv90aTfcK1WmTv7BoNYOgRhx/AGVRg4G+DpAIqkQUd
         qzdQ==
X-Gm-Message-State: AOAM532g9B1Tccj6AgP3mjY7ljHONN7u5nYeLZMcnkSNUIQcp1/5bmPr
        WSCukFwNbCQaeUjV5o44d8W12A==
X-Google-Smtp-Source: ABdhPJwD+S7K+2xo6XGPzpZWOm/R/Wcr70/IAr4BByEl7I7vZ/Ps4PA7dJVttdYLp/fDi5wADTpg5g==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr2838766wma.6.1610734603340;
        Fri, 15 Jan 2021 10:16:43 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 27/29] drm/nouveau/nouveau_bios: Remove unused variable 'pdev' from 'nouveau_bios_init()'
Date:   Fri, 15 Jan 2021 18:15:59 +0000
Message-Id: <20210115181601.3432599-28-lee.jones@linaro.org>
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

 drivers/gpu/drm/nouveau/nouveau_bios.c: In function ‘nouveau_bios_init’:
 drivers/gpu/drm/nouveau/nouveau_bios.c:2086:18: warning: variable ‘pdev’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_bios.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index 7cc683b8dc7a6..e8c445eb11004 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -2083,13 +2083,11 @@ nouveau_bios_init(struct drm_device *dev)
 {
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nvbios *bios = &drm->vbios;
-	struct pci_dev *pdev;
 	int ret;
 
 	/* only relevant for PCI devices */
 	if (!dev_is_pci(dev->dev))
 		return 0;
-	pdev = to_pci_dev(dev->dev);
 
 	if (!NVInitVBIOS(dev))
 		return -ENODEV;
-- 
2.25.1

