Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F612B4E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbgKPRmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbgKPRmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:05 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190EAC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:04 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m6so2481553wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmOPpMPfhIiNWLmfD425Vh4v6mCQcNCmoMGuMYmd5/A=;
        b=qQWadntt/mFLB2dHX6lrFTrO+5jYltfzBzIRsvL1z5Z6vtAiX/okLVJtYTfU6M+6ZS
         XzZpueyoOCEm+ppetpCQb/hIf7iXx7l2KUxEI7bn55gdSyyYDPd9gZdfOyOvNWfft1SM
         w+iuynB+rS795d3bkOrNtC1Xrylj2zsp80gJYvH7zZSfL6Hahtp7qBLDtGOGBcpQcEFP
         DJViqYgYnecWKSHdDGPxR8ed0QSh4us9Z22xp+J6fICeTcd+6MkNOp86MqffqD6smjYX
         23yKflHz+b2Wn4pZ9o8v5+IFG9YZ/IJ13tKgb+qBOEJgoE4oB3VoDH9y+d0FXXQ2jRgs
         kSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmOPpMPfhIiNWLmfD425Vh4v6mCQcNCmoMGuMYmd5/A=;
        b=GOnY6JQ2rc7qKAOzB0Xi/9GgDlRsbNuUokrPSPFyVKPxes+5C1Ox7s2lx1BqPkykVZ
         gGdHFhI8cHgaUIT3W3Y/zKl2Bf5xiJ71BaEzSC8fxCA81qvsG9QKod9gxlPxWO1ch/DT
         i8oGCIPq7hjDvkfBtyahTV+Vj14RpNIJMEadTz04eJ6qHDKM9Ti17js9AhsBeQLm66je
         IkCZuCZJHg7Q3jtev58XcsL/8UMzpInkPRwiklLoHQp1eQbQVizxmi4iH6nVP0FlAFGc
         M2K9DVV0/CSiFwCL0yUKsTfyCHR4I7c2MN+puvmHn1hjmvQZadhvVNFaUECbyQ55thBY
         dHAA==
X-Gm-Message-State: AOAM530ecJBizrahg0lXQE39kcB01HNA3r0O7JPHOxumIZM3xGXZXqv1
        yXpcElnTqdkF9oc9rx7X2rIRww==
X-Google-Smtp-Source: ABdhPJwE+AiRHnGNLBkmlszJMRYyDRr3EsBayn0O2BqS6CGMXtLN5yEZ0ylGG7y5khqkG3OToESChw==
X-Received: by 2002:a5d:510a:: with SMTP id s10mr20125292wrt.402.1605548522848;
        Mon, 16 Nov 2020 09:42:02 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 30/42] drm/selftests/test-drm_dp_mst_helper: Move 'sideband_msg_req_encode_decode' onto the heap
Date:   Mon, 16 Nov 2020 17:41:00 +0000
Message-Id: <20201116174112.1833368-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is too much data being stored on the stack.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function ‘sideband_msg_req_encode_decode’:
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:168:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index e00bdc557f880..6b4759ed6bfd4 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -122,7 +122,7 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 {
 	struct drm_dp_sideband_msg_req_body *out;
 	struct drm_printer p = drm_err_printer(PREFIX_STR);
-	struct drm_dp_sideband_msg_tx txmsg;
+	struct drm_dp_sideband_msg_tx *txmsg;
 	int i, ret;
 	bool result = true;
 
@@ -130,8 +130,12 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 	if (!out)
 		return false;
 
-	drm_dp_encode_sideband_req(in, &txmsg);
-	ret = drm_dp_decode_sideband_req(&txmsg, out);
+	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
+	if (!txmsg)
+		return false;
+
+	drm_dp_encode_sideband_req(in, txmsg);
+	ret = drm_dp_decode_sideband_req(txmsg, out);
 	if (ret < 0) {
 		drm_printf(&p, "Failed to decode sideband request: %d\n",
 			   ret);
@@ -166,6 +170,7 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 
 out:
 	kfree(out);
+	kfree(txmsg);
 	return result;
 }
 
-- 
2.25.1

