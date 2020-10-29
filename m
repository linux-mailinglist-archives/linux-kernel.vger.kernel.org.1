Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455A329E86E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgJ2KHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgJ2KHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:07:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09179C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r186so1950728pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2D3ljIRngzfKMwuPIcKvtEhnJRKSaVwL3WkG6knrvk=;
        b=iJdMqKJo/Y1DfzCXyrAsC7ydxAYWlLXt65DaS6ZVvbJzNhcxMlgdqH9EL/Ob3JzeER
         AbjvQv6bu/QTEGkmE5JjwP4uPDLBzjlgFWzfDFkd4ALTbpz7yJMW5yjagF8GlYlYa22I
         6x4PYRNnWnVUEsPK3BhmcwyRWUKB9q2rB7EVJlRm6dOalZdlOWfOYBWKKS3Wqr4SkTyr
         s/+pyPvgzjDNJx8yt4VglU/f3HnsJt54JmCR/R5pyDiJHP8Pp8YkWU3v3HERpwfqUhuG
         Q9CWdWimLtDB0hL5uBei035TPMO30Nvk2eHOthy3iQVq9cFS7/T1FOT2vZ6ltTMLGHbv
         nOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2D3ljIRngzfKMwuPIcKvtEhnJRKSaVwL3WkG6knrvk=;
        b=b4+EtxmpE3ELg5EHy0OcoIJNHd8y9oISYjtfeFhb7fr5+DbHX+2Yf2LznLXYyFfXJB
         w5hpf7s8W/LzOG3iUYjDquoLf1V0NyVG5Bba86wPSZhNinIkmVcTSD40FPSAsM4pMi4J
         dYUr4qZD126xuUOxhtNHfIo8S+oV4xutRU9ELH9JQ1sA65dyix5UqTf++4xuiFePvLC5
         vvsCcdmlTLqXy7oNcEkqLWbmvONjukCH4YhArEKZZYSQmnzr31YCNzDSzzeKIZjv6R+j
         /8tpZRFYOGjnawedU4D2N7evuyj7O69cd8hMdB1XZjX04XfejrRmHm55Ucbqypm5r+cY
         ed8w==
X-Gm-Message-State: AOAM530UQgTuSXzx21IkmP7F0tfLMfNUa3ox8mdbIoe+Aq3HdAo3qmTG
        LWwekzwEV2eqdhT8Bn8Z8lo=
X-Google-Smtp-Source: ABdhPJw+sl1+eNNJtth6xd8veXHyJIWPanGxAy4CkMbMtjxGSF9IHIikZ+eIeze1C6rwhn+dMh2GNw==
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr3634098pjj.206.1603966067626;
        Thu, 29 Oct 2020 03:07:47 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id 186sm2457826pff.95.2020.10.29.03.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:07:47 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 9/9] mfd: sprd-sc27xx-spi: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 18:06:47 +0800
Message-Id: <20201029100647.233361-9-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029100647.233361-1-coiby.xu@gmail.com>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 6b7956604a0f..4db2ec9ef2ff 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -206,7 +206,6 @@ static int sprd_pmic_probe(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sprd_pmic_suspend(struct device *dev)
 {
 	struct sprd_pmic *ddata = dev_get_drvdata(dev);
@@ -226,7 +225,6 @@ static int sprd_pmic_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
 
-- 
2.28.0

