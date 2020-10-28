Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90129DAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390589AbgJ1X21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:28:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20041 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390571AbgJ1X2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603927687; x=1635463687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bJAk/HlCEdByWU/6opUy/B9SIlWfZOpnQb53UvC9we8=;
  b=Hn+AzotJJt7fcBKxuGWJuGGFvqho/BBeXPH3KWNEi7V8tsMeqMUYoDxd
   3pvijlM4zPOAGhISdLbg6CAfoctWwxEsu43RnEjEGFy37+Ud3t7GVpJIB
   9dfkpPTOZhTjD7DxISeVDtYKM6lY91PK0XhYRyeM5pB2BqwuyekYLZa+c
   F3x790gEE+NJW6INdR5M0DX/S+FjxOngVf+c/OQeNuaViy2nt/zOVsGGB
   mRaO+aBt9Z+GltUazNOaJd0ih7Kx9f0P6z9YNeGEsmRvFxVoOxW6HSrDm
   L7nDdCuijzN3jx34gJFdcpZ4IsFwnFkWmp0ANJHcuDtxCudPCWiZafQ/n
   Q==;
IronPort-SDR: Wg3Bg+qcJWqdd6/QGCxM/eiz/grrWqx60mCd/y4nPVNmGfgkj2VpY5pyldjp7KMTrQkaRczOm5
 U9jo+VPevekV2ORXS8cJ2THMbSwCHnAh2auSSifX846r/Dz+yAwHQzltD0g0iMKRdGcecGGtW8
 Dbhve2oLceW2oT2zFjB2ZhqbWP9KxwOD0XhFRiwHdYWpLiR6oUz8owPenei5Mg7N8fUcQstqRn
 jV+v3zYn/BraNYQB8jY/s91ppPFPKiZiwsE1gu/oxCDLCzPDlPnWVqQraCdQi+9Ar2bRi5iU41
 yEM=
X-IronPort-AV: E=Sophos;i="5.77,428,1596470400"; 
   d="scan'208";a="155611424"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 07:28:07 +0800
IronPort-SDR: EJFOM87XrKCk+mpnGIEtnR4IAkDRlFXgMkXTOlKZmtMsfnQe4NUKew5ORz2ygYmmzJtjwSj6B/
 7LEZemOhOejeimuNMcMlR4fHKace1jL1azQrGxcyPdQeVQwxWEFqXUULqx4bLJB3GsQ5Ox1Clm
 jCwULkQwvfbTOfQoekUFEOiRSv97k+aW4w51Vr2NOX8iD+gKiVtW7sFI0cvSud/jxZxe4ctBfY
 0eOaYBMdhc/t1Mv7erOSvv9vf+uZFfKhP4gwJHlTsiGfhHrNylyVbij6E/ETh83aXfAoXPR7Qe
 oqMT26FBQ9edprBfJlaQmYi7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 16:14:23 -0700
IronPort-SDR: 94lWjA8ui21z5dRyHN8PFZLWc4UbJh3udYMvZwY9leNLlEB8hUj+d1Z/jiMQcWUW7nsSihk7lE
 De3GYYbvK3lkjiMk/0VstuQyyR07X7e7Nu4hoRn9agFLCYiKJt4QQ50Tdh80eMih/LGBigp8M0
 YF4Oro9CD5i31jZTZiMSllyoN6XzPvseyy2jZQK0GjkEhFzFJ6aj0z5kIPRf8wtwUdctUo7UdD
 gKiq4jBVFuM6YFUEVh5FVbmmXhPISPJ9c5N8NAgSnNMt2dHBWCDeA5nRnyKMt6UNmLAA7y793f
 8fc=
WDCIronportException: Internal
Received: from myd002180.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Oct 2020 16:28:08 -0700
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
Subject: [RFC PATCH 3/3] RISC-V: Enable Microchip PolarFire ICICLE SoC
Date:   Wed, 28 Oct 2020 16:27:59 -0700
Message-Id: <20201028232759.1928479-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028232759.1928479-1-atish.patra@wdc.com>
References: <20201028232759.1928479-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Microchip PolarFire ICICLE soc config in defconfig.
It allows the default upstream kernel to boot on PolarFire ICICLE board.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index d222d353d86d..2660fa05451e 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -16,6 +16,7 @@ CONFIG_EXPERT=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
+CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SMP=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
@@ -79,6 +80,9 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
 CONFIG_RTC_CLASS=y
-- 
2.25.1

