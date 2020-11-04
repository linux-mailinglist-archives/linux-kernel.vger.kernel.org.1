Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4BE2A6E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgKDTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731404AbgKDTgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:32 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34656C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:32 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id y12so23314487wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/gv0SsLI7CnshsO1g6Ee0CY3I2zGh9OhwtyHlvyxPI=;
        b=G6g1v7xnvTEazh/ppcd2E7jvCP9tnex3H3LMRF+WLiV7v1gqyiHTOFHoGlbEghWcLl
         M5Bn/Z403KWlOt57pmj2w0wXo66zrZj1cqd+ahq8abwgEqi7j+5i/2dfLxw++VpKI/Yn
         IiszaeGQ1N+99+Qc8wB7QcRfXvhOzY6Pt8rFbTG34hhUT0aa6Y/kKwHXONYUw+B3dNkd
         phbwSu2SMPbQkI8lwxuZOk9FkQ8KpFStZ9Sm0IrGkPV1I4MzC/2hp6Xp/Fp2sQplHP6l
         aUAaxtYKtbJN0hwUqQJZ02apn7dO8KuluGGFsK8zWngliqyMv+cl4ogsn0b/joa2Q2wt
         1vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/gv0SsLI7CnshsO1g6Ee0CY3I2zGh9OhwtyHlvyxPI=;
        b=mVnVvJJDbXo/lJKwM26VG4tKX/7yotFhGJTByHgQGJe55TdKW5V5mYBcAiScXRSll3
         fa2tXax7XN5fPA8PdfZXDFIBr+u47hHyj4E2JtZD5C/jaIOVSc86pwNmRJhsNFOSmsix
         YOCRCHEt2HCPmtgAEfg4Ye+W4skXzittZbnGhn+HJIjw8+OwklfouQVWy5BaDXdYFdsx
         5mXeQVGHbjb7wlT2Q35k0WhmFNSpG0dNJfj93VXeK6jOqSr7hBxhhH+/p79PF8Fdg8YN
         eF3QoxQeM7SkelIK6YHgYdiIVzVhqBZdzHTrKuH/iDIkEKjGL0XxzAXy1S/wXBhlTVPv
         aB6A==
X-Gm-Message-State: AOAM5317Xn8hPBdlcrGYRiQoS630JBrlh7F9FCs2uM2tkCj3L4EPgrOY
        a3zkym5hfaA4wQUu9/ZlOaFDSA==
X-Google-Smtp-Source: ABdhPJzJvYOB3ZWklk3J/n/mJXGJhAX0H9YEbO+QG9lKvohw7OcHOpD65XMl0ZpyDLrHvlIL8OTU3Q==
X-Received: by 2002:adf:8284:: with SMTP id 4mr9105007wrc.386.1604518590885;
        Wed, 04 Nov 2020 11:36:30 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 22/36] tty: serial: xilinx_uartps: Supply description for missing member 'cts_override'
Date:   Wed,  4 Nov 2020 19:35:35 +0000
Message-Id: <20201104193549.4026187-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/xilinx_uartps.c:205: warning: Function parameter or member 'cts_override' not described in 'cdns_uart'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/xilinx_uartps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a9b1ee27183a7..a14c5d9964739 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -192,6 +192,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @baud:		Current baud rate
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
+ * @cts_override:	Modem control state override
  */
 struct cdns_uart {
 	struct uart_port	*port;
-- 
2.25.1

