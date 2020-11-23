Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03B2C0453
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgKWLT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgKWLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:19:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91449C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g14so2998494wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rspc5DyHTiyjnt/zI3mhKCdrn/a3BO0urzTMZbliFpc=;
        b=ccDG24NQJV0M9KJ61WwazAEpBTPdZvVnUdJfyhTRyScfWGmVgacHz/60yz8QINN5xV
         MHc2Q5kRSuZ0EkpeuuLPxslbzc0RQluMm9BfqRo8+48ba3QnOlzMo/gwONBYO7BhoX0y
         NpB+d1tfjRGT6aFGGvnKMh3ZKCpwtgYGvYKDsQCXTKqGm8uziiuSsiHeGZ3Nl8GR1DDx
         de8bYMXazjeAI2NbukBgfZz2yGFSmJF9rKIIoGs8NlKUZcaJ84TCTYmZby5xAblXi0Jj
         5GuPVXW9KTz7UU24M8bR2DeFOhn1Dh5/IqKeaymMW3XGdzJWS1e2lOuvZYRYmDNWSh0M
         FNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rspc5DyHTiyjnt/zI3mhKCdrn/a3BO0urzTMZbliFpc=;
        b=YhPTF5ZfrfUYmRrsPTkHdds1TXAoHWBuZxoAsevznzqAn8O25zu/i0rynnIlZT/ke2
         /UJg39mnojDvJc3pB2aBZrsGBNoFBAxn8huMMGy0pHjGCr+AstfRqO1g0Eu2r4/YcAsy
         b8MCiPYku85J9vKnUTdOAKkiK/SOsQm7+JGI3oEt8zcklVyn9feP9NWuP2rin7IjtfrV
         oSus7dmpb1IzzvR4di5klqrrS8Ib3Xv3yvktK/mNGRUkzWwEDIq6kxQDhx42cUItYYxd
         TjsAmtL1Re2OGSCaeE1tmowqnq32BJ62AAj7wl0ScGWtVr/Anzx2ZAy6DJn4ZAxAH6Wo
         6xdA==
X-Gm-Message-State: AOAM531J9uajlRMlbN+G9qFvyTSrwFCNCVbLyRentBSx34PhbGMo6lSo
        ujBBQRbA0ePjiLLaXesy2mhCaA==
X-Google-Smtp-Source: ABdhPJwCK6jYnSWHSowYPd1FM/wjZ/1t8IxyK5UDB5ZjFKBkqXT0dGW7ebvAbZHCMZrE7UCQQx1fWw==
X-Received: by 2002:a5d:690a:: with SMTP id t10mr11961847wru.203.1606130395314;
        Mon, 23 Nov 2020 03:19:55 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:19:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 26/40] drm/amd/include/navi14_ip_offset: Mark top-level IP_BASE as __maybe_unused
Date:   Mon, 23 Nov 2020 11:19:05 +0000
Message-Id: <20201123111919.233376-27-lee.jones@linaro.org>
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

 In file included from drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c:27:
 drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:179:29: warning: ‘USB0_BASE’ defined but not used [-Wunused-const-variable=]
 179 | static const struct IP_BASE USB0_BASE ={ { { { 0x0242A800, 0x05B00000, 0, 0, 0 } },
 | ^~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:172:29: warning: ‘UMC_BASE’ defined but not used [-Wunused-const-variable=]
 172 | static const struct IP_BASE UMC_BASE ={ { { { 0x00014000, 0x02425800, 0, 0, 0 } },
 | ^~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:151:29: warning: ‘SDMA_BASE’ defined but not used [-Wunused-const-variable=]
 151 | static const struct IP_BASE SDMA_BASE ={ { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0 } },
 | ^~~~~~~~~

NB: Snipped a few of these

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/navi14_ip_offset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/navi14_ip_offset.h b/drivers/gpu/drm/amd/include/navi14_ip_offset.h
index ecdd9eabe0dc8..c39ef651adc6f 100644
--- a/drivers/gpu/drm/amd/include/navi14_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/navi14_ip_offset.h
@@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
 struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ATHUB_BASE ={ { { { 0x00000C00, 0x02408C00, 0, 0, 0 } },
-- 
2.25.1

