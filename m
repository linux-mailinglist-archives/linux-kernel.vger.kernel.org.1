Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E112B4E18
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbgKPRmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387813AbgKPRmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:04 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD208C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so19674914wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TjcKYWuzDhqklR5qoTIUsTytnZe/lM+b0Bx4U4tTS3A=;
        b=sU22MNf45vVUHSsYOdy9fl9yIGywaq3clCbLYSUdwuJl0SOFI02Lsd0y793lP8J6Rk
         rPkBRR7UXN6FZZWxOCbado478weeCmgsuYDA2GENsiflFpTuvK+0sE2pkFQD1xqN3M63
         zW6V3eyDvMX99Ec4jMu4ywyLi57RfvGLgaUwkywJ7QNJ040N40KGfN+YHqdl9CMF/z9x
         We/t8grpmbCU5c3UVZ1bHCbKDcJY4xcWcvl/OFHGBz9SwOE6y5t7HZyfNxZepyLrNsfx
         TrcS04JbRFhulNsEItHdk1Pgvb5ivEtH1MUNujY9SVgqgD+oiBNJUW4W5BuZSJ0cWA+t
         1mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TjcKYWuzDhqklR5qoTIUsTytnZe/lM+b0Bx4U4tTS3A=;
        b=gBbef70EUf+W+01ynwo+zV9Xtjizaow/1xuCuOQNbh4gupjMHo+6IPIx8jSPCOUfN7
         BYEDGQW2p64h0AGG1vTjVxTYKCR0AS+5e0putpZReqswTbQUWwxeAvU/OIs4FkaeHpyj
         jkN71bxuE8KgkrFmQ0MDG+KbOmw4e23pHqA6i29/sEkg1O5UZ/h/MeTtQmkqgRkHH1VN
         zAVURI9znKJgw5DitmhkvZ4ge3XDio9UihSPED8KbY+1KPm9DhYpbpzyX8qdfmzcUMvw
         2oz2/ch/XRr/h0uAbJ8EmjuZ78mFmjyGjP7vLoF+Cs8iOLCnPamLXRniPjPH856VVehn
         UG4Q==
X-Gm-Message-State: AOAM530noGUOdoDsqVAnOM1WV5GoK9KkdI4TfWTkWFcU+MldAuvhLDGk
        SxAWfV2CN5ceEw8LUCBvmiplDw==
X-Google-Smtp-Source: ABdhPJy1yyaqbtAV862cd0RoEAr1Ke/mk6oE5G4P2h3GHj95qMG7W+9SB8wzWyLsernWsiTuWwQE8A==
X-Received: by 2002:adf:db4a:: with SMTP id f10mr20402689wrj.420.1605548521624;
        Mon, 16 Nov 2020 09:42:01 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:42:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        David Francis <David.Francis@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 29/42] drm/selftests/test-drm_dp_mst_helper: Place 'struct drm_dp_sideband_msg_req_body' onto the heap
Date:   Mon, 16 Nov 2020 17:40:59 +0000
Message-Id: <20201116174112.1833368-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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
 .../drm/selftests/test-drm_dp_mst_helper.c    | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 1d696ec001cff..e00bdc557f880 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -120,44 +120,53 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
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
+	if (!out)
+		return false;
 
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

