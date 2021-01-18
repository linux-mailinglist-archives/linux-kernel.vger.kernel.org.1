Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680662FA73E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407038AbhARRQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406956AbhARRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610990033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zPWPbpxZWQ8Q/hCVXbr12g2BZoHJDH3rLZiVqLyNR4s=;
        b=TSFWgb4YRv+0ARlBogCSgoCzR4gk2qGnQDUoomf1nCfJan7JSBCzp1p/OF5Fyr4pjEaTpd
        UJoL1lmcCRcGtbZs7zZM+9Lr0eExdqAm9WccucwnCVh9RFRgTq2L7j2b1V8hD9uC+Vgv4z
        Haayh1I6Kk9JtfuAElxFP3UChaAn2LQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-CkabUPLpMdumkNK9YORFNQ-1; Mon, 18 Jan 2021 12:13:52 -0500
X-MC-Unique: CkabUPLpMdumkNK9YORFNQ-1
Received: by mail-ed1-f69.google.com with SMTP id f19so8105434edq.20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPWPbpxZWQ8Q/hCVXbr12g2BZoHJDH3rLZiVqLyNR4s=;
        b=T6CEpidVkvM0B5J3VrVRx1D9fWOxMbPpECEWHQtw7sasDvHBMQwYCQTTyFdNyfeYeW
         HgFD92It3hGRd85AFMoDyAcvBPJxVPdKCGwA4K3dyffqiscSuABfxc7bvI4przIAM0ZO
         L8C0VqeljteKzOTkK/QnvJZA4HLY3BpNyqmVxvF4+0X0Rbdvxpi7GTQv2XRIkSM3qGCB
         2HEHinQCRQPtz32hAxVjIku3mvHm2a26ZXlkb9CJe3CHTTKVe2qnJQsb82buy3de9EPf
         +IwGe3OUI/7bOYKMDkR9AbfZp/3V2P0ilU/6+2uukQdZOp+LjeSJ6e7+SrLT9uiYGSf5
         bCCg==
X-Gm-Message-State: AOAM532DZ4etkyTWqY2CL8a1D3sXfZkttRgCceB5BJTa5ejKgdbds+s0
        ogc0eJcu3JoLENde+ylhiFfH4Nd/ladIQATpURPTReq152BZkHbySOx5t9sLYywexBTwho8Bj0N
        xSUmgmoULjTRjqqPo8G1rif2SZqStZobAfKnWHniH95hGfGWqfF8Rl61/YsnTbwdeQu3TXth8ed
        8=
X-Received: by 2002:a50:ef04:: with SMTP id m4mr342204eds.283.1610990030856;
        Mon, 18 Jan 2021 09:13:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoj1e6TAGfavAW61fVh95F7eCJo8dz9I2P4799nex8prpjvxVLKTzylFJOQiCPtugh+B7R1w==
X-Received: by 2002:a50:ef04:: with SMTP id m4mr342188eds.283.1610990030608;
        Mon, 18 Jan 2021 09:13:50 -0800 (PST)
Received: from kherbst.pingu.com ([2a02:8108:3d3f:f97c:65d6:8fd9:2fe5:eed])
        by smtp.gmail.com with ESMTPSA id de4sm3126429edb.38.2021.01.18.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 09:13:50 -0800 (PST)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>
Subject: [PATCH] drm/nouveau/svm: fail NOUVEAU_SVM_INIT ioctl on unsupported devices
Date:   Mon, 18 Jan 2021 18:13:46 +0100
Message-Id: <20210118171346.2053021-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a crash when trying to create a channel on e.g. Turing GPUs when
NOUVEAU_SVM_INIT was called before.

Fixes: eeaf06ac1a558 ("drm/nouveau/svm: initial support for shared virtual memory")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 4f69e4c3dafd..1c3f890377d2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -315,6 +315,10 @@ nouveau_svmm_init(struct drm_device *dev, void *data,
 	struct drm_nouveau_svm_init *args = data;
 	int ret;
 
+	/* We need to fail if svm is disabled */
+	if (!cli->drm->svm)
+		return -ENOSYS;
+
 	/* Allocate tracking for SVM-enabled VMM. */
 	if (!(svmm = kzalloc(sizeof(*svmm), GFP_KERNEL)))
 		return -ENOMEM;
-- 
2.29.2

