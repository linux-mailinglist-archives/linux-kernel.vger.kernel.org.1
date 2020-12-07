Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C42D0953
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 04:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgLGDQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 22:16:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9386 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgLGDQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 22:16:35 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cq7jN4Hhnz79Th;
        Mon,  7 Dec 2020 11:15:20 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 11:15:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] dt-bindings: mediatek: mt8192: eliminate yamllint warnings
Date:   Mon, 7 Dec 2020 11:14:30 +0800
Message-ID: <20201207031430.1345-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following yamllint warnings:
./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
index bf8c8ba25009dcc..54650823b29a41d 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
@@ -7,8 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Mediatek MT8192 with MT6359, RT1015 and RT5682 ASoC sound card driver
 
 maintainers:
-   - Jiaxin Yu <jiaxin.yu@mediatek.com>
-   - Shane Chien <shane.chien@mediatek.com>
+  - Jiaxin Yu <jiaxin.yu@mediatek.com>
+  - Shane Chien <shane.chien@mediatek.com>
 
 description:
   This binding describes the MT8192 sound card.
-- 
1.8.3


