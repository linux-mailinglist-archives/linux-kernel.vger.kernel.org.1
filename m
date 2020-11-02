Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA18A2A2CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgKBOYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKBOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:24:25 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432ACC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:24:24 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b8so14858409wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpntW8qOQ6pR3vVGmsTYcGUv23Vlc0jF5vAOPXJRUnY=;
        b=OEPURfW0F5vM6exWKOpcJkjQrhV9jXWZbcAdjngWRPRcaLOP5W4ZwGGQxQN54fY3Sd
         GVCokXyaAlkA5Bsoe5Wfn3xNV0rp05HNqMNKoMAbXEQTSXw1XhgMvgb9YBLzuxmUX5Z4
         xg8rMBp2jc4OInxJy6pp9N9Enz5eNE9JlYt3m0j8VJkUXaRvpLHvwmi08unDt4fj4YEL
         nbTYzBcn0/ySR2Yt9A8hwP59HbNyd/81GX4zaAPuEmodgnyUZa+Q/F8YiwwSwp8NiR48
         qWB6Hi0pC7gL+i7ej267J9nVvhfx3o/E2zUi+ULF3k2ZVkRrvWfiiZ2SvcXYv+AWiNuz
         Oy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpntW8qOQ6pR3vVGmsTYcGUv23Vlc0jF5vAOPXJRUnY=;
        b=B2b+6/gjgz5eeoJ/Yc2nVabx33lzZuXOEZvlcalcA0whpWoqERcQWXONA4pd8398u5
         Xe3E0ut+T1aJgSfIRRprwUQ4bMjUQ1wQdx8dGhywtdOZ0YdjZ26sRAAOTot9oYx5/ahp
         xNCjIHdP9DKpfPkFFw6Ewvz84fQdeveUXnA1Oo4noTpQ4+wAdFrp5CgPMw5qXEDMTMwh
         ABuF/fzgngJvrb3qPI57LOZnSR0kftNF6R66cWqL5IuHC3qDfuQqgZ2NPQQ8a2aIMQ9R
         WhSTQmm4oWvkHSB6Yy1KEHKDItiq/Bz3T2tsrPOD56DZ6Dw9lM7TF7+NjOMdIq7yi40r
         y6Iw==
X-Gm-Message-State: AOAM531oSNLZRw9eFNXIDvRj5j0UJXB4mP8hjMtJ/FwbX8+J7+l0hxHl
        HxqpXv52HcfF2B5i0PadvVXpdA==
X-Google-Smtp-Source: ABdhPJzqM4zHDC6zJHOrG9oqJ8YwdfCQNaNJtkjJOKY1K4M2Wce/LLBycsCbeSVNpuImTr2/U1Kyog==
X-Received: by 2002:adf:f20e:: with SMTP id p14mr19910515wro.376.1604327062980;
        Mon, 02 Nov 2020 06:24:22 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f7sm23542501wrx.64.2020.11.02.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:24:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bradley Grove <linuxdrivers@attotech.com>
Subject: [RESEND 15/19] scsi: esas2r: esas2r_main: Demote non-conformant kernel-doc header
Date:   Mon,  2 Nov 2020 14:23:55 +0000
Message-Id: <20201102142359.561122-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102142359.561122-1-lee.jones@linaro.org>
References: <20201102142359.561122-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/esas2r/esas2r_main.c:911: warning: Function parameter or member 'a' not described in 'esas2r_check_active_queue'
 drivers/scsi/esas2r/esas2r_main.c:911: warning: Function parameter or member 'abort_request' not described in 'esas2r_check_active_queue'
 drivers/scsi/esas2r/esas2r_main.c:911: warning: Function parameter or member 'cmd' not described in 'esas2r_check_active_queue'
 drivers/scsi/esas2r/esas2r_main.c:911: warning: Function parameter or member 'queue' not described in 'esas2r_check_active_queue'

Cc: Bradley Grove <linuxdrivers@attotech.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/esas2r/esas2r_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index 7b49e2e9fcdec..923e6e5ddbf90 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -894,15 +894,11 @@ static void complete_task_management_request(struct esas2r_adapter *a,
 	esas2r_free_request(a, rq);
 }
 
-/**
+/*
  * Searches the specified queue for the specified queue for the command
  * to abort.
  *
- * @param [in] a
- * @param [in] abort_request
- * @param [in] cmd
- * t
- * @return 0 on failure, 1 if command was not found, 2 if command was found
+ * Return 0 on failure, 1 if command was not found, 2 if command was found
  */
 static int esas2r_check_active_queue(struct esas2r_adapter *a,
 				     struct esas2r_request **abort_request,
-- 
2.25.1

