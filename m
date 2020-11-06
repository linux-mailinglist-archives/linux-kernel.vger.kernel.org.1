Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8510C2A9F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgKFVuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgKFVt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:49:59 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:49:58 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so2655722wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmOPpMPfhIiNWLmfD425Vh4v6mCQcNCmoMGuMYmd5/A=;
        b=TRvyCyTnH/kQfSvaUF+4Mph7uYU4vkWmNwmMg9+BDBN6t+igCS95yEeZ4LEqh4XUXD
         R8eISkv5gAP1hNdQMKo8Ygf8Gve+fObVMUpbtkUZRz3t9vj+Rl5hLbsgS8TFMxYL1psx
         k2F/jE4BkilaJVkYfuqAELthkI0vmyfkkO8Sa7LPXqf0E8s41v60oHpJqCPM9CYOUw93
         kFpqUD4NcLPRLJidrtSOKH515bDJ0/3XSArh4XbtdFHSMyCN2yhSMT34nqX25CCKGZpC
         k3MoG3RpKjMZ29E2uQ4EUbT3Dc9v20vXEg8ajge2Yhd2lTgTdopSaE0V/2USYSKYzNG2
         OhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmOPpMPfhIiNWLmfD425Vh4v6mCQcNCmoMGuMYmd5/A=;
        b=FofoFURSZZbyjx/WVGCQRuR/8kLN7o7bz1+oYs0KFxRh02UNTRUGGlEkI/pkvesDvp
         9G6vX9Tmm298YZDUM+S4cv0YSwStfukBqnKONx4jSSkTg+3erbudZNSqWnbVlvqx58Q0
         Z0OzZPpVgwdNygdTvPd2zBNhWEaTLAPmIgffYlWXGYmwH2NutTfGi0Uu/LLRVLWvo5Qf
         2RsDR3RJfSYM8AhAsHfOL72el0jiJVgkgjWfxDaEJlvXJvxRg7G9PE6+XSxN33/+SHLs
         jNqXNTgeuZOK217dB3fUAmIvBohfuvpgEQ/LfQO4IvKriZKG5PmMOFP7TQ5vq/Q+4ZRa
         wHYQ==
X-Gm-Message-State: AOAM530YWhQ4BTsVmzOyn/qxkXL7gnWX70eBlOSXkJvTpzst/qWRKAcO
        Z+C6bBwG8AKEjf0off50U+hdlw==
X-Google-Smtp-Source: ABdhPJwlneUD3GOe/AzXC/erfEbWyozUYjeiG0s72KxFlAtyLwPy1FkZOocvYKMIlCHlqDhVsYGVqw==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr1681391wmb.54.1604699396872;
        Fri, 06 Nov 2020 13:49:56 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:49:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/19] drm/selftests/test-drm_dp_mst_helper: Move 'sideband_msg_req_encode_decode' onto the heap
Date:   Fri,  6 Nov 2020 21:49:33 +0000
Message-Id: <20201106214949.2042120-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
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

