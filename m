Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB412A2CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKBOZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgKBOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:24:17 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64EDC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:24:16 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id n18so14816631wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1a6YHQXGZMUnJNF8MJYubaqVfXzvcvl6CdQ46sxWjM=;
        b=amjzFEdycct+fBy4wvobDLEhGWm69eQKt6whChJ8JlXRazlsySQ0Ut+SSj5dhR9Uy+
         MzzORxICFwAWp1+zpN2DGGck1/P/+TmIoazBVBx5KkCuGKePv0vd3xYeaut6QYmA0afn
         cU7NCJJgm0IPXrmL9eDpUFozyCxvByyRcEHW+W/OoQe0epzsOfDPEqB2yo0jeZp83L5M
         W7AnoTt4HqU+FJUwMcAVy/X6n+iCx1t+B1XvEWY9MFX7tQKNFj1Myq3Jc+W+6CI25iBo
         MDtLD/bdtSnwIs9vz0T42TdP9Z4pJgo9q12VdIHCKKQY9dABhdJuCxC3sq9aIHo5XlYh
         LrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1a6YHQXGZMUnJNF8MJYubaqVfXzvcvl6CdQ46sxWjM=;
        b=A9QZUvwSZBLEKRfkDU/OkyQAHAXEbrvv0vCPPYwzWN045ZMAQARF6oqcgEHcjfN6ya
         mtLFwKXF8HoFoscMCftYEhZRuvr1iW3TFP302JtMfelxzV8iGBLS4Q4WaXIs1hmhF0FB
         CBE0Bz6hFvOlGlUzP49MerGE5IaQIVlkTp4gcb1G4qwKzHOG7rH+unC+1T2qrrQr7TWZ
         3GFhzplhzuZQzQyrDisf9FxkkjBi55sHlZnPoOnzDz74EAcgeg4yAp0L9DQ+YVv0cVGl
         2V8jx2+5fUqDhKeEf/FTCy03gciMmY5Mt8yCtRW9TP6BzqtgxoK6uWQFgC4Tu4wQYPi6
         Ygug==
X-Gm-Message-State: AOAM5337PLynszOT8+AMNpG8R1oDhsGe9BA1ZpQe41JJl0GZfZnzGefv
        3b+PwRw8BfL8GRB4qVRSBy4qkA==
X-Google-Smtp-Source: ABdhPJzLFghEEj7dMpcUjxYt0Fs0erXBoWfEk0PbyWEwcX7Qvon6YJDXZHuMfGOlMmGONgXYLU03Cw==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr21969909wrn.271.1604327055374;
        Mon, 02 Nov 2020 06:24:15 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f7sm23542501wrx.64.2020.11.02.06.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:24:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bradley Grove <linuxdrivers@attotech.com>
Subject: [RESEND 09/19] scsi: esas2r: esas2r_init: Place brackets around a potentially empty if()
Date:   Mon,  2 Nov 2020 14:23:49 +0000
Message-Id: <20201102142359.561122-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102142359.561122-1-lee.jones@linaro.org>
References: <20201102142359.561122-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/esas2r/esas2r_init.c: In function ‘esas2r_init_adapter’:
 drivers/scsi/esas2r/esas2r_init.c:418:41: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Cc: Bradley Grove <linuxdrivers@attotech.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/esas2r/esas2r_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index 09c5c24bf391f..4b91db7ba919c 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -412,10 +412,11 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 	esas2r_disable_chip_interrupts(a);
 	esas2r_check_adapter(a);
 
-	if (!esas2r_init_adapter_hw(a, true))
+	if (!esas2r_init_adapter_hw(a, true)) {
 		esas2r_log(ESAS2R_LOG_CRIT, "failed to initialize hardware!");
-	else
+	} else {
 		esas2r_debug("esas2r_init_adapter ok");
+	}
 
 	esas2r_claim_interrupts(a);
 
-- 
2.25.1

