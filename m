Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95FE2FA745
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406872AbhARRSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:18:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406481AbhARRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610990170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zPWPbpxZWQ8Q/hCVXbr12g2BZoHJDH3rLZiVqLyNR4s=;
        b=MyQNU040wOqucv8mouNi+uMPmNm7HQbrz3h+d2LFTq3fhNgh8Ea9cSDnqsomMHM/kUPD36
        BTaRrm3bp1PG7N/PP2fNvtL5/j9scilA9rek0+7y8RfSyLOwQ6PvcsRD8urilHamYSQy2i
        EUzj7Sj7gFebrcBSRhF0IuLjNHIG9vY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-FVcoIIAdPe2XvyW9Q0IBWw-1; Mon, 18 Jan 2021 12:16:08 -0500
X-MC-Unique: FVcoIIAdPe2XvyW9Q0IBWw-1
Received: by mail-ed1-f72.google.com with SMTP id f21so7854684edx.23
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPWPbpxZWQ8Q/hCVXbr12g2BZoHJDH3rLZiVqLyNR4s=;
        b=TsvEr5IdAKE8TcclhAt3YpN0hy08npLUVfFSWlx7mGcli9VUSDycLnJ+7XRsYLIumO
         SEhywX9fhCvm31ZBJu6YNVmSDflBczX+8GSeQMva6cIAbZ9MWdPNYQzcuQVRV9B9flh8
         f2evkwgZ4H6oUKIJCAfpbaa0COXfE5OnO9eP+jwveJ682ODkvQxE43FhGgrXZHW6PhYy
         WTwR7cGU1gOu25/0dztZXHCtp8a8ccSR0CiqfGmMPs6Kh+HKg3GuMNZATYEj1HK561MD
         TpiW8f5KSZSRVEp3mxnFIviUA2NJNAQYDm+aGmEffZ1cvM1etLbR3XKSxhHYL6UL6Jez
         fS8g==
X-Gm-Message-State: AOAM5330EBNRJurTXVFvU7OZnEvgorjywIklWhZL6o9FsXoNWZg/KnPO
        SgRkCKDiOXOreAqertsn7BvQH7MQtCEPo0tyHKyHjvuMDuxAXu5vUnpHg9CTd3zElKmV3Bq5sqr
        WcFQv9+smEdKIir9b9ik0THhNotuo6sC2nqmmQM9Cw7Y0QfPLhkH4QcGwp+e1rg04uL4cYKBlsE
        4=
X-Received: by 2002:aa7:cb10:: with SMTP id s16mr383923edt.304.1610990167339;
        Mon, 18 Jan 2021 09:16:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEjn0yaOyT8VeVvxbTFfawWNsNOlofn2pYeeSMukmaS0N7WcyAgfAevbwrdw8SfatYeJqpwg==
X-Received: by 2002:aa7:cb10:: with SMTP id s16mr383903edt.304.1610990167154;
        Mon, 18 Jan 2021 09:16:07 -0800 (PST)
Received: from kherbst.pingu.com ([2a02:8108:3d3f:f97c:65d6:8fd9:2fe5:eed])
        by smtp.gmail.com with ESMTPSA id n3sm5152323ejd.85.2021.01.18.09.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 09:16:06 -0800 (PST)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH] drm/nouveau/svm: fail NOUVEAU_SVM_INIT ioctl on unsupported devices
Date:   Mon, 18 Jan 2021 18:16:06 +0100
Message-Id: <20210118171606.2055109-1-kherbst@redhat.com>
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

