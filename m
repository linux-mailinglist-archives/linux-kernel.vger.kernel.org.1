Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFC821B169
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGJIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 04:34:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38484 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgGJIeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:34:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D60DA201248;
        Fri, 10 Jul 2020 10:34:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 188C92002A0;
        Fri, 10 Jul 2020 10:34:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 51FA9402D3;
        Fri, 10 Jul 2020 16:34:00 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     shawnguo@kernel.org, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] ARM: dts: imx6qp-sabresd: enable sata
Date:   Fri, 10 Jul 2020 16:30:48 +0800
Message-Id: <1594369848-28627-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594369848-28627-1-git-send-email-hongxing.zhu@nxp.com>
References: <1594369848-28627-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SATA on iMX6QP SABRESD board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6qp-sabresd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
index f1b9cb104fdd..480e73183f6b 100644
--- a/arch/arm/boot/dts/imx6qp-sabresd.dts
+++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
@@ -53,3 +53,7 @@
 &pcie {
 	status = "disabled";
 };
+
+&sata {
+	status = "okay";
+};
-- 
2.17.1

