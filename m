Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2C82A6E30
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbgKDThe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbgKDTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:39 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354C5C061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:38 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s9so23306811wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxIwRMD6TNBg9udmxGZqLaXn9yYcY9lwNa4w1OOgomY=;
        b=jOvIce5Y8cX6tbhY9L9KsU+MZChw1k/jcW944Xh2LDWfP2jwxOiW4gq2+Bawg47x9z
         bNE4CHODRlR5URrZecp9S23e5lzUQfpT3inK47e3MR7A9u2JyHP1M5Nu+flMLBMovr4X
         4XuSxNmW2Ig982I82J5WyB5huHaeXoOCGUxU/+C0hOeCouFqYCUOSu7VHvBDKs4Hyycg
         ydDhqoQ9Bav7qws0Xzs9/iSiy3k+R6NSlYZ2rseiR47s64hWEF0pq5Zjd7FLYVnRCdDR
         NHSrZIOa5qvgwc3XTM+5JX8tmYoA3cGjK5D4IcJjYCNa5MRZmHCdUnAD/e4dR4spsuN2
         e3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxIwRMD6TNBg9udmxGZqLaXn9yYcY9lwNa4w1OOgomY=;
        b=pxFsuWgWssQcyyzGZvid0pRTcAP5JlRsq0IzBaqcZal7L9UE51hlisQnOg2oBpQCXg
         l2Sjz+BnT4XQgzCL9HES6cuAffiS8nX/RCPnO8Sf5tFZDchJR5gl5Qu0vZltX+QBNgv3
         fshWbwcXc/27V+cZ3f18K2WFsz4Dt2lqn7knJwLF/+NAomdZ8gzpbDLkR49sPhvkghhW
         HvciaP0+kNLZey77RVT4+PfqIRqpTUYMofSCgL/26hbzt1yiyt6ooVPuea+bvnz754AL
         XQDGKT1StgTyHcChmQWMhsoZV50LeMusyGIacGJAwhz8MsL5gvSQKUQFqvw3T4gep+0N
         mYiw==
X-Gm-Message-State: AOAM531Obv2rBWvGh8lM5pt8uNneIRkNXY2h0KdTVo/kTFk2MzCg1uu6
        1eXna6vg5l9i3rylH0PAEI0q5g==
X-Google-Smtp-Source: ABdhPJxku7Y3Kg5JTrtXlnam3qROwaJDh/c2CuIvjzLZI/zWTYPrraJ+G80GnqYixVTfkfiagatmeA==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr33601906wrq.193.1604518596915;
        Wed, 04 Nov 2020 11:36:36 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 25/36] tty: serial: sifive: Struct headers should start with 'struct <name>'
Date:   Wed,  4 Nov 2020 19:35:38 +0000
Message-Id: <20201104193549.4026187-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also supply a missing member description.

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/sifive.c:157: warning: cannot understand function prototype: 'struct sifive_serial_port '

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/sifive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 13eadcb8aec4e..1066eebe3b28b 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -144,12 +144,13 @@
  */
 
 /**
- * sifive_serial_port - driver-specific data extension to struct uart_port
+ * struct sifive_serial_port - driver-specific data extension to struct uart_port
  * @port: struct uart_port embedded in this struct
  * @dev: struct device *
  * @ier: shadowed copy of the interrupt enable register
  * @clkin_rate: input clock to the UART IP block.
  * @baud_rate: UART serial line rate (e.g., 115200 baud)
+ * @clk: reference to this device's clock
  * @clk_notifier: clock rate change notifier for upstream clock changes
  *
  * Configuration data specific to this SiFive UART.
-- 
2.25.1

