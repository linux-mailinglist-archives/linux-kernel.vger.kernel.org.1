Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785CD28139E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbgJBNDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgJBNDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:03:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563FC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 06:03:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id y5so1246520otg.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lm0KG6Z6mYIW6FSScRaGeMbKbTSKVGePVnDUsykLTR8=;
        b=kLHw+bcujd1ASBE918QEAQbZs+pSx0YOmLIHmHtT9NICWHQ/QRf+1yAA4YMzq5fSOs
         j9QTtWHiUMSwkdqjSRUIzDir4l3zb6wYlCzBMLbDUi9vsxlKLx4iaLGJEaTwJN0RpCqk
         3awCDie2ZT64oHZB9nYyC5GUNGQ53JiODNFyfCvE51lZxt2Xf2Fjcih1Qu5K3SdUEn+0
         nlWzZRSC3Dby+cIgoK4toxzX6be2v/BIdhTzbFYpvUECehWZ99LoCOjwkv49ZPqIrgpI
         cRvHocNb7sCSF1+V0Cbe18GrHeQiPjlncngjY5MxhQm9yzu+ZyS47OfM8z7I0KsH1kWw
         NUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lm0KG6Z6mYIW6FSScRaGeMbKbTSKVGePVnDUsykLTR8=;
        b=p3Uwvz8iVGXPZjUpe8FRu/cYDgqIJrIFocY4qSdP28aRYhSK45igCZ6Eatw+obPPw7
         CN4KIh2KWA/8rAt2/o6uHGw4CCZIO14CirVZUORPgBfeCqnpyH4osgU7TPjKkD+t6RQt
         /WhY38JeHzis4mKXDmF7F2sq3kaWtvQHk2O9nfAN4cWfPv9SFdhN8nydhUJ7wmQ+9ivz
         eyMSaRDZSXOEZai5R1tfqOVPXRVlkcmm/wub5/OT8BAyfiJsCsrMbH95T+X87KJYNAOD
         JOOzO9FKYqyV5051xnPjlGf2Naave928+tdoSSgf6xQG0bQTld8kUTQnwku66K8v8wuE
         XH5Q==
X-Gm-Message-State: AOAM530UadxDhC3gCuJoGEyQUMp/yT1TcYrudJZ4niT9LSHUn9rl9RLF
        TNwec+cPlon4jE0q/zCzuw==
X-Google-Smtp-Source: ABdhPJw1Z/vntyeLXMGvM+HJKNt37/e9ZAvGdu8/KT5pgp2SemWGJSEMvre433wcqC07yW7xuX1Pgg==
X-Received: by 2002:a9d:6e91:: with SMTP id a17mr1596640otr.284.1601643793099;
        Fri, 02 Oct 2020 06:03:13 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id s32sm316808otb.68.2020.10.02.06.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 06:03:11 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:6c36:50d1:1e73:2068])
        by serve.minyard.net (Postfix) with ESMTPA id E553C18003B;
        Fri,  2 Oct 2020 13:03:10 +0000 (UTC)
From:   minyard@acm.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2] drivers:tty:pty: Fix a race causing data loss on close
Date:   Fri,  2 Oct 2020 08:03:04 -0500
Message-Id: <20201002130304.16728-1-minyard@acm.org>
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

thread1          thread2         thread3
-------          -------         -------
 |                |-write data into buffer,
 |                | n_tty buffer is filled
 |                | along with other buffers
 |                |-pty_close()
 |                |--tty_vhangup()
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
 |                                |-------copies data into n_tty buffer
 |                                |-------up_read(&tty->termios_rwsem)
 |--down_read(&tty->termios_rwsem)
 |--copy buffer data to user

From this sequence, you can see that thread2 writes to the buffer then
only clears the part of the buffer in n_tty.  The n_tty receive buffer
code then copies more data into the n_tty buffer.

This change checks to see if the tty is being hung up before copying
anything in n_tty_receive_buf_common().  It has to be done after the
tty->termios_rwsem semaphore is claimed, for reasons that should be
apparent from the sequence above.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---

Changes since v1: Added lines to make the sequence diagram clearer.

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

Another way to fix this that occurred just occurred to me would be to
clear all the buffers in pty_close().

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

