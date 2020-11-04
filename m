Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20C82A6E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbgKDTiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbgKDTgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:08 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8D7C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:08 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so881080wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cP6gn0LDCQPJHzeLMxs972tJjWIPZ5XjoCR2y/E3I/4=;
        b=h4w3aaxJdHfpX2I/6UOVuKIP3iM6j5GzVY6zFbd5IpfnRhTwaXdOund23baMzf5lj2
         Y250Omyl5MmrzDNaPM+hoJAGCGipjD5qUt05GlaI94Yd+0H4Ws7HFY/wI220f2Vp75fR
         XqfpA/ISv4omLC6a/MhqD26FExuII7a0LKDLsFS/y6RVoZYlctyLE6iaxQGeZxX88UUx
         XzUgjHZNTn/16R2n+2XF5CV7xfA9ETtwbTO2WGHt41D/c0XF98MAsAuYRgihsoe3820u
         NwqFWTJWx5tRD3PrBbOXbYyO27DxQ/I7AR5cPfkF2n3s1jZ729zpx2fHTAwGYlLKh1OM
         rb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cP6gn0LDCQPJHzeLMxs972tJjWIPZ5XjoCR2y/E3I/4=;
        b=VyVXd6ZUEPFcy3cEWwomEZToCUAfYL2jKkcFt78xFkTEdN3bZaZQRFTzd9VoO0dRxX
         EQy16BZyCtDwp5H4j9il8deQrvcBW9NNvNpODWbKaQN+i7NwGT/dMa0FN3SKvozgNTG1
         Oo1jfXFy870lHzH+hFUh6LoBPQS7IKqagm7epH+MOwBRzVi59IYhvV4PT+KsnKVHsQYx
         df8PjNpTTo96F8cviqbW+gBi3ajII/bCbTEc0g8gDpGsHDL4ps1CspQYSXu+RylJzZoc
         fq2dxPinp3/I4uLWs9yxna+jGuq/y4EIcAF/FQ+SaAjr3M5mb03W3oBM/2VhMwg/fSfH
         uQww==
X-Gm-Message-State: AOAM531TMRyGSo9RrpBSw8dDzsbMBXl6fUsk34p7bpI3zQ+LrSZv4797
        KDRt+zsbAhPw7wcyATTo4/KkIA==
X-Google-Smtp-Source: ABdhPJxamDD1QQrV+7pKMxzDVHSJ2wmFg/iOMVeBQNTrFqV0Kjor0XrvoIB99DO9Z5gw2NfFVnGivw==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr4742363wmh.106.1604518567258;
        Wed, 04 Nov 2020 11:36:07 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 06/36] tty: tty_port: Demote obvious abuse of kernel-doc formatting
Date:   Wed,  4 Nov 2020 19:35:19 +0000
Message-Id: <20201104193549.4026187-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_port.c:633: warning: Function parameter or member 'port' not described in 'tty_port_close'
 drivers/tty/tty_port.c:633: warning: Function parameter or member 'tty' not described in 'tty_port_close'
 drivers/tty/tty_port.c:633: warning: Function parameter or member 'filp' not described in 'tty_port_close'
 drivers/tty/tty_port.c:672: warning: Function parameter or member 'port' not described in 'tty_port_open'
 drivers/tty/tty_port.c:672: warning: Function parameter or member 'tty' not described in 'tty_port_open'
 drivers/tty/tty_port.c:672: warning: Function parameter or member 'filp' not described in 'tty_port_open'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index ea80bf872f543..346d20f4a4862 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -623,7 +623,7 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 }
 EXPORT_SYMBOL(tty_port_close_end);
 
-/**
+/*
  * tty_port_close
  *
  * Caller holds tty lock
@@ -659,7 +659,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
 }
 EXPORT_SYMBOL_GPL(tty_port_install);
 
-/**
+/*
  * tty_port_open
  *
  * Caller holds tty lock.
-- 
2.25.1

