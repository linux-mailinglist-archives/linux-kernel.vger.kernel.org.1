Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32C2B0345
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKLLBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgKLK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:59:04 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016F0C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:04 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so5538475wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MHJyDo+dkqaA5w+YXjlvk3XVBhsjDZYqsJp3LUhS8A=;
        b=KQSSQ3IxHes0Saggsokj8bCjKruLsA4X//7w68uYX/6pFvJ7su4wLIpBC3gFdlWQjN
         1j1Vlo/8+Ll859yHWvPEiVEctu0EqX0rCxdYRqgbWObpqeOIIf/aF5wMW0hH3a6eYOxc
         SS+k7VN8rM17sSJcS5+p3h30MXt/llycgXhBKQS8OwhZFaG2mfeEktgMbW9lC9EH3/9i
         Jfy33Gdj60/fpKdjmDAYa9MEU1WEk0S7/pMiwWhVScqgSu71Xq65pnmFEyXUugGS/vsK
         nZpFJj9gXEytzLZvzlxxwNvlpRksEoQQ3EEwKjSYl5PYIQlw7k4pfPydJcCDxEY8+hPv
         Mnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MHJyDo+dkqaA5w+YXjlvk3XVBhsjDZYqsJp3LUhS8A=;
        b=lLV9T7XD9cd+cHPrjxVtrodI70grruFS98XsPE7+Kcjh/p9mbH3YHMp8YgTBUmdJsD
         SBUHZwFKGPqSiRtNeCbGkaWyucZppBNmlLuEtM33VcDF/St6TBz6zx/OUqF0oMnZHP0r
         SPJUzqDWxNjvTZ8+FWb0ik4quyo0zYI6ev+joKr16RJ17Omhf9uGFHgY9k1GRf25Eymc
         9bFY610WEHueRMl+XQUtMsRJa+Zu3G94PdoAAwq6pa0k9Mf+fgoKjypXlO5j/PEMoKUa
         yqmbf3bsxClXUGfDIeln02dzAvUsLDmK0PALtNq7fKCfegZ5dUFskLmkT/KHQq4vaCc5
         odmg==
X-Gm-Message-State: AOAM531okHa1Ls3MPHHRTIxCP7qJgmI8Wa+JuHLlv39nZJJ2LPpS4jnR
        8dQs2WBv4pZ9T728zij29LobgTVBm2gFeHxB
X-Google-Smtp-Source: ABdhPJwwp6fZgnD5WnZ4ggvhKpwkhreu99lahIMHKVI/z9H4g1sYnkNE9N5zRdF5bT5/XsAWdU59Mg==
X-Received: by 2002:adf:f04b:: with SMTP id t11mr7092763wro.147.1605178742777;
        Thu, 12 Nov 2020 02:59:02 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id u5sm1167239wro.56.2020.11.12.02.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:59:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: [PATCH v2 2/4] tty: serial: 8250: 8250_port: Move prototypes to shared location
Date:   Thu, 12 Nov 2020 10:58:55 +0000
Message-Id: <20201112105857.2078977-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112105857.2078977-1-lee.jones@linaro.org>
References: <20201112105857.2078977-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
 drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Mike Hudson <Exoray@isys.ca>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/8250/8250_early.c | 3 ---
 include/linux/serial_8250.h          | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 70d7826788f53..c171ce6db6910 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -204,9 +204,6 @@ OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
 
 #ifdef CONFIG_SERIAL_8250_RT288X
 
-unsigned int au_serial_in(struct uart_port *p, int offset);
-void au_serial_out(struct uart_port *p, int offset, int value);
-
 static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
 {
 	dev->port.serial_in = au_serial_in;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 2b70f736b091d..9e655055112d9 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -187,4 +187,9 @@ extern void serial8250_set_isa_configurator(void (*v)
 					(int port, struct uart_port *up,
 						u32 *capabilities));
 
+#ifdef CONFIG_SERIAL_8250_RT288X
+unsigned int au_serial_in(struct uart_port *p, int offset);
+void au_serial_out(struct uart_port *p, int offset, int value);
+#endif
+
 #endif
-- 
2.25.1

