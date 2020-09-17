Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A1D26D5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIQIIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:08:52 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57678 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgIQIHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:07:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08H7mHqx109021;
        Thu, 17 Sep 2020 02:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600328897;
        bh=T4zQBPS1F2SXKrCt4rPxzEiQtYHMKcHNXfFU9SacdUY=;
        h=From:To:CC:Subject:Date;
        b=xAhE3C+cAQHtac4YoDsMwtQcNt8M0LKxmtd++no3kmyKBNCfsVUZ8OHvkv9sXz+N7
         bP5C2A91APcljU33gsoFqt5vD43d8/OLXUHvhmfVSPp0o5vkr56t0DgPL2uvsLFofU
         vex5WDtgW+ivAuwzpF+wBZt+FqnJ3BNlDknK+/J0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08H7mHGK106397;
        Thu, 17 Sep 2020 02:48:17 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 02:48:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 02:48:16 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08H7mEdr100359;
        Thu, 17 Sep 2020 02:48:14 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] mtd: hyperbus: hbmc-am654: Add DMA support
Date:   Thu, 17 Sep 2020 13:17:45 +0530
Message-ID: <20200917074749.8957-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add DMA support for reading data from HyperBus memory
devices for TI's AM654/J721e SoCs

With DMA there is ~5x improvement in read througput.

Vignesh Raghavendra (4):
  mtd: hyperbus: Provide per device private pointer
  mtd: hyperbus: hbmc-am654: Fix direct mapping setup flash access
  mtd: hyperbus: hbmc-am654: Drop pm_runtime* calls from probe
  mtd: hyperbus: hbmc-am654: Add DMA support for reads

 drivers/mtd/hyperbus/hbmc-am654.c | 148 ++++++++++++++++++++++++++----
 include/linux/mtd/hyperbus.h      |   2 +
 2 files changed, 134 insertions(+), 16 deletions(-)

-- 
2.28.0

