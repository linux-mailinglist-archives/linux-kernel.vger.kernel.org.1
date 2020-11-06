Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897612A9F3E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgKFVi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgKFVhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:08 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA811C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:07 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so138041wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAVB42jTKgsR2DuIhHd9CknEAkwHuiO/0Jzqc0AJHek=;
        b=Xft/B9fu4Im1k0dKVSkx2E+3tIW45CfD9m5SnndRedpuZNtDA9jwuOMSmDMyXAUDA2
         8DqgZypZm1qWREX42zMnN5d8EcV9h29ypuD9mQz/9tRWZOMPQ58wDF1GDAbVdyute8vq
         iUV1qeg6LZmU0YzUnF26w0NT4/1GdDv5Vfmuh6kST+e7nbuA5bR0swIoxFEWAuY4Nsmn
         EZUfjc678ToDf0LrZvRb+139/Nfe8YJrBEP1xfSBHQzLrfdjT0v8vl09I/2VTSGC1Xfm
         RcMt+Cic07a2x4IqgNKiUKEunFOKCW8X45dUQn/FoxWtB4J5XTTn8saME6H5WLpGlPSp
         cQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAVB42jTKgsR2DuIhHd9CknEAkwHuiO/0Jzqc0AJHek=;
        b=cg6h4KAmLaE1Ghi59EsWZpM/WSC2GQLo00SRA369A4uWwOmbVeXHlfclIUth6b4CYJ
         Ue9oegApBKQ8+DuR9RM5i4+41h/NazCd7IYKQrimW9EaJZcP+w66uJBpGqnYhg/5LdWL
         knh731sPGuuUo7TFnCWEbc4RtdIcIHvzfCq/GhQ3c2IS8xhc+P1AAZaQHKOu68WLije8
         lWwjHLDyxtDRjhaDBrLxs3unnF5nvKmZypbV9TO/lkt4WpFkPAA8KzM7rhdXw2L7ofr9
         vBwH8/DwBrHFveN8nclUM5N2FTNrmnFXy6qsP/SZ1k0cM/z2XRK333Zv3nRD2M8rEWp3
         cd/w==
X-Gm-Message-State: AOAM532odgLPWeyO8wleOrFf9A25FeF7cdo2mlQdvBfSwm+OV9wJAUnZ
        vicgtasDU1L/eao/7Gw9dGt7iw==
X-Google-Smtp-Source: ABdhPJxCwYYOw1/mIqOC16L7H4ZWLXb6dETRi6SHPSZ1OVNMglLTHfytwUmatx0cFLKe6/NUUEy7Bw==
X-Received: by 2002:a1c:8194:: with SMTP id c142mr1564965wmd.94.1604698626446;
        Fri, 06 Nov 2020 13:37:06 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 05/23] mtd: mtdcore: Fix misspelled function parameter 'section'
Date:   Fri,  6 Nov 2020 21:36:37 +0000
Message-Id: <20201106213655.1838861-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/mtdcore.c:1592: warning: Function parameter or member 'section' not described in 'mtd_ooblayout_find_eccregion'
 drivers/mtd/mtdcore.c:1592: warning: Excess function parameter 'sectionp' description in 'mtd_ooblayout_find_eccregion'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index e9e163ae9d863..31d1be4b22617 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1578,7 +1578,7 @@ static int mtd_ooblayout_find_region(struct mtd_info *mtd, int byte,
  *				  ECC byte
  * @mtd: mtd info structure
  * @eccbyte: the byte we are searching for
- * @sectionp: pointer where the section id will be stored
+ * @section: pointer where the section id will be stored
  * @oobregion: OOB region information
  *
  * Works like mtd_ooblayout_find_region() except it searches for a specific ECC
-- 
2.25.1

