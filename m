Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3FE2EE9B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbhAGXZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbhAGXZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:25:45 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE234C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:25:04 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 9so9354455oiq.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmUdLzxmBg4D1mwGM7vnFOB690lMNeSwn4LSD0odzp4=;
        b=u+W01yvGhDD172Y2qwGyv/tjdI8yPhKDNyownkKPjoqaM0jVqd2JmuoTJdTzirGDfc
         peK7Dv1eHLmsql4lu3BxkQ8pG1s3Go/Ns4PlyQjR7nL8ua5f2QinaORu3wVdgtebOpOa
         w0n/njIz9+BqWxs+En+aOGtfDdlTxU89aMRBzb9kbSdeuzlS4eP33RSFi51B7KgGbSV+
         1wd6eHRpLjt/CPrMlcmEU1XgrYAbrXb1PsS21MxhH4FUUPnaOKRrFTTFUBY/amQHo7aI
         yU3RVhg2pyKjw/AzWG5//3C3m65NcBLxESU6u73M9/m0Ku9PoAmkSBx9sU8u0QuNg4gl
         1ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmUdLzxmBg4D1mwGM7vnFOB690lMNeSwn4LSD0odzp4=;
        b=ZDH7zA12k9onl/SBQWxMm3TnnuAKxFuKljPkljYohzNe4z6rl1pbMZytR+1FFvwoSj
         e0WuYBWbmaM84337d2YplLDSjGhnetjzYr/xnP0B4DdzEEnGeW87DLnKkrUCA8AM8ozt
         e9pgDobh3D9nDUBuwBAKtruO//cOmzFl/ys8FsVUBoeOjcZD+Y8hVMLUqnJkCOSPiHKY
         GTAJKM8fztBKM4tS/1vh1yzjqWfX0cfmYzuolF62qdaHe+U1vkrhmnQ1NjRw251OqEEI
         +qpGIqS7V1wWgBNKCzc07j5SKEbl0ULtqMovg2pGUNTPVL2S2gq7yiBNlXBdRa6m44zN
         CsoA==
X-Gm-Message-State: AOAM53265SdptUrzZqDU3pgAFJDFC99e3Pqz7ypfBas1bZX5z6iGWhZv
        kOloDNgwTTN7yCqaJJbfUnJHosxfjLf/jA==
X-Google-Smtp-Source: ABdhPJxthYbGUuE7fBxZhHvfSlR36ln95ZMgaKKKJiu/HRQooSm17t8kbBC4uHLIQplvnLyixudKsw==
X-Received: by 2002:aca:fd0d:: with SMTP id b13mr610040oii.27.1610061904161;
        Thu, 07 Jan 2021 15:25:04 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a22sm1408284otr.75.2021.01.07.15.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:25:03 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: mdt_loader: Detect truncated read of segments
Date:   Thu,  7 Jan 2021 15:25:26 -0800
Message-Id: <20210107232526.716989-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that no validation of how much data the firmware loader read in
for a given segment truncated segment files would best case result in a
hash verification failure, without any indication of what went wrong.

Improve this by validating that the firmware loader did return the
amount of data requested.

Fixes: 445c2410a449 ("soc: qcom: mdt_loader: Use request_firmware_into_buf()")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/mdt_loader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 24cd193dec55..e01d18e9ad2b 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -253,6 +253,14 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 				break;
 			}
 
+			if (seg_fw->size != phdr->p_filesz) {
+				dev_err(dev,
+					"failed to load segment %d from truncated file %s\n",
+					i, fw_name);
+				ret = -EINVAL;
+				break;
+			}
+
 			release_firmware(seg_fw);
 		}
 
-- 
2.29.2

