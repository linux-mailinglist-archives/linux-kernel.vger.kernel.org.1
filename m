Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EAD1B96B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 07:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgD0FmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 01:42:04 -0400
Received: from foss.arm.com ([217.140.110.172]:56616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbgD0FmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:42:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A7A81063;
        Sun, 26 Apr 2020 22:42:03 -0700 (PDT)
Received: from ssg-dev-vb.arm.com (E111385.Arm.com [10.50.65.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DEB93F73D;
        Sun, 26 Apr 2020 22:41:59 -0700 (PDT)
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
Subject: [PATCH 1/3] hwrng: cctrng - Add dependency on OF
Date:   Mon, 27 Apr 2020 08:41:37 +0300
Message-Id: <1587966099-28139-2-git-send-email-hadar.gat@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587966099-28139-1-git-send-email-hadar.gat@arm.com>
References: <1587966099-28139-1-git-send-email-hadar.gat@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cctrng is unusable on non-DT systems so we should depend
on it.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 0c99735..df2d001 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -476,7 +476,7 @@ config HW_RANDOM_KEYSTONE
 
 config HW_RANDOM_CCTRNG
 	tristate "Arm CryptoCell True Random Number Generator support"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM & OF
 	default HW_RANDOM
 	help
 	  This driver provides support for the True Random Number
-- 
2.7.4

