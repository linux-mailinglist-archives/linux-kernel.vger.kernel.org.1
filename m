Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D502A2A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgKBLzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgKBLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:26 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EF1C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:26 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h22so9239533wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BvGUWERXaYGJjMJDGbA+xeDXFdD9XnQLhYUhgfSf5Mw=;
        b=BDjAOCyrtvyPqB0ou7ixlAjaCYYL4sJAlfYMjm8CmJVrlMy5GlykX23d1CV8+hlrQt
         jm3570TZOoBNQp/jbO9p7NcWcHA7hYD05b4IJELZ+fm3rWqlnPRK6GAEE9+8zWYQtHGm
         YbDOxW+u4uE9sqKhVXCiDAP5Z89cRFutstba5kDRGjUHd2yYpdlCjKPchJ/D+kxLNF6W
         funPxdm/wN2dR64CJb1jm+7UFmYuDZpt0RABnWvng61Eb2ksmInsZZd4UMkweWysLFk2
         jpiyVHoBMo2AvN7DjzIzQWqJc/jnOtqV62Tk7NVEnVt3hi4jh9B3nk/9P+p5yFrFemxG
         SP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvGUWERXaYGJjMJDGbA+xeDXFdD9XnQLhYUhgfSf5Mw=;
        b=obqkLNvZzZI7pPIuMvBIw5Vo1PdZqtS+dkcB4SAVqq3M16e3Ofn4f23eYe/dMbdT23
         uTtO5CHsx64uiteGWVWgCEIMu/oI6vFDZulIYOdpFRW3mdBVnZnwBgf0H2wboOxTWNa1
         p6P4FfnsnXBjX80Ty6oHpGBbTxQTqtJwoIOl08m1zyKNnXSPsc1DhekG9IpT2ggMcrFg
         tX/kuPXaqdD4dydl7KCAx7Rx0aascwDinJQYX2ZjaBlLDNu4NPchYH2yXIh/V2P1BkJg
         +DR09CFrWgkq738ufYEvuEkB8aZ0ScfosOa+BgliIfPsYcxI6l/WZuinYhsMqD35Z1qM
         vgDg==
X-Gm-Message-State: AOAM533js4WnuKrosHjrPB7K5SVJRPcY1irHzS1QhucBKTSeYXKxbcI1
        Xz2cVujfMXVWvgEn0g49EjMZjA==
X-Google-Smtp-Source: ABdhPJwQ1EjTwfCM7yhPtNvjrqOk2umJRWV/i2J3TyjOLlGeGndTu9CRfs9pbUSWOZWpmeXpt1LtHQ==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr17464567wmo.143.1604318065105;
        Mon, 02 Nov 2020 03:54:25 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 09/23] mtd: nand: spi: toshiba: Demote non-conformant kernel-doc header
Date:   Mon,  2 Nov 2020 11:53:52 +0000
Message-Id: <20201102115406.1074327-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member 'write_cache_variants' not described in 'SPINAND_OP_VARIANTS'
 drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member '0' not described in 'SPINAND_OP_VARIANTS'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/spi/toshiba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 21fde28756742..7380b1ebaccd5 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -28,7 +28,7 @@ static SPINAND_OP_VARIANTS(update_cache_x4_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-/**
+/*
  * Backward compatibility for 1st generation Serial NAND devices
  * which don't support Quad Program Load operation.
  */
-- 
2.25.1

