Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E11CBED2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 10:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgEIISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 04:18:10 -0400
Received: from v6.sk ([167.172.42.174]:48972 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgEIISH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:18:07 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 48082610B3;
        Sat,  9 May 2020 08:18:05 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [RESEND PATCH v2 2/3] dt-bindings: phy: Allow BSD licensing of marvell,mmp3-hsic-phy.yaml
Date:   Sat,  9 May 2020 10:17:53 +0200
Message-Id: <20200509081754.474787-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200509081754.474787-1-lkundrak@v3.sk>
References: <20200509081754.474787-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote this binding and I'm fine with it being GPL + BSD dual-licensed,
as is recommended for new DT bindings.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
index 30e290c57930..ff255aa4cc10 100644
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

