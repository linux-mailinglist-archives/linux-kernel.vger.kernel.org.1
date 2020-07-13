Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6770721A614
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgGIRqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgGIRqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:46:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE9C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 10:46:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so3294482wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pP2tdu8A1HxZVI+uozY0df9nk/Y+k4UvHam72V3AaIk=;
        b=HOjBlIQW3V9/ieSrhgXZ2CuZd05AGRfyL5watxTrh18Od1QoPikv6mwTbjESssycgO
         x89pAqUhtiMUDhC8cAGCD+aYRw17aIKhWv/cvtN/XoQZPfdjHxM2Ob/LhIjLRQeA6nQ6
         LPmvd6zFFxlTH5y3sOAv7OY8eYWM2pzmJ7S6RmPCzL/FNL8l5g178cG5f2yy6RhXkNcb
         /BhzmQgbqlVMhQuC+et0xn4j5vPpMd0+LpaTfr/D+ttZ6OxBxMzQsRNOiHOh9aI1uFQO
         O7K+1TphYfN+lNgseM0qE12H6Aymd88qTmYK7EuLvusxf+PsSCPxYwB8C9qrmt15SeD4
         ImSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pP2tdu8A1HxZVI+uozY0df9nk/Y+k4UvHam72V3AaIk=;
        b=qY+/ggMxDq1YvK6JPgr06K2oQGqNtsOiGUeQeoejyuiGgkiyLCgoHbXZywvPzcmJgq
         ST1WX+USMR5baUq5zkR/a5qZZeZr0zCDd4hdM1KKTT1dFw0TMCyv8ooAAgziTKzKK/+s
         B4pQKHooC8R1nMZqOsgxcBBb5SSVbeCj+HufJV+G7g5lvsTbMAoL6qfypA1IqB481Bpl
         H0fWVrXLqfukNJuChz4T+cpRk+5fLgSema9Gk9SG12IUjw0N0420njfmPwDSHedqYW/j
         rH0WAF7W71St/riNjtWT2IPSwZAaxo7lXyUBtiUKIJqkOmz1KfPnCLqP0jBwaM/8LUTm
         jo1Q==
X-Gm-Message-State: AOAM532/S3nMdkqbI4I8GC+S0QnC/DgWc7cS7ugEudUA/HfZh/G/sf4e
        fOOQPH+hTu1peYHhkCVQCbrYSw==
X-Google-Smtp-Source: ABdhPJzScneAJUqO4lgPookL/z5Oqr9eS06jW1CjZ5o87jZtk4YDFmcwzq5frcqtB9jNumELbK1V0A==
X-Received: by 2002:adf:f203:: with SMTP id p3mr36428391wro.331.1594316763029;
        Thu, 09 Jul 2020 10:46:03 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id f15sm6063854wrx.91.2020.07.09.10.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:46:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH 04/24] scsi: aacraid: dpcsup: Remove unused variable 'status'
Date:   Thu,  9 Jul 2020 18:45:36 +0100
Message-Id: <20200709174556.7651-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709174556.7651-1-lee.jones@linaro.org>
References: <20200709174556.7651-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/dpcsup.c: In function ‘aac_aif_callback’:
 drivers/scsi/aacraid/dpcsup.c:232:6: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]
 232 | int status;
 | ^~~~~~

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/dpcsup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/dpcsup.c b/drivers/scsi/aacraid/dpcsup.c
index 25ebb94368f2c..749f8e740ece1 100644
--- a/drivers/scsi/aacraid/dpcsup.c
+++ b/drivers/scsi/aacraid/dpcsup.c
@@ -230,7 +230,6 @@ static void aac_aif_callback(void *context, struct fib * fibptr)
 	struct fib *fibctx;
 	struct aac_dev *dev;
 	struct aac_aifcmd *cmd;
-	int status;
 
 	fibctx = (struct fib *)context;
 	BUG_ON(fibptr == NULL);
@@ -250,7 +249,7 @@ static void aac_aif_callback(void *context, struct fib * fibptr)
 	cmd = (struct aac_aifcmd *) fib_data(fibctx);
 	cmd->command = cpu_to_le32(AifReqEvent);
 
-	status = aac_fib_send(AifRequest,
+	aac_fib_send(AifRequest,
 		fibctx,
 		sizeof(struct hw_fib)-sizeof(struct aac_fibhdr),
 		FsaNormal,
-- 
2.25.1

