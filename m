Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF312A9F3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgKFVhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgKFVhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:06 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79514C0613D3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:06 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k18so2620680wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kN+nLzLc6b7cOpaWz6eZ4gZDLXqa51d6pByGdFZOfqY=;
        b=fZaGgVTCmG4C5q/nm2wPolvW4omaf6In8+148k3bUqfG0b9+xbgmdoGQJe4JfWa7IG
         kEBE/0YRyWKYZkljpvwdYarXXq7SJHorTHqEXuwVWUnjaWnneUOa+9y/1YfAwHVJ7/ok
         EuiPoxYzoADNR9L2YnGO8Ie4AKlWTVSwWlS23k5ZkE8Sfh8SE2PIN2LdZwCeH1X+Fj/Q
         6GImujez0wtGZdyFlKNSM4xXo0H2tx8UpHVPlp5//LCLmlxqpX93pSd92nv0Ca/MxK6H
         7lsrMjA+ITkI7Z32zXit2my2/GRfjnt/PUdxlsZ8S0dU0I6NhXr6yh8LtUgGfSlkiwha
         QX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kN+nLzLc6b7cOpaWz6eZ4gZDLXqa51d6pByGdFZOfqY=;
        b=dYMvGhAvsQB7+DsushVejUk5Y1x1pVq1SNJCh7EwqMMDwzjhQ+qmjYYP0R0SWp/sx2
         aeuUiEFgHyrDMqgNR3qsb90jJvBteOnArJz9aVGYqFs88qUVQFW6+1Ui0ifTN1Et0/xv
         o13Q0LIhlqihWiWDfLzMmJTbopCeeHc4Y9LwKBVOlRmjO6MnR68wniamxr33Ddcjleqw
         cfdt1/KjkZnzo7S2m/Gr/UKE2zhI9A6p2z5WZE1vr/bd1e0jgbvtbXjfqqxvH2hk/34X
         OAEh5zxlVeDYZ35DBm0wywigiwk0mQmfbj1ga6QWfkS48DOVIWLFKxsPHOkIRgELU7Ws
         2luQ==
X-Gm-Message-State: AOAM5304jO8SOohoejhBW7DoxYgGWMRDpBsGw5G9Gj1zAMS56TRvOHsx
        M3udwCTvhDh8RDIAUIFEPYpH5Q==
X-Google-Smtp-Source: ABdhPJxpFXiTiFTvGKQFl417MX1y8IQ9Khsilv+A/5dxWcIJdtyZhGm+p5Q/SQLoqDlSdBt7I92WLQ==
X-Received: by 2002:a1c:6284:: with SMTP id w126mr1597664wmb.145.1604698625105;
        Fri, 06 Nov 2020 13:37:05 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 04/23] mtd: devices: docg3: Fix kernel-doc 'bad line' and 'excessive doc' issues
Date:   Fri,  6 Nov 2020 21:36:36 +0000
Message-Id: <20201106213655.1838861-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch also places the descriptions in the correct order.

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/devices/docg3.c:819: warning: bad line:
 drivers/mtd/devices/docg3.c:1799: warning: Excess function parameter 'base' description in 'doc_probe_device'

Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/docg3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index a030792115bc2..5b0ae5ddad745 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -816,7 +816,7 @@ static void doc_read_page_finish(struct docg3 *docg3)
 
 /**
  * calc_block_sector - Calculate blocks, pages and ofs.
-
+ *
  * @from: offset in flash
  * @block0: first plane block index calculated
  * @block1: second plane block index calculated
@@ -1783,10 +1783,9 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
 
 /**
  * doc_probe_device - Check if a device is available
- * @base: the io space where the device is probed
+ * @cascade: the cascade of chips this devices will belong to
  * @floor: the floor of the probed device
  * @dev: the device
- * @cascade: the cascade of chips this devices will belong to
  *
  * Checks whether a device at the specified IO range, and floor is available.
  *
-- 
2.25.1

