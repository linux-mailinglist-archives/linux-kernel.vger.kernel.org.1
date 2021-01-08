Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9372EF8CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbhAHUQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbhAHUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1210DC061242
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:41 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a12so10120983wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0vgdR8naA6iZCQ4IL55g07H1SHyqDXPDametYwo0Pg=;
        b=oLM/pC+rSUDP4ZUfp3a6s6i/HWBsHp9Du8iTI2RGZXxY1NVI07AaFBnwpdJlHwG0ri
         VQWy/Y4lQ4XMyQj7vkEB2ONHZswhsBNlxrWqZDqKyDwMCsD0tvwyuGX5oCvKMYmbJvDb
         K39uYXCmZbZuRkO4RkxnD88hGmVCmzqPdBvnFKoWaghzSw40LfLtM0F52BlernQZy5A7
         0+LUMRcbxP334bSPiCN3m1gjS8U5YoMbdS1BgCd6DO48LnFmd+Q+V4szxYZkFUmqmOix
         BGN6f5dDtv1T46Dye2RikAAdhcILtMNFQNof7yhedF7tFiwrW4S39SWbEhIwsG5JY1Mu
         bfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0vgdR8naA6iZCQ4IL55g07H1SHyqDXPDametYwo0Pg=;
        b=lbpVwUftxZH1sRFq7Z40jj9udyHdBKv5jXjZYKi4gr4rY6rgE4qMxLS2Wc8cAraL9F
         bH7bx5LdJuWHVxDrX6oc5IfhwToe8CDNcWo30PrnOtEjLUd2HzlLvnvqNaS9NF5n/jLA
         mufcCySxZI+m2HKIZtEf13NxcoMBnCTv6UZ6h5vdYScwJf5WChM11O1qJ6Grx+3P0bP5
         O4HkujRQ+8du+nQlhmJq4Vgc2qwzlnh/Q+66lDXoghJKMv/fbccVy0BkC5wCQU4nSr4n
         nioGr4Im0/Qqc9sHgEWt00tOjovEyI7/3b24IyQj0y2lzQkeSxD68X+IGHEYoFFZ+RDn
         ZMyQ==
X-Gm-Message-State: AOAM531RldqLu5kGndg8RegvKQKTcJ/WPQjQ3cr+rpUiWCuVaPdE7gkd
        Ng29KHCTSxk7SFqLodOH/dJyEQ==
X-Google-Smtp-Source: ABdhPJyYiKLdjQp26AmRTUh/MggUIUNkwlTVFGf1EzxWSSuGPgRj9sazR71L7iqaa5Znm27QpNWWow==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr5243954wrw.73.1610136939823;
        Fri, 08 Jan 2021 12:15:39 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        George Shen <george.shen@amd.com>,
        Eric Bernstein <eric.bernstein@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 24/40] drm/amd/display/dc/dce/dce_stream_encoder: Remove unused variable 'regval'
Date:   Fri,  8 Jan 2021 20:14:41 +0000
Message-Id: <20210108201457.3078600-25-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.c: In function ‘dce110_update_generic_info_packet’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.c:70:11: warning: variable ‘regval’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: George Shen <george.shen@amd.com>
Cc: Eric Bernstein <eric.bernstein@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index ada57f745fd76..265eaef30a519 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -67,7 +67,6 @@ static void dce110_update_generic_info_packet(
 	uint32_t packet_index,
 	const struct dc_info_packet *info_packet)
 {
-	uint32_t regval;
 	/* TODOFPGA Figure out a proper number for max_retries polling for lock
 	 * use 50 for now.
 	 */
@@ -99,7 +98,7 @@ static void dce110_update_generic_info_packet(
 	}
 	/* choose which generic packet to use */
 	{
-		regval = REG_READ(AFMT_VBI_PACKET_CONTROL);
+		REG_READ(AFMT_VBI_PACKET_CONTROL);
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL,
 				AFMT_GENERIC_INDEX, packet_index);
 	}
-- 
2.25.1

