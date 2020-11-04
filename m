Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B560F2A6E36
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgKDTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731018AbgKDTg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75683C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:24 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e2so3440994wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCthp+iIayFdO+hk3LjcuMh49TMSV9TDkGCxD2U2U74=;
        b=tdLzplErGzlsTMvA24FKwL+xCV7IDZGYkhg0Ou03OOiOpukQUndtoqdN4Btssu+uh5
         pHqlPj6YXHeaWY3svCwI+7BVuZnpLg9kcBdM3/i04heoyrJMQNzzUhmNBeh8Yx1aNXF9
         zfq84NfJovwoP6B0NFVL4tsiXIWzvB3qmeFTQP1QCxQ/Jsk/MR9hKniaUp9Hnjz3XE88
         pvWufpKWRjTPPVPfazBFWwYRfO50piv+Fff8KFd1J6zfTrJfwY9nT65ktGWC6K+/eWMX
         NMTU5EATHwcZAsh3okG6nCEDbMWxSQN4ts5Y5s9aEIz0sXJZ8GY2v+CtagQdWeVvYYyH
         ce5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCthp+iIayFdO+hk3LjcuMh49TMSV9TDkGCxD2U2U74=;
        b=ZLvXXYeEfgC2/AEm2cCFDBlrJ1e3QwliKDc5FDBfKEo6eWtuUl9RWfadzko6bYAD8C
         SvWj5VkLMpdESVGo1w8twaOdwAHsURC8DUsSCReDNpX/B5whBGfFOCpXkf1X/GAbdHN6
         ta8KR34GuUm4MERD2OgaSzeaZ94uAXJW/+TKDPr5mXStsxuoTw3PHljcjqLXw695hZyl
         M36sJ3mg9JBeVmka3Z9Cc4yfE/xFKP7haa3Kdh7avhoXcjTfTAoL0O/iNKj1EO24Xwax
         H1CKAJnBMkX86VwGsI7F67VQ9AAcDNt3/XLgowGCFrSnma9+58BdzM7rEiWjneY96lX2
         lZYg==
X-Gm-Message-State: AOAM5329j4+QcwKrrRkqVT8qIO7k2toDDu9kFekIW8AP2JwlTLsDsufJ
        orrJG28Ur5pPk/H5BoUS5dHKfg==
X-Google-Smtp-Source: ABdhPJxDQR/qW6NmTWHEpSz51ngDxQ9A5uFFVjpceis1t/O+rnkxd10E6YYGgu5C0ahzzXDmBT9mmg==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr6582229wmi.78.1604518583103;
        Wed, 04 Nov 2020 11:36:23 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 17/36] tty: serial: amba-pl011: Mark 'sbsa_uart_acpi_match' as __maybe_unused
Date:   Wed,  4 Nov 2020 19:35:30 +0000
Message-Id: <20201104193549.4026187-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When !ACPI 'sbsa_uart_acpi_match' is not referenced.

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/amba-pl011.c:2792:36: warning: ‘sbsa_uart_acpi_match’ defined but not used [-Wunused-const-variable=]

Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 87dc3fc15694a..c255476cce287 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2789,7 +2789,7 @@ static const struct of_device_id sbsa_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
 
-static const struct acpi_device_id sbsa_uart_acpi_match[] = {
+static const struct acpi_device_id __maybe_unused sbsa_uart_acpi_match[] = {
 	{ "ARMH0011", 0 },
 	{},
 };
-- 
2.25.1

