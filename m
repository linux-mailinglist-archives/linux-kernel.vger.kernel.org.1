Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1862C0450
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgKWLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgKWLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:48 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC75C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:46 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a186so14725755wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32SVJ8mdRe/T7//SaLi21jO2sGQbGaZReyRM63Vrq+I=;
        b=VbVyI7IwpSnGVD6+CoCln9D/YR1WicPAg51iH21SRVTcs6T3np9/gKs/xquUFHxAO3
         QoWpNWkbIDo1GGgDdoUL2Ouhv1j/RwYN3ip3FCNoUak8Vvch4k5k52ucqtLnlablo/6u
         SNgLtssab4dr7Xe3CduS5bFpNEzUabWliu1oFptjht18hpg9LcgHBDARGc6bpbkGB2wx
         c3XVbpXolFeBxe576y3M9GKEslcK1dvNt+51/4ecuqHsc38M4oAAjILB13cUUnihUZ/8
         xwpn4rcW6qYpfM+41YoeWtnhFdkileNG1g8UA8oLqOUrQ0H2wwQC/mG2vl0eIIySNpzS
         TCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32SVJ8mdRe/T7//SaLi21jO2sGQbGaZReyRM63Vrq+I=;
        b=rGXuimeiRuzfibJ6pJhD5qR0kqItNAEoc6MmZVzHXGmjpDpsfAsBOZs30OZCQX9B/M
         HrpLkzDOrls87HjaYTctntR9gu7/LJjN6yMMgu1+IuVl2pP/WHDwn6FTzmyoXvA2Offh
         yu6rM+bBe1pqCtuy1Cwhjyp60k9UhYv4TVbThuXweMvGUvo9Dbt8RW1mPfMPKnx9RoUu
         YhqRzGiso5V5fHaNI+8KVahHshFTNGziPvUJLVV0+DwoJKAUCuBK7/BirjbGeoRfkH7T
         +vYfUfANeqPqaJFoEFZP+k5ZgSumqyu5FeNG+fazYOsC/JkY+9dRqWLVpU8bB/Nvru8S
         3xvw==
X-Gm-Message-State: AOAM532EF3LUY0x8xxOFXYD6H4tf5Y5lNTziHp0nOY/RbosyCY4hq7vT
        lI6SZkQw5Pocp9PpTcBXMX0xRQ==
X-Google-Smtp-Source: ABdhPJyX70CgmiRTAARTla7+IkR+i58bgsk4beDqZTn5Nf854m12NsA8sHd5AqoMGrO+Ci/I16J6Rg==
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr15232172wmc.86.1606130385644;
        Mon, 23 Nov 2020 03:19:45 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 18/40] drm/msm/disp/dpu1/dpu_encoder: Fix a few parameter/member formatting issues
Date:   Mon, 23 Nov 2020 11:18:57 +0000
Message-Id: <20201123111919.233376-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:207: warning: Function parameter or member 'cur_slave' not described in 'dpu_encoder_virt'
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:207: warning: Function parameter or member 'hw_pp' not described in 'dpu_encoder_virt'
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:207: warning: Function parameter or member 'intfs_swapped' not described in 'dpu_encoder_virt'
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1445: warning: Function parameter or member 'drm_enc' not described in '_dpu_encoder_trigger_flush'
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1445: warning: Function parameter or member 'phys' not described in '_dpu_encoder_trigger_flush'
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1445: warning: Function parameter or member 'extra_flush_bits' not described in '_dpu_encoder_trigger_flush'
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1481: warning: Function parameter or member 'phys' not described in '_dpu_encoder_trigger_start'
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:1564: warning: Function parameter or member 'dpu_enc' not described in '_dpu_encoder_kickoff_phys'

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 289bfb6f1861c..288e95ee8e1d5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -132,9 +132,10 @@ enum dpu_enc_rc_states {
  * @phys_encs:		Container of physical encoders managed.
  * @cur_master:		Pointer to the current master in this mode. Optimization
  *			Only valid after enable. Cleared as disable.
- * @hw_pp		Handle to the pingpong blocks used for the display. No.
+ * @cur_slave:		As above but for the slave encoder.
+ * @hw_pp:		Handle to the pingpong blocks used for the display. No.
  *			pingpong blocks can be different than num_phys_encs.
- * @intfs_swapped	Whether or not the phys_enc interfaces have been swapped
+ * @intfs_swapped:	Whether or not the phys_enc interfaces have been swapped
  *			for partial update right-only cases, such as pingpong
  *			split where virtual pingpong does not generate IRQs
  * @crtc:		Pointer to the currently assigned crtc. Normally you
@@ -1436,9 +1437,9 @@ static void dpu_encoder_off_work(struct work_struct *work)
 
 /**
  * _dpu_encoder_trigger_flush - trigger flush for a physical encoder
- * drm_enc: Pointer to drm encoder structure
- * phys: Pointer to physical encoder structure
- * extra_flush_bits: Additional bit mask to include in flush trigger
+ * @drm_enc: Pointer to drm encoder structure
+ * @phys: Pointer to physical encoder structure
+ * @extra_flush_bits: Additional bit mask to include in flush trigger
  */
 static void _dpu_encoder_trigger_flush(struct drm_encoder *drm_enc,
 		struct dpu_encoder_phys *phys, uint32_t extra_flush_bits)
@@ -1475,7 +1476,7 @@ static void _dpu_encoder_trigger_flush(struct drm_encoder *drm_enc,
 
 /**
  * _dpu_encoder_trigger_start - trigger start for a physical encoder
- * phys: Pointer to physical encoder structure
+ * @phys: Pointer to physical encoder structure
  */
 static void _dpu_encoder_trigger_start(struct dpu_encoder_phys *phys)
 {
@@ -1558,7 +1559,7 @@ static void dpu_encoder_helper_hw_reset(struct dpu_encoder_phys *phys_enc)
  *	encoder rather than the individual physical ones in order to handle
  *	use cases that require visibility into multiple physical encoders at
  *	a time.
- * dpu_enc: Pointer to virtual encoder structure
+ * @dpu_enc: Pointer to virtual encoder structure
  */
 static void _dpu_encoder_kickoff_phys(struct dpu_encoder_virt *dpu_enc)
 {
-- 
2.25.1

