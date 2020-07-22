Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D0229997
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbgGVNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 09:55:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:24151 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgGVNzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:55:17 -0400
IronPort-SDR: ljqY8jS4YnEeWEQMprnE9BnmjaQA1dfOCY71bjBCQAQU1EjC/fhEKYr0Pj0bL++akrMNotICr1
 jtopCHFCSKow==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="149493079"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="149493079"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 06:55:15 -0700
IronPort-SDR: jaeDV14yHjeJq0Sf7csJi2SVEVfCUprwvqIlgp6j77nxU/vKzFWvgMMRCU5OrSSCncjQheKmrd
 XB6LJIKKUH5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="328216742"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga007.jf.intel.com with ESMTP; 22 Jul 2020 06:55:07 -0700
From:   richard.gong@linux.intel.com
To:     mchehab+huawei@kernel.org, davem@davemloft.net, robh@kernel.org,
        gregkh@linuxfoundation.org, thor.thayer@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH] MAINTAINERS: altera: change maintainer for Altera drivers
Date:   Wed, 22 Jul 2020 09:09:40 -0500
Message-Id: <1595426980-32062-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Thor is moving to a new position and I will take over the maintainership.
Add myself as maintainer for 3 Altera drivers below:
1. Altera I2C driver
2. Altera System Manager driver
3. Altera System Resource driver

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4a43a9..d87a307 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -750,7 +750,7 @@ R:	Pali Rohár <pali@kernel.org>
 F:	drivers/input/mouse/alps.*
 
 ALTERA I2C CONTROLLER DRIVER
-M:	Thor Thayer <thor.thayer@linux.intel.com>
+M:	Richard Gong <richard.gong@linux.intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-altera.txt
 F:	drivers/i2c/busses/i2c-altera.c
@@ -767,13 +767,13 @@ S:	Maintained
 F:	drivers/gpio/gpio-altera.c
 
 ALTERA SYSTEM MANAGER DRIVER
-M:	Thor Thayer <thor.thayer@linux.intel.com>
+M:	Richard Gong <richard.gong@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/altera-sysmgr.c
 F:	include/linux/mfd/altera-sysmgr.h
 
 ALTERA SYSTEM RESOURCE DRIVER FOR ARRIA10 DEVKIT
-M:	Thor Thayer <thor.thayer@linux.intel.com>
+M:	Richard Gong <richard.gong@linux.intel.com>
 S:	Maintained
 F:	drivers/gpio/gpio-altera-a10sr.c
 F:	drivers/mfd/altera-a10sr.c
-- 
2.7.4

