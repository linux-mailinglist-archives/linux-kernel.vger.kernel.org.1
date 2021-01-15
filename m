Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C672F7790
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhAOLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:24:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:58081 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbhAOLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:24:22 -0500
X-UUID: 69a24a2d07a641f392b1dff7cc47ea39-20210115
X-UUID: 69a24a2d07a641f392b1dff7cc47ea39-20210115
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1357855546; Fri, 15 Jan 2021 19:23:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 Jan 2021 19:23:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Jan 2021 19:23:35 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <crystal.guo@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <stanley.chu@mediatek.com>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <Yingjoe.Chen@mediatek.com>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <Yidi.Lin@mediatek.com>, <ikjn@chromium.org>
Subject: [v7,2/2] reset-controller: ti: introduce an integrated reset handler
Date:   Fri, 15 Jan 2021 19:23:31 +0800
Message-ID: <20210115112331.27434-3-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210115112331.27434-1-crystal.guo@mediatek.com>
References: <20210115112331.27434-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5E853876C392C9C9401EA3500EE0D371DA375EFC9FD4FBEBB67153AC2FA3F1082000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce ti_syscon_reset() to integrate assert and deassert together.
If some modules need do serialized assert and deassert operations
to reset itself, reset_control_reset can be called for convenience.

Such as reset-qcom-aoss.c, it integrates assert and deassert together
by 'reset' method. MTK Socs also need this method to perform reset.

Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
---
 drivers/reset/reset-ti-syscon.c | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
index 218370faf37b..a30cb17362a4 100644
--- a/drivers/reset/reset-ti-syscon.c
+++ b/drivers/reset/reset-ti-syscon.c
@@ -15,15 +15,24 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/delay.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
 #include <dt-bindings/reset/ti-syscon.h>
 
+#define MTK_SYSCON_RESET_FLAG	BIT(0)
+#define MT_RESET_DURATION	10
+
+struct mediatek_reset_data {
+	unsigned int flag;
+};
+
 /**
  * struct ti_syscon_reset_control - reset control structure
  * @assert_offset: reset assert control register offset from syscon base
@@ -56,6 +65,7 @@ struct ti_syscon_reset_data {
 	struct regmap *regmap;
 	struct ti_syscon_reset_control *controls;
 	unsigned int nr_controls;
+	const struct mediatek_reset_data *reset_data;
 };
 
 #define to_ti_syscon_reset_data(rcdev)	\
@@ -158,9 +168,32 @@ static int ti_syscon_reset_status(struct reset_controller_dev *rcdev,
 		!(control->flags & STATUS_SET);
 }
 
+static int mtk_syscon_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	int ret;
+
+	ret = ti_syscon_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+	usleep_range(MT_RESET_DURATION, MT_RESET_DURATION * 2);
+
+	return ti_syscon_reset_deassert(rcdev, id);
+}
+
+static int ti_syscon_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct ti_syscon_reset_data *data = to_ti_syscon_reset_data(rcdev);
+
+	if (data->reset_data && data->reset_data->flag & MTK_SYSCON_RESET_FLAG)
+		return mtk_syscon_reset(rcdev, id);
+	else
+		return -ENOTSUPP;
+}
+
 static const struct reset_control_ops ti_syscon_reset_ops = {
 	.assert		= ti_syscon_reset_assert,
 	.deassert	= ti_syscon_reset_deassert,
+	.reset		= ti_syscon_reset,
 	.status		= ti_syscon_reset_status,
 };
 
@@ -182,6 +215,7 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	data->reset_data = of_device_get_match_data(&pdev->dev);
 	list = of_get_property(np, "ti,reset-bits", &size);
 	if (!list || (size / sizeof(*list)) % 7 != 0) {
 		dev_err(dev, "invalid DT reset description\n");
@@ -217,8 +251,13 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
 
+static const struct mediatek_reset_data mtk_reset_data = {
+	.flag = MTK_SYSCON_RESET_FLAG,
+};
+
 static const struct of_device_id ti_syscon_reset_of_match[] = {
 	{ .compatible = "ti,syscon-reset", },
+	{ .compatible = "mediatek,syscon-reset", .data = &mtk_reset_data},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, ti_syscon_reset_of_match);
-- 
2.18.0

