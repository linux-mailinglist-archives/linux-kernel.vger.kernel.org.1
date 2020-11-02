Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615822A2A30
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgKBL5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgKBL5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:46 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B792C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:46 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k18so9221908wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ef7dXGUoI/7wCGOrbe2vfPSP8bVd47W9yi6D/rto+eg=;
        b=KtIihyq44D6eQQ1SyQbHwN2RghFDuYyzJz8bcOStuQ0rSQiT5hDC7jAkyFz0gm3sa3
         1fVbNkFyrBQ5DACL0iCpl3EXwZKKWzp5AhKDcnB4IPUWH0IYdiPdCOpzmNy9ABaLm4iq
         ZbLFv2JIlAqgYGRPtSITpt/EUBtPbFwASpdKcO0Pnf93hOF9SMtYry0sLAtAmLif0rsa
         PBOwiyAR2u6X5WKGKcmoP9q9LL2i9N4IRuFrvWOn0sRYEcg9zNqsdp/azeTf3uMhO+h0
         nOhL14kNYHmtuOM02Wr2/L8F5IfTl9emyXs5qAc8AFKOVVbZIZFsSwpaMVt8EjgmBgWQ
         p38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ef7dXGUoI/7wCGOrbe2vfPSP8bVd47W9yi6D/rto+eg=;
        b=d1Fv8hodsXwH/YMgpKdahHvLKWGaDIfAJvnP6uJw94t0dCscSeTMEWQgd/CGca+Gvv
         utQiukE0C7uH/BngUB0I8abtoCPt+zBrS7I1ldeysVe1/kCqWCXH1DNbltu/UhetG6H5
         HyPY6YmZswp58K4jhn2Qy+2yYjBel5yjuw3/xx7U1U5XL8fSr4U1Et7jej9peetZcvUb
         BWFcDCYl789pc7cGnGrP5eYemMuvbBgXAC87GQODGWUP519+uMGPne883Rq8icQIGWU2
         /iK3BJL2f5b9QuDmL+EM2t030PGwAc18OhTlEVY74KmEhIxDtdeXqQ7oTZqW5mQWASoW
         K0Pw==
X-Gm-Message-State: AOAM533WRNQmTwfayDBLgQPUxJyuAdUHcMtscshkLiYSdGNuHk1P0RrI
        ZOwIENVVjkWMxoSsr6dViN7F+w==
X-Google-Smtp-Source: ABdhPJyqtagpf+L9Ma8OVh6vEFJkaUTGUL1h9EMSgWvo/T7ilXbsqD32DUHiJiJJUQTqX3Jdwb72YQ==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr16394348wmd.146.1604318265149;
        Mon, 02 Nov 2020 03:57:45 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Santosh Yaraganavi <santosh.sy@samsung.com>,
        Vinayak Holikatti <h.vinayak@samsung.com>
Subject: [PATCH 11/19] scsi: ufs: ufshcd: Fix some function doc-rot
Date:   Mon,  2 Nov 2020 11:57:20 +0000
Message-Id: <20201102115728.1077697-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/ufs/ufshcd.c:6603: warning: Function parameter or member 'hba' not described in 'ufshcd_try_to_abort_task'
 drivers/scsi/ufs/ufshcd.c:6603: warning: Function parameter or member 'tag' not described in 'ufshcd_try_to_abort_task'
 drivers/scsi/ufs/ufshcd.c:6603: warning: Excess function parameter 'cmd' description in 'ufshcd_try_to_abort_task'

Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Santosh Yaraganavi <santosh.sy@samsung.com>
Cc: Vinayak Holikatti <h.vinayak@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2309253d3101c..7ba3e923eb585 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6594,7 +6594,8 @@ static void ufshcd_set_req_abort_skip(struct ufs_hba *hba, unsigned long bitmap)
 
 /**
  * ufshcd_try_to_abort_task - abort a specific task
- * @cmd: SCSI command pointer
+ * @hba: Pointer to adapter instance
+ * @tag: Task tag/index to be aborted
  *
  * Abort the pending command in device by sending UFS_ABORT_TASK task management
  * command, and in host controller by clearing the door-bell register. There can
-- 
2.25.1

