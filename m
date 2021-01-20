Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6B2FC616
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbhATAtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:49:03 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:10335 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbhATArH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 19:47:07 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 0A67DA13B1;
        Wed, 20 Jan 2021 01:37:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=JMWVu00sJKNa
        UzNO4ZqMeD8FYjdkJxYXTlplUlw+228=; b=lq6NDPkAXpmI84ENkvapU+/dvC9v
        2T7P5ZnI+OpPi6a90fntxUJKzIWntVojJWzhWxiR2i5S7nGHhCRExMy+Ba1uusy7
        N8ZkYhEFUDsSvREvwd4TUOf3VElPYerwFuwaNbysB7n42gJNB6doWAiJnt2FkWj+
        nvlh7K4RI0E9A8n+S5aEmLxuhF1zVUz8iex9wvpoC45+5IKQp43GPDbCk2f1QTjg
        r9GNHB6lpjyDcEFspGXbHcHI8/8THpNwqNjBMu9usR9lKjeCv1Cc/lPQkBAnVh9I
        Xfo64u0akxwAz0ViFh15MxBtCLqmnyoBo+O5jUJ2D5X2GGrBRWJz7tSVcA==
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
To:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] uapi: virtio_ids: add a sound device type ID from OASIS spec
Date:   Wed, 20 Jan 2021 01:36:29 +0100
Message-ID: <20210120003638.3339987-2-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OASIS virtio spec defines a sound device type ID that is not
present in the header yet.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index bc1c0621f5ed..029a2e07a7f9 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -51,6 +51,7 @@
 #define VIRTIO_ID_PSTORE		22 /* virtio pstore device */
 #define VIRTIO_ID_IOMMU			23 /* virtio IOMMU */
 #define VIRTIO_ID_MEM			24 /* virtio mem */
+#define VIRTIO_ID_SOUND			25 /* virtio sound */
 #define VIRTIO_ID_FS			26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM			27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
-- 
2.30.0


