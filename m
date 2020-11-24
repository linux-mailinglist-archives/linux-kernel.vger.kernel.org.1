Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8A2C3152
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgKXTrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgKXToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:10 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF0C061A4F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:09 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x13so80593wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zomKjMWIzPWrEYw6ovqJZadIuaIS2jNkIlpZKRH8vHs=;
        b=Cybaq8YBYtuTaFR9pBITA1eQRnSBpzhBLkn4zNF+2G3HKC8ZoZ6IIv1b5/uH9fiyVm
         34zogKau3MdUz9JhxsXYpQdi3G7agieql+9jT4s0GActMXzOvScBl0L6AxuVTQHjXCwd
         8XbMr1LcfHVtvjKBTRkxNgaBWMC2klAWVbsp2zM7N3lf+v1GB61U9DU2YYCWdoM9nUtF
         TUzZ+vpHwelItISKNaByhSP4b0gb+/zFCFhXKorLw2zAsz3s148A3UfUpuqf5D/mKslA
         uu66sHvtiZtIKh/qjMtlnJMmd75EIOucoeNL7XXgS8oINJiY9f1yxbNsWiStD/hjpNUi
         YMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zomKjMWIzPWrEYw6ovqJZadIuaIS2jNkIlpZKRH8vHs=;
        b=UjAPpgnhhCoapzpGvYW3occSn2qxcQz4sVAMM/UVFz3C5ggscUDNvQv3RVgxVQ5qIx
         OljnYm1QeixgaRIWsJTnq0hirpFYAVc9GmzUNxM0QpDrq6Y3Sq2UjxK2McKKFDlArPNS
         1yxh2K9I2UOapS+1B5UBcNU8f4RSE3deFENNHWbnPCvlGGocpvPTpmBZWVXLU60csiRV
         SULKZRjmNGC+pYUexBkmg/GYFS8U5aC4QoFIyuLR9Dy9BDNViQ++0Ydd/acAQLrzJd1m
         5sZFEn4pxnOCKZLB0pCU4Jtg7dlS2bzyt8USM2JuAQEpAiqu5xG4K8zqNjAG30oqU4cG
         YFZA==
X-Gm-Message-State: AOAM533vfImWykTF08+CV3KrKeCzPTGwteDwg//HLxbAmi8EH+9RCvoq
        ryJ8JGbJLWrTEtw3cbsYxI7zMA==
X-Google-Smtp-Source: ABdhPJyp6RogQVTezKIu79LTXpjXEtp0sMVK4trAa640b+djxzfz62EpQey4z/X3AvcXXAyXJhkViw==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr173565wmu.31.1606247047808;
        Tue, 24 Nov 2020 11:44:07 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/40] drm/amd/amdgpu/amdgpu_psp: Make local function 'parse_ta_bin_descriptor' static
Date:   Tue, 24 Nov 2020 19:37:51 +0000
Message-Id: <20201124193824.1118741-8-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2576:5: warning: no previous prototype for ‘parse_ta_bin_descriptor’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 74cbaf2126982..910e89dc324b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2573,9 +2573,9 @@ int psp_init_sos_microcode(struct psp_context *psp,
 	return err;
 }
 
-int parse_ta_bin_descriptor(struct psp_context *psp,
-			    const struct ta_fw_bin_desc *desc,
-			    const struct ta_firmware_header_v2_0 *ta_hdr)
+static int parse_ta_bin_descriptor(struct psp_context *psp,
+				   const struct ta_fw_bin_desc *desc,
+				   const struct ta_firmware_header_v2_0 *ta_hdr)
 {
 	uint8_t *ucode_start_addr  = NULL;
 
-- 
2.25.1

