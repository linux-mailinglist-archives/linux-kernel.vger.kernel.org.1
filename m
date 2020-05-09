Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650E41CC0F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgEIL1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 07:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728359AbgEIL1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:27:01 -0400
Received: from pruto.48.io (48.io [IPv6:2a01:430:17:1::ffff:361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F9C061A0C;
        Sat,  9 May 2020 04:27:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pruto.48.io (Postfix) with ESMTPSA id 2620B94C8C;
        Sat,  9 May 2020 13:18:10 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.3.2 pruto.48.io 2620B94C8C
Authentication-Results: pruto.48.io; dmarc=none (p=none dis=none) header.from=48.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=48.io; s=default;
        t=1589023090; bh=KARkDbiFWBw5fwU/CBmudfRgDCP3DX1QEy8rHToFI6w=;
        h=From:To:Cc:Subject:Date;
        b=TpYDnwlozMKCJmINVAMNyROL4vRGCGtwNP6WniI11KG05i8Vsb0n9UZ9E9lVXlRNX
         zh9RTmRj2cyjohHodu5zFNwQs2z9zRNEv8QrdY3SElPv7j/4SNe6I0wHTqisB9F+W7
         b8deqXBknDw0ZIQOWg/cP9UrEClkpaJx8ghg32WQ=
From:   srk@48.io
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Marko <srk@48.io>,
        Marek Vasut <marex@denx.de>, Sean Cross <xobs@kosagi.com>
Subject: [PATCH 0/2] Novena laptop: LVDS-to-eDP bridge
Date:   Sat,  9 May 2020 13:17:30 +0200
Message-Id: <20200509111732.26102-1-srk@48.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Marko <srk@48.io>

Contains updated patches I've received from Marek with the following
changes:

- yaml docs migration
- extended documentation

Tested on a Kosagi Novena laptop with imx6 display controller.

Based on v5.7-rc2, applies to drm-misc-next 5e6ed29d72d2

CC: Marek Vasut <marex@denx.de>
Cc: Sean Cross <xobs@kosagi.com>

Marek Vasut (2):
  dt-bindings: it6251: add bindings for IT6251 LVDS-to-eDP bridge
  drm/bridge: Add ITE IT6251 bridge driver

 .../bindings/display/bridge/ite,it6251.yaml   |  97 +++
 drivers/gpu/drm/bridge/Kconfig                |  12 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/ite-it6251.c           | 582 ++++++++++++++++++
 4 files changed, 692 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6251.yaml
 create mode 100644 drivers/gpu/drm/bridge/ite-it6251.c


base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.25.1

