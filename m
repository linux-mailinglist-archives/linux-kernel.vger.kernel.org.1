Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E552F45E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbhAMIIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbhAMIIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:08:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ADCC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i9so1073352wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaeomoLKGJGFe9Jgp55uGAQ2Av3znwR4r6zsWFi8gnM=;
        b=a2yKsTYGdiUbLd2mWkidqDrvPlvZZ5FXmHZVOI/ZJt+qlTpDD0GPY4yO5CwlZ8HtQX
         0JP8bJnuDFhtIZX1D0dj9X0+M3/awU24gnWGEjvC+gnwrJdEgynvD5CPVCSHFPUtDrip
         gxbZ2yJ5xi/21obPp3WmjV+icfhym+bWGkbTX3nGf0YR/R1p/d4zP+hlk9ec8bHrgu/D
         IShsSLZkxsSIiirqu+vWB0t93ZDvQnGHPhgHHSUVLjbHqGz4HETSbmmvS9WX+nlcexj0
         WK/8uAY6iaR7JanaWIV2IJWncfRb0NRgC7UzcN6HSNHQ9IkLkQITeLeiOv658ORyBAbH
         nEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaeomoLKGJGFe9Jgp55uGAQ2Av3znwR4r6zsWFi8gnM=;
        b=CSCfmsAb51nZzx8wx2hI6djO163iM0cTPcqwY/ND8L5K/bmCPVv4hYzO77Bb2i/gm+
         byZgrO7UTLIGrh5nNbs4iJ7Uk5bp+kv0n4sw00oZadcAMSD/gNpjvVBXo/4icf4EKaP/
         1PeYqsgTm+z3Qksets03BG/OXe9tozWPHeQr4EFbAK9Ja66L9DyiW2kaAG1IbIxxExIg
         /cWCX4MqbVzKp6mfWrsYUDP+2wnoMgI90x8WT81cH8wZEi9JGg+i1OKsWrtYHTyVQkVr
         aQh5sz5LyLB+l6xkVn8YZ/ar9Sy2LqKuxQjRCzJs0i1U/J9hhzWFAcNKgS/mL9tFAqFW
         w+qA==
X-Gm-Message-State: AOAM530sa5BSedHYqPTdUaG298DrhjnzwTRKqngCa19XS+yll8MXffSK
        NKwfimvaHZ8PstqcPAYJaCmARg==
X-Google-Smtp-Source: ABdhPJxIZoMKbNb4w1ZkLvZdmGtnOn5BNOh8NDCqXHBOlvTSHKkCv5v+l8IjyN/hBBVS5ACPhV0amA==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr1203353wrq.19.1610525279883;
        Wed, 13 Jan 2021 00:07:59 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:07:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 03/30] drm/amd/display/dmub/src/dmub_dcn30: Include our own header containing prototypes
Date:   Wed, 13 Jan 2021 08:07:25 +0000
Message-Id: <20210113080752.1003793-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn30.c:83:6: warning: no previous prototype for ‘dmub_dcn30_backdoor_load’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn30.c:118:6: warning: no previous prototype for ‘dmub_dcn30_setup_windows’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index f00df02ded81b..7e6f4dbabe45b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -26,6 +26,7 @@
 #include "../dmub_srv.h"
 #include "dmub_reg.h"
 #include "dmub_dcn20.h"
+#include "dmub_dcn30.h"
 
 #include "sienna_cichlid_ip_offset.h"
 #include "dcn/dcn_3_0_0_offset.h"
-- 
2.25.1

