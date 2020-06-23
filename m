Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA212047A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 04:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgFWCxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 22:53:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731902AbgFWCvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6EF5B197;
        Tue, 23 Jun 2020 02:51:35 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 14/29] soc: realtek: chip: Add RTD1319 revisions
Date:   Tue, 23 Jun 2020 04:50:51 +0200
Message-Id: <20200623025106.31273-15-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chang <stanley_chang@realtek.com>

Identify RTD1319 SoC revisions B00 to B02.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 * Split out from Stanley's v1
 
 drivers/soc/realtek/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
index ae7c5322f338..6b3d1f3d3816 100644
--- a/drivers/soc/realtek/chip.c
+++ b/drivers/soc/realtek/chip.c
@@ -3,6 +3,7 @@
  * Realtek Digital Home Center System-on-Chip info
  *
  * Copyright (c) 2017-2020 Andreas Färber
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
  */
 
 #include <linux/bitfield.h>
@@ -61,6 +62,9 @@ static const struct dhc_soc_revision rtd1619_revisions[] = {
 
 static const struct dhc_soc_revision rtd1319_revisions[] = {
 	{ "A00", 0x0000 },
+	{ "B00", 0x0001 },
+	{ "B01", 0x0002 },
+	{ "B02", 0x0003 },
 	{ }
 };
 
-- 
2.26.2

