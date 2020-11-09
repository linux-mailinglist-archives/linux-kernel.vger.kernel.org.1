Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD42AC3AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgKISWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbgKISWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:42 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:41 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so390818wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agE410NhHkG/VilLjKYAizauXJMrtB10xUIGh/10Z74=;
        b=Z4+xXsux0cuxaF0X0CxSUo3a337YVpcYhtV1lfsrsLYeg+rP4mBKxEDnfCcV32WgQs
         nwvFDV0UVswNzv+7k9HnNM9G42WDu95sxlT3VuXoi73XDGB9l7A3Sd6ny3gvazveNwCa
         9BF3Lm8IbmMKQLvBRIrW8GctWJWfoNTZslH//t/ip+jPJuTZwgO/3BP+dNUZz1zwdUO5
         D/3nfNGkBbHbn4XHeEJB2/HS32axERrHMrMitwM8hiYsiwk/osob6aQ5y3A0A8JbCRMG
         D1Vg8ROq/Fn28PyM2WXP/DincnC/LRQ7WGSGhTWQbp0J9f52aTUCQGArOWmWLceSZENc
         /KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agE410NhHkG/VilLjKYAizauXJMrtB10xUIGh/10Z74=;
        b=B4BVPebsyUO4oCZ0DXCFwUI3bgFhj4SLdYBKHxAptdrE9x7/dfcX3kmybPhF72M9wT
         mbDBkp1QIOXdmvlEmpYbnEg5P+UlTwD34dz6mXWlAVpECAKu2oXds5AcekwhKX5K3/nj
         DIKO9eK4/qZO6JHaczxMQfYvjI/GgHUEpiT2OCG2yWEIU3hUs4w4QaE7WOobcPN0404f
         koT0Od7M39kV5zC843SkQTOIqn9+5EfT1A3WUV5nYmDxSk1JmzRdPdSFJs25mvB0jIG9
         /sNKdtizoB0xAlWOUBuqkT39WR2ywfETCxChGNyWuz1kNLGQrA0MihZEF35G0ZAdIB8Y
         I3Jg==
X-Gm-Message-State: AOAM533jo0ccNPFgZ0TlOuRVyw5j5rg/t5CRx0KX7DXghA8KafxLFU3+
        LYHo2IkNhmdA23RC0YhnvO7mx0fo3jjLq7uG
X-Google-Smtp-Source: ABdhPJyw3u7oovt0s0+EZWOET6iA5NhMchu1kRYIDRZYcKaCmHuKTbHQTjEihlIA9JdcEXKzNEVNSw==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr445117wmk.185.1604946160461;
        Mon, 09 Nov 2020 10:22:40 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 14/23] mtd: ubi: gluebi: Fix misnamed function parameter documentation
Date:   Mon,  9 Nov 2020 18:21:57 +0000
Message-Id: <20201109182206.3037326-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/gluebi.c:446: warning: Function parameter or member 'ns_ptr' not described in 'gluebi_notify'
 drivers/mtd/ubi/gluebi.c:446: warning: Excess function parameter 'ptr' description in 'gluebi_notify'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/gluebi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
index cc547b37cace5..1b980d15d9fbf 100644
--- a/drivers/mtd/ubi/gluebi.c
+++ b/drivers/mtd/ubi/gluebi.c
@@ -439,7 +439,7 @@ static int gluebi_resized(struct ubi_volume_info *vi)
  * gluebi_notify - UBI notification handler.
  * @nb: registered notifier block
  * @l: notification type
- * @ptr: pointer to the &struct ubi_notification object
+ * @ns_ptr: pointer to the &struct ubi_notification object
  */
 static int gluebi_notify(struct notifier_block *nb, unsigned long l,
 			 void *ns_ptr)
-- 
2.25.1

