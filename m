Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097282B033F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgKLK7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgKLK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:59:04 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2382C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:02 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so5538424wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUApcPFop5u+0n6maG4b1W3j2HASGPuguS8NAypdi9s=;
        b=phBuF/dHNPpDGl+pFhgREEj8PPftj878V4xWXbMdMp3rBH1yvQVZIsJkcmILpkp9fm
         LR8yCWdQZc31Nko3dAL0nXE28+GYTBLFBt3YoBfn+EPnrrnW9nYmpqhdQvVSIzdxneWC
         yuNNrXZmVox+U0HQQiRHvvv7JQDTNA9oP3s9vqgEWuLXvIbqN4+WQ1SNrOEGVrxymViZ
         Y9hS1MpIrGtY7XqgPAekGB7ZpvlKDpIPm1u95fczQ7uDnj/Sd1WgOtGb/y/5m+GaHj5i
         MK8pB4/S2D9qBWtR07xLSFcXuJ+1xOPneCYoLtBHtOVWth8b91u+L0ef/3IurxMUw20Z
         5r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUApcPFop5u+0n6maG4b1W3j2HASGPuguS8NAypdi9s=;
        b=LKfsW4G0hT7NyQN8lhDTbW3bkGANk0nywEYr8brSXWtNix+jNStx6IopRINq5dwwJL
         F4xEsgqsoCZeaQ1iT0BR9znLNOopGF5/FCpv4rWsxEBDxM9B6CaomKgVwNnYMKR3gDgW
         y8FzvFt8xpXkE99xLOZILOBxLmdgel8A0YxFD97HJ8gE5g7fDnbWUJw/6DCRzru8pAHB
         TNx6cQdJfaaHi3bX5u15kK26L1UK5tmiSFVydFN1dF6r81vh8sOPZPj5lbvfaQtwdITz
         zEJam4t5g+s8v0wcKsP3s2aaNUQRaVUDGb45U3q2FRHdDUNOgo/82+kIUylcJSKihXe6
         Vltw==
X-Gm-Message-State: AOAM533fBYiY4PaJdr64wapn7CrGYWbZcgFl09hMApwg8KM3nDeSAv6H
        lhVU4ei+2geuJogeCpHovbdNSCQ6wyEaP3al
X-Google-Smtp-Source: ABdhPJxTb+akJrPdJdvLED5EkCL7Es4Ahn9eyOGtrxemnRGhQJMtIxLaARpMTcitNzR4VJ240sGX3Q==
X-Received: by 2002:adf:f043:: with SMTP id t3mr33569060wro.234.1605178741715;
        Thu, 12 Nov 2020 02:59:01 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id u5sm1167239wro.56.2020.11.12.02.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:59:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 1/4] tty: tty_ldisc: Fix some kernel-doc related misdemeanours
Date:   Thu, 12 Nov 2020 10:58:54 +0000
Message-Id: <20201112105857.2078977-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112105857.2078977-1-lee.jones@linaro.org>
References: <20201112105857.2078977-1-lee.jones@linaro.org>
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
index e813808b27a7f..1ba74d6f5e5cd 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -135,6 +135,7 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 }
 
+static int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
 /**
  *	tty_ldisc_get		-	take a reference to an ldisc
  *	@tty: tty device
@@ -156,8 +157,6 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
  *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
-static int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
-
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 {
 	struct tty_ldisc *ld;
@@ -191,7 +190,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 	return ld;
 }
 
-/**
+/*
  *	tty_ldisc_put		-	release the ldisc
  *
  *	Complement of tty_ldisc_get().
@@ -251,12 +250,12 @@ const struct seq_operations tty_ldiscs_seq_ops = {
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
 
@@ -702,6 +701,7 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 /**
  *	tty_ldisc_hangup		-	hangup ldisc reset
  *	@tty: tty being hung up
+ *	@reinit: whether to re-initialise the tty
  *
  *	Some tty devices reset their termios when they receive a hangup
  *	event. In that situation we must also switch back to N_TTY properly
-- 
2.25.1

