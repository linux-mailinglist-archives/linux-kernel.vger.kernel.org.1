Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358C92A49CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgKCPa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgKCP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:22 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02306C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:22 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s9so18989814wro.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UC0uGgUjjSLjD5RcXybgGHkFEDsZSC9QtuC5QnEPQQA=;
        b=oMoqkY4xKPUSIE4sPX8CPBS6as2OCFRrRZQamf9SpgZ5L2QRSxFEWPgEXdtOYlxH4u
         xLI4+0ASt/vT5xDnhavT41xnnxwTZwZ04tQlsnaLN8wNqCnzOMhbQdiNSY9ASZjCXSUN
         FSOkgTAA9b9hwXEeZp/khhczim9RujgyAp6ynusJei589VRjSeYvDCUxXjlhm0+qJECc
         S9u9ZZtS7dg7QDt9GNaALCnjuh42/Ox46+0hX37obpEjsVD1r5T6ZI5xn/uAqk+dxhZp
         YHmBaJw2oKZoldOnnA+JPphtHd68M+mWe8fgSEA5v56q45W8Y0thY5d+6p7D/Y+703uC
         Wtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UC0uGgUjjSLjD5RcXybgGHkFEDsZSC9QtuC5QnEPQQA=;
        b=dibPufb3Li9Cnw0XPWVgV81GdTKZwvru3hKZgQxztjY7qx8lBQDH/nkp3ijRc6u+2b
         OFob33EaSqLF8A7ZgE32qQ9j5nWrPJXHOWfe83JUgRS9uHuZF0pE6EpEl0eJoyGd9dtJ
         u2X5oYmTs5QnTs8sOFeAnPNMwL+VXDjUJokcEcOyZEjA6N1Aljz1g4cZVQzdBov9Oqin
         89EOh7z38ebBdWXHdWpibntwDQ2C9za7I3fJuJ42fVeOfZYdaq9/ee+xYOP2FGhGgbn6
         CI6EXiijIV+tnO3VlmhwzUY97HXZ3e/gZevM0XeoTTCWepPo1fZWec5wN7dFkgLh3dXX
         lFkg==
X-Gm-Message-State: AOAM533nCbwNttXWIMsNX69NwcCHmryHozS/KAMQ8zjL+W5p+UCERxzF
        RkFN2WgzAntDPFk9i2p9FRwMzQ==
X-Google-Smtp-Source: ABdhPJxbdd8ZQFkyxwtakpdO5uZhE5duJJLh1WcEzx28/qO4spTQ4M9Cj9aozLszVbQeETu/3i5acQ==
X-Received: by 2002:a5d:664b:: with SMTP id f11mr25449480wrw.195.1604417360753;
        Tue, 03 Nov 2020 07:29:20 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sandeep Nair <sandeep_n@ti.com>,
        Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH 08/25] soc: ti: knav_dma: Fix a kernel function doc formatting issue
Date:   Tue,  3 Nov 2020 15:28:21 +0000
Message-Id: <20201103152838.1290217-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/ti/knav_dma.c:507: warning: Function parameter or member 'channel' not described in 'knav_dma_close_channel'

Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Sandeep Nair <sandeep_n@ti.com>
Cc: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/ti/knav_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 8c863ecb1c605..b2d63d8854d63 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -500,7 +500,7 @@ EXPORT_SYMBOL_GPL(knav_dma_open_channel);
 /**
  * knav_dma_close_channel()	- Destroy a dma channel
  *
- * channel:	dma channel handle
+ * @channel:	dma channel handle
  *
  */
 void knav_dma_close_channel(void *channel)
-- 
2.25.1

