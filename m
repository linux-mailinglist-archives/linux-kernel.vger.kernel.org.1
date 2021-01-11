Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C911B2F1F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390941AbhAKTYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403769AbhAKTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863D7C0617AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y17so901994wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2Y1r1imcED85eFixB5AGXQS5WVhMYvk3Zres7MALT0=;
        b=A9a7/txq8Sk8aZPWjqlVS7sQ7X76uzBkQT+uQKbCuBAo6drReTQXWZzzobNcV+49OM
         pvmfjOh3M1yF+g53OxFNO/eVMX/9KDnyoXnJvlMGgp9k5u+2lbEQwmsAiQ+qTe0z4720
         h4sAgdSkVS4WAaju+KzUlV5nDOxBJwQN1H4rB7+H3WeuPQVHAl53ZfPgPt9lvOMG9CqD
         +nMhXKTCFutgeUQqBtyIO5KKAv6e7VamtSiG1HwXUi6EbynxBAZgFFmsZTUMwlIvf0ku
         Ehr+GTNdqFcdN83P3mFAC3mZ/ZuK6kDWklTQaSJBI4NWhVdL1LGS2VZl+jp8araC7iay
         v2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2Y1r1imcED85eFixB5AGXQS5WVhMYvk3Zres7MALT0=;
        b=HkN2N7fR5UZwMSfn/XRtiUxRTSkr8GRIHqStrdzZHY11CdJ6VXXUVsnGACsN/pjhHB
         pXlfplcvdz3d6sWatzXebzazbfiUsf/yPngaz8qW8Doy+ak1y+IZioDielleIkv5MQjB
         G8Clb5uBTS7mVx5uoqWEGpoxjgM6TsJWQjT6seud3evVyP4StkQeVgFMooCjcgInkPMq
         cyisrYoJZ2yYEWeGWOkGxnwnCw/itZvu0HbLGxTjD5EIFLKfddhiS835G2SVrgzkGULm
         AOLl8zGsXtupsKIuaxk3zGRf7mX+KQ4YDzXwBgjzTOpQu5GpaKifiqMqaoOwoWt1lNKp
         93gQ==
X-Gm-Message-State: AOAM530aLvKPpalcIFy0EdfZWps0ejcDwdM9nr+B5otMTF/pvIbu5d6g
        DTr/aOVDxfOv5SyX8tO2bssTpw==
X-Google-Smtp-Source: ABdhPJxMkvS+0WgCtIpMj49T+7z6ZxDRGngvPDkgDzadkF0BRqZKDE3Fxouh4Z8iFzMsZ6o+KiI48Q==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr565190wrt.425.1610392783332;
        Mon, 11 Jan 2021 11:19:43 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:42 -0800 (PST)
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
Subject: [PATCH 10/40] drm/amd/display/dc/dce120/dce120_hw_sequencer: Encompass defines in same clause as their use
Date:   Mon, 11 Jan 2021 19:18:56 +0000
Message-Id: <20210111191926.3688443-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally someone should strip-out all these garbage 'if 0's.

Tempted to carry out the work myself on principle!

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_hw_sequencer.c:53:47: warning: ‘reg_offsets’ defined but not used [-Wunused-const-variable=]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
index 66a13aa39c951..d4afe6c824d2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
@@ -50,6 +50,7 @@ struct dce120_hw_seq_reg_offsets {
 	uint32_t crtc;
 };
 
+#if 0
 static const struct dce120_hw_seq_reg_offsets reg_offsets[] = {
 {
 	.crtc = (mmCRTC0_CRTC_GSL_CONTROL - mmCRTC0_CRTC_GSL_CONTROL),
@@ -79,7 +80,6 @@ static const struct dce120_hw_seq_reg_offsets reg_offsets[] = {
 /*******************************************************************************
  * Private definitions
  ******************************************************************************/
-#if 0
 static void dce120_init_pte(struct dc_context *ctx, uint8_t controller_id)
 {
 	uint32_t addr;
-- 
2.25.1

