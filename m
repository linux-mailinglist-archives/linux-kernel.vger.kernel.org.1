Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC3E21F6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 18:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgGNQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 12:13:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:13532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNQNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:13:38 -0400
IronPort-SDR: dvGI9j/VnMN+8MEVudOFHXH+fggHt2RAhRc7UbiBt3Up3+0gx+N6lJoL+ejO7Q7jWKZRkEE1ln
 OcBbjg5Xw1mA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="129030337"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="129030337"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:13:37 -0700
IronPort-SDR: QcyaP3jmR+RLjEngeSzDHCAO1ftKwgqziLRElxLSVGyWU+jwZTYYffEv4eJQO3cE3/k7OOPA+c
 jv8wajkqibtw==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="485930514"
Received: from yagellee-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.20.60])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:13:33 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v3 1/7] arm64: Add config for Keem Bay SoC
Date:   Tue, 14 Jul 2020 17:12:59 +0100
Message-Id: <20200714161305.836348-2-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714161305.836348-1-daniele.alessandrelli@linux.intel.com>
References: <20200714161305.836348-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add ARCH_KEEMBAY configuration option to support Intel Movidius SoC
code-named Keem Bay.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 8dd05b2a925c..95c1b9042009 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -121,6 +121,11 @@ config ARCH_HISI
 	help
 	  This enables support for Hisilicon ARMv8 SoC family
 
+config ARCH_KEEMBAY
+	bool "Keem Bay SoC"
+	help
+	  This enables support for Intel Movidius SoC code-named Keem Bay.
+
 config ARCH_MEDIATEK
 	bool "MediaTek SoC Family"
 	select ARM_GIC
-- 
2.26.2

