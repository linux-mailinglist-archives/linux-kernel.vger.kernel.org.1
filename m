Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487782B1C78
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgKMNuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgKMNua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:30 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D7C061A4D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:29 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b6so9994720wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QYNTgRMVpRNL/FiK5ZAGdhQROE1FVRdCXLrN0ldkq14=;
        b=xbhv4k28x+rz7JYkl2nx+QIT1GO56rWtWgOVjpknc5Ye22Krl6lwzpW/2pOF1sCTy9
         2qJdTAnkUlFwEnmBo4XLt7h5rcQSg9vIHupq1v00bkPrICVU2Nr0U0BUPPaLocEBpsQ+
         4nJJonTvzNCGOCheLsfA5+uAxLmCTzjye3iipYGSA+dpTipVS2MBA3TbYfBnAYXuuiFb
         pvcq/v7eAhIXepTQQf+HvsBULlp1ndJZxlNDzogMtJ53kGXnKUTAWbOBLYHD+k7lbsPd
         m8NDRWDuvyKir3o6os4/s+FRDX3Zo5vPJeT9AFmJbroj6Km9vFfc3gxcMjvhND8EDXCl
         23tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QYNTgRMVpRNL/FiK5ZAGdhQROE1FVRdCXLrN0ldkq14=;
        b=kvtWcwb7wgvwwlYOyTadiAXWmwlYITfcK7M023XyA8IXGRWSBQNLB85lGQDyYpq6rW
         LIFiDOxyvvHvo3K704trspq+Pv3ikv8CCrJfVjMjN2xbpFLMPVyM7q3Kx0SL8QS0P6Ls
         al3zXmlVLofLbxwqGCJHd59iS41sgFxrxXTW0U2tgjcgf7EOqjKUEi3a/jtL5XPt4hOB
         2o5mp4iPFo200i8S3uAtNIB3c1OV2SJ/TF8SAb8C/3t2aYO47cQSM6EfYKLhD+aMAUk+
         VUAxJmZdeMMbPMDnawHUJAHwZbk+a82sK9dkQ4A3G70EHkWrrNB5X8nOhR6naepzZjDR
         LKVw==
X-Gm-Message-State: AOAM532/ldL7WyQTk/gR6MEpjqV3qVSp/KZI1GHZgshNtRPFDK3SgxEe
        cgsezzVjEaJcVSxlBmbtu9XJ5w==
X-Google-Smtp-Source: ABdhPJxGg8xVfkoLyRKc98fsfddvDgvzg2WvnhfQ31H4T81wJBlY94sbHLHZQmkIg0Ktxg25JJV+9A==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr3532493wrw.176.1605275427821;
        Fri, 13 Nov 2020 05:50:27 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 37/40] drm/amd/amdgpu/smu_v11_0_i2c: Provide descriptions for 'control' and 'data' params
Date:   Fri, 13 Nov 2020 13:49:35 +0000
Message-Id: <20201113134938.4004947-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c:225: warning: Function parameter or member 'control' not described in 'smu_v11_0_i2c_transmit'
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c:325: warning: Function parameter or member 'control' not described in 'smu_v11_0_i2c_receive'
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c:325: warning: Function parameter or member 'data' not described in 'smu_v11_0_i2c_receive'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 7fb240c4990ca..5c7d769aee3fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -212,6 +212,7 @@ static uint32_t smu_v11_0_i2c_poll_rx_status(struct i2c_adapter *control)
 /**
  * smu_v11_0_i2c_transmit - Send a block of data over the I2C bus to a slave device.
  *
+ * @control: I2C adapter reference
  * @address: The I2C address of the slave device.
  * @data: The data to transmit over the bus.
  * @numbytes: The amount of data to transmit.
@@ -313,7 +314,9 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 /**
  * smu_v11_0_i2c_receive - Receive a block of data over the I2C bus from a slave device.
  *
+ * @control: I2C adapter reference
  * @address: The I2C address of the slave device.
+ * @data: Placeholder to store received data.
  * @numbytes: The amount of data to transmit.
  * @i2c_flag: Flags for transmission
  *
-- 
2.25.1

