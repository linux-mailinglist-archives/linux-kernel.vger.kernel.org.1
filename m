Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B722F17A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbhAKOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbhAKNDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:03:37 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B4C06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:02:56 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id FR2u2400j4C55Sk06R2uHp; Mon, 11 Jan 2021 14:02:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kywqU-002pvS-A9; Mon, 11 Jan 2021 14:02:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kywqT-001W0u-RF; Mon, 11 Jan 2021 14:02:53 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/2] ALSA: firewire-tascam: Fix integer overflow in midi_port_work()
Date:   Mon, 11 Jan 2021 14:02:51 +0100
Message-Id: <20210111130251.361335-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111130251.361335-1-geert+renesas@glider.be>
References: <20210111130251.361335-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As snd_fw_async_midi_port.consume_bytes is unsigned int, and
NSEC_PER_SEC is 1000000000L, the second multiplication in

    port->consume_bytes * 8 * NSEC_PER_SEC / 31250

always overflows on 32-bit platforms, truncating the result.  Fix this
by precalculating "NSEC_PER_SEC / 31250", which is an integer constant.

Note that this assumes port->consume_bytes <= 16777.

Fixes: 531f471834227d03 ("ALSA: firewire-lib/firewire-tascam: localize async midi port")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

I don't know the maximum transfer length of MIDI, but given it's an old
standard, I guess it's rather small.  If it is larger than 16777, the
constant "8" should be replaced by "8ULL", to force 64-bit arithmetic.
---
 sound/firewire/tascam/tascam-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 90288b4b46379526..a073cece4a7d5e3a 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -209,7 +209,7 @@ static void midi_port_work(struct work_struct *work)
 
 	/* Set interval to next transaction. */
 	port->next_ktime = ktime_add_ns(ktime_get(),
-				port->consume_bytes * 8 * NSEC_PER_SEC / 31250);
+			port->consume_bytes * 8 * (NSEC_PER_SEC / 31250));
 
 	/* Start this transaction. */
 	port->idling = false;
-- 
2.25.1

