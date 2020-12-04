Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060D62CEA5E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgLDJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:00:26 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41893 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgLDJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607072425; x=1638608425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hd8ZmjId7vBbXQM1jz5+4Nu+51CF6i4iXNW7aRPTEWM=;
  b=ZBWg4gq+2MNB5vaNSMIdkwxm1fOporNa83h+/unjzyc3XvZU6nNQnNDI
   vKx0+0glU6A0rLu4jO7N1I6qiDBWoKxoHcpZKbYtc5cWZik3Tl9X0xee1
   lXbDVY4UCewQEq3vaH14BD+Gg3kqX2C6abBWRuARwn/qv4NyLZK14Er74
   smEtrX8gcmoQBsU3ygUgoMn3H3TdOtzp0JDDVQqIi7ule88M6uiL/UlD4
   10tAtzx+myVyQN3YNv6S6BogY60RoBVuCGzYTayG2oUqo47CfNDd31Ffz
   1yMiotWJIgN8yy78hqdAC0yt8ASYlYi914V9keiLhU3mCSWz9h/+sa+CH
   A==;
IronPort-SDR: cY9dAJSm1SPbcoIh62NBx3SMW8TAEpLeV+NGOGs959m+u2coiyp1ZO/m7lokcQcJ7Vd9pvWNAz
 d08vzzPo3ab8epw+scgrLomoxG3n7IVcnH1g1GGkli/9kuxw8ABSRdZ5Ou0jQTJ5ZXOW9gzbNp
 RZEd6hme4SJYwfHaDgPMN9DzT9I5tzDM5dThEgb3VMH/TnHA/uM34yoHz91n51iw3avuohVtwy
 pYtXAZLcns3I6FXoInz6fU5eNWa61W6tQUeug5qLdODjv/KxBpOI+btLs8TkBVWYW2IVEflR4G
 RKM=
X-IronPort-AV: E=Sophos;i="5.78,392,1599494400"; 
   d="scan'208";a="258129844"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 17:18:03 +0800
IronPort-SDR: AIGhHAeu70aBtnDXVT9Rh4Vl8v9v5OVXufL+qT0Zv25kAezq9qrObmELGZ/mFeemAMF8Q2ORAE
 NXaPK77ZBHFYV2VJ8/zcRio3zn6ti1naU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 00:44:11 -0800
IronPort-SDR: YOD2hDxJzF7vnxvNHifPyI2Oz/45hnF4x7vnKsbiL5xlYmiL7JrCkysKlgtj+4NhYzIIZq7lHn
 cAyt4lJHnBqg==
WDCIronportException: Internal
Received: from cnf010505.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.200])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2020 00:58:39 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Ivan.Griffin@microchip.com,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor.Dooley@microchip.com
Subject: [PATCH v3 1/5] RISC-V: Add Microchip PolarFire SoC kconfig option
Date:   Fri,  4 Dec 2020 00:58:31 -0800
Message-Id: <20201204085835.2406541-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204085835.2406541-1-atish.patra@wdc.com>
References: <20201204085835.2406541-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Microchip PolarFire kconfig option which selects SoC specific
and common drivers that is required for this SoC.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig.socs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 8a55f6156661..148ab095966b 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,5 +1,12 @@
 menu "SoC selection"
 
+config SOC_MICROCHIP_POLARFIRE
+	bool "Microchip PolarFire SoCs"
+	select MCHP_CLK_PFSOC
+	select SIFIVE_PLIC
+	help
+	  This enables support for Microchip PolarFire SoC platforms.
+
 config SOC_SIFIVE
 	bool "SiFive SoCs"
 	select SERIAL_SIFIVE if TTY
-- 
2.25.1

