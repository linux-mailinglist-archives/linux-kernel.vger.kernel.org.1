Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3927329EAAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgJ2LdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:33:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:57132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbgJ2Lc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45007B81E;
        Thu, 29 Oct 2020 11:32:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/17] vt: keyboard, make HW_RAW a function
Date:   Thu, 29 Oct 2020 12:32:20 +0100
Message-Id: <20201029113222.32640-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a multiline macro, convert HW_RAW to an inline function. It
allows for type checking of the parameter. And given we split the code
into two tests, it is now more readable too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 1de0d5217aed..dea2f25a5d9f 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1259,8 +1259,14 @@ DECLARE_TASKLET_DISABLED_OLD(keyboard_tasklet, kbd_bh);
     defined(CONFIG_PARISC) || defined(CONFIG_SUPERH) ||\
     (defined(CONFIG_ARM) && defined(CONFIG_KEYBOARD_ATKBD) && !defined(CONFIG_ARCH_RPC))
 
-#define HW_RAW(dev) (test_bit(EV_MSC, dev->evbit) && test_bit(MSC_RAW, dev->mscbit) &&\
-			((dev)->id.bustype == BUS_I8042) && ((dev)->id.vendor == 0x0001) && ((dev)->id.product == 0x0001))
+static inline bool kbd_is_hw_raw(const struct input_dev *dev)
+{
+	if (!test_bit(EV_MSC, dev->evbit) || !test_bit(MSC_RAW, dev->mscbit))
+		return false;
+
+	return dev->id.bustype == BUS_I8042 &&
+		dev->id.vendor == 0x0001 && dev->id.product == 0x0001;
+}
 
 static const unsigned short x86_keycodes[256] =
 	{ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
@@ -1345,7 +1351,10 @@ static int emulate_raw(struct vc_data *vc, unsigned int keycode,
 
 #else
 
-#define HW_RAW(dev)	0
+static inline bool kbd_is_hw_raw(const struct input_dev *dev)
+{
+	return false;
+}
 
 static int emulate_raw(struct vc_data *vc, unsigned int keycode, unsigned char up_flag)
 {
@@ -1366,7 +1375,7 @@ static void kbd_rawcode(unsigned char data)
 		put_queue(vc, data);
 }
 
-static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
+static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	unsigned short keysym, *key_map;
@@ -1511,10 +1520,11 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
 	/* We are called with interrupts disabled, just take the lock */
 	spin_lock(&kbd_event_lock);
 
-	if (event_type == EV_MSC && event_code == MSC_RAW && HW_RAW(handle->dev))
+	if (event_type == EV_MSC && event_code == MSC_RAW &&
+			kbd_is_hw_raw(handle->dev))
 		kbd_rawcode(value);
 	if (event_type == EV_KEY && event_code <= KEY_MAX)
-		kbd_keycode(event_code, value, HW_RAW(handle->dev));
+		kbd_keycode(event_code, value, kbd_is_hw_raw(handle->dev));
 
 	spin_unlock(&kbd_event_lock);
 
-- 
2.29.1

