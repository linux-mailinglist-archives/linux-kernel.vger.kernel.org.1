Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0734B2935B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405081AbgJTHZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404957AbgJTHZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:25:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1878C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:25:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c194so663764wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kG+BFVGQXRjJ+mkrHQChx2dsZt9ERLvjJfF1uolhOs=;
        b=plL+cBeKkhcgEoOPkXLmzqJiYdCWDjncM1NsZmzKozDX7/EXncko/dd4visTCbkKoz
         FVwBiWYiP7BhOErruEOjUAZ0Yu1zVHwItfkP/LIiO8Yyva2nN8MZSwH/IEALG0jrFlj0
         4AAUonQVksMpZ9psUcdGrC+dYOPhmg45eFwfSKSW6BHg8WYzwyFpIWGR2sr0nJjM7J0M
         mQtPY5YgoWW3/swFlkwJN8ljigLiIdS8Hc53fJZ3MTliPiri/AQLLIewLgIHEtFVgxE5
         n503uTs3wKrKFrFs+Onqv+dDu7l66uYQBOjD5yRq23qITLoK5YQBTJEZfOP3iZJeKneN
         A0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kG+BFVGQXRjJ+mkrHQChx2dsZt9ERLvjJfF1uolhOs=;
        b=V2qr/GcpPquiMi/5i4qlhh6fu3WmRhMBQlA8F9vVyaT2j0Ls96wL3BLZj2n0B85k+m
         L+Qw4jzP+aipSnGmjRp+maQQYNN5U7qVc9AAn8MEIkX6gRcwHIeUjRLj+ZBf8nSFBWzf
         u+k0U7IdRUm0/Iep2eC9wOXoI5DSfZq4VocomP8x+D0Y5T6dK20+e1Vmnhb8VtLn3p3L
         UvG+e85WnHJ/Ur/AeWjbg9EQlCBM+rf+8/oUaax89mGzYNBWC4fvuVtZN7/vmgD/Q3z6
         IATmaDHWwJkVx3otnafhGGjfEAdXIQlXjUN3cBty5s+VfRY6fjcmmpgjd4ujfYEg9XBJ
         /6SQ==
X-Gm-Message-State: AOAM533lzAvxSYzrSemuo2g3FpbJNjAIikoP2AKpi7KXRu0M+0cRYaiW
        ldXuEQ/BAY2VcVo1gx/zrAgdXWEvheLn9haj
X-Google-Smtp-Source: ABdhPJzEsj88NtvzD+ZrWDaQD7qm8tQ4VN7+gEQnQXQ3oeSWYew/8wQyY+0+RSRpxq2rM5wZ5F12lw==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr1375882wmc.188.1603178739517;
        Tue, 20 Oct 2020 00:25:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:3c62:4f82:8f5f:de74])
        by smtp.gmail.com with ESMTPSA id j5sm1487325wrx.88.2020.10.20.00.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 00:25:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     maz@kernel.org
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] arm64: meson: remove MESON_IRQ_GPIO selection
Date:   Tue, 20 Oct 2020 09:25:32 +0200
Message-Id: <20201020072532.949137-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201020072532.949137-1-narmstrong@baylibre.com>
References: <20201020072532.949137-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting MESON_IRQ_GPIO forces it as built-in, but we may need to build it
as a module, thus remove it here and let the "default ARCH_MESON" build as
built-in by default with the option to switch it to module.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cd58f8495c45..dfb66917f665 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -157,7 +157,6 @@ config ARCH_MESON
 	select COMMON_CLK_GXBB
 	select COMMON_CLK_AXG
 	select COMMON_CLK_G12A
-	select MESON_IRQ_GPIO
 	help
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
-- 
2.25.1

