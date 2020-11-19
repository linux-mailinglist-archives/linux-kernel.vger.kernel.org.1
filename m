Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE19F2B928C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKSM27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKSM25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:28:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4735CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:28:57 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so6301652wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nk6ndwLNkHXR1KZ6KubRVDQdUjrvbsIwDbnpAbqsS8s=;
        b=joeY1dUKxoqThAjnOvu1ZdBc0EE1b739MQZOmwNt+Dfnn/bYA3HG7FN7RTJgMRh8nl
         ecd8korNIyRv3lI60/xa+AHlKRKGk2EElT4MUnxjsx533IOlO332ILTqsaqdnKda0kJV
         sqEuI0G92S8oKv7f4akqtVj5IcO6Od3TL2+ayDA8VFNfPeHqhWIAUCsGBGGC8mPerYTO
         rFEPJCjCgDgVL+3yRNNe57OEv0ChWPnotIeux8tELyouYYJx/HaBz8/CBtCZogY5qYiq
         gLBM4m3SyJwn8uRE8d1oyh+QGvyxKqfheT5QLjyROkYhzNorKzVCgXPW+8CpmoYSgk2m
         i8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nk6ndwLNkHXR1KZ6KubRVDQdUjrvbsIwDbnpAbqsS8s=;
        b=T102umvyYZDbpP1x+dZQeKyaZjCQDwlZJxXGgVrF3hRox/aJ+3dWCG3GyUaP+zaSES
         O0B9oymHvl6yKw2cWjwfRUHTSNTudkCerBbN19uoxqudkDHeWi2GliLdfr6s9sG0GTA6
         /ELAxa1gjgppWZU6ULGpJtpiBwMqu7RuwmX1N2+hkwCtQAFBBBg6bONCD3Gyo2lMpV5A
         /1gKL6VXfTahkS7KdkTeD9+fHu69rh8YbkaHgKNr8uf/x7xM02YkO/hrnXOVAZlEuME2
         SYOuTRpFf1levFT9/EGHE8TYtdCRYKvtn1hH6M3mXfT5FGnhrSM4SAqPs76KZpXMVZxp
         xNHA==
X-Gm-Message-State: AOAM532Klgxagx6ZUKkCbE91vPnAbNIN3aDzfCyPSxu8Q9GP8u+0f6f3
        Ryk0RUpJokDfjL+wV+jx5wg=
X-Google-Smtp-Source: ABdhPJygB+5SOpdZQVy+Chngx4Pkoqd6FruYwpo+6Jet4HCmMCq9VkprgeVidnfSLEfqgVF0cLT0YQ==
X-Received: by 2002:a5d:4fc1:: with SMTP id h1mr10645955wrw.226.1605788935926;
        Thu, 19 Nov 2020 04:28:55 -0800 (PST)
Received: from localhost.localdomain (59.red-81-32-35.dynamicip.rima-tde.net. [81.32.35.59])
        by smtp.gmail.com with ESMTPSA id h20sm9005590wmb.29.2020.11.19.04.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 04:28:55 -0800 (PST)
From:   Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>
Cc:     Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        Jiri Kosina <trivial@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: trivial: hikey9xx: fix be32<->u32 casting warnings
Date:   Thu, 19 Nov 2020 13:27:38 +0100
Message-Id: <20201119122737.189675-1-juant.aldea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119114029.183828-1-juant.aldea@gmail.com>
References: <20201119114029.183828-1-juant.aldea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings reported by sparse, by adding
missing __force annotations.

drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32

drivers/staging/hikey9xx/hisi-spmi-controller.c:239:25: warning: cast from restricted __be32

Rationale for #164:
data is declared as u32, and it is read and then converted by means of
be32_to_cpu(). Said function expects a __be32 but data is u32, therefore
there's a type missmatch here.

Rationale for #239:
Is the dual of #164. This time data going to be  written so it
needs to be converted from cpu to __be32, but writel() expects u32 and the
output of cpu_to_be32 returns a __be32.

Signed-off-by: Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>
---
 Changes in V2:
    - Fix typo in commit message.

 drivers/staging/hikey9xx/hisi-spmi-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index f831c43f4783..861aedd5de48 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -161,7 +161,7 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 			     SPMI_SLAVE_OFFSET * slave_id +
 			     SPMI_APB_SPMI_RDATA0_BASE_ADDR +
 			     i * SPMI_PER_DATAREG_BYTE);
-		data = be32_to_cpu((__be32)data);
+		data = be32_to_cpu((__be32 __force)data);
 		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
 			memcpy(buf, &data, sizeof(data));
 			buf += sizeof(data);
@@ -236,7 +236,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 			buf += (bc % SPMI_PER_DATAREG_BYTE);
 		}
 
-		writel((u32)cpu_to_be32(data),
+		writel((u32 __force)cpu_to_be32(data),
 		       spmi_controller->base + chnl_ofst +
 		       SPMI_APB_SPMI_WDATA0_BASE_ADDR +
 		       SPMI_PER_DATAREG_BYTE * i);
-- 
2.28.0

