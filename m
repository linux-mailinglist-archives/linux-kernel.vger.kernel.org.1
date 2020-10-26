Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1D2991AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784716AbgJZQCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784698AbgJZQCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:02:13 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFF820706;
        Mon, 26 Oct 2020 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728133;
        bh=BQ9VPxKLubmKcDqr+QTj48ySaRaBAJGsFgwP+LF9lMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ZSSz6UwrrPmlR/iNmtHKMJ5j2EmmttqTm0WTCJE6BFANZim1Wi7/PfluPcWQoF8q6
         kGEDo2CvV7EXEB79iAoduk8Gmkru+TcSgOb8GOmrG2WJELUTIHmZvvoTYmXSK4xngr
         dmHVn+VEI21W8bLUtPDoinvtOTvHq0KzsfCGv37Q=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: add module license
Date:   Mon, 26 Oct 2020 17:01:54 +0100
Message-Id: <20201026160205.3704789-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When built as a loadable module, coresight now causes a warning about
missing license information.

WARNING: modpost: missing MODULE_LICENSE() in drivers/hwtracing/coresight/coresight.o

Fixes: 8e264c52e1da ("coresight: core: Allow the coresight core driver to be built as a module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwtracing/coresight/coresight-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6994c1309b2b..cc9e8025c533 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1689,6 +1689,7 @@ static void __exit coresight_exit(void)
 module_init(coresight_init);
 module_exit(coresight_exit);
 
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
 MODULE_DESCRIPTION("Arm CoreSight tracer driver");
-- 
2.27.0

