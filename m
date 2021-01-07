Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D086D2EE9C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbhAGXbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbhAGXbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:31:38 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D64FC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:30:58 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a109so8042554otc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsP/yoJjwDCMt7N2rFKs08bZNh7p5m4IePfBuVMv1Fs=;
        b=JMHZY2LmE3U+Oohdp9zbT3pJlzo/L+Gjx1fUWP5xcs9Ot+CCkqKZplP26oMXqVqxzx
         zy4fTwkzEjfVpNHZZ74GnSJfUDBgdz2cvvuQTTW6pm7UPI9bUAyS2bY9BkSkkcXZDAL+
         p1tMDufQEy17xMcRWIMGmvFr7ePDIBrWZKpIXXl72tr7xu0fsdL5Ek/DnRKoYf2GhkjC
         qLmEDKI9rxLz13W0WQiP2XeCtb4rrUyEz08If4T1wCYd7pTLkKFVPQwSj34BSqQ3XJpf
         r1CPwZMRevWiOKu89FAUnu/tkWazEbmt2hlzLI+ZAjQbgVW5Cf19RMdwNz2LBvi8PssG
         U5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsP/yoJjwDCMt7N2rFKs08bZNh7p5m4IePfBuVMv1Fs=;
        b=GJa5vPyOQnEGjtGE9yiAdBVdxRqu3UgiyztQI7z/Z3z7tOt26N1WtBrOPvoYr5yMJc
         9nTd575be5jOHdO4dHPYcVEyIVmYK90WEw4qSZL/ma1FceRm8YdkhqTv9HcBHkbdul6N
         xPkvRqEiW0BOvPO8cPRhgmmgd4+rlJwY0EO8GiEZsKMQ/MWAplUVzXIJz4tAg7dwVKXq
         9UnF39oPNLstKKAm/7l9Em3FxWilIRS+Yam4jl9qXILdvz9HrPjx2gLA1jf9J5soWCeJ
         KHtVzCQMviKIHuQ2KsN5iGIZW9jKH3gG7AUGOSRdinS0nYHJU+UK4Sad0DICmYFBfrPf
         VzUA==
X-Gm-Message-State: AOAM532/naDSlabxuERQ9WJavWabbfPTBXCW59dSt1ZGzi9ujmmjjnSV
        dEhvAm/NGuYAad/rWvfADKVE9Q==
X-Google-Smtp-Source: ABdhPJyLfV5VsSmmOLGSgMJjrcfxNNsl0wmiMIgY4VzYX2JpE2QDBEj+cGZZN+a/m4o8u/ID2cr3NA==
X-Received: by 2002:a9d:208a:: with SMTP id x10mr656889ota.260.1610062257343;
        Thu, 07 Jan 2021 15:30:57 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t24sm1425945oou.4.2021.01.07.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:30:56 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: mdt_loader: Validate that p_filesz < p_memsz
Date:   Thu,  7 Jan 2021 15:31:19 -0800
Message-Id: <20210107233119.717173-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code validates that segments of p_memsz bytes of a segment will fit
in the provided memory region, but does not validate that p_filesz bytes
will, which means that an incorrectly crafted ELF header might write
beyond the provided memory region.

Fixes: 051fb70fd4ea ("remoteproc: qcom: Driver for the self-authenticating Hexagon v5")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/mdt_loader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index e01d18e9ad2b..5180b5996830 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -230,6 +230,14 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			break;
 		}
 
+		if (phdr->p_filesz > phdr->p_memsz) {
+			dev_err(dev,
+				"refusing to load segment %d with p_filesz > p_memsz\n",
+				i);
+			ret = -EINVAL;
+			break;
+		}
+
 		ptr = mem_region + offset;
 
 		if (phdr->p_filesz && phdr->p_offset < fw->size) {
-- 
2.29.2

