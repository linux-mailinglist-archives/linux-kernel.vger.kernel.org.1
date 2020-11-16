Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA77E2B408A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKPKNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKPKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:13:22 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:13:20 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so10815935wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmwQkPQqqWfXNlvX22Ha9TLOtrxJBFOVDCpoC+8Emho=;
        b=VvheAsTbE8WwpQ2oYwLrAgkSd7Iiqal9qpsjYaiEUXlrvw4ul0QXafZM5YzuXHglSq
         g/MWOWQnEjTSABEKewgUk3oMSFqBsw1lKeOPIKXX5mZUYH7fGQlrpid6Tqk2bwvFxgHj
         g8iA+zzNudSegB+t6KrHGLYAVeYMMl2xDFWm4/DZCTtTOd7u6QA5hEz87tP4W15NjRhb
         PitbTnLHGuFd8kNnOCValDGKx8Uu99kfaTU1pYkurBWDWFG+BQ6rj0KnK4bCbSd6SSCq
         /rvKzF654gGMCjXP4nbyIygBc0XFsVMJSl6vjV2Iz6fCSkJr8u4+S0EkNpPTv/uMT5pg
         BypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmwQkPQqqWfXNlvX22Ha9TLOtrxJBFOVDCpoC+8Emho=;
        b=dTVG28/aeEXWh/JFgSaX6PZeyFJDOuuNSE3Dn7xkt/tOkPmMHT4rc8fxEgvqEfIbqY
         +MqYkuwvZSMWqxU37ShkgOjP0d0Cn6I8hLB8A38iYW0sJU2tnYY7L52Tl/r8a6o5igrS
         8DcEynkX0nzRyTdP8iX9qbifFGWohv5QkR2wFoqmLunbEEjOZZIUoIr39rMbLN6Z8Aui
         THdk/vMCpTMNvto73rkVLAgBlsW0i2Cz17AAX5AvHz8T4odzwusjlnpDOg7EpQEbpNfb
         4FrbCUKGoMbI3gH13tRiT6a+HEATkdjpBY79cMS3XE9WUbzoaEmGhH9+dHpppww1eLBH
         Xmww==
X-Gm-Message-State: AOAM530LiH1NLG2rIPD1Ryg5otjXUMW5wXWpdaz/VNp8kzCKTn2kOHpd
        rz+TsITSqjBfb5U1I5jzZI+2Cg==
X-Google-Smtp-Source: ABdhPJwojuwRwPWJmJTh4YRPyQtsJWF1DKV/v95zcHZ2hPsI9lVNq8Xs4AKIMwnPt6nVMY0I7URwTA==
X-Received: by 2002:adf:f041:: with SMTP id t1mr18646025wro.139.1605521599046;
        Mon, 16 Nov 2020 02:13:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:edb9:72a:9e35:6eb])
        by smtp.gmail.com with ESMTPSA id g66sm19082228wmg.37.2020.11.16.02.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:13:18 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 0/2] phy: amlogic: Add support for AXG MIPI D-PHY
Date:   Mon, 16 Nov 2020 11:13:13 +0100
Message-Id: <20201116101315.71720-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This D-PHY depends on a separate analog PHY.

Changes since v2 at [2];
- Rebase on v5.10-rc1

Changes since v1 at [1]:
- Fix bindings and add review tag

[1] https://lkml.kernel.org/r/20200907072708.26043-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20200929093203.337954-1-narmstrong@baylibre.com

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

