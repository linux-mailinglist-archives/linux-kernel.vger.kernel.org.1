Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9E5200044
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 04:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgFSCgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 22:36:52 -0400
Received: from mx.socionext.com ([202.248.49.38]:27924 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbgFSCgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:36:51 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Jun 2020 11:36:50 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 603BC60066;
        Fri, 19 Jun 2020 11:36:50 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 19 Jun 2020 11:36:50 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 05DBC1A0E67;
        Fri, 19 Jun 2020 11:36:50 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] Add new UniPhier AHCI PHY driver
Date:   Fri, 19 Jun 2020 11:36:45 +0900
Message-Id: <1592534207-13550-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for AHCI PHY interface implemented in Socionext
UniPhier SoCs. This driver supports PXs2 and PXs3 SoCs.

Kunihiko Hayashi (2):
  dt-bindings: phy: Add UniPhier AHCI PHY description
  phy: socionext: Add UniPhier AHCI PHY driver support

 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |  76 +++++
 drivers/phy/socionext/Kconfig                      |  10 +
 drivers/phy/socionext/Makefile                     |   1 +
 drivers/phy/socionext/phy-uniphier-ahci.c          | 335 +++++++++++++++++++++
 4 files changed, 422 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
 create mode 100644 drivers/phy/socionext/phy-uniphier-ahci.c

-- 
2.7.4

