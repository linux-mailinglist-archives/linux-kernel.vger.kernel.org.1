Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856C42A657D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgKDNrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbgKDNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:47:37 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9073CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 05:47:35 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w14so22072924wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 05:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmwQkPQqqWfXNlvX22Ha9TLOtrxJBFOVDCpoC+8Emho=;
        b=gQgZf7NoHKA5npz3yO3fH/y+LWZsEmkIvnyGUG9rn+YBRvu3h/vOlMi5Q10bvsarb4
         CDhpCdKTzDbxU8N4tyzVdlACP3Eb4NE8rtTDr7UZpwWIb9miga30uuEQ2aZ/o81pwEPE
         BISJQMMP56TEgZWjE6oUfm0z14krbjWCmPQVPB9Gwq9MySVHb+eWEPb1utja3YP4VU6w
         wUddh+FsA260N3FHdxcxbdevGixTe6mW8/vtcQFKUxKssRlAqQKBJX1oCNaz50l9rf6k
         gk3xqjpMvAmN73bxFSpbnYbOVp/gp4ND3AsZ3qpsC1IgEwXG2f1/fkhpseNvv0Wk7WJS
         si6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmwQkPQqqWfXNlvX22Ha9TLOtrxJBFOVDCpoC+8Emho=;
        b=iC8ZmaQCDIHUxhXZ0gl0Zk6Q9wx5szRaxG/5i46Z1x+SGcI6k/CTHWBJs/3Ijyn+pu
         AHMEpTt6qZ0/OW0+oPd7eVXnQQUa2q932LSpt+WAlEC4UmBt072LLygPlibEdpD6WeSv
         30as45N8ev1xl/YCY3O1uQ8f7R2AWD/JTmXB2Ss7w5zvt2EhnPSm2EoXf+xT11LkB9Yx
         wf9W57nqYoqmxUXjblDgba+z1KlBZ6ZJfpPepfWirL4IlknGscHVjkXr0DBOmiSCVzhS
         EwnBi2CtvygC6htSKxsfmD+ANFBMjKbQbAOHOsaUTgBaIq75LvFt0KO6iYvDdO9XzZpc
         OZxA==
X-Gm-Message-State: AOAM532hOVzEUg5UbbP8TAOC6xnOwKqIFLrOw3zNKm3qBYxZo8dH/0lu
        Njujn2bWdr6+2nLxzmOn2v/NLg==
X-Google-Smtp-Source: ABdhPJx9m53A68O1kVO4RL6dPwUA8WgeZ2Rhw0wkFix4N7HZp5KAorb35ru83vcaAkHLSjFSDRIizQ==
X-Received: by 2002:adf:a51d:: with SMTP id i29mr32865331wrb.409.1604497654114;
        Wed, 04 Nov 2020 05:47:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:3d8d:fb08:21c9:faa3])
        by smtp.gmail.com with ESMTPSA id 30sm2759586wrs.84.2020.11.04.05.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 05:47:33 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] phy: amlogic: Add support for AXG MIPI D-PHY
Date:   Wed,  4 Nov 2020 14:47:28 +0100
Message-Id: <20201104134730.1545875-1-narmstrong@baylibre.com>
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

