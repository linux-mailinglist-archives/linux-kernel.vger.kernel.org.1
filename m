Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA44826A5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgIONHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgIONDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:03:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB18C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so3231493wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4CoH5TAZ8PWZGgkK37fQU1Rpb3QFqRwR18W1WLP6KQ=;
        b=V8FGR80todspLXHPA3rvQdUVZYGAcksQC64DzbVitjaaVSY9H923PWKTKpB9LEFYSn
         g7LrTNiowUuBWwWBIMTHNL/PS0H4QvIq15F17//dblz7MGWTLED0m/Cf6EQnnwkkefRE
         DA7Prc84Oam1fA+nfTHT6LD+o82/YAZvwELrrlKNBcqPTMmMduKKbN5aiMUzHPZFC6xO
         6DS27Gkt+to7g+sMg8TvVPlWqGgkWonatrYuPJL+X4G6NZp5pWdTAKTrFbQc+f8CG3mn
         FFEIz00GgmrSSPr5F4xyz1M5GZGxZzobQY1afkQS8tF7fXhuUQckqbh1vmxholiu2mty
         HE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4CoH5TAZ8PWZGgkK37fQU1Rpb3QFqRwR18W1WLP6KQ=;
        b=iNTnKqrWknEEscTA471MLQrih89CpHNPVjbe+C8NnXGEDxBogJ9hPLlFXCmzGrv8Io
         2UTRxpO4iyO64P9dwayNfQHaeB4Tv8cDPRBhJS48MbyDpdnxN0FchUuIO4ik8EeACg2D
         qMm3+QHPH4JAIhCN6vPWDRVUMjFL0/z5K8NI5m/AgIr3d6Ybj6oVRGMPLIgV0eNxTaFF
         nW9dxwljhgPDjOeyCcDnTL5ln3kp+8DS9jBUxOFt0ky1tGQypHLmNBN6DMXgHxnbsFbY
         PyQrwbcXovPk7GVVljHuz8MEP75OS2TeSZyRcEx4scQhhfE5fmiUi3povznjKzing26U
         wfOQ==
X-Gm-Message-State: AOAM533uNCdhfWz0ysUMdj5VQsKtOpjmyQupBmMl1a3iXZDFe2vRpqpF
        lO6mf/QUwGZ1H5KCIt1deuQijQ==
X-Google-Smtp-Source: ABdhPJz0zBLG7y0swlr6YJYUhuyr4uO7r8ajbskB2On0o9CJid1FPjDmrmIcb6nizzlgHcZqHlOYAg==
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr13902369wrc.71.1600175022951;
        Tue, 15 Sep 2020 06:03:42 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id t16sm27098671wrm.57.2020.09.15.06.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:03:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/3] phy: amlogic: add MIPI DSI function to analog MIPI+PCIe PHY
Date:   Tue, 15 Sep 2020 15:03:36 +0200
Message-Id: <20200915130339.11079-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXG Analog MIPI-DSI PHY also provides functions to the PCIe PHY,
thus we need to have inclusive support for both interfaces at runtime.

This fixes the regmap get from parent node, removes cell param
to select a mode and implement runtime configuration & power on/off
for both functions since they are not exclusive.

Changes since v1 at [1]:
- added description to binding as requested parent
- updated commit log of patch 1
- also update example of patch 1

[1] https://lkml.kernel.org/r/20200907073402.26674-1-narmstrong@baylibre.com

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
2.22.0

