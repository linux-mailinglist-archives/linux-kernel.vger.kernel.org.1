Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF92A2A2D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgKBL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgKBL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:41 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE2FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:40 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b8so14294498wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzeTsnVBQeYqxq9T62Y4dbDZSOnvVH0q+uB/IaQ0f7A=;
        b=Q1AwgfsouB13kxSXkM0CmETepswEz1eVF+VhfvBpuMdzXpMIvywphCdXvG+fOhnH+M
         uPiZk0nua3yuqzUpD1oZUgtFv5yxENwoGBjuhx/fmGUjZ42QCbP/59yEnsEnaqOuqS3j
         mIOI8BDB4bPiPxF6SDQJ51ohgjspHBdMExEtOrDEoBUHpzIybHz8R+OjoR5VDWq61E2x
         TjpuDO4XBynh0DH1SUP0Vkb3D79v3jSCquyCOCzWqLzpZ4RkL9GxzOVobdFceraVo+KF
         G738Qa5E9ueNmA5DakG3VtUID3fJPXCixRJ7qLDwXk/tYBN8dZT1Y7FrS4sYmuqHUBxU
         p9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzeTsnVBQeYqxq9T62Y4dbDZSOnvVH0q+uB/IaQ0f7A=;
        b=o54YhJaH8xlV4/YhHSJqoKMxgHNDEIgk+DVKsEevT7ccHICx19pdj6nHueFGPbA+CU
         IF9kCEdF4AC2eBGotwGZku6fDI0c994hSPTPM0l2lI7QBZbnd84KXvYU43btgib2yjC7
         LK6n4I3sNYfx2+xTAXqiB0PB7HoXcuEWQ9HGxmdHfb0eTemWHOgYvh+tnrRXEdNgeZg5
         X+7EkHMalN7ekRvvpSS71uYPkqCih0YmV6q0I2bRpV9oxx6jPwfqLNxtO+nhxg7eVXV1
         86eoukVUODeI/WZweD7dRRRlbZvC7UxucM0AswtwFPJg7+Vy3b4TM/2K9jHCpOFokmRK
         H9Hw==
X-Gm-Message-State: AOAM533ojj8vd8WvsAWdSoZUGNLNDRlMeEcwVlQwwLcWkTlLr6YPy6Lv
        uFY3lL8Pd8XBeBisI6U/OH1Pww==
X-Google-Smtp-Source: ABdhPJxyfPT/83kPU3iYXCZUiqj6IumS5dGwjDXqrac2lfMMIL870WSP0HaGBmm4xxuq4oWhfypuUg==
X-Received: by 2002:adf:e681:: with SMTP id r1mr19178108wrm.181.1604318259418;
        Mon, 02 Nov 2020 03:57:39 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 06/19] scsi: lpfc: lpfc_debugfs: Fix a couple of function documentation issues
Date:   Mon,  2 Nov 2020 11:57:15 +0000
Message-Id: <20201102115728.1077697-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_debugfs.c:4204: warning: Function parameter or member 'len' not described in 'lpfc_idiag_queacc_read_qe'
 drivers/scsi/lpfc/lpfc_debugfs.c:4781: warning: Function parameter or member 'ctlregid' not described in 'lpfc_idiag_ctlacc_read_reg'
 drivers/scsi/lpfc/lpfc_debugfs.c:4781: warning: Excess function parameter 'drbregid' description in 'lpfc_idiag_ctlacc_read_reg'

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 325081ac65539..5a354abcbafc4 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -4186,6 +4186,7 @@ lpfc_idiag_que_param_check(struct lpfc_queue *q, int index, int count)
 /**
  * lpfc_idiag_queacc_read_qe - read a single entry from the given queue index
  * @pbuffer: The pointer to buffer to copy the read data into.
+ * @len: Length of the buffer.
  * @pque: The pointer to the queue to be read.
  * @index: The index into the queue entry.
  *
@@ -4762,7 +4763,7 @@ lpfc_idiag_drbacc_write(struct file *file, const char __user *buf,
  * @phba: The pointer to hba structure.
  * @pbuffer: The pointer to the buffer to copy the data to.
  * @len: The length of bytes to copied.
- * @drbregid: The id to doorbell registers.
+ * @ctlregid: The id to doorbell registers.
  *
  * Description:
  * This routine reads a control register and copies its content to the
-- 
2.25.1

