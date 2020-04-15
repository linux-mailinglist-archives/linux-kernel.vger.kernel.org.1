Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98811AAF02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410614AbgDORBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:01:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:5570 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404589AbgDORBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:01:15 -0400
IronPort-SDR: hL9iSJdvt2brm9MEAWLu872F62g0sCqpZcYAwOhLx8h02oAs62sIXc96MBqZD6V7lt+0/e7GzU
 HTumCzVSoX1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 10:01:14 -0700
IronPort-SDR: BGAF5aQNkaPmHIzRYbKoAZLAKJIndFLlcc3vgwR8KVtlF0MP52J+9Y4zFe63g68eE5CsiWLGBz
 P0cwd6o8xbFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="277679302"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2020 10:01:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20A3A19C; Wed, 15 Apr 2020 20:01:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/3] ARM: bcm2835: Switch to use %ptT
Date:   Wed, 15 Apr 2020 20:00:45 +0300
Message-Id: <20200415170046.33374-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptT instead of open coded variant to print content of
time64_t type in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/firmware/raspberrypi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index da26a584dca0..a3e85186f8e6 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -182,16 +182,10 @@ rpi_firmware_print_firmware_revision(struct rpi_firmware *fw)
 					RPI_FIRMWARE_GET_FIRMWARE_REVISION,
 					&packet, sizeof(packet));
 
-	if (ret == 0) {
-		struct tm tm;
-
-		time64_to_tm(packet, 0, &tm);
+	if (ret)
+		return;
 
-		dev_info(fw->cl.dev,
-			 "Attached to firmware from %04ld-%02d-%02d %02d:%02d\n",
-			 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-			 tm.tm_hour, tm.tm_min);
-	}
+	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n", &packet);
 }
 
 static void
-- 
2.25.1

