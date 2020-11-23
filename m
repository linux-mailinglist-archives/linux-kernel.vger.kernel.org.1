Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7A2C0441
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgKWLTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgKWLTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:34 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24442C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:33 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so15633564wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6TxZrIbNMVP7o8ffQeQ+THJAoGZCcLMTEIXjKM9FgM=;
        b=QEiN8BF481vy1itk5mYNjHhp3ODhlFKpcihyTsun19jF9lCXKIV2KOMFVEhiFp9nf1
         qXrEGioY6tiSMg08hq7mG0Xx2MWEhwzooA3zubf41pDhYVtUDVBhWqtMCngxLMZ7iGNd
         7/D0B5vel1SGQ38TejgEeUMBrb55noT5ERpnHpIjeemmSZJBCax5XBUBd99gtFd/wrHA
         204okbOUXn24oqRQowzeU3NYjsXBaugokDNaQfuNsQFkhEhgb6P/Cs1eSjVqeD64r4/k
         wSmIWIhgiWGoOONiWrN3St1U7CfX23RzS0sr9bNZgDP3WCFnbiG9JZrTE2zXaivI0W4f
         RJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6TxZrIbNMVP7o8ffQeQ+THJAoGZCcLMTEIXjKM9FgM=;
        b=dJiyekPc1Fhy/B98WDVfwIK4JwGANDEX/2tI43xY4hXnbug5C9Fg5Ej2g8QbkTpacn
         Aq6vQTuy262315IufId6FGNMEPw/QmVR7ZjZQHwb9HmQXOr157A/5fPl6cvbUZK94u+m
         HZUStfig1SY//FLarODqcKzvOCR1oCfBDHOWwSI+mUgTm4EVK+DOr6mj7K86M/Qgd6lD
         yCC/4t6Q64WqE4tZ2SeGkQ5z55/zWhCCD6aJjpoGpUT3QGX31sk9pjiCRjMisu0wWf2f
         8ZUZS/qZTyS67O8+zQ854LfZePVBeOtwuweakXCNuTx/kjNJedW5v0FCFQyRZfJTcKMe
         Jlrw==
X-Gm-Message-State: AOAM533mH/h5TX1YaTtjEQsQR6AWl8nLtfrQEerkm8jx5y4U2EH5s45q
        dvi84uxsW8/cPQ7Cl4w7ZryGRw==
X-Google-Smtp-Source: ABdhPJw5sV/lyQ2vBt5hnGdFgueJFj1mlY3MQP/jo4kh5m98ZS07N7plke4XzDo8WwclZZlteV+fvA==
X-Received: by 2002:a1c:2384:: with SMTP id j126mr23894310wmj.116.1606130371886;
        Mon, 23 Nov 2020 03:19:31 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 07/40] drm/amd/amdgpu/dce_v8_0: Supply description for 'async'
Date:   Mon, 23 Nov 2020 11:18:46 +0000
Message-Id: <20201123111919.233376-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c:185: warning: Function parameter or member 'async' not described in 'dce_v8_0_page_flip'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 7973183fa335e..224b30214427f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -176,6 +176,7 @@ static void dce_v8_0_pageflip_interrupt_fini(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  * @crtc_id: crtc to cleanup pageflip on
  * @crtc_base: new address of the crtc (GPU MC address)
+ * @async: asynchronous flip
  *
  * Triggers the actual pageflip by updating the primary
  * surface base address.
-- 
2.25.1

