Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963EA28CAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403910AbgJMJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391443AbgJMJ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:27:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3711C0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:27:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so14524386wrl.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8a9970NyoL8j/WouYPI3QrVUX98ELJ53wzM6Z8s7NI=;
        b=XHfjcF0ZziDDiY5hGxeJXZG6wHx+Mq3O7G0F92FKfFobe2YcU9Phyc5G0rUD1jDbGk
         w0yxK2uXGTFkfgajQvrtp7y46i/m/OD/KTnxf63f6ZEuCTWkzZbfk970AUST0c0le71N
         KpegIlZ3ee5uccsOOK2TBrIfT2n8JmAOS5wYyLwN/Von53kMhx8OaVjSPIpBD3ElrlWQ
         tMIjAzJTVBxjOZ+7+xJBG1XLMThQKZBdskghBck7fhMnD2XuIDQsDFlOqBOda7agxQ0q
         tYmpBahs9mj53RdVlX4Jx1+t1/6NQN1N/3sBLPr6uxvcGrJS2AarVnv8FlF2vm8ZyaxV
         um/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8a9970NyoL8j/WouYPI3QrVUX98ELJ53wzM6Z8s7NI=;
        b=Bbw+M+YWKVj4vQ88SfsC4xb9vsyCOx4nCABqFTtgZScFWb6R+0PV9SQUIq3TiI2rLB
         smiQjTXPxz6KtopglnEg3al4CwHHOS+n9sEBlqTEIOSUQ5vf8YMlej1Ro8/CAB0yDY23
         v75Cs/sKmSF4w1OnvicfecZr2SOh5NfbAHRz19AgLcYSvFVCiaHLj87thpbZvsksb9de
         7aepXrC/sxDRe5eiPn3AGzhZR013L07jTx4b2vAvX9wa8Sz+VTSoh5hAO+4UaS9lDPvi
         5LrMvAWSAHxEz38D/AiiYy8RboRG2x75coAI4YTTaQB8Nh+mw0U6vcoxvYTQJlWUdrdb
         D4IA==
X-Gm-Message-State: AOAM5328JAnzQJ/9mBwvhIM1h3jAYJg5tPMMRyZaVQQ4Rb9wF4Yvk0MH
        Mih52o0XraKkEFlExAaZyD9NFQ==
X-Google-Smtp-Source: ABdhPJysxJ0YjqYhgvuz7yO6DNijyqhaPhUZZeVNIIdsnRzkGQZ9wKFCrAovRtTSeI2LSqBeku+mIw==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr19794943wrq.129.1602581235480;
        Tue, 13 Oct 2020 02:27:15 -0700 (PDT)
Received: from localhost.localdomain (147.169.185.81.rev.sfr.net. [81.185.169.147])
        by smtp.gmail.com with ESMTPSA id f6sm14484830wru.50.2020.10.13.02.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 02:27:14 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] cpufreq: blacklist mt8516 in cpufreq-dt-platdev
Date:   Tue, 13 Oct 2020 11:27:09 +0200
Message-Id: <20201013092709.3336709-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013092709.3336709-1-fparent@baylibre.com>
References: <20201013092709.3336709-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8516 to cpufreq-dt-platdev blacklist since the actual scaling is
handled by the 'mediatek-cpufreq' driver.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index b8d48ed37156..73cb8f2ad9d4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -124,6 +124,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
 	{ .compatible = "mediatek,mt8183", },
+	{ .compatible = "mediatek,mt8516", },
 
 	{ .compatible = "nvidia,tegra20", },
 	{ .compatible = "nvidia,tegra30", },
-- 
2.28.0

