Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755102CA686
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391609AbgLAPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbgLAPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:06:07 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A82AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:05:27 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so1301924pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eU7j8BPKnWBddO7CUJ6gQsdoCuU7j9gjTF1r55fd6o=;
        b=k/8xOGCSHs/NFP97H7XObBKaRl6q82qCkUHmcGoRygKALd0V5qtgAouHqEXXVabRpv
         F9jnD6t8COEzc8yVaoAsj+5KUcqC78uhIlVVpIQuOg6X5cV7+wWPz8acnRgX44Y/MuKE
         Dk6CM3PgT2hGJeIo8CiVqix954FJZ7rZvscrTfgWU2pnAWGiq7InCVHK80R65tb+F5AS
         HPUG9TYPoCkqlhyd1rEiKorX02cwzZs46w2376wKSXHCYzyJsnivp9dVDHG6ItaiiPuR
         wBVmGeBogdc1UxRqZFn7tL/ETIHAJ2pSKDMU54jw72xuhP7aJKXSdvRk6bnRYJQP8WWP
         nZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eU7j8BPKnWBddO7CUJ6gQsdoCuU7j9gjTF1r55fd6o=;
        b=YMp4DuhyTdsrIAMmbDX86Yq1f+UH7OMLFv5I8q3iW90JRzL3f2svyAwHsVAYns9Ldy
         tU5OX3QBSXubUQ9IHeFuZ/qW2baJ9rG7FsDDllRXSTAASNW/3qa0AQWruwjAhlCcP/H9
         cdd01zhsngrYbPQ8tsPPMHNhYRP2yJrAPVXBPEBia79Gosa9YCjkkiedAZTzUD4XE7Av
         RPdlJQf3byJ44GEESE8s8W+abhwOnHXPrFc+bUNfwnSgsEv0HjZIk/u6f7j1bqFe/ooY
         AgmiHGgkPraFUek33neH/ptcPdubPw6dKlFPh2nQBW+G+wplk3q39KPGr8+zPNFeohGs
         btDw==
X-Gm-Message-State: AOAM530UuLrqlnNd2jW9xbp7YrJP2JozAo09/MGfnzjnZyEsFDQQ5XUK
        ld5j5d5KKyNFLjp65uL7w68=
X-Google-Smtp-Source: ABdhPJwKw7peE+tmHZS5R+XJqXJKC7j/LcI8voG1JvHkG1HmXeNsE/3SPB9NPpGJFmXIrhJLP3Sh+g==
X-Received: by 2002:a63:df05:: with SMTP id u5mr2584816pgg.73.1606835126601;
        Tue, 01 Dec 2020 07:05:26 -0800 (PST)
Received: from localhost.localdomain ([103.149.248.59])
        by smtp.gmail.com with ESMTPSA id q6sm57677pfu.23.2020.12.01.07.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 07:05:26 -0800 (PST)
From:   jiladahe1997 <jiladahe1997@gmail.com>
X-Google-Original-From: jiladahe1997 <972931182@qq.com>
To:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org, 972931182@qq.com,
        Mingrui Ren <jiladahe1997@gmail.com>
Subject: [PATCH RESEND] tty/serial/imx: Enable TXEN bit in imx_poll_init().
Date:   Wed,  2 Dec 2020 07:03:08 +0800
Message-Id: <20201201230307.5738-1-972931182@qq.com>
X-Mailer: git-send-email 2.29.2
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
Hi, thanks for your reply, and sorry for sending two identical emails.
The email service I used before seems to have some problems, 
so I switched to gmail.This is the "correct" version, please check.

 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 43c6d7142fdd..7c665db3d897 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1829,7 +1829,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 	ucr1 |= UCR1_UARTEN;
 	ucr1 &= ~(UCR1_TRDYEN | UCR1_RTSDEN | UCR1_RRDYEN);
 
-	ucr2 |= UCR2_RXEN;
+	ucr2 |= UCR2_RXEN|UCR2_TXEN;
 	ucr2 &= ~UCR2_ATEN;
 
 	imx_uart_writel(sport, ucr1, UCR1);
-- 
2.29.2

