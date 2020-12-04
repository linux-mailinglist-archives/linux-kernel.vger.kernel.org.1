Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D52CEEAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgLDNPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:15:01 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:42415 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgLDNPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:15:00 -0500
Received: from orion.localdomain ([95.114.158.118]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYcy3-1kgWBh3Gol-00Veyn; Fri, 04 Dec 2020 14:12:22 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] drivers: gpu: drm: virtio: fix dependency of DRM_VIRTIO_GPU on VIRTIO
Date:   Fri,  4 Dec 2020 14:12:21 +0100
Message-Id: <20201204131221.2827-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:3Im9AR8enAhEZ521drYds2y30UO6XrMQxF7XSNeRaHzWJtu0806
 nomRdpnhyqV9yq3cBgTAy9GY7ZuqnPpXvXM4RYvkgZ6VZwhypBYgx9OZ6LbDbl+uL1ivihl
 c3jNOwd4B09o3DTB1Je5/4NeVyCGFGPxXeU2Lio/C8KpRElAOpzJTx8oDvGpOKEOwx3JZS+
 zRV38mFeCRPfFCwMuz+jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AmIBzynERGA=:1kWOUlbnhPpxZWVVEoRSEn
 zpnM7Mr+us70/SF9KXZf5AnLGVcnfkIVLxkf9Ju9gpe0ksEggHTb/FpgjrIZAD2OA+QqzSVXC
 QV1KglKfcXcbNdL6ZZLkyLIotpxo92EBufXxRGF/DDSHRs1n6NhiOHWdaTCrB4v5jYXgeoWeJ
 0UHtS06OrFtnujpyRpWbuao+bXQXh4YLflZVnPE5r7nqMtMSv6fkNp3qCK1Qog31LXFP1OpIy
 4O2WJPNcO37Dq/7ER7Qn+l/llByn/cQTVaY9KN+sluIuw+ytkcshT0ARnvqmspXXT2O9KaM7U
 TDBZ1fYTaJU1tH3nnBYN4+Sp21E0f35EY16YCBUMQA7WzwxhO7NuGl9ghOR7s3SQVmc7/7kCD
 S59MYeZG7zz0rhNMjHqFRNsbU3BdTph0Cfk3cENP73V7l0cG5l3DhJPixRyc9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIRTIO itself has no dependencies and therefore can easily be just
select'ed, instead of depending on it. The current depends on causes
any others trying to select VIRTIO to fail like this:

   drivers/gpu/drm/Kconfig:74:error: recursive dependency detected!
   drivers/gpu/drm/Kconfig:74:	symbol DRM_KMS_HELPER is selected by DRM_VIRTIO_GPU
   drivers/gpu/drm/virtio/Kconfig:2:	symbol DRM_VIRTIO_GPU depends on VIRTIO
   drivers/virtio/Kconfig:2:	symbol VIRTIO is selected by GPIO_VIRTIO
   drivers/gpio/Kconfig:1618:	symbol GPIO_VIRTIO depends on GPIOLIB
   drivers/gpio/Kconfig:14:	symbol GPIOLIB is selected by I2C_MUX_LTC4306
   drivers/i2c/muxes/Kconfig:47:	symbol I2C_MUX_LTC4306 depends on I2C
   drivers/i2c/Kconfig:8:	symbol I2C is selected by FB_DDC
   drivers/video/fbdev/Kconfig:63:	symbol FB_DDC depends on FB
   drivers/video/fbdev/Kconfig:12:	symbol FB is selected by DRM_KMS_FB_HELPER
   drivers/gpu/drm/Kconfig:80:	symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER

It seems that having both 'depends on' as well as 'select' on the same symbol
sends us into big trouble, and Kconfig can't break up the circular dependency
(note that in the tested configuration, neither I2C, FB or DRM are enabled at
all). Perhaps we could consider this a bug in Kconfig, but the trouble can
easily be circumvented by changing 'depends on' into 'select'.

DRM_VIRTIO_GPU also depends on VIRTIO_MENU, so even after this change, that
option will only show up if the user already enabled virtio in the config.

This change didn't cause any changes in the .config after menuconfig run,
so we should be completely safe here.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpu/drm/virtio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
index b925b8b1da16..51ec7c3240c9 100644
--- a/drivers/gpu/drm/virtio/Kconfig
+++ b/drivers/gpu/drm/virtio/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_VIRTIO_GPU
 	tristate "Virtio GPU driver"
-	depends on DRM && VIRTIO && VIRTIO_MENU && MMU
+	depends on DRM && VIRTIO_MENU && MMU
+	select VIRTIO
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
 	select VIRTIO_DMA_SHARED_BUFFER
-- 
2.11.0

