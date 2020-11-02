Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9DA2A2A0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgKBLyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgKBLy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:28 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C94EC061A48
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:27 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id g12so14220600wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaSgExpL1nCtBP1Xc6kSLtHGXCrLErSmtz6Y4QPAfFg=;
        b=UGwwhJqOoS3Rp/Ibr7m1kmtFcpqS/DaYg6/MLmYIqmIHmjm18yFoO74jKG+i2V9K34
         pF9yjLX9yOJfMjmjH8lLEHNSwiAXsJsVyQLkKRiR+RV/VYnDMYRr6W8EKP39qT++Jzfp
         W2e5HuMxV96fNdA/uRR2Nxge8NqFjcke6ahjWYWGWYt9iY6fnMBppf25H2VuBm57fakY
         OaMOFoQxa8FyJERKQ4tMXIbXdmkS3gh3EG6rK6PoNJr2sJNN/Q0ArDqW2Wu6WjFXufkb
         E9X0oUn660fm6tbwBtDAfXHUJJdegDkvFYYIvSLWMpgYcHCfkGV8Hp5qVtjRwtSWJwsU
         Ll/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaSgExpL1nCtBP1Xc6kSLtHGXCrLErSmtz6Y4QPAfFg=;
        b=k3iynXUTlYnkmvgE/t3lq97KW0d8nlGKG80skBHSGz0wSwlOnBYeHFGDUCr/S2QjeA
         3xqOY4+w743WPgkP8F+/Mbq5KqAOpSt4+iZFb35HcPopmH6uG/KgBpajW/u/bnVqbGCK
         ANQrQHGzoDgZsNULHRbqi3fypEleaOKT61NfdHEZYCTVCLRpZvKywNZHXRaYYf3WnB+P
         2YDMmSUfw8qMckm4P2naQQ+5+GjO1VuKr/TrMurXNCyHIzuWGYSJplFbQmixr5++bPZS
         1QNtw5ky9ImORJWPuO/SEMFd0Rn5eAUXN5DczkYcTXbwUV5htgBTnpYvGbPErLzOXraV
         WBYg==
X-Gm-Message-State: AOAM533g19ZEDGsiTw1atu1mNWD2UWlE508yGA8amsWE51jvTuMDO31p
        dsdMB4ZBb1ftGuaQOJiXLsLIUA==
X-Google-Smtp-Source: ABdhPJwyWOeESSW2N5ZEBETQvar05vBOvWfj5hR9v638iZ8Jd5zKk7f0XzxPcmaEsUmVjPC2epzmHQ==
X-Received: by 2002:adf:ab02:: with SMTP id q2mr11068973wrc.320.1604318066256;
        Mon, 02 Nov 2020 03:54:26 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 10/23] mtd: ubi: kapi: Correct documentation for 'ubi_leb_read_sg's 'sgl' parameter
Date:   Mon,  2 Nov 2020 11:53:53 +0000
Message-Id: <20201102115406.1074327-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
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

