Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1B1CE457
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 21:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgEKTZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 15:25:46 -0400
Received: from v6.sk ([167.172.42.174]:52400 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731534AbgEKTZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:25:43 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id A6820610D3;
        Mon, 11 May 2020 19:25:41 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 09/10] dt-bindings: marvell,mmp2: Add ids for the power domains
Date:   Mon, 11 May 2020 21:25:16 +0200
Message-Id: <20200511192517.1206442-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511192517.1206442-1-lkundrak@v3.sk>
References: <20200511192517.1206442-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MMP2 the audio and GPU blocks are on separate power islands. On MMP3
the camera block's power is also controlled separately.

Add the numbers that we could use to refer to the power domains for
respective power islands from the device tree.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Rob Herring <robh@kernel.org>

---
Changes since v1:
- Rob's ack

 include/dt-bindings/power/marvell,mmp2.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/power/marvell,mmp2.h

diff --git a/include/dt-bindings/power/marvell,mmp2.h b/include/dt-bindings/power/marvell,mmp2.h
new file mode 100644
index 000000000000..c53d2b3e1057
--- /dev/null
+++ b/include/dt-bindings/power/marvell,mmp2.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DTS_MARVELL_MMP2_POWER_H
+#define __DTS_MARVELL_MMP2_POWER_H
+
+#define MMP2_POWER_DOMAIN_GPU		0
+#define MMP2_POWER_DOMAIN_AUDIO		1
+#define MMP3_POWER_DOMAIN_CAMERA	2
+
+#define MMP2_NR_POWER_DOMAINS		3
+
+#endif
-- 
2.26.2

