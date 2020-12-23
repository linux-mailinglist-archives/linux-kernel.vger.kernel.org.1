Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937892E1C25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgLWMOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 07:14:54 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37591 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728330AbgLWMOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:14:52 -0500
X-UUID: cf142bb577984ca19cedf7ebae6db2b2-20201223
X-UUID: cf142bb577984ca19cedf7ebae6db2b2-20201223
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 75795305; Wed, 23 Dec 2020 20:14:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 20:13:46 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 20:13:45 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 0/3] Add support for MT6315 regulator
Date:   Wed, 23 Dec 2020 20:13:41 +0800
Message-ID: <1608725624-30594-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for MediaTek PMIC MT6315 regulator driver,
which adds MT6315 related buck voltage data to the driver.
This series is based on below patch[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-next&id=d40c2d4ed62df64ce603c208bceff25245380157

changes since v2:
- fix the error of binding document.
- refine the mt6315 regulator for better code quality.
- add mt6315 regulator node into mt8192-evb.dts.

Hsin-Hsiung Wang (3):
  dt-bindings: regulator: document binding for MT6315 regulator
  regulator: mt6315: Add support for MT6315 regulator
  arm64: dts: mt8192: add mt6315 regulator nodes

 .../bindings/regulator/mt6315-regulator.yaml  |  71 +++++
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts   |  46 +++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6315-regulator.c          | 298 ++++++++++++++++++
 include/linux/regulator/mt6315-regulator.h    |  45 +++
 6 files changed, 471 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
 create mode 100644 drivers/regulator/mt6315-regulator.c
 create mode 100644 include/linux/regulator/mt6315-regulator.h

-- 
2.18.0

