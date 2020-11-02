Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D092A279C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgKBJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:59:50 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:47784 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgKBJ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:59:50 -0500
X-Greylist: delayed 55233 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 04:59:49 EST
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 32C31B32;
        Mon,  2 Nov 2020 10:59:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1LKR1ss1F6nn; Mon,  2 Nov 2020 10:59:47 +0100 (CET)
Received: from function.home (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 12F7D29E;
        Mon,  2 Nov 2020 10:59:47 +0100 (CET)
Received: from samy by function.home with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kZWcr-00COzy-Lr; Mon, 02 Nov 2020 10:59:45 +0100
Date:   Mon, 2 Nov 2020 10:59:45 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup: document the usage of enum values
Message-ID: <20201102095945.ap4pdff2dn47hijh@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cursor tracking modes enum, the edge enum, and the read_all commands
enum should be used as such in the source code, to make it more readable
and make gcc catch missing values in switches.

Also, some values of enums are coupled with others, we at least need to
document these.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
 drivers/accessibility/speakup/i18n.h |    6 +++
 drivers/accessibility/speakup/main.c |   64 ++++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 31 deletions(-)

--- a/drivers/accessibility/speakup/i18n.h
+++ b/drivers/accessibility/speakup/i18n.h
@@ -23,12 +23,15 @@ enum msg_index_t {
 	MSG_OFF = MSG_STATUS_START,
 	MSG_ON,
 	MSG_NO_WINDOW,
+
+	/* These must be ordered the same as enum cursor_track */
 	MSG_CURSOR_MSGS_START,
 	MSG_CURSORING_OFF = MSG_CURSOR_MSGS_START,
 	MSG_CURSORING_ON,
 	MSG_HIGHLIGHT_TRACKING,
 	MSG_READ_WINDOW,
 	MSG_READ_ALL,
+
 	MSG_EDIT_DONE,
 	MSG_WINDOW_ALREADY_SET,
 	MSG_END_BEFORE_START,
@@ -41,11 +44,14 @@ enum msg_index_t {
 	MSG_LEAVING_HELP,
 	MSG_IS_UNASSIGNED,
 	MSG_HELP_INFO,
+
+	/* These must be ordered the same as enum edge */
 	MSG_EDGE_MSGS_START,
 	MSG_EDGE_TOP  = MSG_EDGE_MSGS_START,
 	MSG_EDGE_BOTTOM,
 	MSG_EDGE_LEFT,
 	MSG_EDGE_RIGHT,
+
 	MSG_NUMBER,
 	MSG_SPACE,
 	MSG_START, /* A little confusing, given our convention. */
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -90,19 +90,18 @@ const u_char spk_key_defaults[] = {
 #include "speakupmap.h"
 };
 
-/* Speakup Cursor Track Variables */
-static int cursor_track = 1, prev_cursor_track = 1;
-
-/* cursor track modes, must be ordered same as cursor_msgs */
-enum {
+/* cursor track modes, must be ordered same as cursor_msgs in enum msg_index_t */
+enum cursor_track {
 	CT_Off = 0,
 	CT_On,
 	CT_Highlight,
 	CT_Window,
-	CT_Max
+	CT_Max,
+	read_all_mode = CT_Max,
 };
 
-#define read_all_mode CT_Max
+/* Speakup Cursor Track Variables */
+static enum cursor_track cursor_track = 1, prev_cursor_track = 1;
 
 static struct tty_struct *tty;
 
@@ -405,15 +404,17 @@ static void say_attributes(struct vc_dat
 	synth_printf("%s\n", spk_msg_get(MSG_COLORS_START + bg));
 }
 
-enum {
-	edge_top = 1,
+/* must be ordered same as edge_msgs in enum msg_index_t */
+enum edge {
+	edge_none = 0,
+	edge_top,
 	edge_bottom,
 	edge_left,
 	edge_right,
 	edge_quiet
 };
 
-static void announce_edge(struct vc_data *vc, int msg_id)
+static void announce_edge(struct vc_data *vc, enum edge msg_id)
 {
 	if (spk_bleeps & 1)
 		bleep(spk_y);
@@ -608,7 +609,8 @@ static void say_prev_word(struct vc_data
 {
 	u_char temp;
 	u16 ch;
-	u_short edge_said = 0, last_state = 0, state = 0;
+	enum edge edge_said = edge_none;
+	u_short last_state = 0, state = 0;
 
 	spk_parked |= 0x01;
 
@@ -653,7 +655,7 @@ static void say_prev_word(struct vc_data
 	}
 	if (spk_x == 0 && edge_said == edge_quiet)
 		edge_said = edge_left;
-	if (edge_said > 0 && edge_said < edge_quiet)
+	if (edge_said > edge_none && edge_said < edge_quiet)
 		announce_edge(vc, edge_said);
 	say_word(vc);
 }
@@ -662,7 +664,8 @@ static void say_next_word(struct vc_data
 {
 	u_char temp;
 	u16 ch;
-	u_short edge_said = 0, last_state = 2, state = 0;
+	enum edge edge_said = edge_none;
+	u_short last_state = 2, state = 0;
 
 	spk_parked |= 0x01;
 	if (spk_x == vc->vc_cols - 1 && spk_y == vc->vc_rows - 1) {
@@ -694,7 +697,7 @@ static void say_next_word(struct vc_data
 		spk_pos += 2;
 		last_state = state;
 	}
-	if (edge_said > 0)
+	if (edge_said > edge_none)
 		announce_edge(vc, edge_said);
 	say_word(vc);
 }
@@ -1366,31 +1369,30 @@ static void speakup_deallocate(struct vc
 	speakup_console[vc_num] = NULL;
 }
 
+enum read_all_command {
+	RA_NEXT_SENT = KVAL(K_DOWN)+1,
+	RA_PREV_LINE = KVAL(K_LEFT)+1,
+	RA_NEXT_LINE = KVAL(K_RIGHT)+1,
+	RA_PREV_SENT = KVAL(K_UP)+1,
+	RA_DOWN_ARROW,
+	RA_TIMER,
+	RA_FIND_NEXT_SENT,
+	RA_FIND_PREV_SENT,
+};
+
 static u_char is_cursor;
 static u_long old_cursor_pos, old_cursor_x, old_cursor_y;
 static int cursor_con;
 
 static void reset_highlight_buffers(struct vc_data *);
 
-static int read_all_key;
+static enum read_all_command read_all_key;
 
 static int in_keyboard_notifier;
 
-static void start_read_all_timer(struct vc_data *vc, int command);
-
-enum {
-	RA_NOTHING,
-	RA_NEXT_SENT,
-	RA_PREV_LINE,
-	RA_NEXT_LINE,
-	RA_PREV_SENT,
-	RA_DOWN_ARROW,
-	RA_TIMER,
-	RA_FIND_NEXT_SENT,
-	RA_FIND_PREV_SENT,
-};
+static void start_read_all_timer(struct vc_data *vc, enum read_all_command command);
 
-static void kbd_fakekey2(struct vc_data *vc, int command)
+static void kbd_fakekey2(struct vc_data *vc, enum read_all_command command)
 {
 	del_timer(&cursor_timer);
 	speakup_fake_down_arrow();
@@ -1427,7 +1429,7 @@ static void stop_read_all(struct vc_data
 	spk_do_flush();
 }
 
-static void start_read_all_timer(struct vc_data *vc, int command)
+static void start_read_all_timer(struct vc_data *vc, enum read_all_command command)
 {
 	struct var_t *cursor_timeout;
 
@@ -1438,7 +1440,7 @@ static void start_read_all_timer(struct
 		  jiffies + msecs_to_jiffies(cursor_timeout->u.n.value));
 }
 
-static void handle_cursor_read_all(struct vc_data *vc, int command)
+static void handle_cursor_read_all(struct vc_data *vc, enum read_all_command command)
 {
 	int indcount, sentcount, rv, sn;
 
