Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AD72A97BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgKFOgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:36:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:4886 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbgKFOfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:35:55 -0500
IronPort-SDR: MOad1jaE7i8MNbQW3oF5d1rZmFwo52/t4e/p0xqWWUol+WdYh54ewJZ0fUHVwh3UvvarU6N7yo
 Cufn+wR7ISQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="149402307"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="149402307"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 06:35:55 -0800
IronPort-SDR: J2sF3od6uqsxGE9FVRpkynRKWCTvlnMc8Uv1Jp84b4qmhDm25X6RHs1eRj5a/ZI4buDDSaZpFA
 VCTbXbC47z+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="321606262"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Nov 2020 06:35:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AAF8F252; Fri,  6 Nov 2020 16:35:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead of open coded variants
Date:   Fri,  6 Nov 2020 16:35:49 +0200
Message-Id: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few places when GENMASK() or BIT() macro is suitable and makes code
easier to understand.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/vt/keyboard.c | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 56b5e8f8fe88..bfe54b9822af 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -53,7 +53,7 @@
  * Exported functions/variables
  */
 
-#define KBD_DEFMODE ((1 << VC_REPEAT) | (1 << VC_META))
+#define KBD_DEFMODE (BIT(VC_REPEAT) | BIT(VC_META))
 
 #if defined(CONFIG_X86) || defined(CONFIG_PARISC)
 #include <asm/kbdleds.h>
@@ -423,8 +423,8 @@ static unsigned int handle_diacr(struct vc_data *vc, unsigned int ch)
 
 	diacr = 0;
 
-	if ((d & ~0xff) == BRL_UC_ROW) {
-		if ((ch & ~0xff) == BRL_UC_ROW)
+	if ((d & ~GENMASK(7, 0)) == BRL_UC_ROW) {
+		if ((ch & ~GENMASK(7, 0)) == BRL_UC_ROW)
 			return d | ch;
 	} else {
 		for (i = 0; i < accent_table_size; i++)
@@ -857,16 +857,16 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
 		shift_down[value]++;
 
 	if (shift_down[value])
-		shift_state |= (1 << value);
+		shift_state |= BIT(value);
 	else
-		shift_state &= ~(1 << value);
+		shift_state &= ~BIT(value);
 
 	/* kludge */
 	if (up_flag && shift_state != old_state && npadch_active) {
 		if (kbd->kbdmode == VC_UNICODE)
 			to_utf8(vc, npadch_value);
 		else
-			put_queue(vc, npadch_value & 0xff);
+			put_queue(vc, npadch_value & GENMASK(7, 0));
 		npadch_active = false;
 	}
 }
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
 
@@ -1125,14 +1125,14 @@ static void kbd_init_leds(void)
  */
 static unsigned char getledstate(void)
 {
-	return ledstate & 0xff;
+	return ledstate & GENMASK(7, 0);
 }
 
 void setledstate(struct kbd_struct *kb, unsigned int led)
 {
         unsigned long flags;
         spin_lock_irqsave(&led_lock, flags);
-	if (!(led & ~7)) {
+	if (!(led & ~GENMASK(2, 0))) {
 		ledioctl = led;
 		kb->ledmode = LED_SHOW_IOCTL;
 	} else
@@ -1338,7 +1338,7 @@ static int emulate_raw(struct vc_data *vc, unsigned int keycode,
 
 		if (code & 0x100)
 			put_queue(vc, 0xe0);
-		put_queue(vc, (code & 0x7f) | up_flag);
+		put_queue(vc, (code & GENMASK(6, 0)) | up_flag);
 
 		break;
 	}
@@ -1355,7 +1355,7 @@ static inline bool kbd_is_hw_raw(const struct input_dev *dev)
 
 static int emulate_raw(struct vc_data *vc, unsigned int keycode, unsigned char up_flag)
 {
-	if (keycode > 127)
+	if (keycode >= BIT(7))
 		return -1;
 
 	put_queue(vc, keycode | up_flag);
@@ -1423,12 +1423,12 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		 * applications. This allows for 16384 different keycodes,
 		 * which should be enough.
 		 */
-		if (keycode < 128) {
+		if (keycode < BIT(7)) {
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
@@ -2108,11 +2108,11 @@ int vt_do_kdskled(int console, int cmd, unsigned long arg, int perm)
 	case KDSKBLED:
 		if (!perm)
 			return -EPERM;
-		if (arg & ~0x77)
+		if (arg & ~(GENMASK(6, 4) | GENMASK(2, 0)))
 			return -EINVAL;
                 spin_lock_irqsave(&led_lock, flags);
-		kb->ledflagstate = (arg & 7);
-		kb->default_ledflagstate = ((arg >> 4) & 7);
+		kb->ledflagstate = arg & GENMASK(2, 0);
+		kb->default_ledflagstate = (arg & GENMASK(6, 4)) >> 4;
 		set_leds();
                 spin_unlock_irqrestore(&led_lock, flags);
 		return 0;
-- 
2.28.0

