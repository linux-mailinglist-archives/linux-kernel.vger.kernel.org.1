Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC62836A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgJENfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgJENfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:35:31 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638E720756;
        Mon,  5 Oct 2020 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601904930;
        bh=QxMXAQ+yCvEEn6dM1e6qBOXZBOw7fFkONowEA4VtgVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1e/t/aI+colfpTAM8N4qwcH90Q+7vo/lnXUhRI0VM+bn23OgQZ+t/oKuHAsSnG1qu
         YyAUr+6XSImnKCL1x33tLJgt0i7mNX766dwnc2juex09x6SpP86/i4+6d465pn+1h5
         jxJ+fZr9U8VynzflBIHAaY9HYeNjE+YI0MDW3/qc=
Received: by pali.im (Postfix)
        id 1D75EA07; Mon,  5 Oct 2020 15:35:28 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: marvell: espressobin: Update link to V7 schematic
Date:   Mon,  5 Oct 2020 15:35:13 +0200
Message-Id: <20201005133513.8649-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925084306.16309-1-pali@kernel.org>
References: <20200925084306.16309-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up-to-date version of V7 schematic is on new URL linked from official
tech-spec webpage http://espressobin.net/tech-spec/

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in V2:
* Added commit description
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
index e225dce64b9e..4775a7eda481 100644
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

