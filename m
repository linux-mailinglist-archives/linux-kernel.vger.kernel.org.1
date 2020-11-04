Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4532A6E0A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgKDTgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgKDTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:12 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F3FC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:12 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id n18so23308571wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjBxGFjQOACKcEPH71GqcBHfM0FSXHr4VPO3b9djiEU=;
        b=rV/SPypZHb9//eJSr8Tjv610oy3JEwpGgWOP6Lt+65kRrYKtWcfAa4IpYUHwDrfwJ0
         7gUxWdi/g7LLKEJrLpvSye5yu3crV5eqDg+HJm6SZfkSBmQdzIckhKJ95ufpPNlbSe0p
         BZelrdz9aSmHUQUmn5YSiZGbcKKlAJ2jJ+Ad8Jr+IKfJjSAPy0Lg/cKOaa5Fk0yUhpFW
         Oh+6cgudeQ+t+VkecEgkLAMQ91TaFTUnaUhKmTcAz9y6LwW+q4SFmarHMJECy1Flg0I2
         FPe4Hl5oZSWhaQl4AXQopwu4WPbRjl6DJU39WhCwo1WB3Gb21qzs8a3GLJqzYWFEcg7+
         zrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjBxGFjQOACKcEPH71GqcBHfM0FSXHr4VPO3b9djiEU=;
        b=dd14WwJJ8yUqz94LW9z4rwY2rs3xGw2HYii472p63nA3VWrtz7ETs9rrgj3CuI9aHa
         KBtkwMN2qC7u0Lms6lEHX+IymYeBgJf7hHNPfZptIMLR4VZbUgrf82iJzgZ1rDaMpNeX
         E7haWCl/1BGwyxl5W5ar3O8EylNE9HPgJ4XjFifWFlAe0MXpOFjh9AlyFsZPYTPVtsuV
         pwYlO4eJ+1w2ETW0/QfFVaO83kF0lLYykPWCj0coe1auzb5ZnytYJaU9NTpJrft7Ken2
         HdB7slEvtyFsYYmXugIy/ViZiMt/34f1Ogcf10VmtFByOL9PqtcESUH1OI41T3cnF/VK
         mM/A==
X-Gm-Message-State: AOAM533YHscryFT7cIDN3ZYjRJqHtldQlGH7Rx1taTQSNCNADINuTuWS
        abwnDSqNPNiemMGyq7pfWwM0Zum6wu5dyjbQ
X-Google-Smtp-Source: ABdhPJyEGj6iuDEjo9diFKAvSOXtZ68ik2y5ve+fEOipOrF2xgWPU+sVXuSjxmd78dbJzBmDMzquxA==
X-Received: by 2002:adf:a29e:: with SMTP id s30mr36335757wra.29.1604518570841;
        Wed, 04 Nov 2020 11:36:10 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 08/36] tty: tty_ldisc: Fix some kernel-doc related misdemeanours
Date:   Wed,  4 Nov 2020 19:35:21 +0000
Message-Id: <20201104193549.4026187-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Functions must follow directly on from their headers
 - Demote non-conforming kernel-doc header
 - Ensure notes have unique section names
 - Provide missing description for 'reinit'

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_ldisc.c:158: warning: cannot understand function prototype: 'int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD); '
 drivers/tty/tty_ldisc.c:199: warning: Function parameter or member 'ld' not described in 'tty_ldisc_put'
 drivers/tty/tty_ldisc.c:260: warning: duplicate section name 'Note'
 drivers/tty/tty_ldisc.c:717: warning: Function parameter or member 'reinit' not described in 'tty_ldisc_hangup'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_ldisc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index fe37ec331289b..aced2bf6173be 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -135,6 +135,7 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 }
 
+static int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
 /**
  *	tty_ldisc_get		-	take a reference to an ldisc
  *	@disc: ldisc number
@@ -155,8 +156,6 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
  *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
-static int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
-
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 {
 	struct tty_ldisc *ld;
@@ -190,7 +189,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 	return ld;
 }
 
-/**
+/*
  *	tty_ldisc_put		-	release the ldisc
  *
  *	Complement of tty_ldisc_get().
@@ -250,12 +249,12 @@ const struct seq_operations tty_ldiscs_seq_ops = {
  *	Returns: NULL if the tty has been hungup and not re-opened with
  *		 a new file descriptor, otherwise valid ldisc reference
  *
- *	Note: Must not be called from an IRQ/timer context. The caller
+ *	Note 1: Must not be called from an IRQ/timer context. The caller
  *	must also be careful not to hold other locks that will deadlock
  *	against a discipline change, such as an existing ldisc reference
  *	(which we check for)
  *
- *	Note: a file_operations routine (read/poll/write) should use this
+ *	Note 2: a file_operations routine (read/poll/write) should use this
  *	function to wait for any ldisc lifetime events to finish.
  */
 
@@ -701,6 +700,7 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 /**
  *	tty_ldisc_hangup		-	hangup ldisc reset
  *	@tty: tty being hung up
+ *	@reinit: whether to re-initialise the tty
  *
  *	Some tty devices reset their termios when they receive a hangup
  *	event. In that situation we must also switch back to N_TTY properly
-- 
2.25.1

