Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A84E2C37AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 04:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgKYDgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 22:36:32 -0500
Received: from foss.arm.com ([217.140.110.172]:45998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgKYDgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 22:36:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C1F106F;
        Tue, 24 Nov 2020 19:36:31 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 293723F718;
        Tue, 24 Nov 2020 19:36:31 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] mmc: sdhci: Use more concise device_property_read_u64
Date:   Tue, 24 Nov 2020 21:36:30 -0600
Message-Id: <20201125033630.603863-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we only need a single u64 the _array form is
unnecessarily. Use device_property_read_u64 instead.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/mmc/host/sdhci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index feba64fbde16..ad4ae88a7f74 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3992,10 +3992,10 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 	if (host->v4_mode)
 		sdhci_do_enable_v4_mode(host);
 
-	device_property_read_u64_array(mmc_dev(host->mmc),
-				       "sdhci-caps-mask", &dt_caps_mask, 1);
-	device_property_read_u64_array(mmc_dev(host->mmc),
-				       "sdhci-caps", &dt_caps, 1);
+	device_property_read_u64(mmc_dev(host->mmc),
+				 "sdhci-caps-mask", &dt_caps_mask);
+	device_property_read_u64(mmc_dev(host->mmc),
+				 "sdhci-caps", &dt_caps);
 
 	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
-- 
2.26.2

