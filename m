Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB422AB590
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgKIK4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:56:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:15079 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgKIK4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:56:05 -0500
IronPort-SDR: 0NySyziVh0VXGTaJJNI0AaE6bKo3S2uUrBozShWSraxHhAo+6XHnzxLnyZUaRIYewJtLDTakZY
 1w/M/hpOrNUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="231414866"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="231414866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:56:04 -0800
IronPort-SDR: jmC/+ZVQos2br28spqy0eUf9/LFjJAzDeL1nPPyU3uYuD5dBbB3ZANdcgj/BIM4wC/ATMVG8/P
 qTvJMOmt1SFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="540795431"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2020 02:56:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6B4CD1EA; Mon,  9 Nov 2020 12:56:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] vt: keyboard, use BIT() macro instead of open coded variants
Date:   Mon,  9 Nov 2020 12:55:59 +0200
Message-Id: <20201109105601.47159-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few places when BIT() macro is suitable and makes code
easier to understand.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: left only BIT() conversion (Jiri)
 drivers/tty/vt/keyboard.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 56b5e8f8fe88..05d7e812e0f5 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -53,7 +53,7 @@
  * Exported functions/variables
  */
 
-#define KBD_DEFMODE ((1 << VC_REPEAT) | (1 << VC_META))
+#define KBD_DEFMODE (BIT(VC_REPEAT) | BIT(VC_META))
 
 #if defined(CONFIG_X86) || defined(CONFIG_PARISC)
 #include <asm/kbdleds.h>
@@ -857,9 +857,9 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 		shift_down[value]++;
 
 	if (shift_down[value])
-		shift_state |= (1 << value);
+		shift_state |= BIT(value);
 	else
-		shift_state &= ~(1 << value);
+		shift_state &= ~BIT(value);
 
 	/* kludge */
 	if (up_flag && shift_state != old_state && npadch_active) {
@@ -880,7 +880,7 @@ static void k_meta(struct vc_data *vc, unsigned char value, char up_flag)
 		put_queue(vc, '\033');
 		put_queue(vc, value);
 	} else
-		put_queue(vc, value | 0x80);
+		put_queue(vc, value | BIT(7));
 }
 
 static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
@@ -976,7 +976,7 @@ static void k_brl(struct vc_data *vc, unsigned char value, char up_flag)
 		return;
 
 	if (!up_flag) {
-		pressed |= 1 << (value - 1);
+		pressed |= BIT(value - 1);
 		if (!brl_timeout)
 			committing = pressed;
 	} else if (brl_timeout) {
@@ -986,7 +986,7 @@ static void k_brl(struct vc_data *vc, unsigned char value, char up_flag)
 			committing = pressed;
 			releasestart = jiffies;
 		}
-		pressed &= ~(1 << (value - 1));
+		pressed &= ~BIT(value - 1);
 		if (!pressed && committing) {
 			k_brlcommit(vc, committing, 0);
 			committing = 0;
@@ -996,7 +996,7 @@ static void k_brl(struct vc_data *vc, unsigned char value, char up_flag)
 			k_brlcommit(vc, committing, 0);
 			committing = 0;
 		}
-		pressed &= ~(1 << (value - 1));
+		pressed &= ~BIT(value - 1);
 	}
 }
 
@@ -1096,9 +1096,9 @@ static int kbd_update_leds_helper(struct input_handle *handle, void *data)
 	unsigned int leds = *(unsigned int *)data;
 
 	if (test_bit(EV_LED, handle->dev->evbit)) {
-		input_inject_event(handle, EV_LED, LED_SCROLLL, !!(leds & 0x01));
-		input_inject_event(handle, EV_LED, LED_NUML,    !!(leds & 0x02));
-		input_inject_event(handle, EV_LED, LED_CAPSL,   !!(leds & 0x04));
+		input_inject_event(handle, EV_LED, LED_SCROLLL, !!(leds & BIT(0)));
+		input_inject_event(handle, EV_LED, LED_NUML,    !!(leds & BIT(1)));
+		input_inject_event(handle, EV_LED, LED_CAPSL,   !!(leds & BIT(2)));
 		input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
 	}
 
@@ -1427,8 +1427,8 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 			put_queue(vc, keycode | (!down << 7));
 		} else {
 			put_queue(vc, !down << 7);
-			put_queue(vc, (keycode >> 7) | 0x80);
-			put_queue(vc, keycode | 0x80);
+			put_queue(vc, (keycode >> 7) | BIT(7));
+			put_queue(vc, keycode | BIT(7));
 		}
 		raw_mode = true;
 	}
@@ -1487,7 +1487,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	if (type == KT_LETTER) {
 		type = KT_LATIN;
 		if (vc_kbd_led(kbd, VC_CAPSLOCK)) {
-			key_map = key_maps[shift_final ^ (1 << KG_SHIFT)];
+			key_map = key_maps[shift_final ^ BIT(KG_SHIFT)];
 			if (key_map)
 				keysym = key_map[keycode];
 		}
-- 
2.28.0

