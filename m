Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5AD1FC13E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 23:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFPVzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 17:55:18 -0400
Received: from v6.sk ([167.172.42.174]:48430 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgFPVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:55:14 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 98D7161634;
        Tue, 16 Jun 2020 21:54:42 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: phy: Allow BSD licensing of marvell,mmp3-hsic-phy.yaml
Date:   Tue, 16 Jun 2020 23:54:34 +0200
Message-Id: <20200616215435.987899-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616215435.987899-1-lkundrak@v3.sk>
References: <20200616215435.987899-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote this binding and I'm fine with it being GPL + BSD dual-licensed,
as is recommended for new DT bindings.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Rob Herring <robh@kernel.org>

---
Changes since v2:
- Add Rob's ack

 .../devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
index 30e290c579308..ff255aa4cc103 100644
--- a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 # Copyright 2019 Lubomir Rintel <lkundrak@v3.sk>
 %YAML 1.2
 ---
-- 
2.26.2

