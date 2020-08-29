Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8252566DA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 12:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgH2Kj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 06:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgH2Kjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:39:52 -0400
Received: from localhost.localdomain (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F122076D;
        Sat, 29 Aug 2020 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598697591;
        bh=xH+2+81KD+9EvlFYr/lFeBRmflSJRA4u9K/v+gTsJ4E=;
        h=From:To:Cc:Subject:Date:From;
        b=UBnUPUxeV/cXXVxFA/AHJ9U0RIqMcCzmu7AwAppMwXK6rVpi+EUXz8wDpN24+UDIm
         PJ0M8zc5YpV+DhLFI5lS/qp+fR/FM74sJYZHfC6QnmE9BO1zzi2D1NIQpQOji+BQA9
         I8pfRHeWAv2KIM3HaVMispF/L9Hc+oiEBYg65YRw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: soundwire: remove unsed header mod_devicetable.h
Date:   Sat, 29 Aug 2020 16:09:39 +0530
Message-Id: <20200829103939.4007097-1-vkoul@kernel.org>
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

