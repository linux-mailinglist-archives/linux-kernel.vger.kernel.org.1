Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62C82769F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgIXHDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgIXHDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:03:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02DC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so2484531wrl.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZaPNKJuEacLwZnK7xKIFA6JPudKdUr5CdDzQLqL8J1s=;
        b=T+iO2xpI730STKPDaVWnziaXi3onIHvmBct6YAd5f0zDT/R5ybbia0YEOmxgmHYwZj
         2qHlJWG8pEZ1861GEjUtePIV7g30opoVA3/G+2DHdUeSGro/xq68MbX8fsig1UiJNNYp
         vGQzBN9cjaqBQpBYq8zHd4qH0eJyLc26xh1sdqKYCJvLrzdIM0iovDnvx9vDx9ue38Vk
         UHSjHlqTzw4VzTKcubQKviPVUPdz237nLkTwUilMgxhwwMnW09FwxQMQ+2yeRDWNsW5x
         vdsCu9HA5UC8s7XT15QUwsQHz2UUNNW6AwSAvFH2gOXf/XNnQyo26wMvs/nrIt/8az5y
         vTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZaPNKJuEacLwZnK7xKIFA6JPudKdUr5CdDzQLqL8J1s=;
        b=RBtttTSqjefFB22eqMeJs86P/c701MTD5rHIfektmv4022D2zs/s8no+zhXLgehber
         LEiMHYUZXtM2/wPzO4TkEigvk/qOLmv2pKAmPsip/KW+hxcxOvekzOKzvUGK8NFCby0h
         Edkla2Kl9Flpc5fucOL7RSt7p7DNADDjV0g+XQJ93T3g0XTSYjjYGp8owd/1MjKsUjnh
         CFTGKxAi/qMg+QoQ4J6I/aH8AiGMK97gKQDTqWx1ga1czh1Eqtcfkk5v30iIGD6w40c8
         crZdsJeMKv357rs3JVS0QK88caq4G7PzeH2djPKCFuJcsAaB02iOBLgS1coHWNE0xl/5
         tMnA==
X-Gm-Message-State: AOAM530+/K6ltuk2zJJqkVkpmX9IXNZIsCisaYmwP5hgjaXltZt8iNOM
        RYR31nOKl6MZ7unCExlEXDsTAediS/I=
X-Google-Smtp-Source: ABdhPJwqCN9yFB7+UzniQAv3T6KS6D6X2axd0D8KywbFKHSJcpqy055E66rSbMQlOBtnsiOna2mO5A==
X-Received: by 2002:a5d:5583:: with SMTP id i3mr3279000wrv.119.1600930982434;
        Thu, 24 Sep 2020 00:03:02 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n4sm2320628wrp.61.2020.09.24.00.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:03:01 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 1/4] habanalabs: correct an error message
Date:   Thu, 24 Sep 2020 10:02:56 +0300
Message-Id: <20200924070259.19833-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't try to allocate huge pages here so remove the huge word.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 3324332811bc..84227819e4d1 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -77,8 +77,8 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 		paddr = (u64) gen_pool_alloc(vm->dram_pg_pool, total_size);
 		if (!paddr) {
 			dev_err(hdev->dev,
-				"failed to allocate %llu huge contiguous pages\n",
-				num_pgs);
+				"failed to allocate %llu contiguous pages with total size of %llu\n",
+				num_pgs, total_size);
 			return -ENOMEM;
 		}
 	}
-- 
2.17.1

