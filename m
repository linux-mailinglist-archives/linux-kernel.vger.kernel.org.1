Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF52A659B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgKDN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKDN4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:56:37 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D83C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 05:56:36 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w14so22104781wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPcVTlt4PtaJnqwyX4xYXu+/IKdY0k4HutlOclbS1nM=;
        b=TpYxmLYUqj9kx/e2FrI3x6kcSiKrlec6frSs+K3eiHy3VmnVi0HQfgHxG6NWpWbsA6
         XhTgoDvF/L7nwXGyEVueEzefc3H+SRhG3isD4mYaMoMV7EZtdqWVArpSAFEu8n0gC9ph
         yfWRUaJ9rGVLmabTL800X5KMWkLJzlKGUPcfBe+PhHIxsTZ81JT4mqSX4vL1rC5TQbwz
         fO9Z5h12ty2qt7ZhF5O80HQnJdYG0r6mcGza1FNXTqPwh1Uq3H//cxcHIpbCyvcGhRb6
         fPfHPgQzsC4fABXlk6BSwl0xJGZ58fzz4WfhNNU5wgY0ofKdVsILqrgP9/KtLciwxtiL
         4cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPcVTlt4PtaJnqwyX4xYXu+/IKdY0k4HutlOclbS1nM=;
        b=fo/RZORcdnJGAgMTzJgWmTbXyYoE7Y0E5Ey6GqXlTHhYScul/1/VWbB3REZJg8cLxs
         RQ/72ftFHZrX+AVP2rSpzv2MToyniIi8RXd5y1X3ltUQhTRixvm1I+mnyjgyRJAGgzf/
         ueNskZ7Y3zF2f86hcPlSbP8UXBFsmf5AjNHdK6EUodYTz+bN2TIuvPVu8MCE2ulTaDv3
         Ba+8yEcOBi2RYhxMuoCewbLPi2OuQ/XOmCeXxPDU1wVoV2ca/JLiaTmDK2RrQAkTnywz
         9joPPFtQ5aKV07xZ98v3x4BVCT13ZZGOmT/6BlaVcbGOxiuY3J4aKM35dJUyVphe5YOd
         kMhw==
X-Gm-Message-State: AOAM532sQHGEaBoTztcfDIb4cUEKMDdJzArJa8GWsINVeAVHnKIOvMfw
        mZfmAenh9basWpy36dTzuyRrbQ==
X-Google-Smtp-Source: ABdhPJwvKQsxeRuBiwVrrkyRPkASRDW6ZeGl2wGnPIA5bbuqYWpqKhHX6b4SMTQc2+uyYV2IvVQ8Xw==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr32201219wrp.399.1604498194931;
        Wed, 04 Nov 2020 05:56:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:61b2:b9fb:eeb7:b9f7])
        by smtp.gmail.com with ESMTPSA id n9sm2285234wmd.4.2020.11.04.05.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 05:56:34 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] phy: amlogic: add MIPI DSI function to analog MIPI+PCIe PHY
Date:   Wed,  4 Nov 2020 14:56:28 +0100
Message-Id: <20201104135631.1550125-1-narmstrong@baylibre.com>
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

