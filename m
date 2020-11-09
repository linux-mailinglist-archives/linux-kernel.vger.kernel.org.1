Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC852AC3BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgKISXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgKISWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:33 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298BCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:33 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so384353wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmRHhQEVdc7j5b8GRJ+bwBPDfCwyz1df7aW7vS1l850=;
        b=ooFGARyLJowx89bv4c+IWUlkxGlUcbdgBeYj9e3XDQ4tCbbK29cBwDi/2apoE7Ezen
         aA4ZXA9omb1aR9rI7SUOtGlFYdS/pk/N36+XDCt+tV9I0JroBpZHWrSayKdbuWE9kVjW
         VU61NyViDdUZ0VJQrkaUGClVY7E5PnoS+BEztEliNmV77vSeoAClw1knzcI37pw/FNDL
         g2S8pSaJHPjwmTkB9M7CPrQ+y/1ALLDt0+xYjrjaoDuBZSIps7MbG3cRRL0/mPwhpGb/
         bdATGXrtQ2CwCcMzRVH2Lp9U5RI2lDhOCMuKnDQH0XRLHfKPyzKW7/5JwpKDcj29yVIi
         Fq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmRHhQEVdc7j5b8GRJ+bwBPDfCwyz1df7aW7vS1l850=;
        b=ROmLsvFl7dvraf4xWAcFcv86Pe4uESZAX9RCgY7Mo5jQUkTTUctC3ML8Isbank7qFF
         gMt74qopJFaK/Bc+5oguxqYNrMYa4SQRAEGdoZWqXS567t6XW/J69bTP1GKExCwZzd6J
         yb+w51W+2QiCRSOwTJdInsGXwJD7eH0xDkoU3vmfJjBhetQSlUrOuBjnqX7ivUey6E8M
         mXde8uOcS1ApKw27bsBo+W8DJdgPu92FRDAvI5Z3fRVgcqQg1vs278auONLCa4Tl/T5x
         ef6fEfIKB+tGSsxrKyI89ikXEWAWEwKXfeJvDDG3K0U+W9Jg/UU8pRX2IYBURxRVIe16
         gjPw==
X-Gm-Message-State: AOAM533n3ywnA0WKIc8K9dICsINKI+RqbzRJNJRuJ80d+RxOkTmzDSf/
        75wDftPnFS5SR64fbR4ehTI7UWOfKwZySh1o
X-Google-Smtp-Source: ABdhPJyvQ6sbfXil1attHlSR9OI+jyrXy9dt1ZTBNHy8j8ojMjNnLhHazzRckJ2Ea46k0MGWOIBXFg==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr433818wmg.165.1604946151927;
        Mon, 09 Nov 2020 10:22:31 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 08/23] mtd: ubi: build: Document 'ubi_num' in struct mtd_dev_param
Date:   Mon,  9 Nov 2020 18:21:51 +0000
Message-Id: <20201109182206.3037326-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/build.c:61: warning: Function parameter or member 'ubi_num' not described in 'mtd_dev_param'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index e85b04e9716b2..40fa994ad6a8f 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -50,6 +50,7 @@
  * struct mtd_dev_param - MTD device parameter description data structure.
  * @name: MTD character device node path, MTD device name, or MTD device number
  *        string
+ * @ubi_num: UBI number
  * @vid_hdr_offs: VID header offset
  * @max_beb_per1024: maximum expected number of bad PEBs per 1024 PEBs
  */
-- 
2.25.1

