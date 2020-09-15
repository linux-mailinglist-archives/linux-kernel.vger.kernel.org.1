Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB6269E09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgIOFsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgIOFsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:48:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62235C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 22:48:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id r19so754618pls.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6P44y5mpNfyLXR4RrG6FSEEHMj+iy7zvhbL9GfNdpo=;
        b=d5fpZWid3HK1S3xeIBo+ue3RwJcRvMaqXA2dL6Lr92GKstsooZcdMke7Fq8vsiRI41
         Ey17Xc6tNlQNXNx0S2hxaCGnhuY2Y2OnpPjTzRXLub5w0N7X/JxbD8I82KLgzYJxivrl
         68MOS1P2Q86+kcaiKUH9xAmW8eP9Z7oTe1e0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6P44y5mpNfyLXR4RrG6FSEEHMj+iy7zvhbL9GfNdpo=;
        b=PuRARuUidF5Y87uEKTdC1ov8BQ11UCs+Vqd3zZDQBGcY1jcZ5E8dHwbL/26I+wkCy2
         0NV+Ibk6IgGaml5x3TNaMrJ2MVzfStuGfhR3FkC6QVxnqxGfDQXFRR0jmpAhJAC9aatm
         3IU3j9WU4dyyLeFHd6+SNatf9uU7EziX/wFctJ7Exr1VuAwCP85dA/yurfzDOBh8nAXy
         68o6RlwLrs7kQ++tgj0rlhi7E4b7waB5bI1VM88AcS+/FQ677rxfQy1hX8ucoLHQlFq/
         JN2F2b5Cx1bkiSSJF/SrNrYAWrnOBpWlgQXCUjVsszdRUxaD9u/y48H2MTbVlG8riMVw
         0gfA==
X-Gm-Message-State: AOAM531hljlrX0YHchq9+1CJhLuU/IP/WwpH2nZdhI7bfOsuVUkLxay+
        tu4hStAik5z6bzXWpJdHHDmfvg==
X-Google-Smtp-Source: ABdhPJyBoTpUYRjmNE7S4RH/HZ+Wd5QDHCdP+aOrKbrqlSzxhloY/EzG1bmXclaKkAnFOoA370xwVw==
X-Received: by 2002:a17:902:b186:b029:d1:cc21:9a7d with SMTP id s6-20020a170902b186b02900d1cc219a7dmr6444831plr.8.1600148920854;
        Mon, 14 Sep 2020 22:48:40 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id gn24sm11034935pjb.8.2020.09.14.22.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 22:48:40 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Changqi Hu <changqi.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v2 1/2] tty: serial: print earlycon info after match->setup
Date:   Tue, 15 Sep 2020 13:48:25 +0800
Message-Id: <20200915054825.3289105-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8250 devices may modify iotype in their own earlycon setup. For example:
8250_mtk and 8250_uniphier force iotype to be MMIO32. Print earlycon info
after match->setup to reflect actual earlycon info.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Change:
v1->v2: rename function
---
 drivers/tty/serial/earlycon.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 2ae9190b64bb9..b70877932d47d 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -56,7 +56,6 @@ static void __init earlycon_init(struct earlycon_device *device,
 				 const char *name)
 {
 	struct console *earlycon = device->con;
-	struct uart_port *port = &device->port;
 	const char *s;
 	size_t len;
 
@@ -70,6 +69,12 @@ static void __init earlycon_init(struct earlycon_device *device,
 	len = s - name;
 	strlcpy(earlycon->name, name, min(len + 1, sizeof(earlycon->name)));
 	earlycon->data = &early_console_dev;
+}
+
+static void __init earlycon_print_info(struct earlycon_device *device)
+{
+	struct console *earlycon = device->con;
+	struct uart_port *port = &device->port;
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
 	    port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
@@ -140,6 +145,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 
 	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, buf);
+	earlycon_print_info(&early_console_dev);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
@@ -302,6 +308,7 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	}
 	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, options);
+	earlycon_print_info(&early_console_dev);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
-- 
2.28.0.618.gf4bc123cb7-goog

