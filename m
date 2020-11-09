Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7C2AB592
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgKIK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:56:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:13548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgKIK4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:56:04 -0500
IronPort-SDR: F8s8lVg+yFmQS54eofYpkmxrzGH+NLpUh81iG8qN4/7FmF4heL3yTlydb1L8mU0O/8G6lvprjD
 vdnOPY4XiGVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="254489647"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="254489647"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:56:04 -0800
IronPort-SDR: my3d6D9SPce8koUSeSvBYLLhaFuSE0wcFkoRbGQC+73Q5AjJJasYsq1SfqXuqnz9kmC838eaAC
 CTCozYO7/KRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="354097625"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 02:56:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 770CA1CC; Mon,  9 Nov 2020 12:56:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] vt: keyboard, replace numbers with \r, \n where appropriate
Date:   Mon,  9 Nov 2020 12:56:00 +0200
Message-Id: <20201109105601.47159-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109105601.47159-1-andriy.shevchenko@linux.intel.com>
References: <20201109105601.47159-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of 10, 13 use \n, \r respectively.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jiri Slaby <jirislaby@kernel.org>
---
v2: added Ack (Jiri)
 drivers/tty/vt/keyboard.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 05d7e812e0f5..872791551c77 100644
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

