Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA881BA27A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 13:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgD0Lgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 07:36:37 -0400
Received: from foss.arm.com ([217.140.110.172]:34232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0Lgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:36:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB3F1FB;
        Mon, 27 Apr 2020 04:36:35 -0700 (PDT)
Received: from ssg-dev-vb.arm.com (E111385.Arm.com [10.50.65.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60B403F73D;
        Mon, 27 Apr 2020 04:36:32 -0700 (PDT)
From:   Hadar Gat <hadar.gat@arm.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hadar Gat <hadar.gat@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>
Subject: [PATCH v3 3/3] hwrng: cctrng - update help description
Date:   Mon, 27 Apr 2020 14:36:04 +0300
Message-Id: <1587987364-4566-4-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587987364-4566-1-git-send-email-hadar.gat@arm.com>
References: <1587987364-4566-1-git-send-email-hadar.gat@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improved the HW_RANDOM_CCTRNG help description.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
---
 drivers/char/hw_random/Kconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index b98eb1c..ac00d78 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -478,13 +478,14 @@ config HW_RANDOM_CCTRNG
 	tristate "Arm CryptoCell True Random Number Generator support"
 	depends on HAS_IOMEM && OF
 	help
-	  This driver provides support for the True Random Number
-	  Generator available in Arm TrustZone CryptoCell.
-
-	  To compile this driver as a module, choose M here: the module
+	  Say 'Y' to enable the True Random Number Generator driver for the
+	  Arm TrustZone CryptoCell family of processors.
+	  Currently the CryptoCell 713 and 703 are supported.
+	  The driver is supported only in SoC where Trusted Execution
+	  Environment is not used.
+	  Choose 'M' to compile this driver as a module. The module
 	  will be called cctrng.
-
-	  If unsure, say Y.
+	  If unsure, say 'N'.
 
 endif # HW_RANDOM
 
-- 
2.7.4

