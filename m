Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FAC29E858
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgJ2KGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:06:22 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:36101 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgJ2KGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:06:21 -0400
Received: from taipei09.ADVANTECH.CORP (unverified [172.20.0.236]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te281f2b2c7ac14014b1fe0@ACLMS1.advantech.com.tw>;
 Thu, 29 Oct 2020 18:06:15 +0800
Received: from localhost (172.16.12.104) by taipei09.ADVANTECH.CORP
 (172.20.0.236) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 29 Oct
 2020 18:06:13 +0800
From:   Shihlun Lin <shihlun.lin@advantech.com.tw>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Campion Kang <campion.kang@advantech.com.tw>,
        Shihlun Lin <shihlun.lin@advantech.com.tw>,
        AceLan Kao <chia-lin.kao@canonical.com>
Subject: [PATCH v3 1/6] MAINTAINERS: Add Advantech embedded controller entry
Date:   Thu, 29 Oct 2020 18:06:08 +0800
Message-ID: <20201029100613.25789-1-shihlun.lin@advantech.com.tw>
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
index e73636b75f29..d59e051c3f9d 100644
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

base-commit: 23859ae44402f4d935b9ee548135dd1e65e2cbf4
-- 
2.17.1

