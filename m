Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6022C1A35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKXAtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgKXAtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:49:12 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B4C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:49:12 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id i13so4396347oou.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMNXHUThgQgUKT4LhTaTZHbIlK/f0HsLvTvbONxdRFQ=;
        b=KZ45WBrg6D7kgEa5/mk8scl7z7g+gcPy+AMbgiJgHEEN1fH+vS9ZGkTeSO5KQPKCm7
         MTeoNDMz2HNpGGiIix+NVjJq2Rr77KbAfXD5zG0ChJV2cSwOrO7Xipb3Bxyp3UP+tNWx
         3MFFTDeEciYBgZrzsdbHfVYHx1TfT3Y1r+Kmp0wt0fj//wu3tpmJeICCzhRE3k7MHwtb
         UH+j4EW3UUq650nVNErZn883KqfVEM37anAMq6qoqiWwh/KIRspnYb68I/0sV4HfVxf5
         1h3P6Wt3r92MMPdYk5yW0MlW4iJ9GLBmQV16TE4bnh1FKaRmgLBcQZfuM9Z/9Zw5Umnk
         DZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LMNXHUThgQgUKT4LhTaTZHbIlK/f0HsLvTvbONxdRFQ=;
        b=E7gMgsSTMYnTG4ZnY4VpGzOZUbHgomfTtUhmji6rNNxTXLDOw9gJy9snsF3yBRZGW2
         NhXDlMQOFTHRJz0J3tTXoYYyFkocPhKaAESlv9v3Co51CnqBy/b7iHuHGIwjngSmeI6M
         xbrhjUhY+eRCMFsUxrpSLmgINLiuDXGXoRJ9gDtmF7m37U9GkGDuG7NdlAcjQaGlTcib
         g8cIBrs2Vfi5BeVFzYRo0uXf2e2vDKe+tboKuC5yW1Z+FIwRfHzbP+NQJzoNftrZq1Aa
         9s2fbr0jMFJKmBvsAFUhnxDdF1RU+xJIYKFi6qDYyZh8QtP3aHUOI7plU22VJyiwp9SV
         pTpg==
X-Gm-Message-State: AOAM530ToaWF9RNQeXlN9rLSdi4P8064IC7uPwm9b3+kycAgGwZHrVf9
        yGUBQAPW6m1ZlaNAwuPbsw==
X-Google-Smtp-Source: ABdhPJwY6ZvfyIflr2lmEL61W/jrQRGOrCTPaj0vJwtzqzjoJ3HBVcrR8O84pg02qWC857JC9DdMOg==
X-Received: by 2002:a4a:3b83:: with SMTP id s125mr1477328oos.82.1606178951580;
        Mon, 23 Nov 2020 16:49:11 -0800 (PST)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id h3sm4433158otq.33.2020.11.23.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:49:09 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:413d:60da:9340:6f51])
        by serve.minyard.net (Postfix) with ESMTPA id 05E87180577;
        Tue, 24 Nov 2020 00:49:09 +0000 (UTC)
From:   minyard@acm.org
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        brian.bloniarz@gmail.com, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 1/2] tty: Export redirect release
Date:   Mon, 23 Nov 2020 18:49:01 -0600
Message-Id: <20201124004902.1398477-2-minyard@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124004902.1398477-1-minyard@acm.org>
References: <20201124004902.1398477-1-minyard@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

This will be required by the pty code when it removes tty_vhangup() on
master close.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/tty/tty_io.c | 32 ++++++++++++++++++++++++--------
 include/linux/tty.h  |  1 +
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7a4c02548fb3..571b1d7d4d5a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -542,6 +542,28 @@ void tty_wakeup(struct tty_struct *tty)
 
 EXPORT_SYMBOL_GPL(tty_wakeup);
 
+/**
+ *	tty_release_redirect	-	Release a redirect on a pty if present
+ *	@tty: tty device
+ *
+ *	This is available to the pty code so if the master closes, if the
+ *	slave is a redirect it can release the redirect.
+ */
+struct file *tty_release_redirect(struct tty_struct *tty)
+{
+	struct file *f = NULL;
+
+	spin_lock(&redirect_lock);
+	if (redirect && file_tty(redirect) == tty) {
+		f = redirect;
+		redirect = NULL;
+	}
+	spin_unlock(&redirect_lock);
+
+	return f;
+}
+EXPORT_SYMBOL_GPL(tty_release_redirect);
+
 /**
  *	__tty_hangup		-	actual handler for hangup events
  *	@tty: tty device
@@ -567,7 +589,7 @@ EXPORT_SYMBOL_GPL(tty_wakeup);
 static void __tty_hangup(struct tty_struct *tty, int exit_session)
 {
 	struct file *cons_filp = NULL;
-	struct file *filp, *f = NULL;
+	struct file *filp, *f;
 	struct tty_file_private *priv;
 	int    closecount = 0, n;
 	int refs;
@@ -575,13 +597,7 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 	if (!tty)
 		return;
 
-
-	spin_lock(&redirect_lock);
-	if (redirect && file_tty(redirect) == tty) {
-		f = redirect;
-		redirect = NULL;
-	}
-	spin_unlock(&redirect_lock);
+	f = tty_release_redirect(tty);
 
 	tty_lock(tty);
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index a99e9b8e4e31..d98319c5d195 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -418,6 +418,7 @@ extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
 extern int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
 extern void tty_ldisc_unlock(struct tty_struct *tty);
+extern struct file *tty_release_redirect(struct tty_struct *tty);
 #else
 static inline void tty_kref_put(struct tty_struct *tty)
 { }
-- 
2.25.1

