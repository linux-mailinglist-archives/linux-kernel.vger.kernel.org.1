Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471D61EF1AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 08:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgFEGxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 02:53:41 -0400
Received: from v6.sk ([167.172.42.174]:46452 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEGxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:53:41 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 7DCAA610D5;
        Fri,  5 Jun 2020 06:53:09 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dt-bindings: clock: Add a missing include to MMP Audio Clock binding
Date:   Fri,  5 Jun 2020 08:52:58 +0200
Message-Id: <20200605065258.567858-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The include file for input clock in the example was missing, breaking the
validation.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reported-by: Rob Herring <robh+dt@kernel.org>
---
 .../devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
index ab6e82d1d3a9e..dffa73402da93 100644
--- a/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/marvell,mmp2-audio-clock.yaml
@@ -59,6 +59,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/marvell,mmp2-audio.h>
+    #include <dt-bindings/clock/marvell,mmp2.h>
     #include <dt-bindings/power/marvell,mmp2.h>
 
     clock-controller@d42a0c30 {
-- 
2.26.2

