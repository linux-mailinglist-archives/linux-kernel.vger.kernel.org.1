Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0C247A82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 00:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgHQWe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 18:34:26 -0400
Received: from mail.v3.sk ([167.172.186.51]:54244 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729879AbgHQWeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:34:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 656E7DFA54;
        Mon, 17 Aug 2020 22:33:28 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id t-bDxQEXBzGE; Mon, 17 Aug 2020 22:33:22 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C2BBDDF92E;
        Mon, 17 Aug 2020 22:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XPR_kNhjw9gr; Mon, 17 Aug 2020 22:33:17 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E7229DFA54;
        Mon, 17 Aug 2020 22:33:14 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v3 2/3] dt-bindings: phy: Allow BSD licensing of marvell,mmp3-hsic-phy.yaml
Date:   Tue, 18 Aug 2020 00:33:59 +0200
Message-Id: <20200817223400.403505-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817223400.403505-1-lkundrak@v3.sk>
References: <20200817223400.403505-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.=
yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
index 30e290c579308..ff255aa4cc103 100644
--- a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 # Copyright 2019 Lubomir Rintel <lkundrak@v3.sk>
 %YAML 1.2
 ---
--=20
2.26.2

