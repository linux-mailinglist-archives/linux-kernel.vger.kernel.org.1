Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18A0258D44
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 13:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIALOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 07:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgIALOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:14:18 -0400
Received: from localhost.localdomain (unknown [122.172.190.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD7720FC3;
        Tue,  1 Sep 2020 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598958820;
        bh=ou1HFNRhbw08TpIm1gTEODy4ufYIh3ej/qbXWccTuNI=;
        h=From:To:Cc:Subject:Date:From;
        b=Q16auNMUJEcoAh55mDRCCEsaJVhuCzykof8L8S6MdD0Jn+MxlTWTi+4AyuphlTY2a
         FbR+osdQjEbxcz1zF+4Ka7PU2nQxJWs1qpe/KsQ6jjDgdI/BlX3G2Ld5isEwpFADIQ
         18zsvPNGBrVxTVx11OAoPrU1uhVSwIGH0H+xPa00=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] regmap: soundwire: remove unused header mod_devicetable.h
Date:   Tue,  1 Sep 2020 16:43:31 +0530
Message-Id: <20200901111331.641072-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mod_devicetable.h does not seem to be required for this file, so
remove it.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

changes in v2:
  - fix typo in patch subject

 drivers/base/regmap/regmap-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 50a66382d87d..c92d614b4943 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -2,7 +2,6 @@
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/device.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/soundwire/sdw.h>
 #include "internal.h"
-- 
2.26.2

