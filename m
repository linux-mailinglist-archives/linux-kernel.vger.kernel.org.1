Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FFD2CB3E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 05:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgLBEZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 23:25:56 -0500
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:54360 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgLBEZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:25:55 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0B24NxDh029494; Wed, 2 Dec 2020 13:23:59 +0900
X-Iguazu-Qid: 2wHHLA7xMrKCChEy9c
X-Iguazu-QSIG: v=2; s=0; t=1606883038; q=2wHHLA7xMrKCChEy9c; m=F3WaA6VlPhmpj9f7wRS45qVKR3VuOfGCXKN2va3wcB4=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1111) id 0B24NwR3037024;
        Wed, 2 Dec 2020 13:23:58 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 0B24NwIL021669;
        Wed, 2 Dec 2020 13:23:58 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 0B24NvUi020550;
        Wed, 2 Dec 2020 13:23:58 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     linux-arm-kernel@lists.infradead.org
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH] MAINTAINERS: Add entries for Toshiba Visconti5 watchdog driver
Date:   Wed,  2 Dec 2020 22:22:20 +0900
X-TSB-HOP: ON
Message-Id: <20201202132220.2408089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for Toshiba Visconti5 watchdog driver and binding.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2daa6ee673f7..f3ad5c290a8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2627,8 +2627,10 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
 F:	Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
+F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
 F:	drivers/pinctrl/visconti/
+F:	drivers/watchdog/visconti_wdt.c
 N:	visconti
 
 ARM/UNIPHIER ARCHITECTURE
-- 
2.29.2

