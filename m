Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE5526FE73
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgIRN1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:27:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38498 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIRN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:27:06 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 09:27:05 EDT
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kJGBC-0001vI-93; Fri, 18 Sep 2020 13:11:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] regmap: fix return of unintialized value in variable ret
Date:   Fri, 18 Sep 2020 14:11:58 +0100
Message-Id: <20200918131158.24083-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A recent commit removed the intialization of ret and now the !config
error return path returns a bogus uninitialized value in ret. Fix
this by explicitly setting ret to -EINVAL for this error exit path.

Addresses-Coverity: ("Uninitialized scalar value")
Fixes: 94cc89eb8fa5 ("regmap: debugfs: Fix handling of name string for debugfs init delays")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/regmap/regmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d0f7cc574ff3..bd385b82f30b 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -710,8 +710,10 @@ struct regmap *__regmap_init(struct device *dev,
 	int i, j;
 	int ret;
 
-	if (!config)
+	if (!config) {
+		ret = -EINVAL;
 		goto err;
+	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (map == NULL) {
-- 
2.27.0

