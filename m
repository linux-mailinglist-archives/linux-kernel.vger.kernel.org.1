Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679542A819F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgKEOy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbgKEOwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:34 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42457C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e6so2106103wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSkh58f2krzhp2hE3KFf5ZyOONS9hWGvZQYe4kveepQ=;
        b=VlPjzCJT3y6e/FnCd2xLEPBd0z7vGt4Qg/m+b0RlACokUoWDnR7rwn/cE/eawSN26W
         Wz2Vmh8dmVk3cTlLPul5wt3AlHqwThJYpazo4c8CHYlLlbi+um3zq0XC/BntQDQDlSug
         qP9xHZoWAqIhvGMCzQyBkgpS2fxEnGPkSCmwP4o0tV70AV7CwMxNJ4dHIVzUHDawwKnM
         N5OzXuMeIbtujOq7o6yjhUQubbYvD45CJls1gsJCnHgAiyv1oWrRGm42I+1RxN6LOq70
         jYUJep8G9BsTpyns4E0uVhkbNw80eZTOMgIaaedtq1GBcTjO4/U4C4y6dYJ9oZ70BJk7
         ocIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSkh58f2krzhp2hE3KFf5ZyOONS9hWGvZQYe4kveepQ=;
        b=Pom0/s/QGyP3N3g7EDevQnkq4L6tLtlNjpuzjbfYvZZOE7RGX/08u9fHoIgTapEWAl
         4qR/68I/DvFRKL5lrBgMRrWWNNl1eDQnbZJy9UGKeKnntVCM0eqwDXvkJ9T1P5sZg1u0
         kA757Q01VoS6/bwWtoZoDhJ6pXWESlM/cgf5waENFIKnp8Z0HWOYtr8LT8LvQBHgkV65
         LEK70sKRiCQtna+757wqTKuSf/UMCGo/R2SgQzkQzCLRuEwBfGav+AO+YwdCd/jxo6H+
         0UV6SJiCGBJIu1ABgdQ6VyN9mhTdYHlmn6Tq6J3I6iHX34UVffDfJ/OZGELc1D5Ror+h
         mAFw==
X-Gm-Message-State: AOAM531P+ioABLD6NytJx1Bo0ripNS2c4DshYt//hnjrU6Hh8HAELMHW
        j53zrqr/6w1ZejIvO7xKz8WBbw==
X-Google-Smtp-Source: ABdhPJyLybY/q1JINhhp6tsqqnQa/WrE4fpJ0FtSt5uywWd1JtbavxdvLo7R9GEFsr/3kV4i58KbAw==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr3530595wra.54.1604587951999;
        Thu, 05 Nov 2020 06:52:31 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        David Francis <David.Francis@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 14/19] gpu: drm: selftests: test-drm_dp_mst_helper: Place 'struct drm_dp_sideband_msg_req_body' onto the heap
Date:   Thu,  5 Nov 2020 14:45:12 +0000
Message-Id: <20201105144517.1826692-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stack is too full.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function ‘sideband_msg_req_encode_decode’:
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Francis <David.Francis@amd.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../drm/selftests/test-drm_dp_mst_helper.c    | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 1d696ec001cff..0a539456f6864 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -120,44 +120,51 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
 static bool
 sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 {
-	struct drm_dp_sideband_msg_req_body out = {0};
+	struct drm_dp_sideband_msg_req_body *out;
 	struct drm_printer p = drm_err_printer(PREFIX_STR);
 	struct drm_dp_sideband_msg_tx txmsg;
 	int i, ret;
+	bool result = true;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
 
 	drm_dp_encode_sideband_req(in, &txmsg);
-	ret = drm_dp_decode_sideband_req(&txmsg, &out);
+	ret = drm_dp_decode_sideband_req(&txmsg, out);
 	if (ret < 0) {
 		drm_printf(&p, "Failed to decode sideband request: %d\n",
 			   ret);
-		return false;
+		result = false;
+		goto out;
 	}
 
-	if (!sideband_msg_req_equal(in, &out)) {
+	if (!sideband_msg_req_equal(in, out)) {
 		drm_printf(&p, "Encode/decode failed, expected:\n");
 		drm_dp_dump_sideband_msg_req_body(in, 1, &p);
 		drm_printf(&p, "Got:\n");
-		drm_dp_dump_sideband_msg_req_body(&out, 1, &p);
-		return false;
+		drm_dp_dump_sideband_msg_req_body(out, 1, &p);
+		result = false;
+		goto out;
 	}
 
 	switch (in->req_type) {
 	case DP_REMOTE_DPCD_WRITE:
-		kfree(out.u.dpcd_write.bytes);
+		kfree(out->u.dpcd_write.bytes);
 		break;
 	case DP_REMOTE_I2C_READ:
-		for (i = 0; i < out.u.i2c_read.num_transactions; i++)
-			kfree(out.u.i2c_read.transactions[i].bytes);
+		for (i = 0; i < out->u.i2c_read.num_transactions; i++)
+			kfree(out->u.i2c_read.transactions[i].bytes);
 		break;
 	case DP_REMOTE_I2C_WRITE:
-		kfree(out.u.i2c_write.bytes);
+		kfree(out->u.i2c_write.bytes);
 		break;
 	}
 
 	/* Clear everything but the req_type for the input */
 	memset(&in->u, 0, sizeof(in->u));
 
-	return true;
+out:
+	kfree(out);
+	return result;
 }
 
 int igt_dp_mst_sideband_msg_req_decode(void *unused)
-- 
2.25.1

