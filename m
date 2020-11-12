Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC862B0D28
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKLTBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgKLTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA54C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so7148828wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1giXMZdt7DXXb4r+KpLOxZ7r3xrDsxCnH5SvILJq7Y=;
        b=ib0DToee6dhVaRCUYKKSQZMNQ/g4EomiT7zCeAwept+8CGssffnj+IMD9+KiqTmiZj
         SGEOXt3jJRypKYdUcKHv/clochvz8K0Thkh9J9nRJEr9WICmtddIe800t7AbEKn+kOFZ
         QOimSE57uPMsVNj95xM3N3msL0+JXs46v/cw3S5mzNx6M3Z5SMFThcN3/SLyEMNkCsoM
         uZZ5zQjvQ6ToX1qDTiXDHZJKKH29DcPFRIA9lWJ6ryGv21IT+mOjGFmoPVNwP6e89fPO
         1yJ9yzLTZKjqtYrAAXAlsWtnYc8H9MMNFADImPh+MXjWW5AY/Mn5BjDUvZvIr3Nutgf+
         Vwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1giXMZdt7DXXb4r+KpLOxZ7r3xrDsxCnH5SvILJq7Y=;
        b=PCNie5Z9N/DRpQBG/Fu0vk/r6b5Uz3NnB9KhHtW8lMHGaU3DIuxL8hFRtZE8BmiOV9
         ghHefKC8Fhvi707Y99FISutSeH1+qXgPmT1mid0tEBNyiucQJUg0e49bMwX1UvcRqDm/
         zYc/HB9u6iRlkh6NQrVY9/aiRfG8wtLghYELGL7lO16c8YiFkrhSDMow/ufQRV91Yjpv
         3ORgM6RzgwRQCJeKOIdlrbgP0H7jogSq03R7Gk+NLzImMZl1L6/iZ/q9cUbHk3CAX2c/
         MGfmsPb01MZXY3XUQJ7ark36+Asv29ar9WNZvSAfYlI7/mNHZ4Wfy7sP0L7i3QFsllVY
         dK+Q==
X-Gm-Message-State: AOAM530lslTcCTBme+d1PvKl6ZiDXNZ/KI/EcdGRsh0mEXGjGfabwgqp
        SU91mcLBiG3vULOigDatjAo+HA==
X-Google-Smtp-Source: ABdhPJzNHArCwbL4pI4uwIksua2841x4CDh9pe2Fw90mcckGWAkWLhZAVXF5LL+GbNyzZfSJFQ7Wfg==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr1119093wrv.266.1605207660599;
        Thu, 12 Nov 2020 11:01:00 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/30] drm/amd/amdgpu/amdgpu_kms: Fix misnaming of parameter 'dev'
Date:   Thu, 12 Nov 2020 19:00:15 +0000
Message-Id: <20201112190039.2785914-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:487: warning: Function parameter or member 'dev' not described in 'amdgpu_info_ioctl'
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:487: warning: Excess function parameter 'adev' description in 'amdgpu_info_ioctl'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cec9aad8bdfa9..98721ae931841 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -474,7 +474,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 /**
  * amdgpu_info_ioctl - answer a device specific request.
  *
- * @adev: amdgpu device pointer
+ * @dev: drm device pointer
  * @data: request object
  * @filp: drm filp
  *
-- 
2.25.1

