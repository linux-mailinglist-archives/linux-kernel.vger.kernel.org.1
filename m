Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F98280C43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 04:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbgJBCQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 22:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733275AbgJBCQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 22:16:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495AFC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 19:16:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h17so20879otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 19:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=pBsS8U3n2goF+q7+KhK9oFL3igcwGXhllgU+f5HX/QY=;
        b=aM5vVjNxhIaOHqqvWHzNsT76l9fZX7wMt7nzpjDWPMQnR9UCmu2zcEp+E6qfYH53GY
         QyJTf66+ZcON3sX3eyeOOcTrxvzOl0HsWPgMaPir1bBEGCx8BVLGBquMIHOeu12+7pqz
         7BkaUWPXUdzy/oTyBl77jLS1UjuVfU5vnrucLCE3X7EMzT5aGImzyotisTeyfmrhLLSy
         3kylrca5OvkFSW28csTIAnmELCEGkA/ngwnhsOqkGLeQeFMId6S5ukSlyWt+y/JWlg9D
         VdW3de35ED5txX62mAzNTcMboqGp2g0uMqG1Vte9Rn18iqPJ1JA/yXaajrMzExGZwPEK
         YlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=pBsS8U3n2goF+q7+KhK9oFL3igcwGXhllgU+f5HX/QY=;
        b=X8mLLO5Kv/Jk5Le8K0fU7+AVRtrRTMVY5VIM+EaEzKXWVHZQnSuVpyHoE2vJkmYTvs
         jb78vyah8gIAczrgIfHR5mP8rDD5e3ydaqzijriY783NiQ6dPF8MpwAn7cgh4dFeV9ZT
         0c2NYj4bLqGXqSjsdxk8C1Gs45sYj5ACXjoourzvbx4PNGWARcPuIRswM7nzB0LoRq8Z
         HH2SDW7mZiTexQxu2E7r+Q4bZNvulQwBZhjyWK0Bd+pEgS9wSChw7RFPfyQlKIYCp/Vb
         Tjg3Lw5DiL84w5/zCIXyuGjPmz6uFADTB5bJL3VFIzf6JCkBQchfbfvUkSVXTI7rY9SZ
         SXwQ==
X-Gm-Message-State: AOAM533aCdYQK5mSA7irg+P/EqZHP7t1sGBrKzznsIykSx4AeOFpRWbN
        kwSf4C+6hRs7QK+q5CIC4b0KdTNNR5tT
X-Google-Smtp-Source: ABdhPJwB+0R5sv4/RL28O5EJ9ThE6Tbpot8ogk+93W0JHSgwAEPqREhErRj6njBTeREyk5b0bXKxKg==
X-Received: by 2002:a9d:6d8a:: with SMTP id x10mr76941otp.354.1601604999546;
        Thu, 01 Oct 2020 19:16:39 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 109sm1399141oty.59.2020.10.01.19.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 19:16:38 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:6c36:50d1:1e73:2068])
        by serve.minyard.net (Postfix) with ESMTPA id 99C7E180056;
        Fri,  2 Oct 2020 02:16:37 +0000 (UTC)
From:   minyard@acm.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] drivers:tty:pty: Fix a race causing data loss on close
Date:   Thu,  1 Oct 2020 21:16:30 -0500
Message-Id: <20201002021630.4892-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

If you write to a pty master an immediately close the pty master, the
receiver might get a chunk of data dropped, but then receive some later
data.  That's obviously something rather unexpected for a user.  It
certainly confused my test program.

It turns out that tty_vhangup() gets called from pty_close(), and that
causes the data on the slave side to be flushed, but due to races more
data can be copied into the slave side's buffer after that.  Consider
the following sequence:

thread1            thread2            thread3
                   write data into buffer,
                      n_tty buffer is filled
                   pty_close()
                    tty_vhangup()
                     tty_ldisc_hangup()
                      n_tty_flush_buffer()
                       reset_buffer_flags()
n_tty_read()
 up_read(&tty->termios_rwsem);
                        down_read(&tty->termios_rwsem);
                        clear n_tty buffer contents
                        up_read(&tty->termios_rwsem);
 tty_buffer_flush_work()
  schedules work calling
        flush_to_ldisc()
                                      flush_to_ldisc()
                                       receive_buf()
                                        tty_port_default_receive_buf()
                                         tty_ldisc_receive_buf()
                                          tty_ldisc_receive_buf()
                                           n_tty_receive_buf2()
                                            n_tty_receive_buf_common()
                                             down_read(&tty->termios_rwsem);
                                             __receive_buf()
                                              copies data into n_tty buffer
                                             up_read(&tty->termios_rwsem);
 down_read(&tty->termios_rwsem);
 copy buffer data to user

This change checks to see if the tty is being hung up before copying
anything in n_tty_receive_buf_common().  It has to be done after the
tty->termios_rwsem semaphore is claimed, for reasons that should be
apparent from the sequence above.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
I sent a program to reproduce this, I extended it to prove it wasn't the
test program that caused the issue, and I've uploaded it to:
  http://sourceforge.net/projects/ser2net/files/tmp/testpty.c
if you want to run it.  It has a lot of comments that explain what is
going on.

This is not a very satisfying fix, though.  It works reliably, but it
doesn't seem right to me.  My inclination was to remove the up and down
semaphore around tty_buffer_flush_work() in n_tty_read(), as it just
schedules some work, no need to unlock for that.  But that resulted
in a deadlock elsewhere, so that up/down on the semaphore is there for
another reason.

The locking in the tty code is really hard to follow.  I believe this is
actually a locking problem, but fixing it looks daunting to me.

-corey

 drivers/tty/n_tty.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 1794d84e7bf6..1c33c26dc229 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1704,6 +1704,9 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 
 	down_read(&tty->termios_rwsem);
 
+	if (test_bit(TTY_HUPPING, &tty->flags))
+		goto out_upsem;
+
 	do {
 		/*
 		 * When PARMRK is set, each input char may take up to 3 chars
@@ -1760,6 +1763,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 	} else
 		n_tty_check_throttle(tty);
 
+out_upsem:
 	up_read(&tty->termios_rwsem);
 
 	return rcvd;
-- 
2.17.1

