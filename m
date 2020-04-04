Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6FA19E61E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDDPgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 11:36:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40953 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgDDPgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:36:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id c20so5204315pfi.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=pbazCulCIKKkz9Ego4v5HD0m1P/J+HUtTSIcWpG1JoY=;
        b=myi6YLyoE+RLHDUNGBvNMpbBa8r3y1anRiBMDobXca9RTKlmkYJPkFfUogM2JOOQdP
         Wx50qpAwF3QvQxetWKFQL3wTH8BpostygOCO68OAEnFZq9hrKKlcsGi1TTrokdgRa/lG
         VooGtC0aZwpvg69Rl6WvdFUFku90XFfp+iBqOX4MDh2LN0Hdi1054ptYzfpSF2Lgj/Yc
         PS+eGFjSZSaJq1IvO1gu0gjEcoxmTjNJj9IKvZUDo4ZEa+ldGTfKi0hyuMMyawyIP8WO
         f5OX09f1bN7Zh+wtihrvLDKMZWkjpjmGl+KlEfrjX4kg9u+tYhwfUjPJ9AE2NIW8w3CD
         KMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=pbazCulCIKKkz9Ego4v5HD0m1P/J+HUtTSIcWpG1JoY=;
        b=G+nAKXJ8GoQEXWZqKEmsoEEtjwMI5CayvK0cizjrI42kkco3V0mbPbfOpxOSqRpwz/
         U2RRIMkYYJ7SaSO+v4+MK11U4Fh1F07Y7JVsdjzdPJcjyE4xiLXes3Zhy6g2SBxvU1CR
         gCLn680U1tWzTtCxOGDeMM9B5HLtaz2ekDSbA98Hn5jASQuSnAEvgPlx6N0vJw8G1ZC1
         ESEG4/Oxh6IlT3RJV6txErc+BEvyrf//+u4QEfedOUy/Zd3BeWask3+e+KADK1oclOW5
         O58sgoBxRmjwBIHvVqMsXSEhLsyQMLBvMp1UWwu58WyAC3f31mYk3Ym0/y7KgxPKHb86
         ocEg==
X-Gm-Message-State: AGi0PuYodgIo+sfbf4SqY7Ok26X4xWRfqr3i3RG/wAy2jqugKJkOMdQ+
        /iwe0ijdqRMDcyWfl3bzufQ=
X-Google-Smtp-Source: APiQypK7h6kbAovnIT6y/Nq2jrHhKaImbbfuqw0UqwWnEZtaSrfx+B7XRFvZyN6Ei4FD/vezZlWRkA==
X-Received: by 2002:a63:f113:: with SMTP id f19mr13951250pgi.168.1586014594406;
        Sat, 04 Apr 2020 08:36:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x75sm8028885pfc.161.2020.04.04.08.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Apr 2020 08:36:33 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH] mtd: spi-nor: Compile files in controllers/ directory
Date:   Sat,  4 Apr 2020 08:36:31 -0700
Message-Id: <20200404153631.103549-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code
split") moved various files into a new directory, but did not add the new
directory to its parent directory Makefile. The moved files no longer
build, and affected flash chips no longer instantiate.

Adding the new directory to the parent directory Makefile fixes the
problem.

Fixes: a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code split")
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mtd/spi-nor/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 7ddb742de1fe..653923896205 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -18,3 +18,5 @@ spi-nor-objs			+= winbond.o
 spi-nor-objs			+= xilinx.o
 spi-nor-objs			+= xmc.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
+
+obj-$(CONFIG_MTD_SPI_NOR)	+= controllers/
-- 
2.17.1

