Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6E2F22E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390177AbhAKWi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389090AbhAKWi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:38:28 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D32C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 14:37:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 620B5162;
        Mon, 11 Jan 2021 23:37:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ibo97wmHcchk; Mon, 11 Jan 2021 23:37:44 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 4548B5FE;
        Mon, 11 Jan 2021 23:37:40 +0100 (CET)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kz5og-002vQ7-Lu; Mon, 11 Jan 2021 23:37:38 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH 1/4] This merely adds the missing synth parameter to all io functions.
Date:   Mon, 11 Jan 2021 23:37:34 +0100
Message-Id: <20210111223737.697336-2-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111223737.697336-1-samuel.thibault@ens-lyon.org>
References: <20210111223737.697336-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spam-Level: ****
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Queue-Id: 620B5162
X-Spamd-Result: default: False [5.00 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         BAYES_HAM(-0.00)[21.49%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/accessibility/speakup/serialio.c      | 22 ++++++------
 .../accessibility/speakup/speakup_acntpc.c    |  4 +--
 .../accessibility/speakup/speakup_apollo.c    |  4 +--
 .../accessibility/speakup/speakup_audptr.c    |  8 ++---
 .../accessibility/speakup/speakup_decext.c    |  2 +-
 drivers/accessibility/speakup/speakup_decpc.c |  4 +--
 .../accessibility/speakup/speakup_dectlk.c    |  2 +-
 drivers/accessibility/speakup/speakup_dtlk.c  |  4 +--
 drivers/accessibility/speakup/speakup_keypc.c |  4 +--
 drivers/accessibility/speakup/speakup_ltlk.c  |  2 +-
 drivers/accessibility/speakup/speakup_soft.c  |  4 +--
 .../accessibility/speakup/speakup_spkout.c    |  4 +--
 drivers/accessibility/speakup/spk_priv.h      |  4 +--
 drivers/accessibility/speakup/spk_ttyio.c     | 34 +++++++++----------
 drivers/accessibility/speakup/spk_types.h     | 12 +++----
 drivers/accessibility/speakup/synth.c         |  6 ++--
 16 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/accessibility/speakup/serialio.c b/drivers/accessibility/speakup/serialio.c
index 403b01d..53580bd 100644
--- a/drivers/accessibility/speakup/serialio.c
+++ b/drivers/accessibility/speakup/serialio.c
@@ -27,11 +27,11 @@ static const struct old_serial_port *serstate;
 static int timeouts;
 
 static int spk_serial_out(struct spk_synth *in_synth, const char ch);
-static void spk_serial_send_xchar(char ch);
-static void spk_serial_tiocmset(unsigned int set, unsigned int clear);
-static unsigned char spk_serial_in(void);
-static unsigned char spk_serial_in_nowait(void);
-static void spk_serial_flush_buffer(void);
+static void spk_serial_send_xchar(struct spk_synth *in_synth, char ch);
+static void spk_serial_tiocmset(struct spk_synth *in_synth, unsigned int set, unsigned int clear);
+static unsigned char spk_serial_in(struct spk_synth *in_synth);
+static unsigned char spk_serial_in_nowait(struct spk_synth *in_synth);
+static void spk_serial_flush_buffer(struct spk_synth *in_synth);
 static int spk_serial_wait_for_xmitr(struct spk_synth *in_synth);
 
 struct spk_io_ops spk_serial_io_ops = {
@@ -150,7 +150,7 @@ static void start_serial_interrupt(int irq)
 	outb(1, speakup_info.port_tts + UART_FCR);	/* Turn FIFO On */
 }
 
-static void spk_serial_send_xchar(char ch)
+static void spk_serial_send_xchar(struct spk_synth *synth, char ch)
 {
 	int timeout = SPK_XMITR_TIMEOUT;
 
@@ -162,7 +162,7 @@ static void spk_serial_send_xchar(char ch)
 	outb(ch, speakup_info.port_tts);
 }
 
-static void spk_serial_tiocmset(unsigned int set, unsigned int clear)
+static void spk_serial_tiocmset(struct spk_synth *in_synth, unsigned int set, unsigned int clear)
 {
 	int old = inb(speakup_info.port_tts + UART_MCR);
 
@@ -251,7 +251,7 @@ static int spk_serial_wait_for_xmitr(struct spk_synth *in_synth)
 	return 1;
 }
 
-static unsigned char spk_serial_in(void)
+static unsigned char spk_serial_in(struct spk_synth *in_synth)
 {
 	int tmout = SPK_SERIAL_TIMEOUT;
 
@@ -265,7 +265,7 @@ static unsigned char spk_serial_in(void)
 	return inb_p(speakup_info.port_tts + UART_RX);
 }
 
-static unsigned char spk_serial_in_nowait(void)
+static unsigned char spk_serial_in_nowait(struct spk_synth *in_synth)
 {
 	unsigned char lsr;
 
@@ -275,7 +275,7 @@ static unsigned char spk_serial_in_nowait(void)
 	return inb_p(speakup_info.port_tts + UART_RX);
 }
 
-static void spk_serial_flush_buffer(void)
+static void spk_serial_flush_buffer(struct spk_synth *in_synth)
 {
 	/* TODO: flush the UART 16550 buffer */
 }
@@ -307,7 +307,7 @@ const char *spk_serial_synth_immediate(struct spk_synth *synth,
 }
 EXPORT_SYMBOL_GPL(spk_serial_synth_immediate);
 
-void spk_serial_release(void)
+void spk_serial_release(struct spk_synth *synth)
 {
 	spk_stop_serial_interrupt();
 	if (speakup_info.port_tts == 0)
diff --git a/drivers/accessibility/speakup/speakup_acntpc.c b/drivers/accessibility/speakup/speakup_acntpc.c
index c94328a..c1ec087 100644
--- a/drivers/accessibility/speakup/speakup_acntpc.c
+++ b/drivers/accessibility/speakup/speakup_acntpc.c
@@ -25,7 +25,7 @@
 #define PROCSPEECH '\r'
 
 static int synth_probe(struct spk_synth *synth);
-static void accent_release(void);
+static void accent_release(struct spk_synth *synth);
 static const char *synth_immediate(struct spk_synth *synth, const char *buf);
 static void do_catch_up(struct spk_synth *synth);
 static void synth_flush(struct spk_synth *synth);
@@ -294,7 +294,7 @@ static int synth_probe(struct spk_synth *synth)
 	return 0;
 }
 
-static void accent_release(void)
+static void accent_release(struct spk_synth *synth)
 {
 	spk_stop_serial_interrupt();
 	if (speakup_info.port_tts)
diff --git a/drivers/accessibility/speakup/speakup_apollo.c b/drivers/accessibility/speakup/speakup_apollo.c
index 0877b40..cd63581 100644
--- a/drivers/accessibility/speakup/speakup_apollo.c
+++ b/drivers/accessibility/speakup/speakup_apollo.c
@@ -163,8 +163,8 @@ static void do_catch_up(struct spk_synth *synth)
 		full_time_val = full_time->u.n.value;
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 		if (!synth->io_ops->synth_out(synth, ch)) {
-			synth->io_ops->tiocmset(0, UART_MCR_RTS);
-			synth->io_ops->tiocmset(UART_MCR_RTS, 0);
+			synth->io_ops->tiocmset(synth, 0, UART_MCR_RTS);
+			synth->io_ops->tiocmset(synth, UART_MCR_RTS, 0);
 			schedule_timeout(msecs_to_jiffies(full_time_val));
 			continue;
 		}
diff --git a/drivers/accessibility/speakup/speakup_audptr.c b/drivers/accessibility/speakup/speakup_audptr.c
index e6a6a96..e89fd72 100644
--- a/drivers/accessibility/speakup/speakup_audptr.c
+++ b/drivers/accessibility/speakup/speakup_audptr.c
@@ -119,8 +119,8 @@ static struct spk_synth synth_audptr = {
 
 static void synth_flush(struct spk_synth *synth)
 {
-	synth->io_ops->flush_buffer();
-	synth->io_ops->send_xchar(SYNTH_CLEAR);
+	synth->io_ops->flush_buffer(synth);
+	synth->io_ops->send_xchar(synth, SYNTH_CLEAR);
 	synth->io_ops->synth_out(synth, PROCSPEECH);
 }
 
@@ -130,11 +130,11 @@ static void synth_version(struct spk_synth *synth)
 	char synth_id[40] = "";
 
 	synth->synth_immediate(synth, "\x05[Q]");
-	synth_id[test] = synth->io_ops->synth_in();
+	synth_id[test] = synth->io_ops->synth_in(synth);
 	if (synth_id[test] == 'A') {
 		do {
 			/* read version string from synth */
-			synth_id[++test] = synth->io_ops->synth_in();
+			synth_id[++test] = synth->io_ops->synth_in(synth);
 		} while (synth_id[test] != '\n' && test < 32);
 		synth_id[++test] = 0x00;
 	}
diff --git a/drivers/accessibility/speakup/speakup_decext.c b/drivers/accessibility/speakup/speakup_decext.c
index 7408eb2..092cfd0 100644
--- a/drivers/accessibility/speakup/speakup_decext.c
+++ b/drivers/accessibility/speakup/speakup_decext.c
@@ -218,7 +218,7 @@ static void do_catch_up(struct spk_synth *synth)
 static void synth_flush(struct spk_synth *synth)
 {
 	in_escape = 0;
-	synth->io_ops->flush_buffer();
+	synth->io_ops->flush_buffer(synth);
 	synth->synth_immediate(synth, "\033P;10z\033\\");
 }
 
diff --git a/drivers/accessibility/speakup/speakup_decpc.c b/drivers/accessibility/speakup/speakup_decpc.c
index 96f24c8..dec314d 100644
--- a/drivers/accessibility/speakup/speakup_decpc.c
+++ b/drivers/accessibility/speakup/speakup_decpc.c
@@ -125,7 +125,7 @@ enum {	PRIMARY_DIC	= 0, USER_DIC, COMMAND_DIC, ABBREV_DIC };
 #define SYNTH_IO_EXTENT 8
 
 static int synth_probe(struct spk_synth *synth);
-static void dtpc_release(void);
+static void dtpc_release(struct spk_synth *synth);
 static const char *synth_immediate(struct spk_synth *synth, const char *buf);
 static void do_catch_up(struct spk_synth *synth);
 static void synth_flush(struct spk_synth *synth);
@@ -474,7 +474,7 @@ static int synth_probe(struct spk_synth *synth)
 	return 0;
 }
 
-static void dtpc_release(void)
+static void dtpc_release(struct spk_synth *synth)
 {
 	spk_stop_serial_interrupt();
 	if (speakup_info.port_tts)
diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
index ab6d61e..d75de36 100644
--- a/drivers/accessibility/speakup/speakup_dectlk.c
+++ b/drivers/accessibility/speakup/speakup_dectlk.c
@@ -289,7 +289,7 @@ static void synth_flush(struct spk_synth *synth)
 		synth->io_ops->synth_out(synth, ']');
 	in_escape = 0;
 	is_flushing = 1;
-	synth->io_ops->flush_buffer();
+	synth->io_ops->flush_buffer(synth);
 	synth->io_ops->synth_out(synth, SYNTH_CLEAR);
 }
 
diff --git a/drivers/accessibility/speakup/speakup_dtlk.c b/drivers/accessibility/speakup/speakup_dtlk.c
index dbebed0..92838d3 100644
--- a/drivers/accessibility/speakup/speakup_dtlk.c
+++ b/drivers/accessibility/speakup/speakup_dtlk.c
@@ -24,7 +24,7 @@
 #define PROCSPEECH 0x00
 
 static int synth_probe(struct spk_synth *synth);
-static void dtlk_release(void);
+static void dtlk_release(struct spk_synth *synth);
 static const char *synth_immediate(struct spk_synth *synth, const char *buf);
 static void do_catch_up(struct spk_synth *synth);
 static void synth_flush(struct spk_synth *synth);
@@ -365,7 +365,7 @@ static int synth_probe(struct spk_synth *synth)
 	return 0;
 }
 
-static void dtlk_release(void)
+static void dtlk_release(struct spk_synth *synth)
 {
 	spk_stop_serial_interrupt();
 	if (speakup_info.port_tts)
diff --git a/drivers/accessibility/speakup/speakup_keypc.c b/drivers/accessibility/speakup/speakup_keypc.c
index 414827e..311f4aa 100644
--- a/drivers/accessibility/speakup/speakup_keypc.c
+++ b/drivers/accessibility/speakup/speakup_keypc.c
@@ -24,7 +24,7 @@
 #define SYNTH_CLEAR 0x03
 
 static int synth_probe(struct spk_synth *synth);
-static void keynote_release(void);
+static void keynote_release(struct spk_synth *synth);
 static const char *synth_immediate(struct spk_synth *synth, const char *buf);
 static void do_catch_up(struct spk_synth *synth);
 static void synth_flush(struct spk_synth *synth);
@@ -295,7 +295,7 @@ static int synth_probe(struct spk_synth *synth)
 	return 0;
 }
 
-static void keynote_release(void)
+static void keynote_release(struct spk_synth *synth)
 {
 	spk_stop_serial_interrupt();
 	if (synth_port)
diff --git a/drivers/accessibility/speakup/speakup_ltlk.c b/drivers/accessibility/speakup/speakup_ltlk.c
index 3c59519..3e59b38 100644
--- a/drivers/accessibility/speakup/speakup_ltlk.c
+++ b/drivers/accessibility/speakup/speakup_ltlk.c
@@ -132,7 +132,7 @@ static void synth_interrogate(struct spk_synth *synth)
 
 	synth->synth_immediate(synth, "\x18\x01?");
 	for (i = 0; i < 50; i++) {
-		buf[i] = synth->io_ops->synth_in();
+		buf[i] = synth->io_ops->synth_in(synth);
 		if (i > 2 && buf[i] == 0x7f)
 			break;
 	}
diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 9a70295..c3f97c5 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -24,7 +24,7 @@
 #define CLEAR_SYNTH 0x18
 
 static int softsynth_probe(struct spk_synth *synth);
-static void softsynth_release(void);
+static void softsynth_release(struct spk_synth *synth);
 static int softsynth_is_alive(struct spk_synth *synth);
 static unsigned char get_index(struct spk_synth *synth);
 
@@ -402,7 +402,7 @@ static int softsynth_probe(struct spk_synth *synth)
 	return 0;
 }
 
-static void softsynth_release(void)
+static void softsynth_release(struct spk_synth *synth)
 {
 	misc_deregister(&synth_device);
 	misc_deregister(&synthu_device);
diff --git a/drivers/accessibility/speakup/speakup_spkout.c b/drivers/accessibility/speakup/speakup_spkout.c
index 6e933bf..bd3d8dc 100644
--- a/drivers/accessibility/speakup/speakup_spkout.c
+++ b/drivers/accessibility/speakup/speakup_spkout.c
@@ -117,8 +117,8 @@ static struct spk_synth synth_spkout = {
 
 static void synth_flush(struct spk_synth *synth)
 {
-	synth->io_ops->flush_buffer();
-	synth->io_ops->send_xchar(SYNTH_CLEAR);
+	synth->io_ops->flush_buffer(synth);
+	synth->io_ops->send_xchar(synth, SYNTH_CLEAR);
 }
 
 module_param_named(ser, synth_spkout.ser, int, 0444);
diff --git a/drivers/accessibility/speakup/spk_priv.h b/drivers/accessibility/speakup/spk_priv.h
index 0f4bcbe..9da57ea 100644
--- a/drivers/accessibility/speakup/spk_priv.h
+++ b/drivers/accessibility/speakup/spk_priv.h
@@ -34,8 +34,8 @@
 
 const struct old_serial_port *spk_serial_init(int index);
 void spk_stop_serial_interrupt(void);
-void spk_serial_release(void);
-void spk_ttyio_release(void);
+void spk_serial_release(struct spk_synth *synth);
+void spk_ttyio_release(struct spk_synth *synth);
 void spk_ttyio_register_ldisc(void);
 void spk_ttyio_unregister_ldisc(void);
 
diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index 6284aff..d62fb74 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -114,11 +114,11 @@ static struct tty_ldisc_ops spk_ttyio_ldisc_ops = {
 
 static int spk_ttyio_out(struct spk_synth *in_synth, const char ch);
 static int spk_ttyio_out_unicode(struct spk_synth *in_synth, u16 ch);
-static void spk_ttyio_send_xchar(char ch);
-static void spk_ttyio_tiocmset(unsigned int set, unsigned int clear);
-static unsigned char spk_ttyio_in(void);
-static unsigned char spk_ttyio_in_nowait(void);
-static void spk_ttyio_flush_buffer(void);
+static void spk_ttyio_send_xchar(struct spk_synth *in_synth, char ch);
+static void spk_ttyio_tiocmset(struct spk_synth *in_synth, unsigned int set, unsigned int clear);
+static unsigned char spk_ttyio_in(struct spk_synth *in_synth);
+static unsigned char spk_ttyio_in_nowait(struct spk_synth *in_synth);
+static void spk_ttyio_flush_buffer(struct spk_synth *in_synth);
 static int spk_ttyio_wait_for_xmitr(struct spk_synth *in_synth);
 
 struct spk_io_ops spk_ttyio_ops = {
@@ -281,7 +281,7 @@ static int check_tty(struct tty_struct *tty)
 	return 0;
 }
 
-static void spk_ttyio_send_xchar(char ch)
+static void spk_ttyio_send_xchar(struct spk_synth *in_synth, char ch)
 {
 	mutex_lock(&speakup_tty_mutex);
 	if (check_tty(speakup_tty)) {
@@ -294,7 +294,7 @@ static void spk_ttyio_send_xchar(char ch)
 	mutex_unlock(&speakup_tty_mutex);
 }
 
-static void spk_ttyio_tiocmset(unsigned int set, unsigned int clear)
+static void spk_ttyio_tiocmset(struct spk_synth *in_synth, unsigned int set, unsigned int clear)
 {
 	mutex_lock(&speakup_tty_mutex);
 	if (check_tty(speakup_tty)) {
@@ -312,7 +312,7 @@ static int spk_ttyio_wait_for_xmitr(struct spk_synth *in_synth)
 	return 1;
 }
 
-static unsigned char ttyio_in(int timeout)
+static unsigned char ttyio_in(struct spk_synth *in_synth, int timeout)
 {
 	struct spk_ldisc_data *ldisc_data = speakup_tty->disc_data;
 	char rv;
@@ -339,19 +339,19 @@ static unsigned char ttyio_in(int timeout)
 	return rv;
 }
 
-static unsigned char spk_ttyio_in(void)
+static unsigned char spk_ttyio_in(struct spk_synth *in_synth)
 {
-	return ttyio_in(SPK_SYNTH_TIMEOUT);
+	return ttyio_in(in_synth, SPK_SYNTH_TIMEOUT);
 }
 
-static unsigned char spk_ttyio_in_nowait(void)
+static unsigned char spk_ttyio_in_nowait(struct spk_synth *in_synth)
 {
-	u8 rv = ttyio_in(0);
+	u8 rv = ttyio_in(in_synth, 0);
 
 	return (rv == 0xff) ? 0 : rv;
 }
 
-static void spk_ttyio_flush_buffer(void)
+static void spk_ttyio_flush_buffer(struct spk_synth *in_synth)
 {
 	mutex_lock(&speakup_tty_mutex);
 	if (check_tty(speakup_tty)) {
@@ -379,7 +379,7 @@ int spk_ttyio_synth_probe(struct spk_synth *synth)
 }
 EXPORT_SYMBOL_GPL(spk_ttyio_synth_probe);
 
-void spk_ttyio_release(void)
+void spk_ttyio_release(struct spk_synth *in_synth)
 {
 	if (!speakup_tty)
 		return;
@@ -395,15 +395,15 @@ void spk_ttyio_release(void)
 }
 EXPORT_SYMBOL_GPL(spk_ttyio_release);
 
-const char *spk_ttyio_synth_immediate(struct spk_synth *synth, const char *buff)
+const char *spk_ttyio_synth_immediate(struct spk_synth *in_synth, const char *buff)
 {
 	u_char ch;
 
 	while ((ch = *buff)) {
 		if (ch == '\n')
-			ch = synth->procspeech;
+			ch = in_synth->procspeech;
 		if (tty_write_room(speakup_tty) < 1 ||
-		    !synth->io_ops->synth_out(synth, ch))
+		    !in_synth->io_ops->synth_out(in_synth, ch))
 			return buff;
 		buff++;
 	}
diff --git a/drivers/accessibility/speakup/spk_types.h b/drivers/accessibility/speakup/spk_types.h
index 91fca30..2dc17c2 100644
--- a/drivers/accessibility/speakup/spk_types.h
+++ b/drivers/accessibility/speakup/spk_types.h
@@ -157,11 +157,11 @@ struct spk_synth;
 struct spk_io_ops {
 	int (*synth_out)(struct spk_synth *synth, const char ch);
 	int (*synth_out_unicode)(struct spk_synth *synth, u16 ch);
-	void (*send_xchar)(char ch);
-	void (*tiocmset)(unsigned int set, unsigned int clear);
-	unsigned char (*synth_in)(void);
-	unsigned char (*synth_in_nowait)(void);
-	void (*flush_buffer)(void);
+	void (*send_xchar)(struct spk_synth *synth, char ch);
+	void (*tiocmset)(struct spk_synth *synth, unsigned int set, unsigned int clear);
+	unsigned char (*synth_in)(struct spk_synth *synth);
+	unsigned char (*synth_in_nowait)(struct spk_synth *synth);
+	void (*flush_buffer)(struct spk_synth *synth);
 	int (*wait_for_xmitr)(struct spk_synth *synth);
 };
 
@@ -188,7 +188,7 @@ struct spk_synth {
 	int *default_vol;
 	struct spk_io_ops *io_ops;
 	int (*probe)(struct spk_synth *synth);
-	void (*release)(void);
+	void (*release)(struct spk_synth *synth);
 	const char *(*synth_immediate)(struct spk_synth *synth,
 				       const char *buff);
 	void (*catch_up)(struct spk_synth *synth);
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
index ac47dba..6c14b68 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -137,14 +137,14 @@ EXPORT_SYMBOL_GPL(spk_do_catch_up_unicode);
 
 void spk_synth_flush(struct spk_synth *synth)
 {
-	synth->io_ops->flush_buffer();
+	synth->io_ops->flush_buffer(synth);
 	synth->io_ops->synth_out(synth, synth->clear);
 }
 EXPORT_SYMBOL_GPL(spk_synth_flush);
 
 unsigned char spk_synth_get_index(struct spk_synth *synth)
 {
-	return synth->io_ops->synth_in_nowait();
+	return synth->io_ops->synth_in_nowait(synth);
 }
 EXPORT_SYMBOL_GPL(spk_synth_get_index);
 
@@ -440,7 +440,7 @@ void synth_release(void)
 		sysfs_remove_group(speakup_kobj, &synth->attributes);
 	for (var = synth->vars; var->var_id != MAXVARS; var++)
 		speakup_unregister_var(var->var_id);
-	synth->release();
+	synth->release(synth);
 	synth = NULL;
 }
 
-- 
2.20.1

