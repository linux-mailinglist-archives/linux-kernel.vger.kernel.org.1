Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC532C0457
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgKWLUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgKWLUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:20:05 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF76C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:05 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so17534356wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qHfHJykVaqUxn8L02JDHmsfIL28LId8QRd31LMjrFmg=;
        b=zzCeS97E1b2WK6Wk02PoTbIMKdaOnWgwalJAZYW6kwBbUSHZfi4uctzruRAlBrBi01
         s1g0HUaTRY5GThIHL7s13m0kRF6AJUh51MBDnO1qSJ7R/Wjzz/1nZTgq3gQzdgtND3FG
         NxT7vDDk6oQpm2vYXtu0NykiMUQIPq+CtF9c2Q2iknriAg/d2LVw3UCzJOznFEIHj1Cc
         D1kKx99KdYvIn+VtlknG6LvZS8vcg1IpQeN2QXBQdQzGMf+KOxB39PXcZwiiOA6JxxH3
         jrdCSO6PhSuIiXZ4xJL+9JROKhcgw1XIO3QB2KkHHsqLYKHYLFJf0sK5jjGG5m3Ey1RQ
         Ws2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qHfHJykVaqUxn8L02JDHmsfIL28LId8QRd31LMjrFmg=;
        b=JXn4RbVNSonZEG7rdVn9xG8UNoyWYnBSgQGegElQ403v5USN/pOjkGlwLpmgih+dIq
         Da3X3SqcU6oOYpHCeTFXxkz3V5Vd0Z0YOK9ZP4iswyQJe4jutjjVoWy1vrodZW6qRuia
         KD2m08LWFTlvTeEBu5kDHGhhu0bmnKeYGTg64WzNP78dXNS4enlNsWIgBTU2pRLNst0s
         jmc9TtewLoK/iQ95dowQtTY0ttbeHUhINkVOTwmQq3RJUc7y2sRBMUxMBG2xY5HPi7TM
         biTHdDEIkx6ZQgX7n2HfmGbiDacv8Cc2fG+poL+l4mr77PxAmcOY/TuSQQIZOAqTbVwY
         ineA==
X-Gm-Message-State: AOAM5329M7klG+0/N4dkbFw9FNPB47X+RXpFBSXHZhEMsdeemGaDaJV2
        KFYz9fqMSLz3mSWtFp805r4Mdg==
X-Google-Smtp-Source: ABdhPJy+3wxz4JBnkJplQfa7wJSMtD26XO+XdnHu8vJdN6Ka8g9Y1bcXVHrKX2TUYDMHzdco2xDKRQ==
X-Received: by 2002:a7b:c94d:: with SMTP id i13mr23152695wml.130.1606130404056;
        Mon, 23 Nov 2020 03:20:04 -0800 (PST)
Received: from dell.default ([91.110.221.218])
        by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:20:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 29/40] drm/amd/include/vangogh_ip_offset: Mark top-level IP_BASE as __maybe_unused
Date:   Mon, 23 Nov 2020 11:19:08 +0000
Message-Id: <20201123111919.233376-30-lee.jones@linaro.org>
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

 In file included from drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c:28:
 drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:210:29: warning: ‘USB_BASE’ defined but not used [-Wunused-const-variable=]
 210 | static const struct IP_BASE USB_BASE = { { { { 0x0242A800, 0x05B00000, 0, 0, 0, 0 } },
 | ^~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:202:29: warning: ‘UMC_BASE’ defined but not used [-Wunused-const-variable=]
 202 | static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x02425800, 0, 0, 0, 0 } },
 | ^~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:178:29: warning: ‘PCIE0_BASE’ defined but not used [-Wunused-const-variable=]
 178 | static const struct IP_BASE PCIE0_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
 | ^~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:154:29: warning: ‘MP2_BASE’ defined but not used [-Wunused-const-variable=]
 154 | static const struct IP_BASE MP2_BASE = { { { { 0x00016400, 0x02400800, 0x00F40000, 0x00F80000, 0x00FC0000, 0 } },
 | ^~~~~~~~

NB: Snipped lots of these

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Huang Rui <ray.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/include/vangogh_ip_offset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/vangogh_ip_offset.h b/drivers/gpu/drm/amd/include/vangogh_ip_offset.h
index 2875574b060e6..691073ed780ec 100644
--- a/drivers/gpu/drm/amd/include/vangogh_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/vangogh_ip_offset.h
@@ -36,7 +36,7 @@ struct IP_BASE_INSTANCE
 struct IP_BASE
 {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
+} __maybe_unused;
 
 
 static const struct IP_BASE ACP_BASE = { { { { 0x02403800, 0x00480000, 0, 0, 0, 0 } },
-- 
2.25.1

