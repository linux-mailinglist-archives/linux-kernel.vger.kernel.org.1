Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1AF2AC3B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbgKISXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgKISWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:36 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB89C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:35 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so393870wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaSgExpL1nCtBP1Xc6kSLtHGXCrLErSmtz6Y4QPAfFg=;
        b=ToJRou/GY83l76OBzOA3w6EcozYKqJ27Q2TR7tt6LGIQ6blHcsNnvL9ilkDPN1mDhk
         WR1lD8Ai2jcj2p5Zvq8/hoCtpifwJ0crOUSBwh27ZDta9uWV5Hi0d4gd5adiZ/EYvU0A
         lgogovwxBFq+GVsnNpmooRxslu9IMrsVrBx6Bd4YkcTz2WgfvPXRORsaCAb+nTrvOTEE
         EkDX3ucAfnIDqt12fWwV6RSbF9WiAichHRikKcLs97F/dujnuJEqNTWyoTgb4IMJ/5le
         CjQRMDSSQVbSliV3EUvkdbw+1pM6wy4jkGWSgDACPpJ5nmMDWZvLwW3fA+KVMbvI6zCL
         2z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaSgExpL1nCtBP1Xc6kSLtHGXCrLErSmtz6Y4QPAfFg=;
        b=LP94fRm1LMhrMFWnc5rkbpLEVRod1UFw3XjNvdZPNeN27dSBPIZ+63pTrqx4pC6In9
         IgTo3kxWwq8YENLuHQUwpiopYRBWome2YOEeAXtwLMmdKo1wzuX9jFb2lsYs0Y8Zo5W6
         5DLWr+Et+kF/nUrjjmluul1B1kVIArPSnG8NWAfscD6+qAFaOnErQ3XfLW9fzqNRna2+
         XpX1+tzLja6pK3CV8NQIIRuT7oLtBwLLZF3fjxIkrSsf8vou36dwyVk2HyxWlOos86+u
         hbN8aE3uXrR9i0ZDwaq1FCnkrX5gBIWUYN9M1B7PJ+HOaOdpUZdl9CfA2elEKs+nskqD
         wjfA==
X-Gm-Message-State: AOAM533mKdxKA4QNvmJIeaiXLws7k9eJazCFl8i1d9Nzgfqpc+/8ejZF
        4ud/PNF+zZfrxzhGHdXRui9giA==
X-Google-Smtp-Source: ABdhPJwpufBZ2yW4s3uXsteza0ZdpSIpxc+C+KW+uYuuZbu541OjO8nozJyEoKXm5P2A2knRB+Jwag==
X-Received: by 2002:a1c:a445:: with SMTP id n66mr465425wme.51.1604946154476;
        Mon, 09 Nov 2020 10:22:34 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 10/23] mtd: ubi: kapi: Correct documentation for 'ubi_leb_read_sg's 'sgl' parameter
Date:   Mon,  9 Nov 2020 18:21:53 +0000
Message-Id: <20201109182206.3037326-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/kapi.c:464: warning: Function parameter or member 'sgl' not described in 'ubi_leb_read_sg'
 drivers/mtd/ubi/kapi.c:464: warning: Excess function parameter 'buf' description in 'ubi_leb_read_sg'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/kapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
index 9718f5aaaf694..0fce99ff29b58 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -450,7 +450,7 @@ EXPORT_SYMBOL_GPL(ubi_leb_read);
  * ubi_leb_read_sg - read data into a scatter gather list.
  * @desc: volume descriptor
  * @lnum: logical eraseblock number to read from
- * @buf: buffer where to store the read data
+ * @sgl: UBI scatter gather list to store the read data
  * @offset: offset within the logical eraseblock to read from
  * @len: how many bytes to read
  * @check: whether UBI has to check the read data's CRC or not.
-- 
2.25.1

