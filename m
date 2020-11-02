Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5126D2A2A23
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgKBLzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbgKBLyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:21 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34849C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:21 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so483152wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAVB42jTKgsR2DuIhHd9CknEAkwHuiO/0Jzqc0AJHek=;
        b=XL81MlRMs1unRPABpCgpJr+JaAeomz/oNcxN1ej0qS8kYI2ziweEwYNSlZgCYjZA7L
         2Ar0q/Wp5pBteG945RKcHjC4IklW/xM5zP+1HX47n7maSnyNQzmmEI5ocHlXk/seQvA1
         CMBDmqX3HralPUOQDPD0PNWxqCyNFlDccPSStC4/nKT60p5aaNcHFHCurSbhDuou7d+H
         wxlU2nz5d27NDB3sQQ3kRWoeLOLE+GXtBKkWuzV0QXnL4Y8RL+4GcTGbpYgTjMu7qCvD
         Pzs3ZzggoPXNyQFJ/Jgz3fzmHi8R6EDyKQGrf5fhJnH6qKK3zz6dnCwUsHhUBfNsq1n6
         7UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAVB42jTKgsR2DuIhHd9CknEAkwHuiO/0Jzqc0AJHek=;
        b=PqjddNhAMKe+Lz+EWKswatusVZSVdXr4Q9tBjS2/RTFO/HHcgFk820TVu1su7ZFgxO
         b/JoDqTb7BgXDQlgbmNgarSTyIko9Hp50cqMqRSWkf+cWOC1MYoYzaoZuaplUXkEeLNp
         uN37RmsLuaB7X5p2uL0BGK1qYMhFjSNPaa2IG3iHcXn5PpDGFyhOEmdcEL3phG7K4Ie6
         vdiO/nbavfyihpbQc7pD1OHyErDuMOmElEGlVzQRmCycWpdnM/7CcH76A29STR5dIX11
         0t7x2raq1ixIFn1KxY8rgXfEERQkRPW47d2+i86fBYGLO2W8y1gt8RVim+ZbavwzOL5O
         YpXg==
X-Gm-Message-State: AOAM532PItk3AJ+sebjFqOcQz+X07F6pscg/Gf25YNeD00RZYSMgMS2y
        8r5H0zMeq+oxFbTf1gOj0kjabA==
X-Google-Smtp-Source: ABdhPJzoSGbk1vNircq8X/CQtBjTD3GlaLI+8BFhFhjLt7IOpKDwQH0kmAv8dlQ+o0zWDWxRSu9bFQ==
X-Received: by 2002:a1c:4d4:: with SMTP id 203mr7507931wme.153.1604318059932;
        Mon, 02 Nov 2020 03:54:19 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 05/23] mtd: mtdcore: Fix misspelled function parameter 'section'
Date:   Mon,  2 Nov 2020 11:53:48 +0000
Message-Id: <20201102115406.1074327-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
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

