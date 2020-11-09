Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8FC2AC3B0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgKISWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgKISWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:36 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677CFC0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:34 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so410840wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/I+nJpznOBt9dN4XJqBf8TuNQJ12DhAWcPprYkWhwFk=;
        b=rQCgoNIa+HcrAR4oxWzehDdHf9SYcJne82iqJeRlLaO/0SzjYou6fpwvojFv2tn63b
         +xMb/hawmDEvq9XV1NCbUhyekrHecLXwpbqsC6TQY4ychclYMzoKFOeJqNGTgn6EldL0
         PpQWssmHYrxPNPNOicxE4xA9WPZFJIeS8RFIDqvt+BvDfHbaqLExjSATD6aOq7Xh7IIZ
         yPKlWSWlEybkfxKCHlriq8rQuidtgCt+/0gIcovjcN3Hs9E+T2Wa+AeTOqNg37y+RFsR
         Tn1OELxcWkmRYlEuoftfHNIzCMElhauet+HDHul1CO+Wfnpd6vvSd1/6EcEUiyWEz+Ns
         PkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/I+nJpznOBt9dN4XJqBf8TuNQJ12DhAWcPprYkWhwFk=;
        b=kkZNKlYYg6FV/rGdQRttgJCOaxoUFsvDEEoAmGIYO+Xh78/hl06wGxE4/3BsfLGMPy
         EkwGV/A1+69Bnu71tRH8nYOL1zB/tibaG1tFaBGIbf7y+u3s6jYBe7SDVjIXU3V9ughc
         HjOfApy4cxs5HsDo4mH9Vz8Nqp6ozDYYuB3Q84YUFfsbz8wmwqBYAqcSKKHF7Q92hv63
         fXShg2UqX5RNep4xAPE8uNbBXTIuacalPaJ5nc8xhR7qOzIEyFuNGkJWp2Q/72OH8+5Y
         iNBsiqBFQ7NyAkH/v13tycavYlSnmFD/H5n/pkhpVH6ex3WyQmPbHnBYBB5PxZ9QAmnt
         72VQ==
X-Gm-Message-State: AOAM530KmCMXxgJtRLmRdapjTiFwB8lklPARnT3Qqd7mbTiudv2hn9xH
        x3tTtGi8Ld9jJ67eaqvBNrLIxw==
X-Google-Smtp-Source: ABdhPJz86bFhflLs7CghxzpISFfVhT4PLe1hRqnLAjFri5fiuIo3PTpO8gVVH55zfoykehzJoHbsqA==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr519127wmk.4.1604946153142;
        Mon, 09 Nov 2020 10:22:33 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 09/23] mtd: spinand: toshiba: Demote non-conformant kernel-doc header
Date:   Mon,  9 Nov 2020 18:21:52 +0000
Message-Id: <20201109182206.3037326-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member 'write_cache_variants' not described in 'SPINAND_OP_VARIANTS'
 drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member '0' not described in 'SPINAND_OP_VARIANTS'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/toshiba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 21fde28756742..7380b1ebaccd5 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -28,7 +28,7 @@ static SPINAND_OP_VARIANTS(update_cache_x4_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-/**
+/*
  * Backward compatibility for 1st generation Serial NAND devices
  * which don't support Quad Program Load operation.
  */
-- 
2.25.1

