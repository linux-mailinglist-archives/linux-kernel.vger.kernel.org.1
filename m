Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550BE29AA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897001AbgJ0LO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:14:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42036 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437480AbgJ0LO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:14:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id a7so1763941lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kx7CART/DxUoMm7Sa0Vnq6dGV13FhDvd/kD3/8Gg8ho=;
        b=WRJYCi/8PhiE0aSiq4DKWnugOqmyTUWLV8teC20a5eXAm5ZLQiJW04YbGu5S4FHHq3
         1+IeBpgH04lJoQ6rWkn2/QxP9VVQdrJNsOLULYrKF8NDLE0stJ/XBfuan65BZf+7nmNt
         pKhzp0IvahIJI5FENoxBxlrik/XKeWlWHzYl2/mHDRIvolZzBXKvlpY/0sJNXJcQVU2w
         YsMhKCGwCNkKz+SJYLNdmCkSOi2dPx8EccUG0L7Y8Tqb8pzXVBMLE8LG9qwamBBAxYqu
         +bNJxg7y+jnflAyqykkVER2bHI5Ac1j+JTGAjcjXjmPhG4QVNcv36LDYcg4rfBK9jtqp
         BStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kx7CART/DxUoMm7Sa0Vnq6dGV13FhDvd/kD3/8Gg8ho=;
        b=jqD7xZSwh+F/lRFnc7n4TKQvmwl9Yu7Z6LwUAJIian0KEpP6xoW7N/WT7Lj3lAK0my
         BWkOnE25foFdvwNCfX9gUDTgtfi6QXkkR09djF2RJ/1Ys8wiTmrvkpjZd5PobdVFvC2s
         2n4CZEgyoG8Ji/unvIVlwyHAwZPd/5XtsiXv2O6r1MPb0D4yMnObZfa+GBG4x9EBL3Qr
         6IbscWCIhtAsoNmEJKsgYibbjZZTEXjoBgsqRajBcc0odzKqhGgs2bKOj2JosyIwydNg
         QcBegvkBZy6L47PNw+aooBgeRsnbVEnolBVNjuhj+oSb4gs33vsLQyGzLSkgTOi8Zcmh
         qaFw==
X-Gm-Message-State: AOAM530MXyuy8JO5qZ+2EvJafH5pXwets1LGheT0892GeZ+t29B9NEeW
        l6C63LbmpO6RgzKdKNt7OAAsgg==
X-Google-Smtp-Source: ABdhPJy51B0fBfONLYlyme+1w8w8xXl3VWMrx+7AUldah86lSav3URmcgsagxOT3Yt43Hco6OvucOQ==
X-Received: by 2002:a19:84d3:: with SMTP id g202mr703123lfd.346.1603797264351;
        Tue, 27 Oct 2020 04:14:24 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id j19sm140462lfb.74.2020.10.27.04.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 04:14:23 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] soc: qcom: QCOM_RPMH fix build with modular QCOM_RPMH
Date:   Tue, 27 Oct 2020 12:14:22 +0100
Message-Id: <20201027111422.4008114-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building allmodconfig leading to the following link error with
CONFIG_QCOM_RPMH=y and CONFIG_QCOM_COMMAND_DB=m:

aarch64-linux-gnu-ld: drivers/clk/qcom/clk-rpmh.o: in function `clk_rpmh_probe':
  drivers/clk/qcom/clk-rpmh.c:474: undefined reference to `cmd_db_read_addr'
  drivers/clk/qcom/clk-rpmh.c:474:(.text+0x254): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `cmd_db_read_addr'

Fix this by adding a Kconfig depenency and forcing QCOM_RPMH to be a
module when QCOM_COMMAND_DB is a module. Also removing the dependency on
'ARCH_QCOM || COMPILE_TEST' since that is already a dependency for
QCOM_COMMAND_DB.

Fixes: 778279f4f5e4 ("soc: qcom: cmd-db: allow loading as a module")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 9b4ae9c16ba7..3bdd1604f78f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -109,7 +109,7 @@ config QCOM_RMTFS_MEM
 
 config QCOM_RPMH
 	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
-	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_COMMAND_DB
 	help
 	  Support for communication with the hardened-RPM blocks in
 	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
-- 
2.28.0

