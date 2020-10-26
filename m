Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1E29917F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784551AbgJZP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773749AbgJZPy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:54:57 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D5C22400;
        Mon, 26 Oct 2020 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603727696;
        bh=VnzGR2F/J7hcHGiLieqtelGxslx6iyl+m0SczyoDd2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=1ENtOvnasCWH6XLt7qtjLJPRv5+bfAorTH+YLCSeawIombjuXpLmPnIXZ2/b8Yg8F
         G7YFzXa+ocOuRUGh3bJ568BD/ntamwIRmxwspHSRVhNjzZXrH8oEBdOY2cgbPf6tcf
         9oaOAay5lGvRk08AMw+uCREpx7uq8vp18gxHQyIg=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>, Rajan Vaja <rajanv@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: xilinx: fix out-of-bounds access
Date:   Mon, 26 Oct 2020 16:54:36 +0100
Message-Id: <20201026155449.3703142-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The zynqmp_pm_set_suspend_mode() and zynqmp_pm_get_trustzone_version()
functions pass values as api_id into zynqmp_pm_invoke_fn
that are beyond PM_API_MAX, resulting in an out-of-bounds access:

drivers/firmware/xilinx/zynqmp.c: In function 'zynqmp_pm_set_suspend_mode':
drivers/firmware/xilinx/zynqmp.c:150:24: warning: array subscript 2562 is above array bounds of 'u32[64]' {aka 'unsigned int[64]'} [-Warray-bounds]
  150 |  if (zynqmp_pm_features[api_id] != PM_FEATURE_UNCHECKED)
      |      ~~~~~~~~~~~~~~~~~~^~~~~~~~
drivers/firmware/xilinx/zynqmp.c:28:12: note: while referencing 'zynqmp_pm_features'
   28 | static u32 zynqmp_pm_features[PM_API_MAX];
      |            ^~~~~~~~~~~~~~~~~~

Replace the resulting undefined behavior with an error return.
This may break some things that happen to work at the moment
but seems better than randomly overwriting kernel data.

I assume we need additional fixes for the two functions that now
return an error.

Fixes: 76582671eb5d ("firmware: xilinx: Add Zynqmp firmware driver")
Fixes: e178df31cf41 ("firmware: xilinx: Implement ZynqMP power management APIs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/xilinx/zynqmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8d1ff2454e2e..efb8a66efc68 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -147,6 +147,9 @@ static int zynqmp_pm_feature(u32 api_id)
 		return 0;
 
 	/* Return value if feature is already checked */
+	if (api_id > ARRAY_SIZE(zynqmp_pm_features))
+		return PM_FEATURE_INVALID;
+
 	if (zynqmp_pm_features[api_id] != PM_FEATURE_UNCHECKED)
 		return zynqmp_pm_features[api_id];
 
-- 
2.27.0

