Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08352A6E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgKDTgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbgKDTgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:21 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95867C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:21 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n18so23308949wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhU22JczQino14ZA+id37bJ/59O6+RdFCVhQrLQp+wk=;
        b=D35ewuq/Qbi7sYEztIn4Ctzx+DaErHti8eftbXB097nkyeK2LkXtTOQFozuIPZFA80
         bDx4kbeFGjmgRYeOr6hj0As2ocDZrGHgeL9gc0m6K4HO5PVVLHlhE7lkU3uNrRr6s1bf
         7FaeBo/j/EfbhhnTr2+RocdFOO+utd09W8JkGK6nMvBiC4tVSxmxvZH1m3mjhdO0nKgr
         LrJdqNgZ946PMhmhA9zStUXTZeJCsNjLkzVFleiqJY4KVKaEDrZeerh0kFs1CUsWX0Zu
         Vdf6JltdqVRBA/xG3P/87y9do/UBja5qYXPRZZpckcf/nksGA7+weXwdknb3ZjwtpnkP
         CwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhU22JczQino14ZA+id37bJ/59O6+RdFCVhQrLQp+wk=;
        b=nKz7OLMNPc1XSdVNz7eCdjk4j1d9f1WP+BeM9eAwJUaGznVIki/Yb17xNP/k04IOcn
         qPXHOZjaExCC3idj4S72QDfnelHzgLcyeSLiQ1rODg4leZ1rIyzEheAVsl0Fz3hg3XGu
         Ftu0QyOOb7tS46uRFlDqzKhvLA4A/8EVnp2+k0u1VqkxqPXWlZ8GuRQ8Nt/GHXE4O1te
         KSHlkQ2mDJL4K/QEqja6m0bgF8/77LxOampUFe2/t9kxz993nuguFe5VJtTX0Xwsf44T
         qfc+Bs3qr75L3KaZRprQl4GMtC/Tk8aTT0YfpF9Er2q8R0UEg7rPMWRghRwFEDP5MvIC
         RNSg==
X-Gm-Message-State: AOAM532PbD3xCCCRrlCTDsnhLxJYMZeEG2xOkPiyOFB9Nc7/mje89XQa
        EkD+O4X5KnFFlS/B4Q85vUjq5A==
X-Google-Smtp-Source: ABdhPJzOaKE/TkHo93XH0EvyYjfVAMLIXwp4e5NqwkQ0Ooo27W5FhhA25IDY46CnKkUuGv+Ibtc2cg==
X-Received: by 2002:a5d:4b12:: with SMTP id v18mr33516344wrq.259.1604518580309;
        Wed, 04 Nov 2020 11:36:20 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miloslav Trmac <mitr@redhat.com>
Subject: [PATCH 15/36] tty: tty_audit: Demote non-conformant kernel-doc headers
Date:   Wed,  4 Nov 2020 19:35:28 +0000
Message-Id: <20201104193549.4026187-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_audit.c:91: warning: Function parameter or member 'buf' not described in 'tty_audit_buf_push'
 drivers/tty/tty_audit.c:129: warning: Function parameter or member 'sig' not described in 'tty_audit_fork'
 drivers/tty/tty_audit.c:137: warning: Function parameter or member 'tty' not described in 'tty_audit_tiocsti'
 drivers/tty/tty_audit.c:137: warning: Function parameter or member 'ch' not described in 'tty_audit_tiocsti'
 drivers/tty/tty_audit.c:202: warning: Function parameter or member 'tty' not described in 'tty_audit_add_data'
 drivers/tty/tty_audit.c:202: warning: Function parameter or member 'data' not described in 'tty_audit_add_data'
 drivers/tty/tty_audit.c:202: warning: Function parameter or member 'size' not described in 'tty_audit_add_data'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Miloslav Trmac <mitr@redhat.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_audit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 9f906a5b8e810..32898aabcd068 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -81,7 +81,7 @@ static void tty_audit_log(const char *description, dev_t dev,
 	}
 }
 
-/**
+/*
  *	tty_audit_buf_push	-	Push buffered data out
  *
  *	Generate an audit message from the contents of @buf, which is owned by
@@ -120,7 +120,7 @@ void tty_audit_exit(void)
 	tty_audit_buf_free(buf);
 }
 
-/**
+/*
  *	tty_audit_fork	-	Copy TTY audit state for a new task
  *
  *	Set up TTY audit state in @sig from current.  @sig needs no locking.
@@ -130,7 +130,7 @@ void tty_audit_fork(struct signal_struct *sig)
 	sig->audit_tty = current->signal->audit_tty;
 }
 
-/**
+/*
  *	tty_audit_tiocsti	-	Log TIOCSTI
  */
 void tty_audit_tiocsti(struct tty_struct *tty, char ch)
@@ -145,7 +145,7 @@ void tty_audit_tiocsti(struct tty_struct *tty, char ch)
 		tty_audit_log("ioctl=TIOCSTI", dev, &ch, 1);
 }
 
-/**
+/*
  *	tty_audit_push	-	Flush current's pending audit data
  *
  *	Returns 0 if success, -EPERM if tty audit is disabled
@@ -166,7 +166,7 @@ int tty_audit_push(void)
 	return 0;
 }
 
-/**
+/*
  *	tty_audit_buf_get	-	Get an audit buffer.
  *
  *	Get an audit buffer, allocate it if necessary.  Return %NULL
@@ -193,7 +193,7 @@ static struct tty_audit_buf *tty_audit_buf_get(void)
 	return tty_audit_buf_ref();
 }
 
-/**
+/*
  *	tty_audit_add_data	-	Add data for TTY auditing.
  *
  *	Audit @data of @size from @tty, if necessary.
-- 
2.25.1

