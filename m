Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE652CEA67
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgLDJBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:01:32 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41999 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgLDJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607072526; x=1638608526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jNYvSiz+H6AytLwCJnlGVjeteLNQ/vg7CpUZAEZLOKs=;
  b=FR4iyoKRokZGprAzbqcLg/gufLyLQWIAkJzWNTupOwxokA5Alm8oxfll
   GqGYJelCbH6GR/J8Cvh47RpKnxJ9qP5/41/Bfc0c7oDxzBKIbYT+SrhQS
   1906wxiZU4D7e48/IMBlD6VedALPD1EZJVSyGoxUew7+mtXckbDTJHTZW
   hWLCWv2oseR5hOpTcWP9uQh06s2CnYMJvOG+4zZFNdpZWC4yccoHLGmFo
   YFS61pP9EupLHX+pshKU5UAguZWYnspdhLBDCGO/sGj0v+0sgsMZLFN24
   auAw08mQG86LKlRNNQanY4bhPdKQN3Ufsufj88GyesPxQcTaX9gY4HozP
   Q==;
IronPort-SDR: qzmdobx10hUww9o9AuPjrmP6J2nb/iMlJFzN4RHal2Zqswt6ISeHmBrXRH4u4f0RJ5tf/BUKGN
 NrtEXvs3t1yhz4gcM/zTtvZNVKDhyGRhf+n2yxxbigE30VMB1pUbiAS3y/UUYwelDZPlquL12U
 mocZa6i4ZhcFilXUEKqTJwn8j+iEPJv3cN1Ob2kmlowQHQ3xqGaJi7xdO8niUEiCQDdVT5c8co
 hB18A/f7wQHG6/WtJ61jQUViNB/bCqxYLh26tfgBta/caT96yQDZL1j3tSfa10mNA7IspJnyTY
 X38=
X-IronPort-AV: E=Sophos;i="5.78,392,1599494400"; 
   d="scan'208";a="258129852"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 17:18:06 +0800
IronPort-SDR: OFAVSe1ZZy8i8e491y4uJYjaS6dXQ7eIbkPaJ/gcw0s+HYqRl20sIwtbHMYfkEOUYwMVNajdvU
 6ZwF69fNmQRxCSSnGw4i33rYbg5X9xaNU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 00:44:14 -0800
IronPort-SDR: J5zkwaI1zWnBh7tC1w9lVCiN2i9JhY5ygV36v++CgGATGZPXFVf4jUXgQf1yDo7CxaxXuAgBo2
 EPytFFLKykpw==
WDCIronportException: Internal
Received: from cnf010505.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.200])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2020 00:58:41 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Bin Meng <bin.meng@windriver.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Ivan.Griffin@microchip.com,
        Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor.Dooley@microchip.com
Subject: [PATCH v3 5/5] MAINTAINERS: add microchip polarfire soc support
Date:   Fri,  4 Dec 2020 00:58:35 -0800
Message-Id: <20201204085835.2406541-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204085835.2406541-1-atish.patra@wdc.com>
References: <20201204085835.2406541-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add Cyril Jean and Lewis Hanly as maintainers for the Microchip SoC
directory

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2daa6ee673f7..cccb7d6c58aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14989,6 +14989,14 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
+M:	Lewis Hanly <lewis.hanly@microchip.com>
+M:	Cyril Jean <cyril.jean@microchip.com>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	drivers/soc/microchip/
+F:	include/soc/microchip/mpfs.h
+
 RNBD BLOCK DRIVERS
 M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
 M:	Jack Wang <jinpu.wang@cloud.ionos.com>
-- 
2.25.1

