Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40727C148
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgI2JcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2JcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:32:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67ECC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:32:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so4525095wrl.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UsmEqNE1VLY277zZdW+TO4ZYR2Vb/rb860kfWSma0Y=;
        b=qdEWVmRhaVAyb7vwdl+3da/tgoTRODR/6lOh1nQVQPjlCYTC8GyzRdjKuu8MYpd8Kx
         E79oNInkWSFOUhLygTLKrvsDjb7K8Sfwqnnf1RHOKN/40sRG8lpdwWj1z1KSuBi4Qo4R
         KrM6bI37mn3LgwjFzxuzYEcNnCgtIEmzFnZQoHViPJ6ZV351q2tp3eWPBVa5GsWJEZp4
         xHAi1y2yoD+z3hDdD5dkV4fagJdCLsF4AWOODKVH0EW93U+cv7m2FB6wuQ5xLTUb03XR
         qZ3zLJA38G3xgn8Fok6TNX2+VllDvV9Sw7ttK/rYCpj88+LpPNt/a+FWgBIdQ6hF3Jt1
         uptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UsmEqNE1VLY277zZdW+TO4ZYR2Vb/rb860kfWSma0Y=;
        b=mMd6Cvg/N0gp5Zm43yT4EHQxH9dx+SjhYfantvqLPpZAjzxpzE/oAR/toeOSN3qPaz
         zFv23hCaWzS6/xYS79KW3qD5TUb/s+IJ1v7cWAMNOo+QgBRxkAvqFfSbe6IixWRHa4Tz
         biS3eGJGU2jca5MktcC7a9AjaF2fnhOu6JQYQMKuYV6aHXoU5MPiExY1A06yXR5U7Z/t
         81ReDJiwB0p+SdqPw8QdAc67t+fVSDul+s7+QmEprJanZwmTd5wZQRFW1upSajR7TlG6
         zuJhRtSZ8kebGdhh2bvzsVupqCEzEhPs083VsdEfVs98NmmqABAZdegQUB+2tq+ZchuD
         ZHRA==
X-Gm-Message-State: AOAM530mEzqrWezQhQhfqbhvNajGi4LnVcu88eLzjdL68gYTJmVw1YLx
        k7aBzunzE4GxQKiWwQC+qBfWsQ==
X-Google-Smtp-Source: ABdhPJxHfjuOh6YrAZAFjomsAPXwlEm8lAWRogXJCncMNd1JG5rXr53P1OH4o/P/cuUUY1TBYwnv0Q==
X-Received: by 2002:a5d:6ac9:: with SMTP id u9mr3082466wrw.46.1601371929215;
        Tue, 29 Sep 2020 02:32:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:d50c:1ee4:fec5:ad12])
        by smtp.gmail.com with ESMTPSA id a10sm4596107wmj.38.2020.09.29.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 02:32:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/2] phy: amlogic: Add support for AXG MIPI D-PHY
Date:   Tue, 29 Sep 2020 11:32:01 +0200
Message-Id: <20200929093203.337954-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This D-PHY depends on a separate analog PHY.

Changes since v1 at [1]:
- Fix bindings and add review tag

[1] https://lkml.kernel.org/r/20200907072708.26043-1-narmstrong@baylibre.com

Neil Armstrong (2):
  dt-bindings: phy: add Amlogic AXG MIPI D-PHY bindings
  phy: amlogic: Add AXG MIPI D-PHY driver

 .../bindings/phy/amlogic,axg-mipi-dphy.yaml   |  70 +++
 drivers/phy/amlogic/Kconfig                   |  12 +
 drivers/phy/amlogic/Makefile                  |   1 +
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c | 413 ++++++++++++++++++
 4 files changed, 496 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c

-- 
2.25.1

