Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593BB21A621
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 19:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgGIRqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 13:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGIRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:46:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C87C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 10:46:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so2746529wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XXWcsoi+xGgOcFmbeWP75diSxyhw0hWfzUHSepxSy6k=;
        b=wDr3kLbsMlSQP8EqutTozrPjOoRfxz5PEnYOYYWvcXRrI8a5KqDDTCU3WMEGYfdgJ0
         5Iv8QeDtcrccOVwVUgkgxN0ALNJ/bjH0lnQR94pxVMiPyNJOGTvkbYgwsNJGyW638YTg
         NfISb7/cCrla8la77CfL1/K1/vwVTFviyWjYH7injCTwF2Ij4VWdXhOTB0ZkmTR/DZ7F
         jhrdgceBGakpaJoDqbTR/QGjiBkHRaxAAUHQ+vgnVV7DHjiioTP0RK+kLNf87FENOCuD
         rwof33dAqHwBO6HyrILWgvtJ8xu9tYIAGUek2gLPUKDKp/VscUeKrykiv6W1QTzVbG1y
         77PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XXWcsoi+xGgOcFmbeWP75diSxyhw0hWfzUHSepxSy6k=;
        b=CgBnJtK3BGDxj44/Nn3gFBd5qoWTZHRkH5KiDznXW1ZtpVtxe85uHSzJ61AtbvRj/e
         K49uXaLNu8nyNqavri+xWrveLfZEaE4PuNtpqmylu1BHFSCPJXabZDJMv/sFATZJ4uHY
         fr2ns0Iqoil1V6gAK4aIsS1ZKZKUfC7PKJL8Yv3+YGuNR3VF5952/EdOFiJSxmxZcqsb
         G3Qy/uFqDu8yXblE/VAPafRB2EeUGkWG998pZMWgY/CGNnQTW/7GOUr3l3b5bFjPLYrX
         6e6+OxEj9gdCliHcquJMV+vY4dZPrbIjngnXT0ML9w8OB9rBj+B1aE3ChZvV69+pETPO
         c9/g==
X-Gm-Message-State: AOAM5317r8pRVf8kao6wPrFfeSgDJfXFQGOGRqwyRYQ1bpcnrIA9la73
        jFH32Kqx3Rm0j1tpR0NN4eZ1qTuT8UA=
X-Google-Smtp-Source: ABdhPJzbrtSZAFEyQ4E+0JitG1cOyHzPhs5DdTvwJhoh6WiCBXI2eHJP4dFjE32RWo0G57WV9pKm4Q==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr1076958wmf.29.1594316785279;
        Thu, 09 Jul 2020 10:46:25 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id f15sm6063854wrx.91.2020.07.09.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:46:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 23/24] scsi: aic7xxx: aic79xx_osm: Fix 'amount_xferred' set but not used issue
Date:   Thu,  9 Jul 2020 18:45:55 +0100
Message-Id: <20200709174556.7651-24-lee.jones@linaro.org>
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

'amount_xferred' is used, but only in certain circumstances.  Place
the same stipulations on the defining/allocating of 'amount_xferred'
as is placed when using it.

We've been careful not to change any of the ordering semantics here.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic7xxx/aic79xx_osm.c: In function ‘ahd_done’:
 drivers/scsi/aic7xxx/aic79xx_osm.c:1796:12: warning: variable ‘amount_xferred’ set but not used [-Wunused-but-set-variable]

Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 8e43ff86e0a60..3782a20d58885 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -1787,10 +1787,12 @@ ahd_done(struct ahd_softc *ahd, struct scb *scb)
 	 */
 	cmd->sense_buffer[0] = 0;
 	if (ahd_get_transaction_status(scb) == CAM_REQ_INPROG) {
+#ifdef AHD_REPORT_UNDERFLOWS
 		uint32_t amount_xferred;
 
 		amount_xferred =
 		    ahd_get_transfer_length(scb) - ahd_get_residual(scb);
+#endif
 		if ((scb->flags & SCB_TRANSMISSION_ERROR) != 0) {
 #ifdef AHD_DEBUG
 			if ((ahd_debug & AHD_SHOW_MISC) != 0) {
-- 
2.25.1

