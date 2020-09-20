Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C442717D6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgITU05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 16:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITU05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 16:26:57 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB282085B;
        Sun, 20 Sep 2020 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600633617;
        bh=F8loTzsy5fkwJ3XL+YXnbVLdbm2gOfrgVElRrw7bieA=;
        h=From:To:Cc:Subject:Date:From;
        b=ArCrysFTbG/9vPwQ0ZIE0q5elmPR7nZJyezec424ZSwv3H3fjx+QpXu5z3dyu6LHz
         cGHruTVDXte1hXE6ZKdOte3sm6NcRDLrMKVmJM36vPxYc7UjAPqJxYf/FpFOVZRDcd
         Q+9IT82Xl4hSGq29XQHMv9E4MROTO0Hd/++OJWLw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] soc: actions: include header to fix missing prototype
Date:   Sun, 20 Sep 2020 22:26:52 +0200
Message-Id: <20200920202652.11469-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the header with prototype of owl_sps_set_pg to fix:

  drivers/soc/actions/owl-sps-helper.c:16:5: warning: no previous prototype for 'owl_sps_set_pg' [-Wmissing-prototypes]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/actions/owl-sps-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/actions/owl-sps-helper.c b/drivers/soc/actions/owl-sps-helper.c
index 291a206d6f04..e3f36603dd53 100644
--- a/drivers/soc/actions/owl-sps-helper.c
+++ b/drivers/soc/actions/owl-sps-helper.c
@@ -10,6 +10,7 @@
 
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/soc/actions/owl-sps.h>
 
 #define OWL_SPS_PG_CTL	0x0
 
-- 
2.17.1

