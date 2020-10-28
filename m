Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B158229DB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390671AbgJ2ACO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:02:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59847 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389366AbgJ2AAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:00:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kXknM-0007Ge-DT; Wed, 28 Oct 2020 12:43:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/pm: fix out-of-bound read on pptable->SkuReserved
Date:   Wed, 28 Oct 2020 12:43:16 +0000
Message-Id: <20201028124316.109886-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A recent change added two uint16_t elements to PPTable_t and reduced the
uint32_t array down to 8 elements. This results in the dev_info printing
of pptable->SkuReserved[8] accessing a value that is out-of-range on
array SkuReserved.  The array has been shrunk by 1 element, so remove
this extraneous dev_info message.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: 1dc3c5a95b08 ("drm/amd/pm: update driver if file for sienna cichlid")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index fa3842f460fc..0600befc6e4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2279,7 +2279,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	dev_info(smu->adev->dev, "SkuReserved[5] = 0x%x\n", pptable->SkuReserved[5]);
 	dev_info(smu->adev->dev, "SkuReserved[6] = 0x%x\n", pptable->SkuReserved[6]);
 	dev_info(smu->adev->dev, "SkuReserved[7] = 0x%x\n", pptable->SkuReserved[7]);
-	dev_info(smu->adev->dev, "SkuReserved[8] = 0x%x\n", pptable->SkuReserved[8]);
 
 	dev_info(smu->adev->dev, "GamingClk[0] = 0x%x\n", pptable->GamingClk[0]);
 	dev_info(smu->adev->dev, "GamingClk[1] = 0x%x\n", pptable->GamingClk[1]);
-- 
2.27.0

