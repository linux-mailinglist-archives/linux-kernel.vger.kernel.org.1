Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCCC2A49CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgKCPas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbgKCP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:27 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4169C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:25 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y12so18996716wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vBNjIzKKFLIKIRI5U9uzeH/MngM3x94OuZSkH5Dv/F4=;
        b=josGJE8g0cGm5dRus2hB4+zeisCPoF+VOurpXrjHOF2wKE+Z9FjCJs/AqIuTqc0sR5
         WamgHlkMDTUh07hEBCFvPLenTgMuPn7jxaqWjXXA7/uwO2zXUk+guh4d20HhL9ZohHzN
         vRDdMz1Viofb5Uavi/+/pI3qgQFa6xZaYXBha9NH3qSrwqwsOXZSkFx+3zewILTjBVL6
         SevRPEdVvn58RZyVPMLw/I6H5IFRZrd5HR0xqfuWpmubml8BZzCSnrMGpDleyPmEzUVp
         iOEN/HWUd11yRJADFVoQL3/TzEAtmxxxWVReIB/gRRcxvUDllbRi7pAy5ABg/H3quXke
         ZWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vBNjIzKKFLIKIRI5U9uzeH/MngM3x94OuZSkH5Dv/F4=;
        b=Z7YN3HoarFyFIo2XabeL39dRtlnuDIU1LhapA8IPKdnfT6ZW/71/5sL16B78so22QL
         m62DiWFNtufFtBFWBQWRkQFEYIKJNk9gokQ/c7Yh+Y2W28oOXVb4JpXUmkRjMvzNpczj
         Jwd4HRp4FyQN4BeeSvQi6bz9SXv0ech28wdh3YkaLEa4HbNuh+qAWtz/ZA9hq4VFKXgr
         LwQZRnoij9kdLop7+GCqIW3I6qFAYHIwVldv4RQpunp+I2XO1w8zZzivfpNeYEdnF1a+
         6/2ug+yz2UWJUWtbVgzAspBOC50u0R6RYjpd/aIlesMjYtEwaMf5TZa0RvwGChJobMSh
         O3eQ==
X-Gm-Message-State: AOAM533ifD5Zq4YMrwj1dGKmPSCA51rIeEZXErw7zK3FDn1pu7CXe7H/
        AM89JZ21bwKUWQygOLIfFYQ8nw==
X-Google-Smtp-Source: ABdhPJx03S5vjk5hMfq3uHPc1HN4w5Uj192gBX1i3DR4VYLTiJ50hEydqw4F3+ykr1pITH8+ok1woA==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr26792942wrt.221.1604417364750;
        Tue, 03 Nov 2020 07:29:24 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Scott Wood <scottwood@freescale.com>, act <dmalek@jlc.net>,
        Dan Malek <dan@embeddedalley.com>,
        "Software, Inc" <source@mvista.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/25] soc: fsl: qe: qe_common: Fix misnamed function attribute 'addr'
Date:   Tue,  3 Nov 2020 15:28:24 +0000
Message-Id: <20201103152838.1290217-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/fsl/qe/qe_common.c:237: warning: Function parameter or member 'addr' not described in 'cpm_muram_dma'
 drivers/soc/fsl/qe/qe_common.c:237: warning: Excess function parameter 'offset' description in 'cpm_muram_dma'

Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Scott Wood <scottwood@freescale.com>
Cc: act <dmalek@jlc.net>
Cc: Dan Malek <dan@embeddedalley.com>
Cc: "Software, Inc" <source@mvista.com>
Cc: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/fsl/qe/qe_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 75075591f6308..497a7e0fd0272 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -231,7 +231,7 @@ EXPORT_SYMBOL(cpm_muram_offset);
 
 /**
  * cpm_muram_dma - turn a muram virtual address into a DMA address
- * @offset: virtual address from cpm_muram_addr() to convert
+ * @addr: virtual address from cpm_muram_addr() to convert
  */
 dma_addr_t cpm_muram_dma(void __iomem *addr)
 {
-- 
2.25.1

