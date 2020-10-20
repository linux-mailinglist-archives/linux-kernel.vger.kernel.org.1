Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94A294196
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437195AbgJTRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391646AbgJTRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:42:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD1C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:42:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a72so2705275wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KolONEJ0/kBt/8YOlOvYo0QZLfG99esXIK0wMwF8lc4=;
        b=mtc2L/eKqA8TBWtNj1lh1nggWXnyR45rPOaumTksxHaV/nb4d/T4zAlD2P9bjzpHyn
         dfu3yTG/We2OKP1fQIc4+Lj1428T5LiozVeaflzq8AolVXTn21CFIl9ulS4Qau5gLq1J
         IRHbGN2i8IDhOy8UUmMXccWL1xNSJqz4YbnSPOvPH89tfwD+a/yz7rEUFLjBBTPpgesM
         3f1X0/IMnDRSGBqiQK5nS0hhXiexW/y6iLionKupQXckqGP06dQHWHoCjeLx0EIIgq6c
         iwtxhRYwRLZBIK1XSuO9zqjgT7EPREzS1V+iRqvqhw1IW7EkCjA0J2023QN0mRwI4q+u
         yZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KolONEJ0/kBt/8YOlOvYo0QZLfG99esXIK0wMwF8lc4=;
        b=F85UgG7ViFlpDmX2m2CFd8i1ct9l+USwxlr88ekEPtTPJxusEh9Ugj308OzhHi6+KE
         /gZ5aKgKgQLRjny28nw/3mBbZDidkWAYfPaFwB1RpjpqUx2RemUyYXNpI1rbGhv5sRSe
         1+Bdzo0hIczeIBBopIs7QP043Du5E6lLNlJ0UVahu7PllM/GJ49wx+wKvcbuWKZFTfQB
         X3XWYg6y7PYbhEqKjQOfO3wrWUTV4Zq1vMCklfaTQZZQTvf3mTtnhhCodP3kgbWpM0aN
         4wYlvNeLkRUyDU4YOBpuXXbbT9jk7N3555W9Y11PapGgYU1dOupJglV0dI9mBZ5tp3+r
         En2A==
X-Gm-Message-State: AOAM531DHNNB6s/qoAYahvYC7ae5Mg9jIwhdk+lCmj2dk5fNFEqrHgxG
        f5Fk4aPmnXNEaCGoEb05WjoaIw==
X-Google-Smtp-Source: ABdhPJxdhFa4U3zvDL3nve6Smzr3olv0OJGGCpFVU2nQZJ2SRN4kwERM99KqsVG5ZE8vhs1527lNKg==
X-Received: by 2002:a05:600c:cb:: with SMTP id u11mr3925064wmm.112.1603215777481;
        Tue, 20 Oct 2020 10:42:57 -0700 (PDT)
Received: from localhost.localdomain (199.170.185.81.rev.sfr.net. [81.185.170.199])
        by smtp.gmail.com with ESMTPSA id v123sm3297756wme.7.2020.10.20.10.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:42:56 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 0/8] Add DRM/DSI support for MT8167 SoC.
Date:   Tue, 20 Oct 2020 19:42:45 +0200
Message-Id: <20201020174253.3757771-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for DSI on the MT8167 SoC. HDMI is not yet supported
as secondary display path.

mmsys is not supported by this series and will be sent in a seperate series
based on [0].

[0] https://patchwork.kernel.org/project/linux-mediatek/list/?series=360447

Fabien Parent (8):
  dt-bindings: display: mediatek: disp: add documentation for MT8167 SoC
  dt-bindings: display: mediatek: dsi: add documentation for MT8167 SoC
  drm/mediatek: add disp-color MT8167 support
  drm/mediatek: dsi: add pdata variable to start clk in HS mode
  drm/mediatek: dsi: add support for mipi26m clk
  drm/mediatek: dsi: add support for MT8167 SoC
  drm/mediatek: add DDP support for MT8167
  drm/mediatek: Add support for main DDP path on MT8167

 .../display/mediatek/mediatek,disp.txt        |  4 +-
 .../display/mediatek/mediatek,dsi.txt         |  7 +--
 drivers/gpu/drm/mediatek/mtk_disp_color.c     |  7 +++
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c        | 50 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 38 ++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dsi.c            | 20 +++++++-
 6 files changed, 120 insertions(+), 6 deletions(-)

-- 
2.28.0

