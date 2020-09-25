Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7DA278307
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgIYInN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYInM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:43:12 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0542E2086A;
        Fri, 25 Sep 2020 08:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601023392;
        bh=aC3eStXjP1gG6VDOsZLRLl3ZQH0RNpWydh+LkmbCjEE=;
        h=From:To:Cc:Subject:Date:From;
        b=ZCpD658bV/kN+mu/eWNzDQ43ObztpCZUmJrNQEc3IoHsEm0KQcPWRZQwtoEDX5APn
         /WphcpLXmG1QKhcrfOaEQcNuMSWS/4Q5u9kZaxVIyIG2LGzISpqa5bqX47F7T+tbBE
         ec23ULMPyIFLzEAoFwzER7fassBDzgXJ+9InlUkw=
Received: by pali.im (Postfix)
        id 690D8E94; Fri, 25 Sep 2020 10:43:09 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: espressobin: Update link to V7 schematic
Date:   Fri, 25 Sep 2020 10:43:06 +0200
Message-Id: <20200925084306.16309-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
index 61d49d6a2a2a..6062a7df7342 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
@@ -8,7 +8,7 @@
  *
  */
 /*
- * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
+ * Schematic available at http://espressobin.net/wp-content/uploads/2020/05/ESPRESSObin_V7-0_Schematic.pdf
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
index 44dbe9a21cc7..c47a93978386 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
@@ -8,7 +8,7 @@
  *
  */
 /*
- * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
+ * Schematic available at http://espressobin.net/wp-content/uploads/2020/05/ESPRESSObin_V7-0_Schematic.pdf
  */
 
 /dts-v1/;
-- 
2.20.1

