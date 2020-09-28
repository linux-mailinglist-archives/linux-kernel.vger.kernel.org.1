Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1483727ABF7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgI1KiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgI1KiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:38:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C4EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:38:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 197so481117pge.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=i1pcc9oI2ymP/R7jfhbDU4KKfk6rWA2fSDx9MDktUoM=;
        b=DtYSjOrpKknZq+N68FeauZjnGlaqhGj9YfjNR6tHvEjuqYDivGpihXu6Wi59kVucU9
         GlrYIRaVS3kSgB2LCbAKZgGMzaeL1u0ECJUBBQ+yDd4apBDDU9SvHlw3xz7v4Q1CxMWh
         FrYZPilHUornOcRgCErukJIqHJDhPdSLYNDryLVYkeE3B/1gyidx1b9NE8yRnEIoPQDl
         Yg2/NYofdcBOwl+kmioB9a62kcvNRxxp5dRSwLXWXWLMuEnk1ESM6xfY4rlXl/xm+rs+
         30IrRHll/i/4MkIpVKnVv1LZdSK8zQpwPhZS/T4v9qkzp/McajxQBCOnHA2XNxEf+teB
         m0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=i1pcc9oI2ymP/R7jfhbDU4KKfk6rWA2fSDx9MDktUoM=;
        b=BulBly1n18U2omEF/ZjvNiRh247Rrr6qREBraR823xZ9KUGk9f1nXFHrGTftKIA5La
         dqk0vUHcphqY1I3jXTIkTYJHpuaH74X4whN9nqUdo+WB9gXDdz5VtVanQF8sP3Gntj8c
         7n80Gq+neCrVB/ilAu75PlgFZVsAfFUMIVqZQWRlCYZWer6NPUbk21xeCoW/LrTTrory
         E72QhvRCjxZGJqlo82MEREZizsMzJ1GRIL636pCfXPhy7tBqCDzX7klYeMGg2gdMeSiH
         Ja6KJrk335PUctFt+jBn0P1KP9LUj/QRCK6jhy8I8MFRq+Oeo45eoWy2xEKjtMWd0/iV
         f3Zg==
X-Gm-Message-State: AOAM530I5z2DtrXVVOS8G23W/8aPCyW2Yt1pkmuatv6NM7SZQByZxgyF
        9LNgJlpTv4BjgOHvEdOvBIly3w==
X-Google-Smtp-Source: ABdhPJw0S3vcuXHtMfaconrKJz9EMkaPVjPfq6pyIyZadAr4wDGVPNkONYBoNJXk13wwRPqhSvbUoA==
X-Received: by 2002:a17:902:6bc7:b029:d2:6aa:e177 with SMTP id m7-20020a1709026bc7b02900d206aae177mr985250plt.52.1601289491958;
        Mon, 28 Sep 2020 03:38:11 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id c9sm921588pgl.92.2020.09.28.03.38.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 03:38:11 -0700 (PDT)
Message-ID: <b41f9af781bc36f4e5f82fccabc86ebbd0e587f8.camel@areca.com.tw>
Subject: [PATCH 4/4] scsi: arcmsr: Update driver version to
 v1.50.00.02-20200819
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        Colin King <colin.king@canonical.com>
Date:   Mon, 28 Sep 2020 18:38:09 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ching Huang <ching2048@areca.com.tw>

Update driver version to v1.50.00.02-20200819.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 5e32f17..5d054d5 100755
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -49,7 +49,7 @@ struct device_attribute;
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
 #define ARCMSR_MIN_OUTSTANDING_CMD	32
-#define ARCMSR_DRIVER_VERSION		"v1.40.00.10-20190116"
+#define ARCMSR_DRIVER_VERSION		"v1.50.00.02-20200819"
 #define ARCMSR_SCSI_INITIATOR_ID	255
 #define ARCMSR_MAX_XFER_SECTORS		512
 #define ARCMSR_MAX_XFER_SECTORS_B	4096

