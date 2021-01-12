Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3812F3A68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436713AbhALT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406888AbhALT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:28:26 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA4C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:26:50 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id EE4AC3EB8B;
        Tue, 12 Jan 2021 20:26:48 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        robdclark@gmail.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v2 7/7] drm/msm/dpu: Remove unused call in wait_for_commit_done
Date:   Tue, 12 Jan 2021 20:26:32 +0100
Message-Id: <20210112192632.502897-8-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112192632.502897-1-angelogioacchino.delregno@somainline.org>
References: <20210112192632.502897-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to dpu_encoder_phys_cmd_prepare_for_kickoff is useless as
it's unused because the serialize_wait4pp variable is never set to
true by .. anything, literally: remove the call.
While at it, also reduce indentation by inverting the check for
dpu_encoder_phys_cmd_is_master.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index 665eb1d4cb8a..b2be39b9144e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -685,20 +685,15 @@ static int dpu_encoder_phys_cmd_wait_for_tx_complete(
 static int dpu_encoder_phys_cmd_wait_for_commit_done(
 		struct dpu_encoder_phys *phys_enc)
 {
-	int rc = 0;
 	struct dpu_encoder_phys_cmd *cmd_enc;
 
 	cmd_enc = to_dpu_encoder_phys_cmd(phys_enc);
 
 	/* only required for master controller */
-	if (dpu_encoder_phys_cmd_is_master(phys_enc))
-		rc = _dpu_encoder_phys_cmd_wait_for_ctl_start(phys_enc);
-
-	/* required for both controllers */
-	if (!rc && cmd_enc->serialize_wait4pp)
-		dpu_encoder_phys_cmd_prepare_for_kickoff(phys_enc);
+	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
+		return 0;
 
-	return rc;
+	return _dpu_encoder_phys_cmd_wait_for_ctl_start(phys_enc);
 }
 
 static int dpu_encoder_phys_cmd_wait_for_vblank(
-- 
2.29.2

