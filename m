Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F012CB5C2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgLBH1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgLBH1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:27:51 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FC7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:27:11 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e23so532133pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSDc+QPPV7lfS2tRmExN+CIJ3XSmRl5eFiJ/T2O7Tak=;
        b=asAUvAsANEWPxBD23ZxHeGe5DoR2N0uCqrOHL3R535VzMxBl1/yFyD1shutxNGTmco
         v6x7B+vNtrWto/EqHUqgnYAVjM/+5pjJmfBYPe2SkK7iPsOrImsslnKRxQVkE/JdMhpD
         djSelaVJ1k/poWuI4rhW9gBhz/HXHA6m+HQOJttHxpjgqfV+iZeLA/TpsqIPaJDmu9L4
         zp/iiIQCheYmiOsuSDt6GXl2Zo7D88oj/4xmyBURbhPd+4otD+UoHycQD3aoyf5Bf510
         L1UyIKZGOXWYKKnH8scwm5pKYj5wyuxC3tqH+cAEftE/fBNY0TgMPQK++/qHbzJpsUzy
         opOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSDc+QPPV7lfS2tRmExN+CIJ3XSmRl5eFiJ/T2O7Tak=;
        b=b3lzoO/B/5e/c2wIyiUiTQEAlN2o/7XzkYrw/+w7EdUpSeQoDJDK87rZKbiZNGTzBP
         owmnvGoiZrn9ULTsuXpTrWn91JaPFpdhuYfg88Mq7oseEEfDJ2SRrcaABuOOfl5y2pmn
         TP9ii+wS8vP2MaYQlLkJQSYza7S4GmafF5TFkAN6UUEGw1XxlpUWBfMF6PRVZAmG01Rx
         2OIv4TmfGWaZBU6cUw7T4XVP31fggsAXl1b32Byu2Yk4tFpXOw227y0ESrLrN3dnc5TP
         AozAtY3siRlZOHAw9pTa0j0s/ZYsw5s5Ew16pCXMllP0GucUochWmpymtT6VSbX9sz4F
         tKIQ==
X-Gm-Message-State: AOAM532DzRtN62dsRqJLPZMNo3km2aVxt4V3b8tGwQEES16SYjrxUrk1
        V00Sy3QPbqGInu5aC1PKYEI=
X-Google-Smtp-Source: ABdhPJwLxCC6Q/nWKGs/rvIUpwdw8Kza0fD/zvL0Pm6TYKHyb1DBoMIK/S3xFs6NIOGXYBk7Qh9iZA==
X-Received: by 2002:a62:2ec3:0:b029:197:6ca1:2498 with SMTP id u186-20020a622ec30000b02901976ca12498mr1328328pfu.32.1606894030808;
        Tue, 01 Dec 2020 23:27:10 -0800 (PST)
Received: from localhost.localdomain ([103.149.248.50])
        by smtp.gmail.com with ESMTPSA id z9sm905890pji.48.2020.12.01.23.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 23:27:10 -0800 (PST)
From:   jiladahe1997 <jiladahe1997@gmail.com>
X-Google-Original-From: jiladahe1997 <972931182@qq.com>
To:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org, 972931182@qq.com,
        Mingrui Ren <jiladahe1997@gmail.com>
Subject: [PATCH v2] tty/serial/imx: Enable TXEN bit in imx_poll_init().
Date:   Wed,  2 Dec 2020 15:25:43 +0800
Message-Id: <20201202072543.151-1-972931182@qq.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mingrui Ren <jiladahe1997@gmail.com>

As described in Documentation, poll_init() is called by kgdb to initialize
hardware which supports both poll_put_char() and poll_get_char().

It's necessary to enable TXEN bit, otherwise, it will cause hardware fault
and kernel panic when calling imx_poll_put_char().

Generally, if use /dev/ttymxc0 as kgdb console as well as system
console, ttymxc0 is initialized early by system console which does enable
TXEN bit.But when use /dev/ttymxc1 as kgbd console, ttymxc1 is only
initialized by imx_poll_init() cannot enable the TXEN bit, which will
cause kernel panic.

Signed-off-by: Mingrui Ren <jiladahe1997@gmail.com>
---
Changes in v2:
 - Add ' ' around '|' for better code style.
 - Re-create patch on the latest master branch. 

 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index cacf7266a262..a66301b3b33d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1881,7 +1881,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 	ucr1 |= UCR1_UARTEN;
 	ucr1 &= ~(UCR1_TRDYEN | UCR1_RTSDEN | UCR1_RRDYEN);
 
-	ucr2 |= UCR2_RXEN;
+	ucr2 |= UCR2_RXEN | UCR2_TXEN;
 	ucr2 &= ~UCR2_ATEN;
 
 	imx_uart_writel(sport, ucr1, UCR1);
-- 
2.28.0

