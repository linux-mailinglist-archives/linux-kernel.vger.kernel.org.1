Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8322D6819
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404548AbgLJUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 15:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404538AbgLJUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:03:52 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4CEC061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 12:03:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 418DFCE0;
        Thu, 10 Dec 2020 21:03:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BJM9QUGJywKT; Thu, 10 Dec 2020 21:03:10 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 68EB7A25;
        Thu, 10 Dec 2020 21:03:10 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1knS9d-00AfPT-Mr; Thu, 10 Dec 2020 21:03:09 +0100
Message-Id: <20201210200132.174722170@ens-lyon.org>
User-Agent: quilt/0.65
Date:   Thu, 10 Dec 2020 21:01:26 +0100
From:   samuel.thibault@ens-lyon.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [patch 3/3] speakup: Simplify spk_ttyio_out error handling.
References: <20201210200123.451204785@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=spk_ttyio_clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids most code indentation

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-5.9/drivers/accessibility/speakup/spk_ttyio.c
===================================================================
--- linux-5.9.orig/drivers/accessibility/speakup/spk_ttyio.c
+++ linux-5.9/drivers/accessibility/speakup/spk_ttyio.c
@@ -225,27 +225,29 @@ void spk_ttyio_unregister_ldisc(void)
 static int spk_ttyio_out(struct spk_synth *in_synth, const char ch)
 {
 	struct tty_struct *tty = in_synth->dev;
+	int ret;
 
-	if (in_synth->alive && tty->ops->write) {
-		int ret = tty->ops->write(tty, &ch, 1);
+	if (!in_synth->alive || !tty->ops->write)
+		return 0;
 
-		if (ret == 0)
-			/* No room */
-			return 0;
-		if (ret < 0) {
-			pr_warn("%s: I/O error, deactivating speakup\n",
-				in_synth->long_name);
-			/* No synth any more, so nobody will restart TTYs,
-			 * and we thus need to do it ourselves.  Now that there
-			 * is no synth we can let application flood anyway
-			 */
-			in_synth->alive = 0;
-			speakup_start_ttys();
-			return 0;
-		}
+	ret = tty->ops->write(tty, &ch, 1);
+
+	if (ret == 0)
+		/* No room */
+		return 0;
+
+	if (ret > 0)
+		/* Success */
 		return 1;
-	}
 
+	pr_warn("%s: I/O error, deactivating speakup\n",
+		in_synth->long_name);
+	/* No synth any more, so nobody will restart TTYs,
+	 * and we thus need to do it ourselves.  Now that there
+	 * is no synth we can let application flood anyway
+	 */
+	in_synth->alive = 0;
+	speakup_start_ttys();
 	return 0;
 }
 


