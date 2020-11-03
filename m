Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E82A5076
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgKCTt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:49:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729792AbgKCTty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604432992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cOplwtOZwkOhcElcenXwd/eL0K6reSp6cKdkv+s32I=;
        b=Eg0fhQ36KKQl06S1uog4pWlG1LP0BEE4bVDJ/ip+M/m0sE+nVi9Y6aNwF06oSs6zZdajyX
        80oNc0Fg8wBJsBlgTWI3DeBQYnj78zQQ3l6L7wQ1m12JvxmQre9zk+DIAKnm8Uf5P/R9DB
        07MZUn6FTiIUZQMmBRxLdMx0sFgdnGc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-JDhQd-DDN9Kmya83c4fAdQ-1; Tue, 03 Nov 2020 14:49:51 -0500
X-MC-Unique: JDhQd-DDN9Kmya83c4fAdQ-1
Received: by mail-qv1-f69.google.com with SMTP id b13so11043588qvz.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 11:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cOplwtOZwkOhcElcenXwd/eL0K6reSp6cKdkv+s32I=;
        b=mcUQ2DLbD/mWWTqzhySj3yh3Ttl7bTSQuL9dZE328cKqltjUWzTPCaMWBiaN6DKk3A
         TGwOlLdKdaVIVlDuVMFARvdLpIkt48N1fBRL6C7fBeOmiblYBUXZTojzrQDnApBHXi/A
         9w1W9zbBDSdY2aXx/VucEOuAZGMJt8Jr9CY6JQhLy1+67nrnAbhfqP5N6sdXYU+ZFBMB
         YTWO11WQCDlrIeBHzr5c1T8N2S1YfXA2CmfY+oPh+mYfUTH3o9lAssZ8/xWLNAkLW/tD
         T5bYQPFl+0RMtY+WMmfuxViJvke6l01ZwWUi0rmk6TrS6/JMJqvXh8dDbDkW2etV46kX
         1MYQ==
X-Gm-Message-State: AOAM531h69TzDjqjBOJp9eBJj9ok9INt0dM1CFXO36cRFbGsEkZ7APhR
        m7AnMWxR6eGJlzq6rhY5Pl9KXS3lRTI8dOfC04DNGrjJ3QRG1f3Zkyj8zY0vzam1JzKl74qsEtV
        LcpPkqjXO1SfSAD07PEf0ufI5
X-Received: by 2002:a37:bb05:: with SMTP id l5mr16086261qkf.73.1604432989515;
        Tue, 03 Nov 2020 11:49:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1Zcn4k0dZYOYRSCsWQkBp1Zne0zAJ6YFAWjuVPKncJ0ZNoLvujh98Uc4XaOcRD8Ws4hkqdg==
X-Received: by 2002:a37:bb05:: with SMTP id l5mr16086229qkf.73.1604432989226;
        Tue, 03 Nov 2020 11:49:49 -0800 (PST)
Received: from xps13.redhat.com ([2605:a601:a639:f01:1ac8:8e0c:f1cc:7a29])
        by smtp.gmail.com with ESMTPSA id w25sm11392532qkj.85.2020.11.03.11.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 11:49:48 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 3/3] drm/nouveau: clean up all clients on device removal
Date:   Tue,  3 Nov 2020 14:49:12 -0500
Message-Id: <20201103194912.184413-4-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103194912.184413-1-jcline@redhat.com>
References: <20201103194912.184413-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The postclose handler can run after the device has been removed (or the
driver has been unbound) since userspace clients are free to hold the
file open the file as long as they want. Because the device removal
callback frees the entire nouveau_drm structure, any reference to it in
the postclose handler will result in a use-after-free.

To reproduce this, one must simply open the device file, unbind the
driver (or physically remove the device), and then close the device
file. This was found and can be reproduced easily with the IGT
core_hotunplug tests.

To avoid this, all clients are cleaned up in the device finialization
rather than deferring it to the postclose handler, and the postclose
handler is protected by a critical section which ensures the
drm_dev_unplug() and the postclose handler won't race.

This is not an ideal fix, since as I understand the proposed plan for
the kernel<->userspace interface for hotplug support, destroying the
client before the file is closed will cause problems. However, I believe
to properly fix this issue, the lifetime of the nouveau_drm structure
needs to be extended to match the drm_device, and this proved to be a
rather invasive change. Thus, I've broken this out so the fix can be
easily backported.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index d182b877258a..74fab777f4d0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -628,6 +628,7 @@ nouveau_drm_device_init(struct drm_device *dev)
 static void
 nouveau_drm_device_fini(struct drm_device *dev)
 {
+	struct nouveau_cli *cli, *temp_cli;
 	struct nouveau_drm *drm = nouveau_drm(dev);
 
 	if (nouveau_pmops_runtime()) {
@@ -652,6 +653,24 @@ nouveau_drm_device_fini(struct drm_device *dev)
 	nouveau_ttm_fini(drm);
 	nouveau_vga_fini(drm);
 
+	/*
+	 * There may be existing clients from as-yet unclosed files. For now,
+	 * clean them up here rather than deferring until the file is closed,
+	 * but this likely not correct if we want to support hot-unplugging
+	 * properly.
+	 */
+	mutex_lock(&drm->clients_lock);
+	list_for_each_entry_safe(cli, temp_cli, &drm->clients, head) {
+		list_del(&cli->head);
+		mutex_lock(&cli->mutex);
+		if (cli->abi16)
+			nouveau_abi16_fini(cli->abi16);
+		mutex_unlock(&cli->mutex);
+		nouveau_cli_fini(cli);
+		kfree(cli);
+	}
+	mutex_unlock(&drm->clients_lock);
+
 	nouveau_cli_fini(&drm->client);
 	nouveau_cli_fini(&drm->master);
 	nvif_parent_dtor(&drm->parent);
@@ -1110,6 +1129,16 @@ nouveau_drm_postclose(struct drm_device *dev, struct drm_file *fpriv)
 {
 	struct nouveau_cli *cli = nouveau_cli(fpriv);
 	struct nouveau_drm *drm = nouveau_drm(dev);
+	int dev_index;
+
+	/*
+	 * The device is gone, and as it currently stands all clients are
+	 * cleaned up in the removal codepath. In the future this may change
+	 * so that we can support hot-unplugging, but for now we immediately
+	 * return to avoid a double-free situation.
+	 */
+	if (!drm_dev_enter(dev, &dev_index))
+		return;
 
 	pm_runtime_get_sync(dev->dev);
 
@@ -1126,6 +1155,7 @@ nouveau_drm_postclose(struct drm_device *dev, struct drm_file *fpriv)
 	kfree(cli);
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
+	drm_dev_exit(dev_index);
 }
 
 static const struct drm_ioctl_desc
-- 
2.28.0

