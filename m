Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD7D2A2A03
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgKBLyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgKBLyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:13 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:12 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id x7so14268351wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6k1rgmOCefV5rf9QkuupaTuT0YgnMPjbaR9fAX+QknE=;
        b=y5VvOFmQmI4ALNtwbtkNl4OGbZcjhf8zgU1CuhmF1lgt6xx89bPvfTiqcAe8fMJX/T
         hqcZuHTNa+0cRhYjgxrIQCiIqwvAFqAThlxlioPAyOdwbn8tsP3t7lgxKk1iWPQLPEz3
         Cr5B8ucqnYxWmXg3bw6gecQ4pGSWq27PMipZXIIPkfSH4iA/alWSqsAZlbJsSzORBZ1D
         No7fCGcChc++FGtT/8AexKRMZMNn8B8VnPGvrvdUXqGFAcqzKgSAaDfuYsEx242K03Cr
         9Rk6DsLUGgCDT4FDFz0qzbcLorZFlPseAr0NClD5fvchTFmbN82Md61/2XznR8FJ1r6x
         DBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6k1rgmOCefV5rf9QkuupaTuT0YgnMPjbaR9fAX+QknE=;
        b=OFvgSzDyPTSiJtm/vn/yyFmM7jl8Xl21aCJfMdvva6zQNRTk/hN3ZpmP0AwJn5eswZ
         M8V8eldBFdXk8Ws3CC+b6Hc7G2wfGh21YyigMwUptpM7Axy/t4Vla1EMHAk9l8kz9ku3
         gZNRQ5YKkxUF/I1P1IX78etqVU4kd2IfWTnunAvA7Ng/57GEeXaofx9tEhqQycE8xBzJ
         rjRSAvLFM5NRQRxEvnUrZksHeVO+mOikT50rToZ1g4RLLsyVfnQeRFw1uwZpYgxtE9UD
         64yZN9cRJG59BftuX1pyRB7Wc1cHAHETJth7UJ5DcjZSuZ18YUou45qTtnCEa7ITc2yr
         Jbow==
X-Gm-Message-State: AOAM533KfxOO35van1w9CW5YWHgx12JqBiNiZv/hV8nJzzm+34l1/kny
        ZwZ12AocxqVB/3iga8bHI5NWjEsh2inZuQ==
X-Google-Smtp-Source: ABdhPJxYCcOe+hVFLFBm6oD3leh3m/w+OrE9Xtc/KQhUYWCDk7x/Hd797HUddLM/pFy7+HmxPgI4Pw==
X-Received: by 2002:adf:804b:: with SMTP id 69mr19674908wrk.274.1604318051232;
        Mon, 02 Nov 2020 03:54:11 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thomas Gleixner <gleixner@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 01/23] mtd: mtdpart: Fix misdocumented function parameter 'mtd'
Date:   Mon,  2 Nov 2020 11:53:44 +0000
Message-Id: <20201102115406.1074327-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/mtdpart.c:300: warning: Function parameter or member 'mtd' not described in '__mtd_del_partition'
 drivers/mtd/mtdpart.c:300: warning: Excess function parameter 'priv' description in '__mtd_del_partition'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Thomas Gleixner <gleixner@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/mtdpart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index c3575b686f796..12ca4f19cb14a 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -292,7 +292,7 @@ EXPORT_SYMBOL_GPL(mtd_add_partition);
 /**
  * __mtd_del_partition - delete MTD partition
  *
- * @priv: MTD structure to be deleted
+ * @mtd: MTD structure to be deleted
  *
  * This function must be called with the partitions mutex locked.
  */
-- 
2.25.1

