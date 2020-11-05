Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD32A7EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgKEMef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:34:35 -0500
Received: from mail.horus.com ([78.46.148.228]:58631 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKEMef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:34:35 -0500
Received: from [127.0.0.1] (178-190-199-171.adsl.highway.telekom.at [178.190.199.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "E-Mail Matthias Reichl Delle", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id E6EBE6409C;
        Thu,  5 Nov 2020 13:34:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1604579672;
        bh=kwxWtriEhEzMJGZknYItr3umCw9UYdQf3+jjdJAPjas=;
        h=From:To:Cc:Subject:Date:From;
        b=CAKkLTIL2ONu6aBI4eX0LnA4ECwu/OlomFZ3nIzduuNEtc1qF8+CXuRchFefnZsyF
         Mi/4taQ0J84Z7Lbl0iKXAS8jxlm5WYYQVgF1mubPfCJwErwXhrD0S/9LrlNLJL57Dp
         gPOogAw0I6ulz00ngmQlYTy+VldflRFxAp8dsk4g=
Received: by delle.lan (Postfix, from userid 1000)
        id 4DBAC1A2737; Thu,  5 Nov 2020 13:34:32 +0100 (CET)
From:   Matthias Reichl <hias@horus.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, Matthias Reichl <hias@horus.com>
Subject: [PATCH] tty: fix crash in release_tty if tty->port is not set
Date:   Thu,  5 Nov 2020 13:34:32 +0100
Message-Id: <20201105123432.4448-1-hias@horus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2ae0b31e0face ("tty: don't crash in tty_init_dev when missing
tty_port") didn't fully prevent the crash as the cleanup path in
tty_init_dev() calls release_tty() which dereferences tty->port
without checking it for non-null.

Add tty->port checks to release_tty to avoid the kernel crash.

Fixes: 2ae0b31e0face ("tty: don't crash in tty_init_dev when missing tty_port")
Signed-off-by: Matthias Reichl <hias@horus.com>
---
 drivers/tty/tty_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7a4c02548fb3f..9f8b9a567b359 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1515,10 +1515,12 @@ static void release_tty(struct tty_struct *tty, int idx)
 		tty->ops->shutdown(tty);
 	tty_save_termios(tty);
 	tty_driver_remove_tty(tty->driver, tty);
-	tty->port->itty = NULL;
+	if (tty->port)
+		tty->port->itty = NULL;
 	if (tty->link)
 		tty->link->port->itty = NULL;
-	tty_buffer_cancel_work(tty->port);
+	if (tty->port)
+		tty_buffer_cancel_work(tty->port);
 	if (tty->link)
 		tty_buffer_cancel_work(tty->link->port);
 
-- 
2.20.1

