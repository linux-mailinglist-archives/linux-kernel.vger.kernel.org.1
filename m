Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30CC2C0E35
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgKWOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgKWOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:52:03 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:52:02 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so3043675wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmeZr0XUHe7lfG5n9TDdoFp85I1L2X2BF+Rr5NpXUP0=;
        b=PTtXCtInvsZCorNwU1hUoH+yzXlYZWe3dndOPDBMxQeAGubOLYI9/jJrTECqDaBBYD
         2EEVPiL9WsTH4/0zd5uAZqNwsH8CPkGIp6JiS9uPYSWICQEJDzuyKdvGD4tM1cJgPj1Q
         BepszEQbdCP4tytl+FHyIY1zzhxRR6KLBnhwZCd6iT/hAUIPhUhMXRkBOUHjFDzlp2S2
         zRvnnqyF3n5wRfrha8MIX0mMnP8ZussA2cba9dQYoxT9+FcmdbW5REOsIwDGscDvmvji
         VJLEoZftpcFHTXCaY9u43QqHhDFDXzJMsC2mQbmW8Pt+t3ZEkVnEftLk7KinyIEOX/uj
         XPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmeZr0XUHe7lfG5n9TDdoFp85I1L2X2BF+Rr5NpXUP0=;
        b=l+x5yqxO9zJoa9k7S+78d8lo0q6O8pXs+szh+5oWhhCoTY/FvNcuUPKWXfJz58dDoi
         kHYYLLp3sm4rRjCrS7yWb0RnjqnHr0LgZIrXF/HLbLG5fptBnrrLDVkSrNMpSkNgjqP9
         Wyw25seytnmbkTeMr9VrLNpjHcAyZdiJ/dSc0P8/TCTqCtWoTkg/vvK/Nu58sVnRxyem
         PajpPzj1wDcDVfVEpP4/2rybA2T2KR7tAEz71MLRzX7ZjE9bR9gVgN9DmjigqnLUgqwP
         zPp4vUKKvIzEyEEOA4qEDndsn62Z2nZdNwZK+At5MgSppqvn78qAPvLvcpLIIogM3WJY
         d4BQ==
X-Gm-Message-State: AOAM5312jOvxRNMlJfkMuZOgJUwOzzCEYTOh4fBLI0oYLyYztT8mHY/j
        pok3fRNppb8jKxlltOIl3FwyfQ==
X-Google-Smtp-Source: ABdhPJx0Nsh3eOEdDLcNLqFyxmZXyWn1bfPylX82bWOzB76sFCdqMGPW+t9dmteFWCUkRzne/kyjmg==
X-Received: by 2002:adf:e912:: with SMTP id f18mr31112308wrm.79.1606143121122;
        Mon, 23 Nov 2020 06:52:01 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:9541:d2fd:3a68:67ae])
        by smtp.gmail.com with ESMTPSA id 9sm14225175wmo.34.2020.11.23.06.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:52:00 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org, kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] phy: amlogic: Add support for the G12A Analog MIPI D-PHY
Date:   Mon, 23 Nov 2020 15:51:55 +0100
Message-Id: <20201123145157.300456-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
panels, this adds the bindings.
    
This Analog D-PHY works with a separate Digital MIPI D-PHY.

This serie adds the Bindings and the PHY driver.

Neil Armstrong (2):
  dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
  phy: amlogic: Add G12A Analog MIPI D-PHY driver

 .../phy/amlogic,g12a-mipi-dphy-analog.yaml    |  40 ++++
 drivers/phy/amlogic/Kconfig                   |  12 ++
 drivers/phy/amlogic/Makefile                  |   1 +
 .../amlogic/phy-meson-g12a-mipi-dphy-analog.c | 177 ++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c

-- 
2.25.1

