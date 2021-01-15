Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA62F7792
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbhAOLYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:24:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:58065 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726030AbhAOLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:24:22 -0500
X-UUID: 2abbb0e4dcce4306913c5122fe29a496-20210115
X-UUID: 2abbb0e4dcce4306913c5122fe29a496-20210115
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1441417786; Fri, 15 Jan 2021 19:23:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 Jan 2021 19:23:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Jan 2021 19:23:33 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <crystal.guo@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <stanley.chu@mediatek.com>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <Yingjoe.Chen@mediatek.com>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <Yidi.Lin@mediatek.com>, <ikjn@chromium.org>
Subject: [v7,0/2] introduce TI reset controller for MT8192 SoC 
Date:   Fri, 15 Jan 2021 19:23:29 +0800
Message-ID: <20210115112331.27434-1-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7:
1. [v7,1/2] remove "mediatek,reset-bit" property from mediatek-syscon-reset.yaml in [v6,1/3]
2. [v7,2/2] use the flag "MTK_SYSCON_RESET_FLAG" to determine whether to call "mtk_syscon_reset",
which integrate assert and deassert together.
3. The patch "[v6,3/3] reset-controller:ti:force the write operation when assert or deassert" has been applied

v6:
fix the format error of mediatek-syscon-reset.yaml

v5:
1. revert ti-syscon-reset.txt, and add a new mediatek reset binding.
2. split the patch [v4, 3/4] with the change to force write and the
change to integrate assert and deassert together.
3. separate the dts patch from this patch sets

v4:
fix typos on v3 commit message.

v3:
1. revert v2 changes.
2. add 'reset-duration-us' property to declare a minimum delay,
which needs to be waited between assert and deassert.
3. add 'mediatek,infra-reset' to compatible.

v2 changes:
https://patchwork.kernel.org/patch/11697371/
1. add 'assert-deassert-together' property to introduce a new reset handler,
which allows device to do serialized assert and deassert operations in a single
step by 'reset' method.
2. add 'update-force' property to introduce force-update method, which forces
the write operation in case the read already happens to return the correct value.
3. add 'generic-reset' to compatible

v1 changes:
https://patchwork.kernel.org/patch/11690523/
https://patchwork.kernel.org/patch/11690527/


Crystal Guo (2):
  dt-binding: reset-controller: mediatek: add YAML schemas
  reset-controller: ti: introduce an integrated reset handler

 .../bindings/reset/mediatek-syscon-reset.yaml | 51 +++++++++++++++++++
 drivers/reset/reset-ti-syscon.c               | 39 ++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml

