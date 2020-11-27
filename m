Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE22C6AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbgK0RxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbgK0Rw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:52:59 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF1C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:52:59 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b63so5160201pfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvGDkQIA9hhTIQSfQu8qh4Je4X5ShxpEEQWekjkOaZM=;
        b=r5tnZOw8d43aRLz9oo+Vhkqkf1mGz6qMnzFbjlh3Cp64+y6bHOxidHVuYn7+P98/dV
         QQRKlUDdGIedh1sebBcCgcjQVsacj2yaFDgmMDA02ftyeAkjEhdEBikRqKtmOfVVDDWz
         i6afTWDYtHpT56Ul2yb/UfGqk7IbykqESscyBqTdabmQDlKHLApz7yLf0FYjtItfYyDU
         5Lp43A1z9PqiepFB18m9V3RIAttE0uq3V8wjR1kdpKsbNPKmaRWrjDKtrPMcAOPKrlQg
         Vq7BnQ0+YWsFmukGOLXwOaNIGOym6oHyTEswoABcKqUm0hk5VP4QE5TzWMgE9cG4bOsH
         9s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvGDkQIA9hhTIQSfQu8qh4Je4X5ShxpEEQWekjkOaZM=;
        b=W6mBepgqzYBSUVga6bM4xgunvap76zLYa0xdmYQdsrU1IN37UzJJRiEoYSIxHO2oM9
         t61OAvfc9wMzqv/1grYeI1mcOagLkkfVGbYa91TOA/X68y0+li56aPIMOD4tJ+PbMWlh
         IBe5cN+RswaxobECh7hvmy+XS6oKi4QXEb3ol3lz41SDkimjfkAI4kYGzsPDcIc/K1oS
         0hKjO60qMLJtDNgAMuBmqQufgMyUkrJH1Jw4FjoeD/MSB21pJK63fJ1KgBTP0qv49/tO
         lwjbOd3AM3N2BPjuCG/RUaKXqWo2IqOaFe8qKzDQaPd10JgTvJ/uiCOwmO4QRSI1H1zS
         g7dg==
X-Gm-Message-State: AOAM531rVzGDQ9FRFxThaXS5C0ooIN8RSVETHaRuDpL9Pli6r6iZnmIb
        lfnutvXyaFcS9gdTniS3Q792Cg==
X-Google-Smtp-Source: ABdhPJzbApJT7adzDXAFrFGSVT8ecMLt32mMowR/GAPY+3MKXy1QjhfToEFLl6peHRPLCMYv4VsOCQ==
X-Received: by 2002:a05:6a00:792:b029:197:ff4c:5997 with SMTP id g18-20020a056a000792b0290197ff4c5997mr8293874pfu.52.1606499579066;
        Fri, 27 Nov 2020 09:52:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:52:58 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] coresight: etm4x: Skip setting LPOVERRIDE bit for qcom,skip-power-up
Date:   Fri, 27 Nov 2020 10:52:42 -0700
Message-Id: <20201127175256.1092685-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

There is a bug on the systems supporting to skip power up
(qcom,skip-power-up) where setting LPOVERRIDE bit(low-power
state override behaviour) will result in CPU hangs/lockups
even on the implementations which supports it. So skip
setting the LPOVERRIDE bit for such platforms.

Cc: stable@vger.kernel.org
Fixes: 02510a5aa78d ("coresight: etm4x: Add support to skip trace unit power up")
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index abd706b216ac..6096d7abf80d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -779,7 +779,7 @@ static void etm4_init_arch_data(void *info)
 	 * LPOVERRIDE, bit[23] implementation supports
 	 * low-power state override
 	 */
-	if (BMVAL(etmidr5, 23, 23))
+	if (BMVAL(etmidr5, 23, 23) && (!drvdata->skip_power_up))
 		drvdata->lpoverride = true;
 	else
 		drvdata->lpoverride = false;
-- 
2.25.1

