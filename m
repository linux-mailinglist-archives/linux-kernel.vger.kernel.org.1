Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF328BD5C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403748AbgJLQQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390043AbgJLQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:16:17 -0400
X-Greylist: delayed 562 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Oct 2020 09:16:17 PDT
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A865C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:16:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 344A34DF;
        Mon, 12 Oct 2020 18:06:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id swlUKubGrYvK; Mon, 12 Oct 2020 18:06:48 +0200 (CEST)
Received: from function.home (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 3ADEE79;
        Mon, 12 Oct 2020 18:06:48 +0200 (CEST)
Received: from samy by function.home with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kS0LX-007yjf-0N; Mon, 12 Oct 2020 18:06:47 +0200
Date:   Mon, 12 Oct 2020 18:06:46 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] speakup: Fix var_id_t values and thus keymap
Message-ID: <20201012160646.qmdo4eqtj24hpch4@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d97a9d7aea04 ("staging/speakup: Add inflection synth parameter")
introduced a new "inflection" speakup parameter next to "pitch", but
the values of the var_id_t enum are actually used by the keymap tables
so we must not renumber them. The effect was that notably the volume
control shortcut (speakup-1 or 2) was actually changing the inflection.

This moves the INFLECTION value at the end of the var_id_t enum to
fix back the enum values. This also adds a warning about it.

Cc: stable@vger.kernel.org
Reported-by: Kirk Reiser <kirk@reisers.ca>
Reported-by: Gregory Nowak <greg@gregn.net>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Gregory Nowak <greg@gregn.net>
Fixes: d97a9d7aea04 ("staging/speakup: Add inflection synth parameter")
---
 drivers/accessibility/speakup/spk_types.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_types.h b/drivers/accessibility/speakup/spk_types.h
index 7398f1196e10..91fca3033a45 100644
--- a/drivers/accessibility/speakup/spk_types.h
+++ b/drivers/accessibility/speakup/spk_types.h
@@ -32,6 +32,10 @@ enum {
 	E_NEW_DEFAULT,
 };
 
+/*
+ * Note: add new members at the end, speakupmap.h depends on the values of the
+ * enum starting from SPELL_DELAY (see inc_dec_var)
+ */
 enum var_id_t {
 	VERSION = 0, SYNTH, SILENT, SYNTH_DIRECT,
 	KEYMAP, CHARS,
@@ -42,9 +46,9 @@ enum var_id_t {
 	SAY_CONTROL, SAY_WORD_CTL, NO_INTERRUPT, KEY_ECHO,
 	SPELL_DELAY, PUNC_LEVEL, READING_PUNC,
 	ATTRIB_BLEEP, BLEEPS,
-	RATE, PITCH, INFLECTION, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG,
+	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG,
 	DIRECT, PAUSE,
-	CAPS_START, CAPS_STOP, CHARTAB,
+	CAPS_START, CAPS_STOP, CHARTAB, INFLECTION,
 	MAXVARS
 };
 
-- 
2.20.1

