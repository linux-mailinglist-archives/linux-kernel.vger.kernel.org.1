Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C262A9F35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgKFVhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgKFVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:28 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649E3C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:28 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v5so2819385wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2abslax4xTZx4NcG965UPlBWLqxdXR2VSBh/TqhIys=;
        b=gIJqWuunPNOfDIFyO4uN9GnnqnFhpSWormMo1MbZZ4YUm684CRnXVVQt8r/MdXa7Xi
         IB35shvh5tfNlmlZOFtSppdMmrhkvS0lGRr4gKBUlXdY2goKLftXZNeNVvKP1+Ezw1Yx
         Qd0BCrhobs7VNkpRRRdTzMLDEKMzOC87O34JwG2mcdjhNxrlr8NVDwLt1gJFU5D75LuA
         qyryLpZ7R/jliLQo2p8Sftdl1lmmed+DlUdTUJHWzFx0YxIV98isN1G1Ia+B0DS6lhzQ
         HUaduOlivmQktAcns7VZIBaZJEIDX6EiRGmlL5GMYBPOdWx4kG3+ztsKRmGzUlYu60Sw
         CHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2abslax4xTZx4NcG965UPlBWLqxdXR2VSBh/TqhIys=;
        b=Lzdk3KwLlRrAopeZy6/veN44llNT9KfkoHDByH/jYdCYGTDjjMTzUc9NA4F4VoTTgP
         sFkqQVfHq43GyzfEkyOSyf8sJQv/1DiHyLOMn4Ci9ts1kO4PgWvw7D6W84gqgvU1M+YA
         ybU48mL2VIFtJXd10I6xKKB8KaYgMNHmYU1I0hv2AXz0ARM0hLBxwKJbz7SFtzttMGza
         8SDTa0YVPeutbDcNqoEtUtULvMxlUbIDVLIuzJnT8iG/5X+PylCYSV5qLDOxS9EruU6w
         41nuztwpKVn3/ZGp1HGbEJlnOPikEPO6zQlFBu3xegqMmmmYcnVq1ps5clCpmFbBclbU
         mhOQ==
X-Gm-Message-State: AOAM53040bFIdStdrQIpyQ8hKO7xXyGseuiN1PdSZp1szCslDUTkK22k
        iZ2xbXwxHro3XSB+guIAdj8Liw==
X-Google-Smtp-Source: ABdhPJwAlwMoxAsuA8YuxFAr4KHnUer28QzUz53pEnK1bLDZ7fl61sKitns5pbZhZEbzXMKzUB8TIQ==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr1606399wmh.165.1604698647102;
        Fri, 06 Nov 2020 13:37:27 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Choudary Kalluri <punnaia@xilinx.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 21/23] mtd: nand: raw: arasan-nand-controller: Document 'anfc_op's 'buf' member
Date:   Fri,  6 Nov 2020 21:36:53 +0000
Message-Id: <20201106213655.1838861-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/arasan-nand-controller.c:133: warning: Function parameter or member 'buf' not described in 'anfc_op'

Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Choudary Kalluri <punnaia@xilinx.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/arasan-nand-controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index fbb4ea751be8e..549aac00228eb 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -118,6 +118,7 @@
  * @rdy_timeout_ms: Timeout for waits on Ready/Busy pin
  * @len: Data transfer length
  * @read: Data transfer direction from the controller point of view
+ * @buf: Data buffer
  */
 struct anfc_op {
 	u32 pkt_reg;
-- 
2.25.1

