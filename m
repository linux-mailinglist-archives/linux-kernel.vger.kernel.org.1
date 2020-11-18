Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D012B7D62
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgKRMIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:08:05 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44610 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726985AbgKRMIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:08:02 -0500
X-UUID: 8c9fb4487c0742ac8142beaa861aab93-20201118
X-UUID: 8c9fb4487c0742ac8142beaa861aab93-20201118
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1926250096; Wed, 18 Nov 2020 20:07:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 Nov 2020 20:07:57 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Nov 2020 20:07:56 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <fshao@chromium.org>, Argus Lin <argus.lin@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH v4 0/5] Add PMIC wrapper support for Mediatek MT6873/8192 SoC IC
Date:   Wed, 18 Nov 2020 20:01:29 +0800
Message-ID: <1605700894-32699-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for new SoC MT6873/8192 to the pmic-wrap driver.

changes since v3:
- refine some coding style about PWRAP_CAP_ARB capacity for better code quality.
- make struct pwrap_mt6873 const.
- add pwrap node into Mediatek MT8192 dtsi.

Hsin-Hsiung Wang (5):
  soc: mediatek: pwrap: use BIT() macro
  soc: mediatek: pwrap: add arbiter capability
  dt-bindings: mediatek: add compatible for MT6873/8192 pwrap
  soc: mediatek: pwrap: add pwrap driver for MT6873/8192 SoCs
  arm64: dts: mt8192: add pwrap node

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |  1 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           | 12 +++
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 90 +++++++++++++++++++---
 3 files changed, 92 insertions(+), 11 deletions(-)

-- 
2.6.4

