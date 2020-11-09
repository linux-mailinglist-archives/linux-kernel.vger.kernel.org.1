Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307E22AC3BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgKISXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgKISWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:33 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D778AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:31 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so410721wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LEqBSYfgnwhk/ZNzzzB95lzeseOVAaohNofEs1LOZBI=;
        b=E5ipTHd3WeDI78ksj0wsN8ta6sheG/AQB8BQ8iXDHY5Vcd5UP94Rmeb7qV39CI/m/s
         b/TNUumxNIHspIcHhdFCsiyjqRYTDi6pnvzjl7SpwuZ+Oxt03xpdAj/3MRJXnqIcQqWJ
         2CWq8IcW42vMXfoIzw9qhqEQzXFH2P7lqowbg2tr3Hh8NbC7AA/znooc5voi/95YHJWY
         oayfshr76vF8oeDXsIWE4y755y3n4vV4To8KDCOWY1QgtknHx0PM6y01BzoWa4VjGVS3
         lm90zOwPqown5kRN4b1GJ0vNIkHGg1TCABjsQk3PkyG7Wq5ZPMW7LC2B3OmnIXnbkm9I
         pOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LEqBSYfgnwhk/ZNzzzB95lzeseOVAaohNofEs1LOZBI=;
        b=NtL5jaBAvLTzCI9AUmoLx+U2zXoYRgiZjdbtLnyfLUfUmo+qAAxc1zErDsuicRE1Mg
         LVWd2kdpMhRMtZQfvqXewpxYam7lRfWy0VO59bFry2rBsJPSggRtWjrb4bAAKRAgPIhD
         yb3w434VrpLn5o696JckjoiamZ2+S5CB6FY6a7iiG4n/n221nskQf+BAk3iMDW0rl3Bi
         diDblforkgROzf6KfZs7WsTFsOAw24olfSg8bhLpHAjgaxBNYrWV4/xchfM1MMBD8WIb
         Gy00q02PZbdHw9afEmbKxqLz0aLoUz0hb6RbbDH8N2LvMBIaE1scKJ1Ag75sXbM/oihu
         1q1w==
X-Gm-Message-State: AOAM533Ayf51n4ubxEkkzBbF7whhvJ/msyvpGXJTsdLtsxKFPpQOuWGu
        JjUoKRNDrKMAM34xEm3GVI6LIw==
X-Google-Smtp-Source: ABdhPJyaVPP3HEd2IjowyvIOVawlg8jsDXag6dU6Ag6aKnnQvcujBiDSl7HF2Rx1NPFQXIBYU4qlLg==
X-Received: by 2002:a1c:a98c:: with SMTP id s134mr443690wme.159.1604946150581;
        Mon, 09 Nov 2020 10:22:30 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-mtd@lists.infradead.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH v3 07/23] mtd: spi-nor: hisi-sfc: Demote non-conformant kernel-doc
Date:   Mon,  9 Nov 2020 18:21:50 +0000
Message-Id: <20201109182206.3037326-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/spi-nor/controllers/hisi-sfc.c:328: warning: Function parameter or member 'np' not described in 'hisi_spi_nor_register'
 drivers/mtd/spi-nor/controllers/hisi-sfc.c:328: warning: Function parameter or member 'host' not described in 'hisi_spi_nor_register'

Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/controllers/hisi-sfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/hisi-sfc.c b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
index 95c502173cbda..7c26f8f565cba 100644
--- a/drivers/mtd/spi-nor/controllers/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
@@ -320,7 +320,7 @@ static const struct spi_nor_controller_ops hisi_controller_ops = {
 	.write = hisi_spi_nor_write,
 };
 
-/**
+/*
  * Get spi flash device information and register it as a mtd device.
  */
 static int hisi_spi_nor_register(struct device_node *np,
-- 
2.25.1

