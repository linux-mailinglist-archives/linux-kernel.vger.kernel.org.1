Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A952CCBF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgLCCEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgLCCEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:04:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E7CC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 18:03:59 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so256234wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 18:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5umzCI4TaFVhL8nuzDezw60k+XBY/fCF3QBJr3x+P4=;
        b=m5EldO+Qqc6atF60hZX23z1bsSqde0yD5g5UQkyll4aZXY1POybhmvMhP2yhBybBm0
         DXHDu/hVMcAdZQRp7YPGzE1j0TKuohpl5bncdBCuoJvBr4M2KfK+1oLtre7T9znaZKF8
         UbsoCgg+EVbKsGqQHygHxrxRC8EkSm2W8ASMYXY410vqrdxL/tfmqQi7leBgTZOQxvWu
         L6CwZE500sgZPnsl8NIZgcBJ+CznbfjESaw446P2/YhS+A3pg+6mJmPc4nI4WcwN/m21
         OtUx1E4/zIyQ5rRfkkNQ58vX7ZdAbeu6KYOqKZi5f97CyuyuwTex/73AffQ4YeXpIt5E
         2Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5umzCI4TaFVhL8nuzDezw60k+XBY/fCF3QBJr3x+P4=;
        b=GZWpvCQktcgc2kWh1uGkki2p3x1LDY5jUeK2FRi3qswKH8kXjnLtlGg8UBh+Y2QXGU
         DnlRvbfEWFPse+V00YL588CUlZRwgm2ryNBspZL0Ef6LK7hqlPmbNbhSpROTBiggFGTi
         Rc4mBg5EJXIPh7k2BhJJmH9U2RvZ9wL4sakntRSgn7DCY1c3ldbtd49TfcUfpoEkMW7D
         hqbnxZeZfnI9TwzEyAinmngycvaLrwdXyhbaIq/77imuj1bhP0P4nfR3G3OC1vjRgIE6
         3VpJ0p3JaVlLm15ssPou+b3Zqso86gJJ1qFOj14nL7uaY9SweeMOancaYQDB+gfXw1hy
         pFTQ==
X-Gm-Message-State: AOAM533t41zbfd82HeuP87WBLv2vlzG7g0rIt0P7irgs+SeSjFmH9Bho
        VCgUZmrtTipaQQpJqlae50g5hQ==
X-Google-Smtp-Source: ABdhPJx/KOLIzYzAJzuJ19MmmmCt3cZapNWF7qykxnDxCWAL957kgpYvEN5Qn/yOtiXS3NY9NfIuGw==
X-Received: by 2002:adf:f181:: with SMTP id h1mr918858wro.267.1606961037823;
        Wed, 02 Dec 2020 18:03:57 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id x4sm570263wrv.81.2020.12.02.18.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 18:03:57 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: Remove dead termiox code
Date:   Thu,  3 Dec 2020 03:03:31 +0100
Message-Id: <20201203020331.2394754-1-jannh@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_termiox() and the TCGETX handler bail out with -EINVAL immediately
if ->termiox is NULL, but there are no code paths that can set
->termiox to a non-NULL pointer; and no such code paths seem to have
existed since the termiox mechanism was introduced back in
commit 1d65b4a088de ("tty: Add termiox") in v2.6.28.
Similarly, no driver actually implements .set_termiox; and it looks like
no driver ever has.

Delete this dead code; but leave the definition of struct termiox in the
UAPI headers intact.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/tty/tty_ioctl.c    | 61 ++------------------------------------
 include/linux/tty.h        |  1 -
 include/linux/tty_driver.h |  9 ------
 3 files changed, 2 insertions(+), 69 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index e18f318586ab..4de1c6ddb8ff 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -443,51 +443,6 @@ static int get_termio(struct tty_struct *tty, struct t=
ermio __user *termio)
 	return 0;
 }
=20
-
-#ifdef TCGETX
-
-/**
- *	set_termiox	-	set termiox fields if possible
- *	@tty: terminal
- *	@arg: termiox structure from user
- *	@opt: option flags for ioctl type
- *
- *	Implement the device calling points for the SYS5 termiox ioctl
- *	interface in Linux
- */
-
-static int set_termiox(struct tty_struct *tty, void __user *arg, int opt)
-{
-	struct termiox tnew;
-	struct tty_ldisc *ld;
-
-	if (tty->termiox =3D=3D NULL)
-		return -EINVAL;
-	if (copy_from_user(&tnew, arg, sizeof(struct termiox)))
-		return -EFAULT;
-
-	ld =3D tty_ldisc_ref(tty);
-	if (ld !=3D NULL) {
-		if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
-			ld->ops->flush_buffer(tty);
-		tty_ldisc_deref(ld);
-	}
-	if (opt & TERMIOS_WAIT) {
-		tty_wait_until_sent(tty, 0);
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-	}
-
-	down_write(&tty->termios_rwsem);
-	if (tty->ops->set_termiox)
-		tty->ops->set_termiox(tty, &tnew);
-	up_write(&tty->termios_rwsem);
-	return 0;
-}
-
-#endif
-
-
 #ifdef TIOCGETP
 /*
  * These are deprecated, but there is limited support..
@@ -815,23 +770,11 @@ int tty_mode_ioctl(struct tty_struct *tty, struct fil=
e *file,
 		return ret;
 #endif
 #ifdef TCGETX
-	case TCGETX: {
-		struct termiox ktermx;
-		if (real_tty->termiox =3D=3D NULL)
-			return -EINVAL;
-		down_read(&real_tty->termios_rwsem);
-		memcpy(&ktermx, real_tty->termiox, sizeof(struct termiox));
-		up_read(&real_tty->termios_rwsem);
-		if (copy_to_user(p, &ktermx, sizeof(struct termiox)))
-			ret =3D -EFAULT;
-		return ret;
-	}
+	case TCGETX:
 	case TCSETX:
-		return set_termiox(real_tty, p, 0);
 	case TCSETXW:
-		return set_termiox(real_tty, p, TERMIOS_WAIT);
 	case TCSETXF:
-		return set_termiox(real_tty, p, TERMIOS_FLUSH);
+		return -EINVAL;
 #endif=09=09
 	case TIOCGSOFTCAR:
 		copy_termios(real_tty, &kterm);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index a99e9b8e4e31..52f5544bcd85 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -303,7 +303,6 @@ struct tty_struct {
 	spinlock_t flow_lock;
 	/* Termios values are protected by the termios rwsem */
 	struct ktermios termios, termios_locked;
-	struct termiox *termiox;	/* May be NULL for unsupported */
 	char name[64];
 	struct pid *pgrp;		/* Protected by ctrl lock */
 	struct pid *session;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 358446247ccd..61c3372d3f32 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -224,14 +224,6 @@
  *	line). See tty_do_resize() if you need to wrap the standard method
  *	in your own logic - the usual case.
  *
- * void (*set_termiox)(struct tty_struct *tty, struct termiox *new);
- *
- *	Called when the device receives a termiox based ioctl. Passes down
- *	the requested data from user space. This method will not be invoked
- *	unless the tty also has a valid tty->termiox pointer.
- *
- *	Optional: Called under the termios lock
- *
  * int (*get_icount)(struct tty_struct *tty, struct serial_icounter *icoun=
t);
  *
  *	Called when the device receives a TIOCGICOUNT ioctl. Passed a kernel
@@ -285,7 +277,6 @@ struct tty_operations {
 	int (*tiocmset)(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
 	int (*resize)(struct tty_struct *tty, struct winsize *ws);
-	int (*set_termiox)(struct tty_struct *tty, struct termiox *tnew);
 	int (*get_icount)(struct tty_struct *tty,
 				struct serial_icounter_struct *icount);
 	int  (*get_serial)(struct tty_struct *tty, struct serial_struct *p);

base-commit: 3bb61aa61828499a7d0f5e560051625fd02ae7e4
--=20
2.29.2.576.ga3fc446d84-goog

