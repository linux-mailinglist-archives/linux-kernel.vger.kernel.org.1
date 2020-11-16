Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500342B40A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgKPKQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgKPKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:16:53 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:16:51 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id j7so18037287wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPcVTlt4PtaJnqwyX4xYXu+/IKdY0k4HutlOclbS1nM=;
        b=TZjbGcnkBRQSD8Dl4SgMJvoMpmw4tLtZFcPYqIvp+RKueRfsMqBuCAC8vyU/ubvNYX
         uLO/dh8A2P3ZugUzDocHm3jFdQeZONKKsi2g5neE1s+gHXG9jd8tOnQQYWoEBCR65qIh
         vq0uyQzd+2aOQ5JCaGNVJM37Wc+b7BSqKp6F0O4il/O1uA1hki9xlLHkMEmwe548jwHE
         FrZdFIkJ9cFJKsY2NgtRJO92jwP6w7loQKZxM2R8M14J1LvBEBxycHLdz08x+NNJ7UaZ
         pCqjpBscww5rIahnB9+0ykkPahxxBTM8GOXsE164c62x9rS7+cA+Ed2J+UR1Z15jSdk7
         NWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPcVTlt4PtaJnqwyX4xYXu+/IKdY0k4HutlOclbS1nM=;
        b=L3TOWNgsnbLf9qI9JePDD+F6PCbdKFmcnei0wwOw0XNND6+/Qyibt4Rq553sB6O9vK
         Usi3fintjWfERzrySoKyWZ6lbWM8Wu/IyP40lhjwXNpSHQkcrAZbITvilktfkATX8EuK
         KnqOOfts0uwDA23sO+ECtDbW6b9fJASHDcVZWTGtb1bq2zDrah4MhWnyqi+1S7GrHCjl
         ZNpxeluUKP0ODRQBqlzneN7ryAgWU+ddD1dLOnHKFJ7i9r0XDaqS1SyHv5jDPtaYbYm9
         4dSkFLtuIXa3HLHv9ojE2vDmyc60Fn9Et/Yar2x2wuqG4+SWEr/k2DY3rOGXgjTJ7XMy
         9Ukw==
X-Gm-Message-State: AOAM531eTT8azSCX9hD8mQWrAEmZdYMiejHAmuJTlkRBwcEShvsUPh8K
        S/Ju2ZIfFzINeY+PAYomdyjEgg==
X-Google-Smtp-Source: ABdhPJwQA7DtozqXJFXVwh4cU0VIT5A/4FmmNR8g+7sNzKjawJaeF7OXh2yqeovX9ruqo2vLuDccOg==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr18853811wrr.1.1605521810515;
        Mon, 16 Nov 2020 02:16:50 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:edb9:72a:9e35:6eb])
        by smtp.gmail.com with ESMTPSA id c17sm22265131wro.19.2020.11.16.02.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:16:49 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt, vkoul@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 0/3] phy: amlogic: add MIPI DSI function to analog MIPI+PCIe PHY
Date:   Mon, 16 Nov 2020 11:16:44 +0100
Message-Id: <20201116101647.73448-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXG Analog MIPI-DSI PHY also provides functions to the PCIe PHY,
thus we need to have inclusive support for both interfaces at runtime.

This fixes the regmap get from parent node, removes cell param
to select a mode and implement runtime configuration & power on/off
for both functions since they are not exclusive.

Changes since v2 at [2]:
- Add DT review tags
- Rebase on 5.10-rc1

Changes since v1 at [1]:
- added description to binding as requested parent
- updated commit log of patch 1
- also update example of patch 1

[1] https://lkml.kernel.org/r/20200907073402.26674-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20200915130339.11079-1-narmstrong@baylibre.com

Neil Armstrong (3):
  dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove reg
    attribute
  dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove phy cell
    parameter
  phy: amlogic: phy-meson-axg-mipi-pcie-analog: add support for MIPI DSI
    analog

 .../amlogic,meson-axg-mipi-pcie-analog.yaml   |  21 +-
 drivers/phy/amlogic/Kconfig                   |   1 +
 .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 204 ++++++++++++------
 3 files changed, 149 insertions(+), 77 deletions(-)

-- 
2.25.1

