Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9862714DE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgITOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 10:14:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57166 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 10:14:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kK06R-0006Zs-Uy; Sun, 20 Sep 2020 14:14:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gma500: clean up indentation issues
Date:   Sun, 20 Sep 2020 15:14:07 +0100
Message-Id: <20200920141407.32672-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of statements that are indented too deeply,
remove the extraneous tabs and also an empty line.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 720a767118c9..50016a754172 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -1501,8 +1501,7 @@ cdv_intel_dp_start_link_train(struct gma_encoder *encoder)
 	clock_recovery = false;
 
 	DRM_DEBUG_KMS("Start train\n");
-		reg = DP | DP_LINK_TRAIN_PAT_1;
-
+	reg = DP | DP_LINK_TRAIN_PAT_1;
 
 	for (;;) {
 		/* Use intel_dp->train_set[0] to set the voltage and pre emphasis values */
@@ -1575,7 +1574,7 @@ cdv_intel_dp_complete_link_train(struct gma_encoder *encoder)
 	cr_tries = 0;
 
 	DRM_DEBUG_KMS("\n");
-		reg = DP | DP_LINK_TRAIN_PAT_2;
+	reg = DP | DP_LINK_TRAIN_PAT_2;
 
 	for (;;) {
 
-- 
2.27.0

