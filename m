Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723792CBB7D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbgLBLWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:22:19 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:34989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLBLWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:22:18 -0500
Received: from orion.localdomain ([77.7.48.174]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MIcqp-1kwCQ42J41-00EdXU; Wed, 02 Dec 2020 12:19:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] uapi: virtio_ids: add missing device type IDs from OASIS spec
Date:   Wed,  2 Dec 2020 12:19:31 +0100
Message-Id: <20201202111931.31953-2-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201202111931.31953-1-info@metux.net>
References: <20201202111931.31953-1-info@metux.net>
X-Provags-ID: V03:K1:cKK9A4U24QIHxfAyVfjPpXyrBNWog2J8vJGLo8UatFNZL5g3w5Y
 x6402b9EUJTi8Y2CnDHI965vKOefMpnpJT3H+cggaZp968e0IKflIy+5otTV+kqomIHZ82A
 s/KtQ0hGHIO56i+1Pn84uwLlvlGBPeqL0fNjeuhkRXC8Fu4a9iEh014eRPgRh+mxjjJpR18
 mrI/0u8GOX/W1OWnDkl8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FZ1z1Mu1W4o=:Dl3YiZxOI5udrdqv3QEgEF
 zpW10mgJHJAWjw4Y6bk2HhsfYMe2nT9PvH6Ve4XfqGfZs0TXJ8s8/5G7FD4T0KL9wUjiegqXl
 QOjkhSOCY9ssy7ZbBN5qJdBkTP7R6LhRaZhjLDrau6klCPnzjUa5lT7W4pIpmjCRfdyqY+La6
 5GkgDIBJeAXxKPbTxkI+cRRe8u7fseQFrmbRUR5N5Gz72Gx9TRyqDWxnBii6YmNuQDXn+VuW6
 FTgu0nvUOhdTg1OKFZGW3ip33fHJfYVW64yOuDI1Akl1mUZmvPzZktKcUkyWe6Tit3z4iCuZ3
 4mGEQGzig/5/UHFUTjkEtXm2OilW6IABWXBOUwKnfM6Q/b3dpg31ndVbuxVdZYf0tzgCR+URf
 5LuANQyrViKB+gKegRUgWcWmSRhwJXxOLeaSNij1x0XFu5vr5imHgviaV2g2Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OASIS virtio spec (1.1) defines several IDs that aren't reflected
in the header yet. Fixing this by adding the missing IDs, even though
they're not yet used by the kernel yet.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/uapi/linux/virtio_ids.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 3cb55e5277a1..bc1c0621f5ed 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -34,15 +34,21 @@
 #define VIRTIO_ID_CONSOLE		3 /* virtio console */
 #define VIRTIO_ID_RNG			4 /* virtio rng */
 #define VIRTIO_ID_BALLOON		5 /* virtio balloon */
+#define VIRTIO_ID_IOMEM			6 /* virtio ioMemory */
 #define VIRTIO_ID_RPMSG			7 /* virtio remote processor messaging */
 #define VIRTIO_ID_SCSI			8 /* virtio scsi */
 #define VIRTIO_ID_9P			9 /* 9p virtio console */
+#define VIRTIO_ID_MAC80211_WLAN		10 /* virtio WLAN MAC */
 #define VIRTIO_ID_RPROC_SERIAL		11 /* virtio remoteproc serial link */
 #define VIRTIO_ID_CAIF			12 /* Virtio caif */
+#define VIRTIO_ID_MEMORY_BALLOON	13 /* virtio memory balloon */
 #define VIRTIO_ID_GPU			16 /* virtio GPU */
+#define VIRTIO_ID_CLOCK			17 /* virtio clock/timer */
 #define VIRTIO_ID_INPUT			18 /* virtio input */
 #define VIRTIO_ID_VSOCK			19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO		20 /* virtio crypto */
+#define VIRTIO_ID_SIGNAL_DIST		21 /* virtio signal distribution device */
+#define VIRTIO_ID_PSTORE		22 /* virtio pstore device */
 #define VIRTIO_ID_IOMMU			23 /* virtio IOMMU */
 #define VIRTIO_ID_MEM			24 /* virtio mem */
 #define VIRTIO_ID_FS			26 /* virtio filesystem */
-- 
2.11.0

