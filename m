Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543BC2A49A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgKCP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbgKCP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A314C061A47
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s9so18990418wro.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTdnnrRVuCbgQS2De8FJKm0elKhLf/t/tAH+rByd77A=;
        b=LVNw/niQDAW9U7ijNZkhMS5ThcE3Jvp1uQvhf0orWmEtKn2CTN9GW0y+S2nuI3TkUP
         9YzM8gG6PxBhLWezVef2ftvQMHKTXdvz5YynRQPSOskmRGlTGP50XRRVVp0SnM1P86lJ
         lRTwtO+SFwmzD9DWFSLR1S4zQjSqQCBPBsLFAYXOCxV+wBg3Tt6qTCSgA3NSjApHInUk
         7lgDysC3A4RQpdlLpRKt35LNUbNxLkMnGb72huwi8QO1/6nexal6XGW2GJ96Ffn/t97a
         E/863EOxVDf06cKGDxLtq0iB6Uu5H4AUBlunSAf6eXkcwnIWcfqHdvS8oL2QTOXQxvOE
         NvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTdnnrRVuCbgQS2De8FJKm0elKhLf/t/tAH+rByd77A=;
        b=btZ56/QtFaKdPcMxGluneoQi55wSFjOQoIMShJHo7A2S0FQsFWLAlBQwuguqx8Mi6N
         LL+W7vWyDzzQzv0OoqIrKMpO8KevyCCOboPBU6KN7LzNCsNZu9Fdus1UkrcZT3BV+BLL
         7dOEw9lzc/ldPqEjFsfBkZZ5duoEpH1cVa71exEePEBUD3IXFxWhJWLYSljCAMJksSsO
         1dBrVM46ZsvPwbEQJlKvEgwAUWSD2EkWEMgDS7k/JxtWke0OcblsUAAIp5FfbwlWngy7
         CN7V7sw5U1R07z/74vftMGg4+Nzy40c9riUovpy2XeuvXuEznR5tbGiBceqgdHMnEmRR
         2SRA==
X-Gm-Message-State: AOAM531eFdrJwxrH2BALekeal4JIK03Wno/0ynwyumRBSE8y1Wxhy/RB
        3bubNNCjNLKYFRlgrL9m5CPRpg==
X-Google-Smtp-Source: ABdhPJxSK592GbXUg76+lrIYFwt6ZRAQ5oj1sTAb7oGVb8E0cWpfd3EnUqKOOq2siJj50icyAKN3Ww==
X-Received: by 2002:adf:f10e:: with SMTP id r14mr25710602wro.337.1604417371320;
        Tue, 03 Nov 2020 07:29:31 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 16/25] soc: qcom: smem: Fix formatting and missing documentation issues
Date:   Tue,  3 Nov 2020 15:28:29 +0000
Message-Id: <20201103152838.1290217-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/qcom/smem.c:135: warning: Function parameter or member 'toc' not described in 'smem_header'
 drivers/soc/qcom/smem.c:275: warning: Function parameter or member 'socinfo' not described in 'qcom_smem'

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/qcom/smem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 28c19bcb2f205..7251827bac88d 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -122,7 +122,7 @@ struct smem_global_entry {
  * @free_offset:	index of the first unallocated byte in smem
  * @available:		number of bytes available for allocation
  * @reserved:		reserved field, must be 0
- * toc:			array of references to items
+ * @toc:		array of references to items
  */
 struct smem_header {
 	struct smem_proc_comm proc_comm[4];
@@ -255,6 +255,7 @@ struct smem_region {
  *		processor/host
  * @cacheline:	list of cacheline sizes for each host
  * @item_count: max accepted item number
+ * @socinfo:	platform device pointer
  * @num_regions: number of @regions
  * @regions:	list of the memory regions defining the shared memory
  */
-- 
2.25.1

