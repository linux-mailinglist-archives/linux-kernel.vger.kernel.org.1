Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCB02A6E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbgKDTiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730732AbgKDTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:17 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D6C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:17 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so3513468wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=katXXgbC22ODZfPs0yu/NB9YKF0+fIlHhM8PNjiXbaw=;
        b=ADBr7XsI+rLmJxONxXWP/C+4inBPw3Is+FoBw9d9AWLtKwlJdr0zEAzVoh66YGH/wF
         5B2liX/UxYxgJwYwWScA0z7+lpdewFvxTl0st+YjUhXA0eAbZtn2tC4BazKqjXt3t3i/
         fPtYiaSlRcqFncpka5baMhqiAhTlvyhKMoLhsGorCD4pbL/nfYrev+Fkgg0uG01JDaRJ
         2bRkmyefJ1mJV5nTZiV4nCA1I2+NLK3XKWD6e4JHhER10QDLxz6S/AoyCnX4Aezb/TU8
         J0WLxSXD18tTZL7zVSlpi2GScG2JZ8TJorwZid3FFYDXpG+hcE7cFRyCvH0ilTKIGOlN
         7Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=katXXgbC22ODZfPs0yu/NB9YKF0+fIlHhM8PNjiXbaw=;
        b=LxU8sX+6IGyhhrNllAHLgFSOErMycyyGLSOcw0IaAXjVhTegP8p8UXOHGdIq89elIl
         K/Bm+34HQzTAuvNGVdqXt6Qva7J6K+9NnSUWcskDkALfP3LRpnXszTdkCTQSUPhyIWhS
         S0TbHw4G8m4DO+ONFH+DlbISowe0/BdkaDz4YB6uJX2ltW+vcSe/ZIRQDNSdGWH7KJnV
         4ch2EO2K/prjXJEdP2PxLZG4l76inroKhSdSnnP8QTZ54AygQ7xnj9tjgSvOwAUxGfXf
         UFORWPcSgOc5C2muP3Ww2ukteoDWWUPq8CAatrKovZxbxTcFXA3rEAJVtviBjMhmqLqA
         xrsg==
X-Gm-Message-State: AOAM533wUQxJtdDHSAQDrP6iiZG+i6+Av/f6dt1kXXGe3UfRsQd8OSA0
        yWbAr9R5BSukAh+08SCNDnm8jA==
X-Google-Smtp-Source: ABdhPJxbqsYr/rsHwRJ9WYE5tORJjbkzD1Vfhl84AyHSo3UGP7oGs7NpCpxqETxqUxvGaS2zZ3Vr+g==
X-Received: by 2002:a1c:a90e:: with SMTP id s14mr6475369wme.46.1604518576270;
        Wed, 04 Nov 2020 11:36:16 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:15 -0800 (PST)
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
Subject: [PATCH 12/36] tty: tty_io: Fix some kernel-doc issues
Date:   Wed,  4 Nov 2020 19:35:25 +0000
Message-Id: <20201104193549.4026187-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote non-conformant headers and supply some missing descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_io.c:218: warning: Function parameter or member 'file' not described in 'tty_free_file'
 drivers/tty/tty_io.c:566: warning: Function parameter or member 'exit_session' not described in '__tty_hangup'
 drivers/tty/tty_io.c:1077: warning: Function parameter or member 'tty' not described in 'tty_send_xchar'
 drivers/tty/tty_io.c:1077: warning: Function parameter or member 'ch' not described in 'tty_send_xchar'
 drivers/tty/tty_io.c:1155: warning: Function parameter or member 'file' not described in 'tty_driver_lookup_tty'
 drivers/tty/tty_io.c:1508: warning: Function parameter or member 'tty' not described in 'release_tty'
 drivers/tty/tty_io.c:1508: warning: Function parameter or member 'idx' not described in 'release_tty'
 drivers/tty/tty_io.c:2973: warning: Function parameter or member 'driver' not described in 'alloc_tty_struct'
 drivers/tty/tty_io.c:2973: warning: Function parameter or member 'idx' not described in 'alloc_tty_struct'

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
 drivers/tty/tty_io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 88b00c47b606e..f50286fb080da 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -208,7 +208,7 @@ void tty_add_file(struct tty_struct *tty, struct file *file)
 	spin_unlock(&tty->files_lock);
 }
 
-/**
+/*
  * tty_free_file - free file->private_data
  *
  * This shall be used only for fail path handling when tty_add_file was not
@@ -543,6 +543,7 @@ EXPORT_SYMBOL_GPL(tty_wakeup);
 /**
  *	__tty_hangup		-	actual handler for hangup events
  *	@tty: tty device
+ *	@exit_session: if non-zero, signal all foreground group processes
  *
  *	This can be called by a "kworker" kernel thread.  That is process
  *	synchronous but doesn't hold any locks, so we need to make sure we
@@ -1065,7 +1066,7 @@ ssize_t redirected_tty_write(struct file *file, const char __user *buf,
 	return tty_write(file, buf, count, ppos);
 }
 
-/**
+/*
  *	tty_send_xchar	-	send priority character
  *
  *	Send a high priority character to the tty even if stopped
@@ -1143,6 +1144,7 @@ static ssize_t tty_line_name(struct tty_driver *driver, int index, char *p)
 /**
  *	tty_driver_lookup_tty() - find an existing tty, if any
  *	@driver: the driver for the tty
+ *	@file:   file object
  *	@idx:	 the minor number
  *
  *	Return the tty, if found. If not found, return NULL or ERR_PTR() if the
@@ -1494,6 +1496,8 @@ EXPORT_SYMBOL(tty_kref_put);
 
 /**
  *	release_tty		-	release tty structure memory
+ *	@tty: tty device release
+ *	@idx: index of the tty device release
  *
  *	Release both @tty and a possible linked partner (think pty pair),
  *	and decrement the refcount of the backing module.
@@ -2961,7 +2965,7 @@ static struct device *tty_get_device(struct tty_struct *tty)
 }
 
 
-/**
+/*
  *	alloc_tty_struct
  *
  *	This subroutine allocates and initializes a tty structure.
-- 
2.25.1

