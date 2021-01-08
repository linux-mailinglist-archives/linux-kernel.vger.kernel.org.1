Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8090F2EF8D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbhAHUQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbhAHUQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC345C061248
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r3so10172891wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltlvlK446O5/kBCmREtmpcuBIIBe0mrhh4gHbZyrmLA=;
        b=eR0e+bPTMpDaQ5oVw+vorFfL18IIvsq9WMtJycz42nqe7lxrgpYAG+NnSqXEbvEPi8
         VS8S6QvbmXY4DPgbH94+g8zc924maSiO9NmbgYltoBkVxN1f2D9fpIwVo7iGozb/ic86
         R3wNL6C+wYq21lo0a6RGpG/We0wBq/no3/33xHyZ0I5G9cBZ10CDxQNUkE7nrutviyoX
         g6nEgtqpjZM7Fei3hvQDT2w7dyEFEmxPNoDLO2Oo9Qjd0XacLjqQBA5gJXQerw8m8LoY
         k3pMqPeXeo6pPh7ItawXSn1KL07TrqeD7nEcVbxfJs9/EJ0g5lBh96lDFF0oFIL7u9xv
         bb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltlvlK446O5/kBCmREtmpcuBIIBe0mrhh4gHbZyrmLA=;
        b=uMZRfr4RVbGcP9rgE78vk/ohtIbgIK0sxYQm1QD9bEm+csVj5Lbakhoc9RCS2tOqEG
         tsTGJyDd2UnjdQn1OMFsKQBvKuH1DS9u2aYUQnS3jiaciR3/+qeP/GjuMFCGcQX41UxA
         8nqjYka3a/1UgDXQpOrcwDsJhttTjeAorayAHPTNEmzIW8i+0tCYx/0q9BAevmV/H5BN
         1uuXIjbQuWzzw452QXXpIrW8EZpyYu4A2RlYTSoda0sWxr7KXNSzqmoQvue33WDa1iwm
         ++bnUXy4vrQ8u6cTjWbq1yDmn29ACY4m+rPLlk2Z/aCjMQnmGZcA+xHtovXOs3FUdO4o
         SqHg==
X-Gm-Message-State: AOAM533Yat17IMnEJlWW5B3NSyf1DLpfH9WywuNTaO857MBissuq+9Fd
        t3xw0y8UNF+tCksWOWZssMPM0w==
X-Google-Smtp-Source: ABdhPJywcpuW4qCShj6qOQWKOuISnPJDe556gUEO7+5pFKdb3vqCRrQBt55/KNmX2vM7BU51pX03EA==
X-Received: by 2002:adf:9467:: with SMTP id 94mr5370698wrq.235.1610136953419;
        Fri, 08 Jan 2021 12:15:53 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 34/40] drm/amd/display/dc/bios/bios_parser: Fix misspelling of function parameter
Date:   Fri,  8 Jan 2021 20:14:51 +0000
Message-Id: <20210108201457.3078600-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning: Function parameter or member 'ss_info' not described in 'get_ss_info_from_tbl'
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning: Excess function parameter 'ssinfo' description in 'get_ss_info_from_tbl'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index d2654c50b0b20..c67d21a5ee52f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -987,8 +987,8 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
  *
  * @bp:      pointer to the BIOS parser
  * @id:      spread sprectrum info index
- * @ssinfo:  sprectrum information structure,
- * return::  BIOS parser result code
+ * @ss_info: sprectrum information structure,
+ * return:   BIOS parser result code
  */
 static enum bp_result get_ss_info_from_tbl(
 	struct bios_parser *bp,
-- 
2.25.1

