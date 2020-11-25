Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB42C4907
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgKYU1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729608AbgKYU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606336037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m28TgjZwi7HhBuSwen4t4g93qkTs31I2N0RIyqGkBQY=;
        b=jW0WPA0zynz3N3NP6dyZ1OyjC+AGgMw3pUaiY+G3iB93hSOio3ulG2hUv3FqJ0jgen1tv3
        bEgrkLJU38CwsodcD6i1JKCFxsD4rw0OHp8ovaTgMfcydQDmpYANhJGShJrjonsJew6dK7
        aZBcbAVTbJGMbYjM2kb2D0jQm81l26k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-BoOd-sPdMn-hhebKS5sHUA-1; Wed, 25 Nov 2020 15:27:15 -0500
X-MC-Unique: BoOd-sPdMn-hhebKS5sHUA-1
Received: by mail-qk1-f199.google.com with SMTP id q25so3279439qkm.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m28TgjZwi7HhBuSwen4t4g93qkTs31I2N0RIyqGkBQY=;
        b=ePsuTvJkjkZWOUcMGPokq5bCWcbKMHx0sCWFZ+EyH39XxpdvbJbNkj7Uo2xaRFHn+N
         I5A6H6S22HhOzAK9i9ntMR6ZUgpX677l0C1ORY+M7Vn9xPHEu1PHyAo+bgyeh+/fIbqC
         js09BtCOhWP0uf7yqHVB79wyTAGH1pDZSgQI1MpfAf8aSiVdOiarlL9GrtdAQZzH+6gM
         6/cxAc9ZDmUyXv2GLZ6W7VQBZpqsbnuQh2bW7H05NmM9v6qXbT9WLvuHXO+AK8FTWoY/
         0kiwHg/lS+lxxXAcn5ZMPxlWeWIw2Gfeugq2Av69K5K+nKcZGszJA1WgIqHFt7z9wzQw
         fviQ==
X-Gm-Message-State: AOAM530gwIT7rhgYtglaKX7SQ3cC5IMKWnUa8R7pzKEcYGPWwfZjd74Y
        HXZvYIOdZ5aAa9nAcHKhDi+zTCZAA4paJOrGb2mi0FH8e1yLtWB0zr7iEZP0vpzR/QxioM/SNaF
        1iL1OQP/Y+EdJGH2wY/qLpLpI
X-Received: by 2002:a37:4854:: with SMTP id v81mr748209qka.20.1606336033967;
        Wed, 25 Nov 2020 12:27:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTVi4YITmr/yVt0UXkpzCkoAdVjZcIU7pnzNdwrA6y0qo2w8G8fpzl3w+LvWzcj9VOPAQxLw==
X-Received: by 2002:a37:4854:: with SMTP id v81mr748193qka.20.1606336033788;
        Wed, 25 Nov 2020 12:27:13 -0800 (PST)
Received: from dev.jcline.org ([2605:a601:a638:b301:9966:d978:493:6a3d])
        by smtp.gmail.com with ESMTPSA id o187sm431772qkb.120.2020.11.25.12.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:27:13 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/3] drm/nouveau: Add a dedicated mutex for the clients list
Date:   Wed, 25 Nov 2020 15:26:47 -0500
Message-Id: <20201125202648.5220-3-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201125202648.5220-1-jcline@redhat.com>
References: <20201103194912.184413-1-jcline@redhat.com>
 <20201125202648.5220-1-jcline@redhat.com>
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

Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
Changes since v1:
  - Add a mutex_destroy() call when destroying the device struct

 drivers/gpu/drm/nouveau/nouveau_drm.c | 10 ++++++----
 drivers/gpu/drm/nouveau/nouveau_drv.h |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 4fe4d664c5f2..6ee1adc9bd40 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -557,6 +557,7 @@ nouveau_drm_device_init(struct drm_device *dev)
 		nvkm_dbgopt(nouveau_debug, "DRM");
 
 	INIT_LIST_HEAD(&drm->clients);
+	mutex_init(&drm->clients_lock);
 	spin_lock_init(&drm->tile.lock);
 
 	/* workaround an odd issue on nvc1 by disabling the device's
@@ -654,6 +655,7 @@ nouveau_drm_device_fini(struct drm_device *dev)
 	nouveau_cli_fini(&drm->client);
 	nouveau_cli_fini(&drm->master);
 	nvif_parent_dtor(&drm->parent);
+	mutex_destroy(&drm->clients_lock);
 	kfree(drm);
 }
 
@@ -1089,9 +1091,9 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file *fpriv)
 
 	fpriv->driver_priv = cli;
 
-	mutex_lock(&drm->client.mutex);
+	mutex_lock(&drm->clients_lock);
 	list_add(&cli->head, &drm->clients);
-	mutex_unlock(&drm->client.mutex);
+	mutex_unlock(&drm->clients_lock);
 
 done:
 	if (ret && cli) {
@@ -1117,9 +1119,9 @@ nouveau_drm_postclose(struct drm_device *dev, struct drm_file *fpriv)
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

