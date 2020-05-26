Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65881AFCB1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgDSR2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 13:28:00 -0400
Received: from v6.sk ([167.172.42.174]:44490 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDSR17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:27:59 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 04FE3610C3;
        Sun, 19 Apr 2020 17:27:58 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 04/10] dt-bindings: marvell,mmp2: Add clock id for the Audio clock
Date:   Sun, 19 Apr 2020 19:27:36 +0200
Message-Id: <20200419172742.674717-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419172742.674717-1-lkundrak@v3.sk>
References: <20200419172742.674717-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clocks the Audio block.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 include/dt-bindings/clock/marvell,mmp2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindings/clock/marvell,mmp2.h
index 5b083f42811e5..87f5ad5df72f4 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -89,6 +89,7 @@
 #define MMP3_CLK_GPU_3D			MMP2_CLK_GPU_3D
 #define MMP3_CLK_GPU_2D			125
 #define MMP3_CLK_SDH4			126
+#define MMP2_CLK_AUDIO			127
 
 #define MMP2_NR_CLKS			200
 #endif
-- 
2.26.0

