Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243512B00CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgKLICL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:02:11 -0500
Received: from aclms1.advantech.com.tw ([61.58.41.199]:28698 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLICC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:02:02 -0500
Received: from taipei09.ADVANTECH.CORP (unverified [172.20.0.236]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te2c999f292ac14014bfdc@ACLMS1.advantech.com.tw>;
 Thu, 12 Nov 2020 16:01:58 +0800
Received: from localhost (172.16.12.104) by taipei09.ADVANTECH.CORP
 (172.20.0.236) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 Nov
 2020 16:01:56 +0800
From:   Shihlun Lin <shihlun.lin@advantech.com.tw>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Campion Kang <campion.kang@advantech.com.tw>,
        Shihlun Lin <shihlun.lin@advantech.com.tw>,
        AceLan Kao <chia-lin.kao@canonical.com>
Subject: [PATCH v4 1/6] MAINTAINERS: Add Advantech embedded controller entry
Date:   Thu, 12 Nov 2020 16:01:51 +0800
Message-ID: <20201112080156.463-1-shihlun.lin@advantech.com.tw>
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
index 94ac10a153c7..c1fe5233b469 100644
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

base-commit: 3d5e28bff7ad55aea081c1af516cc1c94a5eca7d
-- 
2.17.1

