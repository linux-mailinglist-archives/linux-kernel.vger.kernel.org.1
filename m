Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239392C1A36
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgKXAtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgKXAtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:49:12 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0706C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:49:12 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f12so6339112oto.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxDrECmmKNiJyIZxTMw08fimKYohh92/lptBQ8KyP1g=;
        b=WzxJ0RwG9irsw8Z3XMWrceAkIUQ00cfQB3I/yMeCQYVIsJQKM7D3S12z/Qc3ilsHVK
         EYFuahSLTCp/bCQgvUkO1BZ5ZVq8IaXpLAIeh3xxJ0YWbJXQnxqVYJO/WnK1lN189Fzx
         Hm5FS0bUhQMRc48VGaWaz0PMWvnHSwoNk1QWY49b52slHonABsOUOMPE4SkAcOHi4RIX
         u4sFXdKpW7lJq0gb/svF+6ddAfU3wgczhhny3ZqyYninwfoKG+iymKmoTEz7Q0eymBel
         21nfDveea10RAGGJwlpuV0J0/x+Fui61V9qzMx22O80EhtL7sjk3XdufoieLbu2DAFqI
         KI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sxDrECmmKNiJyIZxTMw08fimKYohh92/lptBQ8KyP1g=;
        b=dcpBXowcB0i9SKy7yAcyOD/9MHF1AP7nYOKMySwFZjYy+zx5v/OlRi1nRI2CCYm1iB
         mDjxAkzKdka5iU1m6sQj2cQYu+z1D3/EBzZ8EGuQo+kzJtbCHI1wvKpPh4u56qgyP3P0
         8VoCNf4yBWAcOXCcVkvvL/mF/BKdEPLh7RWiR7sSuFr62ghTRLAXOrgqT8FpXurDgYsA
         nQjzU0dydazjdyqrk787+Eb1/I5MWr/qwFcDoew/x764/GuIsR6+LkOzybDwNspmC2JR
         1pU9EjGZMyJ/lhppkaTQs3Hg2BL2i4mOWLF3OZK1IeDl7u2VL+2baOH5D9YMYIM5dlgo
         z4KA==
X-Gm-Message-State: AOAM531QiZ4zAfuEz2/XF5jZStEqVQ3pA3OZn1J0VYoUKobVpXEx6QRA
        sE/XhMQDzU4zMsqZ+m3Xdw==
X-Google-Smtp-Source: ABdhPJy2k1hhYzb7gV5d+E93ZNHFplr2oE3+PdcaklPwQb/gn6YwXiCoxjy0Fl1a4CF+0mXXYAIF7Q==
X-Received: by 2002:a05:6830:1e34:: with SMTP id t20mr1507974otr.199.1606178952090;
        Mon, 23 Nov 2020 16:49:12 -0800 (PST)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id k13sm1186694otl.72.2020.11.23.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:49:09 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:413d:60da:9340:6f51])
        by serve.minyard.net (Postfix) with ESMTPA id 15C95180578;
        Tue, 24 Nov 2020 00:49:09 +0000 (UTC)
From:   minyard@acm.org
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        brian.bloniarz@gmail.com, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 2/2] drivers:tty:pty: Fix a race causing data loss on close
Date:   Mon, 23 Nov 2020 18:49:02 -0600
Message-Id: <20201124004902.1398477-3-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124004902.1398477-1-minyard@acm.org>
References: <20201124004902.1398477-1-minyard@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Remove the tty_vhangup() from the pty code and just release the
redirect.  The tty_vhangup() results in data loss and data out of order
issues.

If you write to a pty master an immediately close the pty master, the
receiver might get a chunk of data dropped, but then receive some later
data.  That's obviously something rather unexpected for a user.  It
certainly confused my test program.

It turns out that tty_vhangup() on the slave pty gets called from
pty_close(), and that causes the data on the slave side to be flushed,
but due to races more data can be copied into the slave side's buffer
after that.  Consider the following sequence:

thread1          thread2         thread3
-------          -------         -------
 |                |-write data into buffer,
 |                | n_tty buffer is filled
 |                | along with other buffers
 |                |-pty_close(master)
 |                |--tty_vhangup(slave)
 |                |---tty_ldisc_hangup()
 |                |----n_tty_flush_buffer()
 |                |-----reset_buffer_flags()
 |-n_tty_read()   |
 |--up_read(&tty->termios_rwsem);
 |                |------down_read(&tty->termios_rwsem)
 |                |------clear n_tty buffer contents
 |                |------up_read(&tty->termios_rwsem)
 |--tty_buffer_flush_work()       |
 |--schedules work calling        |
 |  flush_to_ldisc()              |
 |                                |-flush_to_ldisc()
 |                                |--receive_buf()
 |                                |---tty_port_default_receive_buf()
 |                                |----tty_ldisc_receive_buf()
 |                                |-----n_tty_receive_buf2()
 |                                |------n_tty_receive_buf_common()
 |                                |-------down_read(&tty->termios_rwsem)
 |                                |-------__receive_buf()
 |                                |       copies data into n_tty buffer
 |                                |-------up_read(&tty->termios_rwsem)
 |--down_read(&tty->termios_rwsem)
 |--copy buffer data to user

From this sequence, you can see that thread2 writes to the buffer then
only clears the part of the buffer in n_tty.  The n_tty receive buffer
code then copies more data into the n_tty buffer.

But part of the vhangup, releasing the redirect, is still required to
avoid issues with consoles running on pty slaves.  So do that.
As far as I can tell, that is all that should be required.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/tty/pty.c    | 15 +++++++++++++--
 drivers/tty/tty_io.c |  5 +++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 23368cec7ee8..29be6b985e76 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -67,7 +67,8 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 	wake_up_interruptible(&tty->link->read_wait);
 	wake_up_interruptible(&tty->link->write_wait);
 	if (tty->driver->subtype == PTY_TYPE_MASTER) {
-		set_bit(TTY_OTHER_CLOSED, &tty->flags);
+		struct file *f;
+
 #ifdef CONFIG_UNIX98_PTYS
 		if (tty->driver == ptm_driver) {
 			mutex_lock(&devpts_mutex);
@@ -76,7 +77,17 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 			mutex_unlock(&devpts_mutex);
 		}
 #endif
-		tty_vhangup(tty->link);
+
+		/*
+		 * This hack is required because a program can open a
+		 * pty and redirect a console to it, but if the pty is
+		 * closed and the console is not released, then the
+		 * slave side will never close.  So release the
+		 * redirect when the master closes.
+		 */
+		f = tty_release_redirect(tty->link);
+		if (f)
+			fput(f);
 	}
 }
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 571b1d7d4d5a..91c33a0df3c4 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -547,7 +547,9 @@ EXPORT_SYMBOL_GPL(tty_wakeup);
  *	@tty: tty device
  *
  *	This is available to the pty code so if the master closes, if the
- *	slave is a redirect it can release the redirect.
+ *	slave is a redirect it can release the redirect.  It returns the
+ *	filp for the redirect, which must be fput when the operations on
+ *	the tty are completed.
  */
 struct file *tty_release_redirect(struct tty_struct *tty)
 {
@@ -562,7 +564,6 @@ struct file *tty_release_redirect(struct tty_struct *tty)
 
 	return f;
 }
-EXPORT_SYMBOL_GPL(tty_release_redirect);
 
 /**
  *	__tty_hangup		-	actual handler for hangup events
-- 
2.25.1

