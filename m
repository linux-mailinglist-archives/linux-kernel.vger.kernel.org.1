Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4662BBD02
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgKUEsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgKUEsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:48:07 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F45C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:48:07 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id o25so13031980oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 20:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5tuY8DghcZBvhcmNZ1QBUM0wOMXflva60dOunjBFlM=;
        b=hEfpldQOix/WT+Po0WGDlXh6hu4sjFQXHsfMLWLFHo/G9OEdGqxAbZqPPQwYx1FZmx
         I3ZjlJl21PCfzGVogb4UhgsLsAv+2qoreIvLIFQxX1IxPcsgbSw4lEZRBDls6WjhL/g/
         6pOxExIBguvb0AgbjSaiHDd3Vyim10/H68RS/hcR9HzUMCA7kFYWxvKNEx/hZFcAQHwK
         RdaGb3b2uBMVORGB1hPZ5MK9Dg2L2QV93WRtLG6Z1/p3TPyLir36KHYX9KtGLZ3tKKe2
         8+qYQTzLc45hrb8ff0E7tqjlYjnb50Xmu2TKQWhTen/KFC8PYy72xNOI6Qrx0SH2+7Dm
         ABqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5tuY8DghcZBvhcmNZ1QBUM0wOMXflva60dOunjBFlM=;
        b=jDHQH7713jUoWyD/GMNR068WI7UzOh5KG0wlg6US1TbWXJEc03DFy270iMH7F4vfaQ
         9GX7zZ6BDCSn2T8E+yY4uGWi5mwa2gE/DbgpfzGgTJOAICjMIQwlNALTx925SXfcNvZz
         2/m4v/9HgXBezOkRN/1EjkyffgIxlmUfYpA83FCGuaQ06QO25iBhS9g1zJDOZUpt4272
         PP5SSArJyL0ML0ebffi924LiKfGdR7IBdpX1OjNc/rJm9grNJhwuf70hMpLzYpftSop/
         re1kLKm1gKhlU91T0Xu8anv8Yzv0ArclrhfWJEAbnaf/03xUNlAtch1/nDObaswUxXk1
         sCyw==
X-Gm-Message-State: AOAM531FOuzmixaLcFX+fByMPIkCdgFL0neV93ALQlEd9sxrdeRGh2Yr
        +XMEpcrjo7LF7yxvIDE71VMLaQ==
X-Google-Smtp-Source: ABdhPJzPZMaQkLsy6sCEJGtV7eRVF/ZWjoSa7tpvgaAqhe01hBeXktkYzZLQurCVbDvJibTDsCRJIg==
X-Received: by 2002:a05:6808:301:: with SMTP id i1mr8853175oie.49.1605934086863;
        Fri, 20 Nov 2020 20:48:06 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g3sm2875800oif.26.2020.11.20.20.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 20:48:06 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bean Huo <beanhuo@micron.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] scsi: ufs: Adjust logic in common ADAPT helper
Date:   Fri, 20 Nov 2020 20:48:10 -0800
Message-Id: <20201121044810.507288-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of ufshcd_dme_configure_adapt() refactored out
duplication from the Mediatek and Qualcomm drivers.

Both these implementations had the logic of:
    gear_tx == UFS_HS_G4 => PA_INITIAL_ADAPT
    gear_tx != UFS_HS_G4 => PA_NO_ADAPT

but now both implementations pass PA_INITIAL_ADAPT as "adapt_val" and if
gear_tx is not UFS_HS_G4 that is replaced with PA_INITIAL_ADAPT. In
other words, it's PA_INITIAL_ADAPT in both above cases.

The result is that e.g. Qualcomm SM8150 has no longer functional UFS, so
adjust the logic to match the previous implementation.

Fixes: fc85a74e28fe ("scsi: ufs: Refactor ADAPT configuration function")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 52e077aa3efe..13281c74cb4f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3618,7 +3618,7 @@ int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
 	int ret;
 
 	if (agreed_gear != UFS_HS_G4)
-		adapt_val = PA_INITIAL_ADAPT;
+		adapt_val = PA_NO_ADAPT;
 
 	ret = ufshcd_dme_set(hba,
 			     UIC_ARG_MIB(PA_TXHSADAPTTYPE),
-- 
2.28.0

