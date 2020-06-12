Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A17A1F73DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFLGXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 02:23:17 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:50651 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgFLGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:23:17 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Jun 2020 11:53:13 +0530
Received: from mkrishn-linux.qualcomm.com ([10.204.66.35])
  by ironmsg02-blr.qualcomm.com with ESMTP; 12 Jun 2020 11:52:47 +0530
Received: by mkrishn-linux.qualcomm.com (Postfix, from userid 438394)
        id 6C8B047A6; Fri, 12 Jun 2020 11:52:46 +0530 (IST)
From:   Krishna Manikandan <mkrishn@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        nganji@codeaurora.org, mka@chromium.org, john.stultz@linaro.org,
        dianders@chromium.org, abhinavk@codeaurora.org,
        mkrishn@codeaurora.org
Subject: [v2] drm/msm/dpu: request for display color blocks based on hw catalog entry
Date:   Fri, 12 Jun 2020 11:52:37 +0530
Message-Id: <1591942957-18410-1-git-send-email-mkrishn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalyan Thota <kalyan_t@codeaurora.org>

Request for color processing blocks only if they are
available in the display hw catalog and they are
sufficient in number for the selection.

Changes in v2:
	- Include Fixes tag in commit message (Rob Clark)
	- Adding the Tested by tag as there are no code
	  changes in v2

Fixes: e47616df008b ("drm/msm/dpu: add support for color processing blocks in dpu driver")
Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
Tested-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 63976dc..9f8de77 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -521,7 +521,7 @@ static struct msm_display_topology dpu_encoder_get_topology(
 			struct dpu_kms *dpu_kms,
 			struct drm_display_mode *mode)
 {
-	struct msm_display_topology topology;
+	struct msm_display_topology topology = {0};
 	int i, intf_count = 0;
 
 	for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
@@ -537,7 +537,8 @@ static struct msm_display_topology dpu_encoder_get_topology(
 	 * 1 LM, 1 INTF
 	 * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
 	 *
-	 * Adding color blocks only to primary interface
+	 * Adding color blocks only to primary interface if available in
+	 * sufficient number
 	 */
 	if (intf_count == 2)
 		topology.num_lm = 2;
@@ -546,8 +547,11 @@ static struct msm_display_topology dpu_encoder_get_topology(
 	else
 		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
 
-	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI)
-		topology.num_dspp = topology.num_lm;
+	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
+		if (dpu_kms->catalog->dspp &&
+			(dpu_kms->catalog->dspp_count >= topology.num_lm))
+			topology.num_dspp = topology.num_lm;
+	}
 
 	topology.num_enc = 0;
 	topology.num_intf = intf_count;
-- 
1.9.1

