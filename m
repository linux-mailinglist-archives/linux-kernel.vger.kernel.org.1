Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A998B2E6C50
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgL1Wzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgL1To2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:44:28 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F19FC061796
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:43:48 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id 7so7626628qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvBWnxy2Os8fNxMPtsKuOpXMECffdeXa05h7jmnjYvo=;
        b=C81kQ0IFEbAKzJlIKUFX2qvxYiOo2fZN0+HaLLqcezyVvY8R+Q7XOuCReoVIW9IjPn
         dmEdZX/NCR7js+WWj7+gvQs+kPFjwkqYguF7I/0JUDU23EDt6ahjo8h7ChQ29x3Izvmz
         VvWvoWXQAK40yBgoyMbklp6fIhb8Pht3WyEpydIjWaKc+P9N7hk2pRyrMIzp4IFOgYt1
         Wrc8Y1SVFPt4VgsD7NZnZfms8eOXBM/yIfy3y6tveIZ77nEbaPH5VQDQl6G2xO3umV63
         QTYoh4y64K7YoO7mA/yVGA6zkkF06glkvhWq9s2OBokFKS+Wcz/wSplTBWpRwq9R+dxo
         6SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvBWnxy2Os8fNxMPtsKuOpXMECffdeXa05h7jmnjYvo=;
        b=VYBTbIG/KbuNoPetwpfHFboAUkmTGvN/2MyXxB2XuL4wjxHBeNgC4MAXwleLwUEXVA
         0WfzmdyWxdapCLHrRfidLmhLi0NTgwdIFI01oFjYg45YhId+w3Erutt+RUGzLhA4AKvU
         TSG/7sxi6dVGwLlQLZoiFlHrwCNatNkgoO9vYTtghcEuyGmGptqe5ujHhZnqln+kuPiB
         /AV+Wq8GhTLMbasd9KluL2ltRL26/8YA49Pz6kzMwWrZB+LEzt2QrO5UvZXfdRCRpWbk
         OzVUdUVTLw7DbabuqHWnFdJYEZAZIQoPmF0H4g2qyr0QsrhIxiEoe4NCZy2qlPdybaXq
         XOkg==
X-Gm-Message-State: AOAM533n65W2+BhdqFo+W2ZuoarKkKFoxE7BlScGV+H3YIiWsGG/7b5r
        QYJkxkMzxgOFk/TuAfqJVXk=
X-Google-Smtp-Source: ABdhPJxmGUuisBdx2PbWWrLf89l6nQ0u3+RKRJRgje8dtCerbPuMt37m25pnsvavE22ggRIndU74Tw==
X-Received: by 2002:aed:20ea:: with SMTP id 97mr44777793qtb.125.1609184627269;
        Mon, 28 Dec 2020 11:43:47 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id a9sm24299136qkk.39.2020.12.28.11.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:43:46 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Carsten Haitzler <carsten.haitzler@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] drm/komeda: use bitmap API to convert U32 to bitmap
Date:   Mon, 28 Dec 2020 11:43:43 -0800
Message-Id: <20201228194343.88880-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit be3e477effba636ad25 ("drm/komeda: Fix bit
check to import to value of proper type") fixes possible
out-of-bound issue related to find_first_bit() usage, but
does not address the endianness problem.

We can use bitmap_from_arr32() here.

Since I have no hardware, the patch is compile-testes only.
Carsten, could you please test it and consider including into
your tree?

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
index 719a79728e24..27968215e41d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -136,11 +136,12 @@ struct komeda_component *
 komeda_pipeline_get_first_component(struct komeda_pipeline *pipe,
 				    u32 comp_mask)
 {
+	DECLARE_BITMAP(comp_mask_local, 32);
 	struct komeda_component *c = NULL;
-	unsigned long comp_mask_local = (unsigned long)comp_mask;
 	int id;
 
-	id = find_first_bit(&comp_mask_local, 32);
+	bitmap_from_arr32(comp_mask_local, &comp_mask, 32);
+	id = find_first_bit(comp_mask_local, 32);
 	if (id < 32)
 		c = komeda_pipeline_get_component(pipe, id);
 
-- 
2.25.1

