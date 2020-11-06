Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234422A97B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKFOfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:35:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:63507 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFOfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:35:55 -0500
IronPort-SDR: P8b/6QwtUMc5o6FzjjlZyDQx9nQqrZqvhJPKTT+NdR2Jao4MEHAuejJljEJufl7YC62KYjdqg4
 nJXxixN2v2UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="156551953"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="156551953"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 06:35:55 -0800
IronPort-SDR: /NILPMzoAQI00dN2nHIQJvtjfTGB7WvLUJrjmbI1N0Dyz16RevFZiT8QHQCQ2JrXBqAKzkftEk
 0gcdx5r/Aynw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="472085732"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2020 06:35:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C04DD3BB; Fri,  6 Nov 2020 16:35:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] vt: keyboard, make use of assign_bit() API
Date:   Fri,  6 Nov 2020 16:35:51 +0200
Message-Id: <20201106143551.43908-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have for some time the assign_bit() API to replace open coded

	if (foo)
		set_bit(n, bar);
	else
		clear_bit(n, bar);

Use this API in VT keyboard library code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/vt/keyboard.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 647c343f61fb..b5132191b0ad 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1433,10 +1433,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		raw_mode = true;
 	}
 
-	if (down)
-		set_bit(keycode, key_down);
-	else
-		clear_bit(keycode, key_down);
+	assign_bit(keycode, key_down, down);
 
 	if (rep &&
 	    (!vc_kbd_mode(kbd, VC_REPEAT) ||
-- 
2.28.0

