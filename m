Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7462F2A6E08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKDTgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730007AbgKDTgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:04 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891EDC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:04 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so3502089wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/N5VekjPLPM7Pui3+xXrSTk4dOhYGb1u8++CWcrEhY=;
        b=FkvcpHtJfzpI9+RIGA8bPkaDdhc67Xtb61R2JVEO8of1HO4qPBcTKaAKKorz11QQoz
         IAIBDDbeNWtWWkrQfFZcfUxMtDlu0o4saZGjyi6Vq9+dahRM75XVLegwPzZIwFfMM73P
         cEhgTNMn8Nv/8XhqHEW+gQi745pq7Des/2oKhOtX5qOvtKogT2H6hZZbeF3AYnI9tEGP
         AW5W8x2/thUP9NP5q1GqJx3prtZy1DTdHNkyj3Bx6XiHb55WR5b1hA70LwRqIsGB3GJh
         uIxdZSpJItdgoSA8mMGigNy54r9eoZhs/SUGyrFKxAFc6iIh9JVNlizrhxeqS0HXU+gY
         MzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/N5VekjPLPM7Pui3+xXrSTk4dOhYGb1u8++CWcrEhY=;
        b=dkHiz8BEP8Tb7XXAFxlduv0fS87KHN+aRMCUeguSBl/7DCV4hFN/9YOoKzE+YjJIeP
         Bxz3PeYr9yHh8Om/xsismL8Xoh7uCO7CVPiekyIlkS/u9I6mb0jdsOP5bOi59STd39Sb
         LdUYzzEpjpFF9wpBydvB/WszW7F4GdKdPC9CkFPQnlqJpigdsm1xCSVbGmxfQ/pzzQ+z
         ppzasMWO0G8ja5PsbDYN8kZvdkaQ/E6DNplebPvxQ+u8qFKnx2ec37Rwz8lWczhtQdX9
         W1IpPdrb56FCDaWuCpMJ4pscIbiSq5fZlIyWP+Q4/P2Zd/mZ8wobVABxhBTKywGBxvuN
         BlxQ==
X-Gm-Message-State: AOAM5313SDcjpQ5UabSRLf2NkPpin0210sdJcnPn1+adtymQDl6mEtHM
        ScBEY6Wqu2knDYPfVfF6CEV4tQ==
X-Google-Smtp-Source: ABdhPJw5/urW81j/lbvQbRCCGtteebvxAcHyJgc78ueE+MXuPgh+COazs5ioEj7u63QDxZleIMBjUA==
X-Received: by 2002:a7b:c00a:: with SMTP id c10mr6196237wmb.119.1604518563203;
        Wed, 04 Nov 2020 11:36:03 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nick Holloway <alfie@dcs.warwick.ac.uk>,
        -- <julian@uhunix.uhcc.hawaii.edu>,
        Marko Kohtala <Marko.Kohtala@hut.fi>,
        Bill Hawes <whawes@star.net>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Russell King <rmk@arm.linux.org.uk>,
        Andrew Morton <andrewm@uow.edu.eu>
Subject: [PATCH 04/36] tty: tty_io: Move 'tty_sysctl_init's prototype to shared space
Date:   Wed,  4 Nov 2020 19:35:17 +0000
Message-Id: <20201104193549.4026187-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_ldisc.c:883:6: warning: no previous prototype for ‘tty_sysctl_init’ [-Wmissing-prototypes]
 883 | void tty_sysctl_init(void)
 | ^~~~~~~~~~~~~~~

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Nick Holloway <alfie@dcs.warwick.ac.uk>
Cc: -- <julian@uhunix.uhcc.hawaii.edu>
Cc: Marko Kohtala <Marko.Kohtala@hut.fi>
Cc: Bill Hawes <whawes@star.net>
Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <andrewm@uow.edu.eu>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_io.c | 2 --
 include/linux/tty.h  | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7a4c02548fb3f..88b00c47b606e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -514,8 +514,6 @@ static const struct file_operations hung_up_tty_fops = {
 static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
-extern void tty_sysctl_init(void);
-
 /**
  *	tty_wakeup	-	request more data
  *	@tty: terminal
diff --git a/include/linux/tty.h b/include/linux/tty.h
index a99e9b8e4e316..10212c6e4345e 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -716,6 +716,7 @@ extern int __must_check tty_ldisc_init(struct tty_struct *tty);
 extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 char *f, int count);
+extern void tty_sysctl_init(void);
 
 /* n_tty.c */
 extern void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
-- 
2.25.1

