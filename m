Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA932ECCD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbhAGJaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:30:24 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33456 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbhAGJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610011821; x=1641547821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JbxwQXAp8/3z4IWi+Gua7LgpjZZA1rYhUXq7awjP4hg=;
  b=K5+aJC2Ygwh9KACv1p6rIpC9hGkb+R9sQZnN5I+LyW2P6MPtizzMhLLb
   iqH/KKeJPJKSbPfuQJtpY2MeNX+68HgzRwvpkL6jzUWa6+A//FXNLv9Jd
   UZmNIUVDXqSuI0M5LE8ayYWzRGaHfsM7LDzPK4PPPLKrqPf1B/U2ygaXe
   jpDRn11B3/y/pAZcpRBv2K5KP9DUl0Us1klEz6o5YU/iCCuFz9m+yz5gW
   OoKnWmSEzRyXDWwk4BWRSZiztp/fLBP8ue4YCE9VGTDfKU5u2Fp261wBq
   +39qaK3lnPgGMaE0vjLLKPz84H3W6sr5tFUp6kHTRAnQGFTeih0QWug9c
   Q==;
IronPort-SDR: 4NGvuqqih5X8ucHT8cZv4ST5xnw7JUBkyZKyO0QWZ2v688t6W/QMTkz/ahPFKrkiAr3aj2zNuq
 uBbbetyoSO4xLwvyn2Fvo2kMWjtVe/wTHbsA4ltl2smNvwswgUG29OkqAseMY1jRRXcLP1gjKh
 VWE178joS8Z4PyNJ0A9gI9Vb0GgmaOMhfL/xgBubDhjmKCJhjv/bM/pwD+BjgBK+OHlbm2X8un
 U1LntO/xH+nNOYoGaNGJkRatCcVpOaSjZX71UqxUspI5ixduLEGuqj+qMLfbBLkOTfS7Z7Rty4
 Wro=
X-IronPort-AV: E=Sophos;i="5.79,329,1602518400"; 
   d="scan'208";a="156695574"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2021 17:27:30 +0800
IronPort-SDR: l7I4RczRBdZgs+uMFy9hLak1X6ipto8mVKbfVE6rkEuKM9p6Q2cQGGCAI4OjVw+uT/gF4a1HyZ
 uFcGaO8GgZO/c6Bl0/jqxDQMD6YYgKWICrCSZcVf0KjCuKi0zErapAjGyEZ/HeJ2gGb5iiHnTN
 7RQN9JsQJOzOiWibaBo/gb0RtvdEFOu+3yTixWfivc7RY5qkmACEIv07Td7mYNpwh3vVqVw/Jv
 Tmf2w86UEielrWNx/hx6eYw8RAOgxFBeTQGiKSZcaidh3gfuMftmlDcw3foS3Ol0q/MTs/soA4
 cB9SUyCVzIwmPPewHmWBkGg+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 01:12:22 -0800
IronPort-SDR: ijzR/wHlOB+9SpHSl1Smyc1/40iR2xT2DOt6Q/lPeC383NbJy2iGpBzrL7+jBDKTBqem+vyyZl
 J7uxDWuTesC2mrzZGX8Mn65QLuklE9mnZTRH71dbECceulqD0Cba0Cr6k8tLezR58Nxud+O+OJ
 o4BAddTZ2ECsjm8KbDSYoWUzI5Ui9cIFQJ1f07oz2EPsybKDZVEwny6UJBpMNxxkYvhMfy/mUi
 /tf3EcqQeQJwTFJiQD2UYQqxjwZlgS3xL7DKqLFu5G6mrEmfl092v2VLuJMdfP3b4I1QyRwlye
 mgM=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jan 2021 01:27:30 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH 4/4] RISC-V: Fix maximum allowed phsyical memory for RV32
Date:   Thu,  7 Jan 2021 01:26:52 -0800
Message-Id: <20210107092652.3438696-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107092652.3438696-1-atish.patra@wdc.com>
References: <20210107092652.3438696-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel can only map 1GB of address space for RV32 as the page offset
is set to 0xC0000000. The current description in the Kconfig is confusing
as it indicates that RV32 can support 2GB of physical memory. That is
simply not true for current kernel. In future, a 2GB split support can be
added to allow 2GB physical address space.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 81b76d44725d..e9e2c1f0a690 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -137,7 +137,7 @@ config PA_BITS
 
 config PAGE_OFFSET
 	hex
-	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
+	default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
 	default 0x80000000 if 64BIT && !MMU
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
@@ -247,10 +247,12 @@ config MODULE_SECTIONS
 
 choice
 	prompt "Maximum Physical Memory"
-	default MAXPHYSMEM_2GB if 32BIT
+	default MAXPHYSMEM_1GB if 32BIT
 	default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
 	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
 
+	config MAXPHYSMEM_1GB
+		bool "1GiB"
 	config MAXPHYSMEM_2GB
 		bool "2GiB"
 	config MAXPHYSMEM_128GB
-- 
2.25.1

