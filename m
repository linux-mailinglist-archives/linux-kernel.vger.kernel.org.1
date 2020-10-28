Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474D029DAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390610AbgJ1X2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:28:43 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20041 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390569AbgJ1X2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603927686; x=1635463686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6n2d3Nw4+/BvSQCZVekBcYAwmYCImlxAQwh3nDgopHc=;
  b=TJMtRRrdbeT92L6GRmQff7c2Kl0lNwfaurtCdQfhX25SalFmFYrj3pGm
   bo5yR3KrzFBvdbdd5BB+I2ZNHgflnFDZhDaVRsk3Fu+OFLuctlPo0lrgp
   Mjn/6YDoyc9ernLzmnoUgq7VywFvl4+rSJ7qBVEf4g5lcjOD58dTloM+Y
   Cj+jmnBXKfUEvrZi1TMmdyQKXOk9MuWHTO9xHAdJysjJobPykJ1RHUOkX
   wfLPW/lD3EDQOyNfD8yeur3JFXVVn013MgPbBNezEoz2zjrz9c+DY0rGJ
   H5VGjU0EAeM+oWQntEpv4HRB2rKT1qnat5h5WjfWr42pM3OISXe4ovYNL
   g==;
IronPort-SDR: ZuF6SaX8tEiW5f16jD7tWKEby97hSaifxwgWFCJ5Hl1DQeSYG4grbHNr0TjstNovClQdAa7dUF
 xhBRdftK9YCY2ZZGAZy880+dHk2Umm20DYoxlsGcVSjC3YXW2aEooXnZexv4jBJP9LzYDZfmZ4
 wV8nsAKu/B5tMkm+UURY8AraQbbcTDucLbJSqxMAv/1hZ7i+9wkWpbsh1OSpyvwb2PLrNWMVic
 +IGa/72R8aFLzL2Dk9I98A7R5TCTLIEUogfeaG5FzSU9ghakGS9++F5ufOTwKeY/vqbIyuFYCU
 B3w=
X-IronPort-AV: E=Sophos;i="5.77,428,1596470400"; 
   d="scan'208";a="155611420"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 07:28:06 +0800
IronPort-SDR: XrKxTqml/lbAFmiO0hYnR/rMWHty/+5vaCfy5/3mWqZu4eRzBOxfDEwiEztTeRn6AF9BrDH4Nz
 qoaZzm/2LFEQnKOyuTzLiPVnoutpec8cp2+k2jqhWNflIjSl+xZHGfpLlv/OCYFHQ7pfvzs+1t
 wS0qJ3FBrdQVnDFIEG93drDcQcHbnaXtDy9t+TvI0TqrWe+WI01FO4lVNXBwPnc0uQHraNZxbk
 FWaqVzEMN37i8oQCbQ9VSTOzAuwKVE+0Cuw3RmLN+f0VApQSmeNunDHjGnuq20KGCh3Mi73S4r
 PKtaHSVOmCClQ5bJZuUgRk/S
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 16:14:22 -0700
IronPort-SDR: dEjHin5uDaUncBBDKai1yiEDYvkh/5xbx9tbjqOIIhUNxWR9COUDwsaTbfD8OhLCHXAKBaH8sO
 JRl/JzxvEXUrLoKVtX0dihBQAcbnboJDogsemdy1o8lwaB7zYsw2Km4OpwbeHRFcpx7AeO83lt
 g3UI16nVWp3Ux4rzKEYXSD5NKtfbJD1AUT3Qh0a3pAs4kQggbMpqlb/nv42qU2VUGP+rmgyGjA
 6eQj7oGORrPbysgCtZOcbPDzR0utnwrJpjKg6+DDH+Wlu1pzyltYsnMrkCMFCRqtKbZydeseKA
 PNg=
WDCIronportException: Internal
Received: from myd002180.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Oct 2020 16:28:07 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        padmarao.begari@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com
Subject: [RFC PATCH 1/3] RISC-V: Add Microchip PolarFire SoC kconfig option
Date:   Wed, 28 Oct 2020 16:27:57 -0700
Message-Id: <20201028232759.1928479-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028232759.1928479-1-atish.patra@wdc.com>
References: <20201028232759.1928479-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Microchip PolarFire kconfig option which selects SoC specific
and common drivers that is required for this SoC.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig.socs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 8a55f6156661..74d07250ecc5 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -22,6 +22,13 @@ config SOC_VIRT
 	help
 	  This enables support for QEMU Virt Machine.
 
+config SOC_MICROCHIP_POLARFIRE
+	bool "Microchip PolarFire SoCs"
+	select MCHP_CLK_PFSOC
+	select SIFIVE_PLIC
+	help
+	  This enables support for Microchip PolarFire SoC platforms.
+
 config SOC_KENDRYTE
 	bool "Kendryte K210 SoC"
 	depends on !MMU
-- 
2.25.1

