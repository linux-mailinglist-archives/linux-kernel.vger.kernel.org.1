Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA782A5073
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgKCTtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:49:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729792AbgKCTtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604432988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fICmVdTj2/Fz/bKsy3AdpD02+6wD2mrXceXnjGzICc=;
        b=VoUqIoqmvM4QGwr/lAJ87SW4LoLol4ObeIQZeju/5C7SzGkKoJGXSInxwJ/Ut/kpKDeaGy
        0tjKpqJGCz8spvrk3LZBy2+2qSQRF1HIpUBnzJj+PbCiWmwaJJw4/fgsUjCiPrtJLa1zDD
        hgR9Jh9Eqx+pH3ViCv6bv1R5L62MLPs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-HQe3VxOHN-yhGnH391Kt8w-1; Tue, 03 Nov 2020 14:49:44 -0500
X-MC-Unique: HQe3VxOHN-yhGnH391Kt8w-1
Received: by mail-qk1-f199.google.com with SMTP id i2so11596500qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 11:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fICmVdTj2/Fz/bKsy3AdpD02+6wD2mrXceXnjGzICc=;
        b=jzqLr7iGq7D0gbx+dXFrSlIr6MNN8j0b2a4eQFREc4bV/pV0Q00CfKz6K9uM1TBY/5
         WP59PuuysVuOFrdtqultcxItkSsTJC/fRQVd8VKMPeGrB1wvZvJj2VSvZmg5RlyVF3Ip
         Pyh38hrkN8nBJdwPqyVtcP5F5Y2m+o/CpBjaZr10ZH0XKGJvJvjYuP469OztQlpX3Ita
         lSIgs/LFicL9x5JIIC3avyWs+8UjmxfcFBi8kXBNjNjMOkc86sa/PbiukJ8e8sAAJABO
         rNude5YDYhKxqfgSKAo90Q+9F0HPCz6cY9B4G2c3SJpC/kZRV+NAtt8Ia8Xd5akJAzjh
         J0Mw==
X-Gm-Message-State: AOAM531Xto3AMrpL/BEE5Ic/nz9mqSMNEUrOP7sCxQd14fGcoH4mI0gE
        s9LQqqZiDqaorizG38daE1n275rRR4gd8rAhdRXiE5TIahqk1sN9ybK5hhkb00nwFC6OBaQLnOZ
        4z4FKVr9Q0/ehbsXnHGFkww5k
X-Received: by 2002:ae9:efc7:: with SMTP id d190mr21846432qkg.12.1604432984330;
        Tue, 03 Nov 2020 11:49:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzFFaYIUOW0IiB6homeuWdNgciqo19z+13u9SaE5afk4jLCu8F41CBfMJHpE2CaxDZW7FAQQ==
X-Received: by 2002:ae9:efc7:: with SMTP id d190mr21846412qkg.12.1604432984080;
        Tue, 03 Nov 2020 11:49:44 -0800 (PST)
Received: from xps13.redhat.com ([2605:a601:a639:f01:1ac8:8e0c:f1cc:7a29])
        by smtp.gmail.com with ESMTPSA id w25sm11392532qkj.85.2020.11.03.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 11:49:43 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 2/3] drm/nouveau: Add a dedicated mutex for the clients list
Date:   Tue,  3 Nov 2020 14:49:11 -0500
Message-Id: <20201103194912.184413-3-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103194912.184413-1-jcline@redhat.com>
References: <20201103194912.184413-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than protecting the nouveau_drm clients list with the lock within
the "client" nouveau_cli, add a dedicated lock to serialize access to
the list. This is both clearer and necessary to avoid lockdep being
upset with us when we need to iterate through all the clients in the
list and potentially lock their mutex, which is the same class as the
lock protecting the entire list.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 9 +++++----
 drivers/gpu/drm/nouveau/nouveau_drv.h | 5 +++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 4fe4d664c5f2..d182b877258a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -557,6 +557,7 @@ nouveau_drm_device_init(struct drm_device *dev)
 		nvkm_dbgopt(nouveau_debug, "DRM");
 
 	INIT_LIST_HEAD(&drm->clients);
+	mutex_init(&drm->clients_lock);
 	spin_lock_init(&drm->tile.lock);
 
 	/* workaround an odd issue on nvc1 by disabling the device's
@@ -1089,9 +1090,9 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file *fpriv)
 
 	fpriv->driver_priv = cli;
 
-	mutex_lock(&drm->client.mutex);
+	mutex_lock(&drm->clients_lock);
 	list_add(&cli->head, &drm->clients);
-	mutex_unlock(&drm->client.mutex);
+	mutex_unlock(&drm->clients_lock);
 
 done:
 	if (ret && cli) {
@@ -1117,9 +1118,9 @@ nouveau_drm_postclose(struct drm_device *dev, struct drm_file *fpriv)
 		nouveau_abi16_fini(cli->abi16);
 	mutex_unlock(&cli->mutex);
 
-	mutex_lock(&drm->client.mutex);
+	mutex_lock(&drm->clients_lock);
 	list_del(&cli->head);
-	mutex_unlock(&drm->client.mutex);
+	mutex_unlock(&drm->clients_lock);
 
 	nouveau_cli_fini(cli);
 	kfree(cli);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 9d04d1b36434..550e5f335146 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -141,6 +141,11 @@ struct nouveau_drm {
 
 	struct list_head clients;
 
+	/**
+	 * @clients_lock: Protects access to the @clients list of &struct nouveau_cli.
+	 */
+	struct mutex clients_lock;
+
 	u8 old_pm_cap;
 
 	struct {
-- 
2.28.0

