Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378E42E0A66
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgLVNLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:11:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56710 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727254AbgLVNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:11:30 -0500
X-UUID: b233725081b747f49c10a2b9a42a4a97-20201222
X-UUID: b233725081b747f49c10a2b9a42a4a97-20201222
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 600847594; Tue, 22 Dec 2020 21:10:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 21:09:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 21:09:48 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v6 00/22] Mediatek MT8192 clock support 
Date:   Tue, 22 Dec 2020 21:09:25 +0800
Message-ID: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on v5.10-rc1.

change since v5:
- remove unused clocks by rolling Tinghan's patches[1][2] into series
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=398781
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=405143
- remove dts related patches from series

change since v4:
- merge some subsystem into same driver
- add a generic probe function to reduce duplicated code

changes since v3:
- add critical clocks
- split large patches into small ones

changes since v2:
- update and split dt-binding documents by functionalities
- add error checking in probe() function
- fix incorrect clock relation and add critical clocks
- update license identifier and minor fix of coding style

changes since v1:
- fix asymmetrical control of PLL
- have en_mask used as divider enable mask on all MediaTek SoC

Weiyi Lu (22):
  dt-bindings: ARM: Mediatek: Add new document bindings of imp i2c
    wrapper controller
  dt-bindings: ARM: Mediatek: Add new document bindings of mdpsys
    controller
  dt-bindings: ARM: Mediatek: Add new document bindings of msdc
    controller
  dt-bindings: ARM: Mediatek: Add new document bindings of scp adsp
    controller
  dt-bindings: ARM: Mediatek: Document bindings of MT8192 clock
    controllers
  clk: mediatek: Add dt-bindings of MT8192 clocks
  clk: mediatek: Fix asymmetrical PLL enable and disable control
  clk: mediatek: Add configurable enable control to mtk_pll_data
  clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers
  clk: mediatek: Add MT8192 basic clocks support
  clk: mediatek: Add MT8192 audio clock support
  clk: mediatek: Add MT8192 camsys clock support
  clk: mediatek: Add MT8192 imgsys clock support
  clk: mediatek: Add MT8192 imp i2c wrapper clock support
  clk: mediatek: Add MT8192 ipesys clock support
  clk: mediatek: Add MT8192 mdpsys clock support
  clk: mediatek: Add MT8192 mfgcfg clock support
  clk: mediatek: Add MT8192 mmsys clock support
  clk: mediatek: Add MT8192 msdc clock support
  clk: mediatek: Add MT8192 scp adsp clock support
  clk: mediatek: Add MT8192 vdecsys clock support
  clk: mediatek: Add MT8192 vencsys clock support

 .../arm/mediatek/mediatek,apmixedsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt |    1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt |   22 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt |    2 +
 .../arm/mediatek/mediatek,imp_iic_wrap.yaml   |   78 +
 .../arm/mediatek/mediatek,infracfg.txt        |    1 +
 .../bindings/arm/mediatek/mediatek,ipesys.txt |    1 +
 .../arm/mediatek/mediatek,mdpsys.yaml         |   38 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,msdc.yaml  |   46 +
 .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
 .../arm/mediatek/mediatek,scp-adsp.yaml       |   38 +
 .../arm/mediatek/mediatek,topckgen.txt        |    1 +
 .../arm/mediatek/mediatek,vdecsys.txt         |    8 +
 .../arm/mediatek/mediatek,vencsys.txt         |    1 +
 drivers/clk/mediatek/Kconfig                  |   80 +
 drivers/clk/mediatek/Makefile                 |   13 +
 drivers/clk/mediatek/clk-mt8192-aud.c         |  118 ++
 drivers/clk/mediatek/clk-mt8192-cam.c         |  107 ++
 drivers/clk/mediatek/clk-mt8192-img.c         |   70 +
 .../clk/mediatek/clk-mt8192-imp_iic_wrap.c    |  119 ++
 drivers/clk/mediatek/clk-mt8192-ipe.c         |   57 +
 drivers/clk/mediatek/clk-mt8192-mdp.c         |   82 +
 drivers/clk/mediatek/clk-mt8192-mfg.c         |   50 +
 drivers/clk/mediatek/clk-mt8192-mm.c          |  108 ++
 drivers/clk/mediatek/clk-mt8192-msdc.c        |   85 ++
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c    |   50 +
 drivers/clk/mediatek/clk-mt8192-vdec.c        |   94 ++
 drivers/clk/mediatek/clk-mt8192-venc.c        |   53 +
 drivers/clk/mediatek/clk-mt8192.c             | 1326 +++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |   23 +
 drivers/clk/mediatek/clk-mtk.h                |   10 +
 drivers/clk/mediatek/clk-mux.h                |   15 +
 drivers/clk/mediatek/clk-pll.c                |   31 +-
 include/dt-bindings/clock/mt8192-clk.h        |  585 ++++++++
 36 files changed, 3310 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,msdc.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,scp-adsp.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt8192-aud.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-mdp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-msdc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-scp_adsp.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192.c
 create mode 100644 include/dt-bindings/clock/mt8192-clk.h
