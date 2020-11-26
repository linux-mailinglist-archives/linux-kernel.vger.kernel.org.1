Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949CD2C5473
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389829AbgKZNGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389790AbgKZNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:06:05 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F5BC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:06:04 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id z1so2277386ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YZf4/VZqM+Z9lbh8Toi6q5/Zm7QXw+MN5AWWv9ll1M=;
        b=uppblSurxa3P9JcajMHBOPQWGc29jSYIYmUhm+agj0vBg/LmXAvgQiSzQa0SHBemln
         JEbwpdsi2TaZXWqPVBbKMKOtiXH0B9pXxVRbRb/Ii0SGBw2r9axKkgCY7cwCFOPXi0k8
         aaHfL69InCFbVxqGhoZ6CVAzr/RI9mB5NYctuHOdRbWj/1t1YgInBqNlhDxqwW23KGK/
         I3aEWUsOsUBmeVs/fiixGx1POtf3bMGgku2hXknPP+m1i+qXwr6j2Hjj95ieHoIP3V/I
         j9cfNnKML2guNcRb2O92AKgGTDhQkzbcYqZ9cmmTkcHAzPZqb4b+sSb9Wji6Lxh0CvGZ
         brcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+YZf4/VZqM+Z9lbh8Toi6q5/Zm7QXw+MN5AWWv9ll1M=;
        b=TO78EaJ0uAUXwAgPE6rZ0ObpWrLJheGi3e6RS5x77ZhWpem1Edee8ZmOvrd72q06L8
         j6qSzYmoI2N3O0e49TRG9vybIgjF4/PHRY72Xq5KBiwIGq39JnngW4lL7LbW1yM0n77R
         kCDBtrS/OBJDqzprCPgl6AmyJptP+J9UAnX0xFyhjiwFrP6NmfTaZmzbfobRiPyxBecn
         IZyXu4xhucqWAN0fxWpX7qy6Z71/FbWKPiQPS9a0nvVTmudETJ0Pms7tiM2kAwpmDDOt
         QtwJoSsZWpfpWPckXs+7BcKP88zAhOaIj8ONxl2HYEzVzdxP0W6AbMXbR/oO2YBBZAAj
         DMLQ==
X-Gm-Message-State: AOAM533zZIdeHNnmWnNUjsr5YAftZaoT1VVRdjuPjnH4xnwXj9gQIsAf
        Li/dKikgJEOEgnKYY8lc7eajccz5sxK+d+KH
X-Google-Smtp-Source: ABdhPJzjW6rxKvOmhpsBZnFOvyZwT4zrQYqYBz7gfWPJ3rPoqzHjg5M7x3Oqru2CO9bTxqbyqEks1w==
X-Received: by 2002:a2e:731a:: with SMTP id o26mr1164563ljc.98.1606395962373;
        Thu, 26 Nov 2020 05:06:02 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id c5sm310077lfg.84.2020.11.26.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:06:01 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] parisc: pci-dma: fix warning unused-function
Date:   Thu, 26 Nov 2020 14:06:00 +0100
Message-Id: <20201126130600.2290331-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building tinyconfig on parisc the following warnign shows up:

/tmp/arch/parisc/kernel/pci-dma.c:338:12: warning: 'proc_pcxl_dma_show' defined but not used [-Wunused-function]
 static int proc_pcxl_dma_show(struct seq_file *m, void *v)
            ^~~~~~~~~~~~~~~~~~

Mark the function as __maybe_unused to fix the warning.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/parisc/kernel/pci-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 36610a5c029f..36a57aa38e87 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -335,7 +335,7 @@ pcxl_free_range(unsigned long vaddr, size_t size)
 	dump_resmap();
 }
 
-static int proc_pcxl_dma_show(struct seq_file *m, void *v)
+static int __maybe_unused proc_pcxl_dma_show(struct seq_file *m, void *v)
 {
 #if 0
 	u_long i = 0;
-- 
2.29.2

