Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FE928DBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgJNIea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:34:30 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:27403 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgJNIe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:34:27 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 04:34:27 EDT
Received: from taipei09.ADVANTECH.CORP (unverified [172.20.0.236]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te234560af1ac14014b1418@ACLMS1.advantech.com.tw>;
 Wed, 14 Oct 2020 16:24:23 +0800
Received: from localhost (172.16.12.104) by taipei09.ADVANTECH.CORP
 (172.20.0.236) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 14 Oct
 2020 16:24:22 +0800
From:   Shihlun Lin <shihlun.lin@advantech.com.tw>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        Campion Kang <campion.kang@advantech.com.tw>,
        Shihlun Lin <shihlun.lin@advantech.com.tw>,
        AceLan Kao <chia-lin.kao@canonical.com>
Subject: [PATCH] MAINTAINERS: Add Advantech embedded controller entry
Date:   Wed, 14 Oct 2020 16:24:22 +0800
Message-ID: <20201014082422.25312-1-shihlun.lin@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.12.104]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei09.ADVANTECH.CORP (172.20.0.236)
X-StopIT: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Advantech embedded controller entry

Signed-off-by: Shihlun Lin <shihlun.lin@advantech.com.tw>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6336f9314ae1..41e94692c4f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -562,6 +562,17 @@ S:	Maintained
 F:	Documentation/scsi/advansys.rst
 F:	drivers/scsi/advansys.c
 
+ADVANTECH EMBEDDED CONTROLLER DRIVER
+M:	Shihlun Lin <shihlun.lin@advantech.com.tw>
+M:	Campion Kang <campion.kang@advantech.com.tw>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/ahc1ec0.yaml
+F:	drivers/mfd/ahc1ec0-hwmon.c
+F:	drivers/mfd/ahc1ec0-wdt.c
+F:	drivers/mfd/ahc1ec0.c
+F:	include/dt-bindings/mfd/ahc1ec0.h
+
 ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL345/ADXL346)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
-- 
2.17.1

