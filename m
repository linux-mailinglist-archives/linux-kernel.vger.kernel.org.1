Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B327C1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgI2J74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:59:56 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32824 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2J7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601373595; x=1632909595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lPXm14u5SNjYaTf0lhMp9UJ1Oo88Rqt6DJtSqddXwAY=;
  b=byQxC8jhlhlmxc1eCo4I6ZeJL6+aik+brD6W/qQKo6rHLWpJQeeUOxEV
   qJ3YIGTiF5DfguX+LDiSBETJAFCfH1jeYmqrtHBHFK87+wIVem9P2lk+G
   G9J8rb/ChG2EBF+yNLjCisWtVowRYyG4vHLJm6QkaoTbRNSWyJkwAH2qw
   hhKFWfjVAQlQc0TXbAGNq0dWjBsW8aot0XYx5Xv13Dyz2MIDnAPalzz7n
   kB64IRaxZCGoUYVtOewOHr65XoUJqMQds7kiMJXyz9p0Z9fmpq/z//8zh
   CH4qeSPWNr2wMvO/5HfdAsMsfZ3rWF597XprupOdQGakG2mY3tP/dnaMO
   w==;
IronPort-SDR: M4yci0kIqU+8eshpn+e6QPel3hH04NBLxed2FThMGZNV1o1FjB2udjyy4n0n0EnQBJsrgFUI5Y
 a5t9ykA350krzVdllYC8xmcKVKeOvM0A9FhES3DlnkUcnaNQ/jXkIrudfuPagRC92cv2rG8KH3
 HsYQ6z51pV4MinOIZCGBE40WQIMqcNaNUn6uKs/Pv8M2tysAzzB7Z629N5JqN9t8cXSg20hR+S
 XfB0gHU6WwwljOuZVuymsNmoy7e/K9Ls2jxz5JyKGbuyf5IUIpb+XLKSFItU0lyqzFzq3cDRK2
 0mE=
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="92761626"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 02:59:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 02:59:45 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 29 Sep 2020 02:59:43 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [RFC PATCH 0/3] mtd: spi-nor: Tackle stateful modes
Date:   Tue, 29 Sep 2020 12:59:48 +0300
Message-ID: <20200929095951.1575658-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916124418.833-1-p.yadav@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My biggest concern with Pratyush's patches is that the stateful modes case
(X-X-X modes that are entered via a non-volatile bit) is not handled.
This is an attempt to tackle this problem. Reasons and explanations in
the commit messages.

Tudor Ambarus (3):
  mtd: spi-nor: Introduce SNOR_F_IO_MODE_EN_VOLATILE
  mtd: spi-nor: Introduce MTD_SPI_NOR_ALLOW_STATEFUL_MODES
  mtd: spi-nor: Parse SFDP SCCR Map

 drivers/mtd/spi-nor/Kconfig | 10 +++++++
 drivers/mtd/spi-nor/core.c  |  8 ++++++
 drivers/mtd/spi-nor/core.h  |  6 +++++
 drivers/mtd/spi-nor/sfdp.c  | 52 +++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

-- 
2.25.1

