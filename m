Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050E82C56E4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391072AbgKZOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390350AbgKZOQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:16:06 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB53C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:16:06 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so2288370wrw.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JVJYFI/qIjUZ3Hi9AztV74PIORKWvfJtU5CTcwVwdKc=;
        b=TYk/4RpVJoVTqhuw7oP/HPv29AnhUOauwXQfwW9KAmBlmXL/z+Sv0AHWeiHg6PmpWn
         hXwRS8OuLjZOSk5KI7zB+D/iQP3MXAIDV9kfz2mAKilN17pecwT4RLhTS7KSTfF0lbUQ
         7UfOMUgJUiGxINLSR+4/903rpd2NTBe9oIMLwX2Gq0iF9kFkg0Rhomoz1/cb02DihvF/
         TyiM5aBLe8qS8PToF2N2b+7PKkLCgaM2k6EcppFSDdDCdNjSXK6E3EQZgCyovrRHq2Xp
         vgpAx6mUm0SzeUM//Fi79HMteNCYgc0d2upaqeyzv/KTRAzJVgPibCsz/7uCF16PUy65
         PyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JVJYFI/qIjUZ3Hi9AztV74PIORKWvfJtU5CTcwVwdKc=;
        b=pnSZ9EGCicHIOb9mOLvZF2FjiCyT3r1lezBSbirERHdyAf8PNYMZjjZyiM0on28t0g
         B1e1UN4YB90XCCHR1GYGPHzIbCTV/KS1Z3o/BujJs7gH9xwIQnl91My7EEDqDAinVygL
         JDpnD0GcOs7zkQoUJT140MX4Awq8qD5zRNYR2DrBw97PWj/vCoOZR5oIm2QoqgvFfpmn
         vMSP75TM5t7u0ni9Yq5CpjNij7UmKieRByFz+w4sa+0ViqHpBp8JWCsQ6Xf9UKRo6HHE
         saCf5r8mvRT8OESuD9QWXtFzoT9H/VYIv9RiJEWJ3Wwv7Cqu0qa+RBTTqYglkkV5ezlq
         YhxA==
X-Gm-Message-State: AOAM532ZK5LjSAsa3eO6LDtlh1JUOGMENp+BjF/fd01AuKu7euVNTaZ6
        w7wrnEKOj6BoQabVDtAhruUjHQ==
X-Google-Smtp-Source: ABdhPJyRT6DX4EfACs62HmCZ6SUs/HD49LkOIYjL7/qZ73YQ1Dl2aX3Sej/xfNYP/78CKkUhszgHxw==
X-Received: by 2002:adf:f44c:: with SMTP id f12mr4207625wrp.155.1606400164752;
        Thu, 26 Nov 2020 06:16:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:193b:ad82:52ad:936c])
        by smtp.gmail.com with ESMTPSA id q16sm9286079wrn.13.2020.11.26.06.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 06:16:03 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/2] clk: meson: g12a: add MIPI DSI Host Pixel Clock
Date:   Thu, 26 Nov 2020 15:15:58 +0100
Message-Id: <20201126141600.2084586-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie adss the MIPI DSI Host Pixel Clock used to feed the DSI pixel
clock to the DSI Host controller.

Unlike the AXG SoC, the DSI Pixel Clock has a supplementary mux, divider and gate
stage before feeding the pixel clock to the MIPI DSI Host controller.

Changes since v1 at [1]:
- switch g12a_mipi_dsi_pxclk_sel flags to CLK_SET_RATE_NO_REPARENT
- fix aligment of g12a_mipi_dsi_pxclk_div & g12a_mipi_dsi_pxclk parent_hws

[1] https://lore.kernel.org/r/20201123163811.353444-1-narmstrong@baylibre.com

Neil Armstrong (2):
  dt-bindings: clk: g12a-clkc: add DSI Pixel clock bindings
  clk: meson: g12a: add MIPI DSI Host Pixel Clock

 drivers/clk/meson/g12a.c              | 74 +++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |  3 +-
 include/dt-bindings/clock/g12a-clkc.h |  2 +
 3 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.25.1

