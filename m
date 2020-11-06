Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82602A8C9D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgKFCRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:17:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgKFCRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604629066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTTP77Binb8q6Myv+TECrFOkx25pYy2wpQfJisWb5cQ=;
        b=fjg83QCTjU91X3ySfKwYCpcSq49rNjCSDyS4VUEQ+2rYWBrpn95CiHx50EH16Md6L44u+8
        p7EoCArSCHq9VJkxYGPqxL3Zd230Npkuykkt3Ja6al8xhRm/cn1p5kdnfCArfIsI8DTw4f
        wzCOHQNlVdWaM83ybh8r6L5cdzIpbdk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-HB19bme-MTSHt-JfZ8q8gg-1; Thu, 05 Nov 2020 21:17:45 -0500
X-MC-Unique: HB19bme-MTSHt-JfZ8q8gg-1
Received: by mail-qk1-f198.google.com with SMTP id v134so2307791qka.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTTP77Binb8q6Myv+TECrFOkx25pYy2wpQfJisWb5cQ=;
        b=KrmcEUpve/FCCA9Yg0oZZdU8zE58Sjp4eHtRMT/x2GTg4QMyTogRXd/z6RT9tvKu5X
         o7NyG5kwkZ3n6wHna5/+Y6x7nfuIrLIiZtzTQEVpsnV0ZGfOCE2n5l94tT1uLz6kntxU
         83gUoyqWcH7ggC+Ld+8TbJWHsnmsW0Sve3sKvh9I/8IiHpIJ3gcdErt8eTILGUIZajpQ
         lrlMp44T0aMDfvu/VjKxvg8vmhumRvJKVrHKewh9GapI5xR1QwWX5UbM648uYBE5RHNH
         mYLHB/smUyBRJjvs01t5cIjMmZXKfNJb6/mj0pc2fNK/jiEVjq+aq2Ld60SPDb4hpoPd
         Q72g==
X-Gm-Message-State: AOAM533J/in1w9pBdPcg5k5WE+f52e/QstEFato//mZ6lzP1hAhHLhSz
        WAvVxpYALU0G5ksKHerbMWJBNdttUee/kdvpCDvHt2CbSbyRtSVufPVblb9xd23HtESEr/d20Uz
        GaGFB2jYXW10ft8GxSyzed5ZB
X-Received: by 2002:a37:b342:: with SMTP id c63mr5354711qkf.146.1604629064605;
        Thu, 05 Nov 2020 18:17:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywxxAwhVSFnT9J8jpLBEO4CY5W9W9Xz/Qxhz0ra1j3pitSYEK7KwYiLA2H5gQ5/94RyqMxyA==
X-Received: by 2002:a37:b342:: with SMTP id c63mr5354696qkf.146.1604629064392;
        Thu, 05 Nov 2020 18:17:44 -0800 (PST)
Received: from xps13.jcline.org ([2605:a601:a639:f01:1ac8:8e0c:f1cc:7a29])
        by smtp.gmail.com with ESMTPSA id q20sm2195301qtn.80.2020.11.05.18.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:17:43 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 3/3] drm/nouveau: begin documenting core nouveau structures
Date:   Thu,  5 Nov 2020 21:16:56 -0500
Message-Id: <20201106021656.40743-4-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106021656.40743-1-jcline@redhat.com>
References: <20201106021656.40743-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start on documentation for the Nouveau device structure and the NVIF
client structure it uses. This documentation is not complete as the
structures are non-trivial and I am not familiar with large portions of
them.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drv.h | 67 +++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index cf6c33e52a5c..cf83d4bf3c6c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -90,8 +90,20 @@ enum nouveau_drm_handle {
 	NVDRM_NVSW    = 0x55550000,
 };
 
+/**
+ * struct nouveau_cli - A DRM-specific NVIF client.
+ *
+ * This encapsulates a NVIF client and is intended to be the sole interface
+ * between the DRM APIs and NVKM. An instance of this structure is allocated
+ * for each userspace client when they open the device file. Additionally,
+ * there are several allocated strictly for the kernel's use.
+ */
 struct nouveau_cli {
 	struct nvif_client base;
+
+	/**
+	 * @drm: A reference to the device that the client is associated with.
+	 */
 	struct nouveau_drm *drm;
 	struct mutex mutex;
 
@@ -101,6 +113,9 @@ struct nouveau_cli {
 	struct nouveau_vmm svm;
 	const struct nvif_mclass *mem;
 
+	/**
+	 * @head: The list entry for this client in the @drm device's list of clients.
+	 */
 	struct list_head head;
 	void *abi16;
 	struct list_head objects;
@@ -108,13 +123,36 @@ struct nouveau_cli {
 	char name[32];
 
 	struct work_struct work;
+
+	/**
+	 * @worker: List of pending &struct nouveau_cli_work associated with this client.
+	 */
 	struct list_head worker;
+
+	/**
+	 * @lock: Protects the @worker list. Additionally, this lock on the
+	 * @drm.master instance is used to serialize destruction of the @base
+	 * member in this structure, as well as the destruction of the &struct
+	 * nvif_mem embedded in &struct nouveau_mem instances.
+	 */
 	struct mutex lock;
 };
 
+/**
+ * struct nouveau_cli_work - A pending work item for an NVIF client.
+ */
 struct nouveau_cli_work {
 	void (*func)(struct nouveau_cli_work *);
+
+	/**
+	 * @cli: Reference to the NVIF client this work belongs to.
+	 */
 	struct nouveau_cli *cli;
+
+	/**
+	 * @head: The list entry for this work item in the &struct nouveau_cli
+	 * worker list.
+	 */
 	struct list_head head;
 
 	struct dma_fence *fence;
@@ -133,9 +171,32 @@ nouveau_cli(struct drm_file *fpriv)
 #include <nvif/object.h>
 #include <nvif/parent.h>
 
+/**
+ * struct nouveau_drm - The nouveau-specific device structure.
+ *
+ * This structure is allocated for a device when it is probed and keeps track
+ * of all the nouveau-specific device details. The lifetime of this structure
+ * is the same as the lifetime of a &struct drm_device and is managed by the
+ * DRM layer.
+ */
 struct nouveau_drm {
+	/**
+	 * @parent: Implementation of the interface required to use the NVIF_DEBUG
+	 * and NVIF_ERROR macros
+	 */
 	struct nvif_parent parent;
+
+	/**
+	 * @master: This NVIF client is used to initialize the NVIF driver and used
+	 * for TTM memory allocations. It is the root of the NVIF object tree.
+	 */
 	struct nouveau_cli master;
+
+	/**
+	 * @client: This NVIF client is used by the DRM layer to interact with
+	 * the NVKM layer for everything except TTM memory allocations. It, and
+	 * all other clients, are children of the primary (@master) client.
+	 */
 	struct nouveau_cli client;
 
 	/**
@@ -143,6 +204,12 @@ struct nouveau_drm {
 	 */
 	struct drm_device drm_dev;
 
+	/**
+	 * @clients: List of all &struct nouveau_cli allocated for userspace
+	 * associated with this DRM device. Clients are allocated when the DRM
+	 * file is opened and deallocated when the file is closed. This list is
+	 * protected by the mutex in @client.
+	 */
 	struct list_head clients;
 
 	u8 old_pm_cap;
-- 
2.28.0

