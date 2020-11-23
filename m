Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508C42BFEDA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgKWDsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:48:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55020 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727454AbgKWDsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:48:30 -0500
X-UUID: 646c172b4ec24cd490e3ca3ace01faba-20201123
X-UUID: 646c172b4ec24cd490e3ca3ace01faba-20201123
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 406099563; Mon, 23 Nov 2020 11:48:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 Nov 2020 11:48:22 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Nov 2020 11:48:23 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v3 0/8] Add Support for MediaTek PMIC MT6359
Date:   Mon, 23 Nov 2020 11:48:02 +0800
Message-ID: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes refactoring interrupt and adding support to MT6359 PMIC.
This patchset includes refactoring interrupt and adding support to MT6359 PMIC.
MT6359 is the primary PMIC for MT6779 and probably other SOCs.
The series[1] sent by Wen will continue to upstream in this patchset afterwards.
The series[1] sent by Wen will continue to upstream in this patchset afterwards.

The series[1] sent by Wen will continue to upstream in this patchset afterwards.

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=306579

changes since v2:
- update binding document in DT schema format.
- remove unused compatible name.
- update correct registers for VBBCK and VA09.

Hsin-Hsiung Wang (6):
  mfd: mt6358: refine interrupt code
  dt-bindings: mfd: Add compatible for the MediaTek MT6359 PMIC
  dt-bindings: regulator: Add document for MT6359 regulator
  mfd: Add support for the MediaTek MT6359 PMIC
  regulator: mt6359: Set the enable time for LDOs
  regulator: mt6359: Add support for MT6359P regulator

Wen Su (2):
  regulator: mt6359: Add support for MT6359 regulator
  arm64: dts: mt6359: add PMIC MT6359 related nodes

 .../devicetree/bindings/mfd/mt6397.txt        |    8 +-
 .../bindings/regulator/mt6359-regulator.yaml  |  145 +++
 arch/arm64/boot/dts/mediatek/mt6359.dtsi      |  295 +++++
 drivers/mfd/mt6358-irq.c                      |   89 +-
 drivers/mfd/mt6397-core.c                     |   23 +
 drivers/regulator/Kconfig                     |    9 +
 drivers/regulator/Makefile                    |    1 +
 drivers/regulator/mt6359-regulator.c          | 1136 +++++++++++++++++
 include/linux/mfd/mt6358/core.h               |    8 +-
 include/linux/mfd/mt6358/core.h               |    8 +-
 include/linux/mfd/mt6359/core.h               |  133 ++
 include/linux/mfd/mt6359/registers.h          |  529 ++++++++
 include/linux/mfd/mt6359p/registers.h         |  249 ++++
 include/linux/mfd/mt6397/core.h               |    1 +
 include/linux/regulator/mt6359-regulator.h    |   59 +
 14 files changed, 2652 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6359.dtsi
 create mode 100644 drivers/regulator/mt6359-regulator.c
 create mode 100644 include/linux/mfd/mt6359/core.h
 create mode 100644 include/linux/mfd/mt6359/registers.h
 create mode 100644 include/linux/mfd/mt6359p/registers.h
 create mode 100644 include/linux/regulator/mt6359-regulator.h

-- 
2.18.0

