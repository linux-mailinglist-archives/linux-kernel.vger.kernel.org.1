Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC82CFC92
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgLES3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgLES3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:01 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE963C02B8ED;
        Sat,  5 Dec 2020 06:20:44 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q22so5815198pfk.12;
        Sat, 05 Dec 2020 06:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AqJwGAguWUPv0d7qoGPEBctmA9oT4E3nRYLjOSxBQec=;
        b=ILWF6QDXXIzn7UDDs5e3eUWql4BWIryXlqM5Vr3Gi3nZSyo6u+YU0PStT3Sb+2cgr7
         FS+uSG+Guf1Z7pNdxJ9ZC8hJDlOan6YU03sTkWrjYoT1RIsAav0M5+8EviIuF6ZxJyLF
         DQbJzxMIxcnkOVcBUKXc8rmvXOj6si7iwtyj2ZBDjjHVEgXMllu2IGlqPXl39/9IxNij
         ikJ3dnPrP3uxn5zJhxhFEOiFV/OnFxcFt8u4DsNFfcAZrjLOT3ap44ZFHKGLj77a9hcR
         u2zJ2epdYBlEd3ZXRUS1IiaHFCG5zOujYzCBPE+mDK5uaA4Fi8cdpLMzkWq7MOcdji+U
         p9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AqJwGAguWUPv0d7qoGPEBctmA9oT4E3nRYLjOSxBQec=;
        b=GWJcLGDO8PVDhcqvYnMfvOXLpSouKW/Z2ksyommMfcfqpaS238Q2IzF31cMeVUXl+p
         O3m0KGxRhA2WDDKdawGMC3Djx4aC0oiTzppXcp0dmdy1mHozDq6IXyXHRirFsRqRTkYv
         t+DmoaNJIM3FvA5FfOhd2F8FtoHRW23C67Y+QiceCEgUNabGuuSQkANHENJr+iVLlJnx
         wWR91xoPguk3h2TntjBzn28kDatu2wpb5nCMJkzVdC/RsNyDne0MMeNdvwwL5xL+2zeC
         bsnGJ8TZIEf59IDnAsTHvqjPHWSktWHvzNI7GYzgn+zpHgFLKf4NYf9bHN+RuWf4W58H
         02wQ==
X-Gm-Message-State: AOAM530wTGqv3pLSWpLsIpbHtlUQjKN4xfZe6x409gsjA6jI2BigWuzJ
        VYfaZzksR6VosgXvjk0N2w0=
X-Google-Smtp-Source: ABdhPJz4x9yM9rQuAipc65Jc3bKF6mgDSrHSQZfhkmzZoUUAM+xm5ZGYbGIed8lT18VQi2I/Zj1ALQ==
X-Received: by 2002:a63:a0b:: with SMTP id 11mr11735991pgk.21.1607178044465;
        Sat, 05 Dec 2020 06:20:44 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:3f6:a1c3:a34c:b902])
        by smtp.gmail.com with ESMTPSA id m4sm9400202pfd.203.2020.12.05.06.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 06:20:44 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 6/8] tty: serial: jsm: Fixed file by added more spacing in line 615
Date:   Sat,  5 Dec 2020 19:50:13 +0530
Message-Id: <7defc00427cc40a3215017461a9e697b7115d22d.1607177807.git.rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1607177807.git.rclemsmith@gmail.com>
References: <cover.1607177807.git.rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        Fixed a coding style issue

        Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 75c9bfa5077c..19d2f0bc6c10 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -612,7 +612,7 @@ void jsm_input(struct jsm_channel *ch)
 				else if (*(ch->ch_equeue + tail + i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_PARITY);
 				else if (*(ch->ch_equeue + tail + i) & UART_LSR_FE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_FRAME);
 				else
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
 			}
-- 
2.27.0

