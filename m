Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BABF2F86DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbhAOUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732635AbhAOUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:40:33 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE46C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:39:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 30so6759829pgr.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mx5JYqiiqeL/1i/1oqLREwGjuTF0JZu0HOVxr4I/yE=;
        b=B7e3vVB5BWZefAgSQtq4sqCrLA0Ra1GJmdYR/yQZiTakDXwbk7HE/z0koHPAOx1DqO
         1DwjTZW6v8CUh/xDPYoIxE4JuR60exX5FDGIFDk/E26csnte8so/Z+/cpGIHQd9bJ9/v
         4a2fDQ0Ha7RlSYw5yglrKfydi5U/wMRXCMb3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mx5JYqiiqeL/1i/1oqLREwGjuTF0JZu0HOVxr4I/yE=;
        b=IGfzhHlMeA0bRT1XanCILnFGTRVC6soz6otEQ6TTZdQWRxRBz1XKjij3IDpN2y73qn
         foNFFCgddzzqfxpY+vI9uCiZszAVpgHKshhYVeGGNcuZb9TuEFSLtbYoN6/TDtXhTqqN
         BnHPOtQLFUOz5xK52TFBRSa+dHkyI8o4/D3o/Yafysox7tPI53btLB9l6HxQZNsanriK
         iJMqPnH863KrZJHkqKYTh0yvrE6j6WWk7+afn5nSkb6r4nYCRmibvRWQH/6IKf5sJzC3
         XCIQFrbCqS+LU6BZ++SH/WYJ/cKebsmzgHoFh8p3h6BKk0C8e5uNVXhZytVANU2282Sg
         ZLFg==
X-Gm-Message-State: AOAM530ZIcqcB06uMHu5wLJP53NxbgHgQadwk1hjNW+DfHGZbivND+r3
        b8kJVgfHQ7pSdv9+HIHsELXRBYXxAa0Orw==
X-Google-Smtp-Source: ABdhPJx/aX7DDkniIIeXVUQbJOYikiXLekTlNd092SbtJjQy1F0hK/K1sPsszRARGVN/2uy//fjMmA==
X-Received: by 2002:aa7:9357:0:b029:1a5:43da:b90d with SMTP id 23-20020aa793570000b02901a543dab90dmr14393001pfn.54.1610743193208;
        Fri, 15 Jan 2021 12:39:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id v2sm8632916pgs.50.2021.01.15.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:39:52 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] soc: qcom: socinfo: Don't print anything if nothing found
Date:   Fri, 15 Jan 2021 12:39:51 -0800
Message-Id: <20210115203951.850873-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's skip printing anything if there's nothing to see. This makes it so
the file length is 0 instead of 1, for the newline, and helps scripts
figure out if there's anything to see in these files.

Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/socinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index a985ed064669..0844b5d4e354 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -373,8 +373,8 @@ QCOM_OPEN(chip_id, qcom_show_chip_id);
 static int show_image_##type(struct seq_file *seq, void *p)		  \
 {								  \
 	struct smem_image_version *image_version = seq->private;  \
-	seq_puts(seq, image_version->type);			  \
-	seq_putc(seq, '\n');					  \
+	if (image_version->type[0] != '\0')			  \
+		seq_printf(seq, "%s\n", image_version->type);	  \
 	return 0;						  \
 }								  \
 static int open_image_##type(struct inode *inode, struct file *file)	  \

base-commit: 3bc4bf77fa2adca8d6677461b6ec57505f1a3331
-- 
https://chromeos.dev

