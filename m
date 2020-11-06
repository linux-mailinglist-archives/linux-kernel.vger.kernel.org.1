Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE6C2A97BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgKFOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:35:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:27734 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgKFOfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:35:55 -0500
IronPort-SDR: 9msWoBOPyAMR/2VoMqlStET23pM7tsuGJtXABgdMveZbV0u8BTSgmTCYJwhD+37hVMKI3wHyBT
 ZjDv2joV3bLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="187477147"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="187477147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 06:35:55 -0800
IronPort-SDR: XySkJ7U+RjToXofx2TFEi/NDWl4dWCaSf1qsmrrm4R0DJXTsbCWzKej8Y3rmReMbSvSAwtE29C
 o17qnRkTgFbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="539857029"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2020 06:35:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B5BDC76; Fri,  6 Nov 2020 16:35:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] vt: keyboard, replace numbers with \r, \n where appropriate
Date:   Fri,  6 Nov 2020 16:35:50 +0200
Message-Id: <20201106143551.43908-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of 10, 13 use \n, \r respectively.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/vt/keyboard.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index bfe54b9822af..647c343f61fb 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -462,9 +462,9 @@ static void fn_enter(struct vc_data *vc)
 		diacr = 0;
 	}
 
-	put_queue(vc, 13);
+	put_queue(vc, '\r');
 	if (vc_kbd_mode(kbd, VC_CRLF))
-		put_queue(vc, 10);
+		put_queue(vc, '\n');
 }
 
 static void fn_caps_toggle(struct vc_data *vc)
@@ -827,7 +827,7 @@ static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)
 
 	put_queue(vc, pad_chars[value]);
 	if (value == KVAL(K_PENTER) && vc_kbd_mode(kbd, VC_CRLF))
-		put_queue(vc, 10);
+		put_queue(vc, '\n');
 }
 
 static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
-- 
2.28.0

