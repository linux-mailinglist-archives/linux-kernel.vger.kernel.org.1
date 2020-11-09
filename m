Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE752AB58F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgKIK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:56:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:15079 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgKIK4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:56:04 -0500
IronPort-SDR: Y7pjPHbBuz5K8Uuv8fmEJr+4QgdQsngTWPNEyT+feD+SROlJkrnMy1Foz1vBmbSHcn0YhLMxVj
 7eJqlFhD3eXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="231414867"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="231414867"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:56:04 -0800
IronPort-SDR: D1cYunPaLP+9ENYu0KcAhPZQwa+I+93KXOc0g1e9jf8hHl+bFb0fb7NPCFdi5sUW1T1NtWg/oL
 wOX0tMXSeMXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="359605356"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Nov 2020 02:56:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8659344A; Mon,  9 Nov 2020 12:56:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] vt: keyboard, make use of assign_bit() API
Date:   Mon,  9 Nov 2020 12:56:01 +0200
Message-Id: <20201109105601.47159-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109105601.47159-1-andriy.shevchenko@linux.intel.com>
References: <20201109105601.47159-1-andriy.shevchenko@linux.intel.com>
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
Acked-by: Jiri Slaby <jirislaby@kernel.org>
---
v2: added Ack (Jiri)
 drivers/tty/vt/keyboard.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 872791551c77..52922d21a49f 100644
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

