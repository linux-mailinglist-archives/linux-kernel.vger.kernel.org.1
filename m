Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5127D473
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgI2R2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI2R2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:28:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:28:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so4429861pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jCfCKOcdlkK7XQuavXEmMvj1/6I5JBU8+KoSiZtQZU=;
        b=LLa3R+/+HG2BNoramYdoVFD5w4S2wH+28H3USQS+Uxio7PX9jQnsOdFyMnnpGcPg/O
         rGzo0ext+Kcf1H4jV9ViYNviAZ1YMrW6g0I9Wv9TBeaRrQI1EEjZNiAoP9P3SLr6Rd6i
         Jw66KWiroK0CYdpntvu7pG2bWsch/sD7x8i+8q4RijN9vfV9ZLpo8MC21YrZ8u2prFVA
         dWAVs+sOxluhDcAWOGsT2vcwmQkDskU9rqkpszcEP6BsCe3iiol+OJnPrNd3nrrY8eYT
         IKNgNSgD3bb6Dbm5V1UKA1aTvhvMLMKSCIadLUGgw/4mIJGX4b2tzLnb7FFx4a7UiyYD
         pNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jCfCKOcdlkK7XQuavXEmMvj1/6I5JBU8+KoSiZtQZU=;
        b=UfCmAH9wUv+OjEjOfzuMfIr+zEMvi+bvNHEHd7CwIB31oZ2uBgiilvSFGTyBoR26dh
         lhNiKV+hlRfoqk8X2Xk12/nz3NwRlv5yhk0U2416nZ3GHp1i4sIeX8nonnvz6mkv6cg0
         veCwLC1ApM2xt3pBLqjZK0RP3+0wTV5Xg3IHvMfWb/7R2K9EVpm5gOKS3++ditJQOA7B
         MdciDvxmzzmvSmHqW4dG9uuURWj72bP+V9KHHSRMQHIsoJR3/e2ysgJDlmcjepdMOkFM
         0HPJJXn4Sl5huHFskuh1NQNnhXxs2JY+1Q2s+6Z0Aj7QmPYThlT498Ki2BxKLoI3p0s4
         lEdA==
X-Gm-Message-State: AOAM531981fGwGd/WsqddkXrRCDtqhpUsM7+r+PvqHAk5lKv+s+4C4wr
        SonrZ7l9Usv+kJ8naV+yLnI=
X-Google-Smtp-Source: ABdhPJwv2MmR7XFREsHxyilT3MOLMv0dmsPAwmNjSSqks27TMMrOL40kXvbffF6dEBzCFM5vQz2uTQ==
X-Received: by 2002:a63:f84c:: with SMTP id v12mr4077213pgj.125.1601400492666;
        Tue, 29 Sep 2020 10:28:12 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f19sm5393006pfj.25.2020.09.29.10.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:28:11 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: parsers: bcm63xx: Do not make it modular
Date:   Tue, 29 Sep 2020 10:27:21 -0700
Message-Id: <20200929172726.30469-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928161617.2a1b2244@xps13>
References: <20200928161617.2a1b2244@xps13>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE
detection"), we generate a reference to fw_arg3 which is the fourth
firmware/command line argument on MIPS platforms. That symbol is not
exported and would cause a linking failure.

The parser is typically necessary to boot a BCM63xx-based system anyway
so having it be part of the kernel image makes sense, therefore make it
'bool' instead of 'tristate'.

Fixes: 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE detection")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/parsers/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index f98363c9b363..e72354322f62 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -12,7 +12,7 @@ config MTD_BCM47XX_PARTS
 	  boards.
 
 config MTD_BCM63XX_PARTS
-	tristate "BCM63XX CFE partitioning parser"
+	bool "BCM63XX CFE partitioning parser"
 	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
 	select CRC32
 	select MTD_PARSER_IMAGETAG
-- 
2.25.1

