Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931862B6641
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgKQNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:12:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47496 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgKQNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:11:43 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kf0lm-0000AT-7g; Tue, 17 Nov 2020 13:11:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/pm: fix spelling mistakes in dev_warn messages
Date:   Tue, 17 Nov 2020 13:11:37 +0000
Message-Id: <20201117131137.420396-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistakes in dev_warn messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index afa542a5af5f..9a2f72f21ed8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -689,14 +689,14 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 
 		if (input[0] == 0) {
 			if (input[1] < smu->gfx_default_hard_min_freq) {
-				dev_warn(smu->adev->dev, "Fine grain setting minimun sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+				dev_warn(smu->adev->dev, "Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
 					input[1], smu->gfx_default_hard_min_freq);
 				return -EINVAL;
 			}
 			smu->gfx_actual_hard_min_freq = input[1];
 		} else if (input[0] == 1) {
 			if (input[1] > smu->gfx_default_soft_max_freq) {
-				dev_warn(smu->adev->dev, "Fine grain setting maximun sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
+				dev_warn(smu->adev->dev, "Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
 					input[1], smu->gfx_default_soft_max_freq);
 				return -EINVAL;
 			}
-- 
2.28.0

