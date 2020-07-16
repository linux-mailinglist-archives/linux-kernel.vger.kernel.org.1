Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105CE222489
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 16:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgGPN7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbgGPN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F42CC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so10423923wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/50EGrtFWRegK5lMk9s0po818SOAgTGmFH82qJKUi/I=;
        b=LBq+wAlywu8+D/xsZk/Cs41V54ogsSAD0symhkOQYpLjrmqFC+uJYxhqW0UP/c5E1A
         HlqZ5qywOollM5+myR2LqfRsc5+Alvhl5bHRZ0Z4QnismbaeFRT/esVAVg9hGK6aliq4
         /X/srN2wM3FTqHYr90UMBYB14yyyPrBPCny4IBkBKhPszAsPg5emDstBgUGnpf0uqJ52
         RSyIenLpfqHEKS/hHGWhy1BGzEm9FhL4Lfc65738Gvuw+UMhsJnaWv4lx/DM9ttGUcO2
         GmvThV397PbiqHdicaNyoJUo0DEm0RLW5k2O5DeYF3AL06StH8q2G/1fwNokG9guyMCF
         DNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/50EGrtFWRegK5lMk9s0po818SOAgTGmFH82qJKUi/I=;
        b=PHwMAEumx6ty7ioNewvpUFo+GchHV4VGfTJUtO+OkM5V+j5BxCy2ydG/6WQrguD8zW
         oljJLwHPK7yHfZCBCzvq2HrL4lknFLNuYfTTUEgZ+2rX87Th7tB2BpRLSjmZSiB/1QAm
         k6JOMLwG7oyqBTqqogWbzL2hgP3/ooaH+M173y0Jqnk77hs4pTyTkIRApz2QmP9jKmly
         cfccalI6Wo2nM4jYYJO80jULcu82wcYjX238NSMG2WbeV1Zx9iMZBAbo50v4nuF6HZm0
         nSLmeZ1hBvLsGu/JwD4S4M/JrEDUqxUUubmzn4VwKatoMwPiVPMFe0Y40eUn1TfhZ472
         jVkA==
X-Gm-Message-State: AOAM530y/JtGRcSPp2D1eNrQcVypgeqnQL5m+JPH7Un0XveAh1GFO5cr
        cmGqbxVQdoMGgvPK2U3xtV9IeA==
X-Google-Smtp-Source: ABdhPJwTXEWVIoqKpOfpR0giULN1Ul3cws+HaMeoV0tNTI2jQekaFtv3xPzB4pUvgA61vDc3bIkKEg==
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr4302911wmm.136.1594907980735;
        Thu, 16 Jul 2020 06:59:40 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 07/30] iio: dac: ad5360: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:05 +0100
Message-Id: <20200716135928.1456727-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5360.c:89: warning: Function parameter or member 'lock' not described in 'ad5360_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5360.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 3e0c9e84e8dab..e2a2473bfed77 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -67,7 +67,7 @@ struct ad5360_chip_info {
  * @chip_info:		chip model specific constants, available modes etc
  * @vref_reg:		vref supply regulators
  * @ctrl:		control register cache
- * @lock		lock to protect the data buffer during SPI ops
+ * @lock:		lock to protect the data buffer during SPI ops
  * @data:		spi transfer buffers
  */
 
-- 
2.25.1

