Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD40F2DB734
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgLPAAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLOXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:32:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EBC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 15:31:20 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id y23so758801wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 15:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NdltaZaVdnosja55B5yVwkwQ3cpKndlfH4RmsgoG5is=;
        b=OD1BYevwfvErSMrqZ3l/SdLgYXgUUwwwx/wCMMMxWpY58tgUFtR69S2A5eiB/HHe66
         atQ6VjrM8HZPHKrBZeRc4cEnyYJ1T/I0QJuBTuyWCdXcILR+xDXUWWe0ieW2laxvDRc6
         mscduWoMOrY6j5CUpQXUHT0n0sUVZwwMlj07D0en20d88INgirQ/PmjH6Z1VlGvzOHFu
         2fl8CDIxkM61tIluH/qhr4hO6PnGJkG06QT409PMKgfGvfc7ER9jvAfKI2iNG/Uyk++2
         hpPay0MYaRSuiqJ08VHhtcCOOh3/HV8ug/Ys9Dt0+XwyroBd60qF3zlzBzhW6EbndHz5
         XslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NdltaZaVdnosja55B5yVwkwQ3cpKndlfH4RmsgoG5is=;
        b=bF6/iVRpePyF3TYRzkqoARQQF9PqaPDPkJByoje+/JT0I0t68igRnMfLLUD2DI2+mS
         uOCrzeS782fwcmXC8ugitDaGswnIeAn7kwvmr7edtUVf3nWYDx/sbX2cuzSs+KxvjZ65
         9dqGSVEJOA96JuKdhLMr76s5WsjGVnGybixxxV3qqYEVDODYU8UEL7mSAL524Ay6yJzc
         iD5nFcMDV9jcX+tlzVJ0Dow+zUvmXSPJ2tAVmOsVaWxKb3boxwTAi5YsOMYrr73wkO9v
         6FNpCLicjpTxTri/l/YaijlQ2u5QeknzjlwoKWrQaGanlTM4/ItzsKxl9T3hsRzMs4Nl
         8rrA==
X-Gm-Message-State: AOAM53169ZmBZLo8Am1p8S8xRbbm+1CG3ccZ1jExEBQC//Tsm0fk+oa4
        1U00QOLvMaofdf8pkiYtiaZ4CQ==
X-Google-Smtp-Source: ABdhPJx4WO43NxbwcDRkYtV0kaHDx/FLIzVRHOV2u/OF1Ic6TezC9+wflt5VLgH2ro8UF0k60LzAhw==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr768403wmi.115.1608075078550;
        Tue, 15 Dec 2020 15:31:18 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id l11sm249866wrt.23.2020.12.15.15.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:31:17 -0800 (PST)
Date:   Wed, 16 Dec 2020 00:31:12 +0100
From:   Marco Elver <elver@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        kernel test robot <lkp@intel.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kfence: fix typo in test
Message-ID: <X9lHQExmHGvETxY4@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo/accidental copy-paste that resulted in the obviously
incorrect 'GFP_KERNEL * 2' expression.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/kfence_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 1433a35a1644..f57c61c833e6 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -665,7 +665,7 @@ static void test_krealloc(struct kunit *test)
 	for (; i < size * 3; i++) /* Fill to extra bytes. */
 		buf[i] = i + 1;
 
-	buf = krealloc(buf, size * 2, GFP_KERNEL * 2); /* Shrink. */
+	buf = krealloc(buf, size * 2, GFP_KERNEL); /* Shrink. */
 	KUNIT_EXPECT_GE(test, ksize(buf), size * 2);
 	for (i = 0; i < size * 2; i++)
 		KUNIT_EXPECT_EQ(test, buf[i], (char)(i + 1));
-- 
2.29.2.684.gfbc64c5ab5-goog

