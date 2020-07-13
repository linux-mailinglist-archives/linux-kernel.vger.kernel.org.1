Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F6E21D145
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgGMIB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgGMIAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:00:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9FBC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so14700271wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z87wYd9sTBTgWM4PfTqIXybXjZhO9Ay2HDdpb30MaC4=;
        b=GwaqYyasb4pt/yHI52LPi50jk3NUPP3MzKPLGyyFAYOzsFv5RQ9x9cHPO3DwYBI3iZ
         rDv6pY8Z4eOxcB7/JyisfZmNnZQYVWncbRV+Ru/xxjVCkpUMxdetPt17OHDPELJ71078
         BlO8fuKQkTo1SHBYmslBIioZX3jyFpbDsKdueBT/ifKntd0mrWdIltyv07HO1raOLfDq
         OSAYGR7zAMC9F0C+HVnBqxE6IbCki+yTWuHoA4m5wbeLFcvNRs7Ns3y3q70PQDAkmAiK
         bbGA3YI/pPaXObK2kOrnV8VmBVff4mECwNNTqPhmNAH3oF0+pKnLZ41T0yblQBSmDW2c
         hRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z87wYd9sTBTgWM4PfTqIXybXjZhO9Ay2HDdpb30MaC4=;
        b=iEorQmEo9gO/ycuvHPVYKTpjlaUgam1tEhErPYevVUbyVfyFBLDx979NDZgq6HKVGq
         g4YfTmks+vhz8l+qSlWfjy9NApK6H6rZ9PkR07cJYXaQpgXofesMB6Bqh01KwOV9EkJo
         ecJKEUsGPXS/2kZ+gEXTI91Aw9dBpqttNiv2o0VkGrby1DucyAsDtg4Al7EuvXNPoh7z
         c5uHmrdCUor/r20KVQGYsY/OSjPwYCvytLKx3OGMn53kNHB45jECe4ZRaE3enUNeuUgD
         G/kQJPp9yHWcUl+yRGuYx15UDjT5VkGQoeVmsyqfrvzAI5vGJTaamhMqVs29TTs1poJW
         sGeg==
X-Gm-Message-State: AOAM532IaeTsVtztea3qHgiWUtoT3SwipAn1asCZQdw3bjlRSPkdv/MU
        lVhYAOx+ehsguKroA7Rgn+T8pA==
X-Google-Smtp-Source: ABdhPJynSOVL/D2X3SU25uKx1ust6+9067RXhrycucU2//FzcNI1aDi48MWlvMNIYiIDzTeBEO6Ppw==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr49585783wrj.14.1594627210957;
        Mon, 13 Jul 2020 01:00:10 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id 33sm24383549wri.16.2020.07.13.01.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:00:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH v2 03/24] scsi: aacraid: dpcsup: Fix logical bug when !DBG
Date:   Mon, 13 Jul 2020 08:59:40 +0100
Message-Id: <20200713080001.128044-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713080001.128044-1-lee.jones@linaro.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DBG is not enabled FIB_COUNTER_INCREMENT() results in an
empty statement, leaving the contents of if() and else() empty.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/dpcsup.c: In function ‘aac_response_normal’:
 drivers/scsi/aacraid/dpcsup.c:105:50: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
 105 | FIB_COUNTER_INCREMENT(aac_config.AsyncRecved);
 | ^
 drivers/scsi/aacraid/dpcsup.c: In function ‘aac_intr_normal’:
 drivers/scsi/aacraid/dpcsup.c:411:30: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
 411 | aac_config.AsyncRecved);
 | ^

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/dpcsup.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aacraid/dpcsup.c b/drivers/scsi/aacraid/dpcsup.c
index a557aa629827e..25ebb94368f2c 100644
--- a/drivers/scsi/aacraid/dpcsup.c
+++ b/drivers/scsi/aacraid/dpcsup.c
@@ -99,10 +99,11 @@ unsigned int aac_response_normal(struct aac_queue * q)
 		}
 		if (hwfib->header.XferState & cpu_to_le32(NoResponseExpected | Async)) 
 		{
-	        	if (hwfib->header.XferState & cpu_to_le32(NoResponseExpected))
+			if (hwfib->header.XferState & cpu_to_le32(NoResponseExpected)) {
 				FIB_COUNTER_INCREMENT(aac_config.NoResponseRecved);
-			else 
+			} else {
 				FIB_COUNTER_INCREMENT(aac_config.AsyncRecved);
+			}
 			/*
 			 *	NOTE:  we cannot touch the fib after this
 			 *	    call, because it may have been deallocated.
@@ -403,12 +404,13 @@ unsigned int aac_intr_normal(struct aac_dev *dev, u32 index, int isAif,
 			if (hwfib->header.XferState &
 				cpu_to_le32(NoResponseExpected | Async)) {
 				if (hwfib->header.XferState & cpu_to_le32(
-					NoResponseExpected))
+					NoResponseExpected)) {
 					FIB_COUNTER_INCREMENT(
 						aac_config.NoResponseRecved);
-				else
+				} else {
 					FIB_COUNTER_INCREMENT(
 						aac_config.AsyncRecved);
+				}
 				start_callback = 1;
 			} else {
 				unsigned long flagv;
-- 
2.25.1

