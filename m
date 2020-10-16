Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55430290D92
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgJPWF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:05:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59320 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbgJPWF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:05:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kTXrH-0007D2-94; Fri, 16 Oct 2020 22:05:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/bios/init: make two const arrays static, makes object smaller
Date:   Fri, 16 Oct 2020 23:05:55 +0100
Message-Id: <20201016220555.686446-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate const arrays on the stack but instead make them
static. Makes the object code smaller by 7 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
 104041	   8284	      0	 112325	  1b6c5	drm/nouveau/nvkm/subdev/bios/init.o

After:
   text	   data	    bss	    dec	    hex	filename
 103874	   8444	      0	 112318	  1b6be	drm/nouveau/nvkm/subdev/bios/init.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index 9de74f41dcd2..dc8625eff20a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -546,9 +546,9 @@ init_tmds_reg(struct nvbios_init *init, u8 tmds)
 	 * CR58 for CR57 = 0 to index a table of offsets to the basic
 	 * 0x6808b0 address, and then flip the offset by 8.
 	 */
-	const int pramdac_offset[13] = {
+	static const int pramdac_offset[13] = {
 		0, 0, 0x8, 0, 0x2000, 0, 0, 0, 0x2008, 0, 0, 0, 0x2000 };
-	const u32 pramdac_table[4] = {
+	static const u32 pramdac_table[4] = {
 		0x6808b0, 0x6808b8, 0x6828b0, 0x6828b8 };
 
 	if (tmds >= 0x80) {
-- 
2.27.0

