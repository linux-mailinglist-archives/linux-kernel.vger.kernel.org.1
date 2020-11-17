Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C22B56B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 03:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgKQCVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgKQCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:21:14 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F1BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 18:21:13 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b63so12429207pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 18:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yGSDQjpXv66NzFG82tzHCYWvk54iQgDPCT1QGnHmEWw=;
        b=tEsk1CLy+1h6wiCqGlKVh2DxP6IPr01lePn8AHamNhItisuv8UKOjF3aIWA/VVb4H5
         solfkFtThn03/KtSnlU14LWexHfhYF5m29AzT+flvmKqD4ETJMyEqcLvyJystjshpKK4
         6GWOmwJ0GnBTKe8ljLUs0YaFfCBvnFJvuAb7+e0SohqlwPt0johD6SvNJJ7pzqx1zt+s
         ODSBNIGC9/vsMJ1bevimRr+kl0O0tUQpsFGVpL0OrD0Rts8AkB330nFNASnHHOXlwZJL
         KfTi5kqv+xxiw1IB8FH8M4D+g2J5IWThlgndvohz9xJGtB8dPsPo0c8Jck9hSMABB6Qq
         LYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yGSDQjpXv66NzFG82tzHCYWvk54iQgDPCT1QGnHmEWw=;
        b=e4rJBdFFJChpCrnQ2wRGEfOsJB7mo52hgJYJNzA+dv/q2Uwvu7ZArWflC+/v3FaG1b
         JE95dh+70Xvr74N4iKigus24ho42Aj+Ox//1X/spTMLXllllrLonFfwnXUFF2FBffTaB
         QiEn35G3pXYbWDXBlc+xAig5KqsTumwDSqL0J8RigAJsNn5GJUOReNbC9NdINN3krndF
         qMoQRXdFnYwXvagNePgr2PlKtGXhTQMSvKcpjsS0zfUNP3a2xxjskH43eybLDtWb2HWL
         9//EkJFzowfF0gI0HNFYvq/eNVVwd8kLrsvTPppjOoLrfxwVL2saff1vul7Yx5kQCZUb
         zGig==
X-Gm-Message-State: AOAM533hQjm7oI/EvaVTURE8li7nA2Ka8b8T9krc6e+Mes+Hpasn3w+U
        wuKGmV1YlqdiswCuqAwjbOLSAVx1UhwWDgR4
X-Google-Smtp-Source: ABdhPJzgZ1nkSll9RCISlfIc52NuSqbR8MOcQCschyYkE5SPXwrf/26HYTyGGsEZ7YBQnPgk/6wKVg==
X-Received: by 2002:a17:90a:bd14:: with SMTP id y20mr2050955pjr.107.1605579673101;
        Mon, 16 Nov 2020 18:21:13 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id m20sm18646955pfk.31.2020.11.16.18.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 18:21:12 -0800 (PST)
From:   Junyong Sun <sunjy516@gmail.com>
X-Google-Original-From: Junyong Sun <sunjunyong@xiaomi.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, sunjunyong@xiaomi.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] ttyprintk: optimize tpk_close flush code
Date:   Tue, 17 Nov 2020 10:21:07 +0800
Message-Id: <1605579667-16573-1-git-send-email-sunjunyong@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tpk_printk(NULL,0) do nothing but call tpk_flush to
flush buffer, so why don't use tpk_flush diretcly?
this is a small optimization.

Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
---
changes in v2:
- rm the flush comment as tpk_flush makes it obvious.
---
---
 drivers/char/ttyprintk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 6a0059e..1f82742 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -103,8 +103,7 @@ static void tpk_close(struct tty_struct *tty, struct file *filp)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tpkp->spinlock, flags);
-	/* flush tpk_printk buffer */
-	tpk_printk(NULL, 0);
+	tpk_flush();
 	spin_unlock_irqrestore(&tpkp->spinlock, flags);
 
 	tty_port_close(&tpkp->port, tty, filp);
-- 
2.7.4

