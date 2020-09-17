Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA526E021
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgIQP6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgIQPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:47:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB06C061756;
        Thu, 17 Sep 2020 08:47:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so3932939ejo.9;
        Thu, 17 Sep 2020 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifLqIBBiM4ThXSLoxSOsnfI6fbrmlczs4vIdt9aQ3i0=;
        b=YLjJHrEuERndMlBjeyPJXtaXrcSqPWAfH/IdF/gAMGs8Jlh0vBM6JXXRNMxgY29Snk
         x0yhRpynliTUZLb9ciGmDIDewRdguVfNo52eyyfPJ/Dv1+tc2Lv4jcIHRaR+WYc/qeNo
         2MHcXE/wajEJvwsBWTH8DC2e4TFtacYLsjFJuNzxrzfeka4bnUDi0IeMv3jI4pbKtvh4
         qD5kAAUWxpSV20byptqb9B/MJaGA7qgpwHOmyajZSNWUCjFhXp/lBYVTJsGplJ6BdrYK
         IS8l8STJtLhAOc2ZEHRGo18Ba7KjtfW3fciUX0ImQ3iup9RzXYhgXiKhdHfvd/yPw7O/
         8CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifLqIBBiM4ThXSLoxSOsnfI6fbrmlczs4vIdt9aQ3i0=;
        b=LVNkvU4z1yx0xXbffaJj/rceIuyK7tIHYD8blox9Yucu4VqqLsMABVij+o5ifUQ2yN
         daGmPQ9gbNda6RsMPJYhhjzFzWcaepMDRnBlpNyEO8uivVIG1F1ebhzbwtT+Ap1zpUOS
         MFp8Tsi2ox4nUImnS9/IZRWAUK9SgzZymjQmh6CkYBcrz9luGl11EQn364NxZVd8AZ5B
         LuLea58MeyGePMCGtWI2oG2lDmBIOupAPhpinGfWc3/JBEdiDeUCtYjK1rmaet50qNyI
         pFCj6KjGKzfZTgk2C5JadAJY2gT6XsCP0AFS75uZ16uSBZ/avqPcu5LFJMM6BWXlJbvu
         hr0Q==
X-Gm-Message-State: AOAM533rkvEnmtfGeqOtRzP3DBgkg2I0AEYhXDDsmOwPaNfYe0TAjk6M
        DjzAI+1GMbJKKVwNXCl2HvzL67Oj7qTrvg==
X-Google-Smtp-Source: ABdhPJzsyJnhXvY4nVvfIupO8x6ooIe6FqbqDIdAvcyagj7JpkdPhdHmABTuYzil9/KssGWzkl1wYg==
X-Received: by 2002:a17:906:fb8c:: with SMTP id lr12mr32902212ejb.9.1600357654295;
        Thu, 17 Sep 2020 08:47:34 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id dm22sm50748edb.49.2020.09.17.08.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 08:47:33 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     dalias@libc.org
Cc:     lethal@linux-sh.org, iwamatsu.nobuhiro@renesas.com,
        ysato@users.sourceforge.jp, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] sh: dma: fix kconfig dependency for G2_DMA
Date:   Thu, 17 Sep 2020 18:45:48 +0300
Message-Id: <20200917154547.139019-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When G2_DMA is enabled and SH_DMA is disabled, it results in the following
Kbuild warning:

WARNING: unmet direct dependencies detected for SH_DMA_API
  Depends on [n]: SH_DMA [=n]
  Selected by [y]:
  - G2_DMA [=y] && SH_DREAMCAST [=y]

The reason is that G2_DMA selects SH_DMA_API without depending on or
selecting SH_DMA while SH_DMA_API depends on SH_DMA.

When G2_DMA was first introduced with commit 40f49e7ed77f
("sh: dma: Make G2 DMA configurable."), this wasn't an issue since
SH_DMA_API didn't have such dependency, and this way was the only way to
enable it since SH_DMA_API was non-visible. However, later SH_DMA_API was
made visible and dependent on SH_DMA with commit d8902adcc1a9
("dmaengine: sh: Add Support SuperH DMA Engine driver").

Let G2_DMA depend on SH_DMA_API instead to avoid Kbuild issues.

Fixes: d8902adcc1a9 ("dmaengine: sh: Add Support SuperH DMA Engine driver")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 arch/sh/drivers/dma/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
index d0de378beefe..7d54f284ce10 100644
--- a/arch/sh/drivers/dma/Kconfig
+++ b/arch/sh/drivers/dma/Kconfig
@@ -63,8 +63,7 @@ config PVR2_DMA
 
 config G2_DMA
 	tristate "G2 Bus DMA support"
-	depends on SH_DREAMCAST
-	select SH_DMA_API
+	depends on SH_DREAMCAST && SH_DMA_API
 	help
 	  This enables support for the DMA controller for the Dreamcast's
 	  G2 bus. Drivers that want this will generally enable this on
-- 
2.25.1

