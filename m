Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E92FE426
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbhAUHjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:39:16 -0500
Received: from segapp03.wistron.com ([103.200.3.20]:62677 "EHLO
        segapp03.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbhAUHjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:39:11 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 02:39:10 EST
Received: from EXCHAPP03.whq.wistron (unverified [10.37.38.26]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te431fb7fcec0a816721aa0@TWNHUMSW4.wistron.com>;
 Thu, 21 Jan 2021 15:31:49 +0800
Received: from EXCHAPP03.whq.wistron (10.37.38.26) by EXCHAPP03.whq.wistron
 (10.37.38.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 21 Jan
 2021 15:31:48 +0800
Received: from gitserver.wistron.com (10.37.38.233) by EXCHAPP03.whq.wistron
 (10.37.38.26) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 21 Jan 2021 15:31:48 +0800
From:   Ben Pai <Ben_Pai@wistron.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <claire_ku@wistron.com>, Ben Pai <Ben_Pai@wistron.com>
Subject: [PATCH v1] ARM: dts: aspeed: Add Mowgli rtc driver
Date:   Thu, 21 Jan 2021 15:31:46 +0800
Message-ID: <20210121073146.28217-1-Ben_Pai@wistron.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 33431E5E8F89510968F99CC5EE2665AB0CD5DBCA1446DBBFDC9A097D43E4BC3B2000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mowgli rtc driver.

Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
index b648e468e9db..8503152faaf0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
@@ -582,6 +582,11 @@
 	/* TMP275A */
 	/* TMP275A */
 
+	rtc@32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+
 	tmp275@48 {
 		compatible = "ti,tmp275";
 		reg = <0x48>;
-- 
2.17.1

