Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A5221E78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgGPIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:32:51 -0400
Received: from mx.socionext.com ([202.248.49.38]:56533 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgGPIct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:32:49 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 16 Jul 2020 17:32:35 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id B9DD4180BC2;
        Thu, 16 Jul 2020 17:32:35 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 16 Jul 2020 17:32:35 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 35D1D1A0509;
        Thu, 16 Jul 2020 17:32:35 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 0/2] Add new UniPhier AHCI PHY driver
Date:   Thu, 16 Jul 2020 17:32:22 +0900
Message-Id: <1594888344-32066-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for AHCI PHY interface implemented in Socionext
UniPhier SoCs. This driver supports PXs2 and PXs3 SoCs.

Changes since v3:
- Eliminate a meaningless blank line and a line break
- Fix misspelling

Changes since v2:
- Adjust copyright year
- Add helper for enabling the controller
- Remove redundant .init in uniphier_pxs2_data
- Add comments for dummy read accesses
- Fix return value in uniphier_ahciphy_init
- dt-bindings: Add Reviewed-by line

Changes since v1:
- dt-bindings: Fix items in reset-names

Kunihiko Hayashi (2):
  dt-bindings: phy: Add UniPhier AHCI PHY description
  phy: socionext: Add UniPhier AHCI PHY driver support

 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |  76 +++++
 drivers/phy/socionext/Kconfig                      |  10 +
 drivers/phy/socionext/Makefile                     |   1 +
 drivers/phy/socionext/phy-uniphier-ahci.c          | 321 +++++++++++++++++++++
 4 files changed, 408 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
 create mode 100644 drivers/phy/socionext/phy-uniphier-ahci.c

-- 
2.7.4

