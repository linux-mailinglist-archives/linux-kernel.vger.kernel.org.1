Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8A32A6E38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbgKDTiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbgKDTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D147CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:18 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e2so3440779wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTLE3fDx+u6VjTzT6dpTTPCm/8rHPP6boBELCTFmpBg=;
        b=n+SGLyXNvdQU4rjj4mubZsi4hwbLwsTcsnnLwzYDMPIhbwe63+nVO1NWaX3aS6dmUx
         3L/2agKl25gvbYPSbv11aqzMRSZv7UekzcbL2Z9mLOgjzaBviP2JGHkvIB+ENAsZBE24
         p+G+FPrfRxa40tohZRpg7hUd5mVHby44jPtaARISzVZpbjgyuZPQHOBKD5nTwEqQI0Vq
         gwqlnt1aDiKbnT7CSkc1eH3UIV2qVrmFfe3YtZAnDa/D9H5yuzEfaEHhkfLYk5ETcxc0
         3JKmbCti5Dkc3YvISF1bIqsTEKyvNXpzwSmk+IOF2D2nIHjg2/CPkBhUfTe60fEefXKq
         h4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTLE3fDx+u6VjTzT6dpTTPCm/8rHPP6boBELCTFmpBg=;
        b=Z/vuUuYCh0fTdl+NebOjFB+T36jBgUdCxwl4P7UXWbRI7R05PuCAudJlLhII/yXzz7
         zdFmz9SoWHhWbh6sHahPncawTErd269WEeXa8yq/HJp++JIWNst3xofQq+F1XeheAUgR
         nshiqjYV2O+dZ1G6EBL4qdSLg0bz1UWbHpTa/vvx5iRB064PzQ7tO3tqPuLzlGcvFXbK
         ytUjT9CUIBdammF4vEHOXvUHrbpMRisBA7vEOuzWN/Q7zxaVSf1WbyFQDI+dukAdl9tc
         8GSOSRMBTBg1Sei9+K8jmJwdF0eohZFzxaQYtqKxpa1HBBg48z0AuMINDiKuEzHzsXbb
         GOPA==
X-Gm-Message-State: AOAM533EDL2ZnbAwKDTDXmbRfsk4tQGqPnb09KahFEQwGTmrPIFfRMLR
        ElF/TA8AetRNdxVmwLYXUfpoqA==
X-Google-Smtp-Source: ABdhPJwiMgTaKQBz/vW+Q77lWF+7EeqsbsMelVL8C6QvCfsvxmsIndZmwUuB1UXHj60cFSp3ozaydA==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr6115133wmf.47.1604518577576;
        Wed, 04 Nov 2020 11:36:17 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions referenced by pointers
Date:   Wed,  4 Nov 2020 19:35:26 +0000
Message-Id: <20201104193549.4026187-14-lee.jones@linaro.org>
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

 drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
 drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Mike Hudson <Exoray@isys.ca>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b0af13074cd36..ebce4406dc289 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -346,7 +346,7 @@ static const s8 au_io_out_map[8] = {
 	-1,	/* UART_SCR (unmapped) */
 };
 
-unsigned int au_serial_in(struct uart_port *p, int offset)
+static unsigned int au_serial_in(struct uart_port *p, int offset)
 {
 	if (offset >= ARRAY_SIZE(au_io_in_map))
 		return UINT_MAX;
@@ -356,7 +356,7 @@ unsigned int au_serial_in(struct uart_port *p, int offset)
 	return __raw_readl(p->membase + (offset << p->regshift));
 }
 
-void au_serial_out(struct uart_port *p, int offset, int value)
+static void au_serial_out(struct uart_port *p, int offset, int value)
 {
 	if (offset >= ARRAY_SIZE(au_io_out_map))
 		return;
-- 
2.25.1

