Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589422B6BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgKQR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgKQR0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:26:12 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FFC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:26:12 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so6880736pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXY01vYqSIFKCXp0IDMP/PsFb63uKbgbyX0xqNFjPx8=;
        b=Ui84wE1DPycMuErhBKrJglxCN+6U2dIsJ8AXIsquTnLJwX7valeZ/Wj4u13g/P7cca
         hCCwyq37SCXL+glSjaLy48q3Es/ccTZPdji18Jc19ouRkm25CJBTDoKB2hq56S1gsxJT
         CgkNQMv/DyTA8jUzzWDYbwu+gOE/Q4fpQMkqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXY01vYqSIFKCXp0IDMP/PsFb63uKbgbyX0xqNFjPx8=;
        b=UmXhn4vdbF0mBc2CK/AslwFY7JZqbBgcMtGRhGs1nHvifPloVNSnMEjLzV7m6hltMv
         RP76qt1fY/o4Ci49zONl3R5KoBoZfRyaLy6bbbxhdYthWqVnh8d7mduqmFDE2VXGB/Ib
         ZlMJ+l5VGmxjT1giW8lAAP29PLIOxgznxzAHwNLit/O8kpsIjKNq9V6ZOnoKFSKNzNPu
         E4jfv0Onw7xOpF+OPCRqNZ1NN+c+EGeYM67twoTco1v6tvp1S2/vILLsV7SRxCYaP+Dy
         qiAl/zi2DM7Ay/HytaNT0MNX9oSwqUlg3wzxAWOwovHHgj0KLDXTLVJKoTUbp/xshjkc
         mgXw==
X-Gm-Message-State: AOAM530i70ZekAxCl+/N1Gare0uq3rTXQkoBYI/ieI3t58PX0nTIZ3Vz
        twpHWnPqc8qrDDDmxCtAnrNAFg==
X-Google-Smtp-Source: ABdhPJx6BBjXdUQptGLanbbvON0/vIPEQPGdKUos1T5nRqRB9kJFXWbLNYc4fRG2VpF08DlYFiAz3w==
X-Received: by 2002:a65:4485:: with SMTP id l5mr4316577pgq.10.1605633971667;
        Tue, 17 Nov 2020 09:26:11 -0800 (PST)
Received: from smtp.gmail.com ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id y9sm3816846pjn.24.2020.11.17.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:26:11 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <abhinavk@codeaurora.org>
Subject: [PATCH] drm/msm/dpu: Remove chatty vbif debug print
Date:   Tue, 17 Nov 2020 09:26:08 -0800
Message-Id: <20201117172608.2091648-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know what this debug print is for but it is super chatty,
throwing 8 lines of debug prints in the logs every time we update a
plane. It looks like it has no value. Let's nuke it so we can get
better logs.

Cc: Sean Paul <sean@poorly.run>
Cc: Abhinav Kumar <abhinavk@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
index 5e8c3f3e6625..5eb2b2ee09f5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
@@ -245,9 +245,6 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
 	forced_on = mdp->ops.setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
 
 	for (i = 0; i < qos_tbl->npriority_lvl; i++) {
-		DPU_DEBUG("vbif:%d xin:%d lvl:%d/%d\n",
-				params->vbif_idx, params->xin_id, i,
-				qos_tbl->priority_lvl[i]);
 		vbif->ops.set_qos_remap(vbif, params->xin_id, i,
 				qos_tbl->priority_lvl[i]);
 	}
-- 
Sent by a computer, using git, on the internet

