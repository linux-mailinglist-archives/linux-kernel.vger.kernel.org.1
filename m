Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDA2C3109
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgKXToZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgKXToO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:14 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2378C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:13 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so6012363wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMRPM9I1lRNzH88FtoqbWHR6lT2TOJ7GT2PZsC4P/7E=;
        b=Pv1nAl+XofxDOZMywxILqcP4qIfKofxo/gaSMnaL6TNvz2rt53Q/joRSKnqpI7b53o
         +mFQmg+10YbgQAqbu6F/cdCzPBL58XI60OMwNhhOmGOdPuoWXcqr88wOld6btC+12xTf
         vHOZo7K8jnHhrisjkOZOwcL8kDhmTh9ZMP4QGo3QnFq1KxzD84c366EnPZGiWBR1rvXX
         hlQ9n+fPeXMkpACeuYr0J69YEKM3NGMCv/LM9NFvZZ/IzMjhZRGShhD9/7VZmk25Gm2f
         VqeMCMauBULX0332aSWQFCo5DEL0tMUuX4zfbsqua/L0qPD8eIEnuUlEv//H5f+tcSu5
         8v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMRPM9I1lRNzH88FtoqbWHR6lT2TOJ7GT2PZsC4P/7E=;
        b=TcNU7xdl4aTTsmtUPjYQt2YkSJcufn0HNawT4Z6nfh/lX2dK/u5Q7M8OqqdxFOiTYl
         d7ClCYowzQJci0vr9fOmSZnBDYIgGEchSvz1VTUpQS9kOZPtW/YCkEBzn/B8JuxpQ4cw
         dnmWfSujoZjoqBOxYmsItaveOxrGRhQmCyKha78i4cFfZ4tQ1MHLdyUAXhkBE2I2xXZd
         inNBUavSSLxgxZndIUAIg9e3sZjsbHns9TwWwy5YaSMRINe78wmQ7DE6Mw5ahY7Q+YCP
         cc/d2qFH6Dytfa9vAcD6JIis2GGqbcYtyusr8MfNZXEpZ/ILLLiDiBQMWIPKr4sPbSOf
         HC9A==
X-Gm-Message-State: AOAM532G/1j7GNVpfgxtvlXZovGZojv+hWwBzMUDa+KzDmbDPDZQx/vb
        JTrbhHSdQNx5v74L/a/eJTq/dQ==
X-Google-Smtp-Source: ABdhPJxtPeOQq1Pn1Ae5Xv1UPMN/ILKfgZPrpa0CptICuNWu7dvVV2HkVJwgEEZQcuPZyY8YjfDuGA==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr78636wrq.11.1606247052702;
        Tue, 24 Nov 2020 11:44:12 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/40] drm/amd/amdgpu/psp_v11_0: Make local function 'psp_v11_0_wait_for_bootloader()' static
Date:   Tue, 24 Nov 2020 19:37:55 +0000
Message-Id: <20201124193824.1118741-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c:223:5: warning: no previous prototype for ‘psp_v11_0_wait_for_bootloader’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index edd2d6bd1d86a..bd4248c93c49f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -220,7 +220,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	return err;
 }
 
-int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
+static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 
-- 
2.25.1

