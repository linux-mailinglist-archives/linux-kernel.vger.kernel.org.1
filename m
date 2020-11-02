Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A032A2A37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgKBL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgKBL5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:51 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E82C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:50 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id n15so14300816wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpntW8qOQ6pR3vVGmsTYcGUv23Vlc0jF5vAOPXJRUnY=;
        b=OZiSivs70ZEJKFQZGwBViBhbq2cmtLBZe8c/PTam53F9gufywvs1xQmVgN+qS4yYBu
         XP3x8mgm62ptPRXtuIJihIPtVnFwMZFewMEV2258M1o/KVDkO+rJeQyb3/zLju3CD6SR
         qKDokWKSXZIJew0W1fqnokQlRZQAq9m4b1lbtHEXYDbk2q3WSiV7ShYMEZkTg8BLEhZy
         dCqdh9D2wG75bgaXKC40N3daSHNTR6GHdF9sAunzlCaWua4QsHt2n1bmEp6jaAwa5EcT
         ZLj7TwckHKuHZWWE3ASBCOD51iDT+9wrS4W7wCOKzIYC6ETm5NX7ahuP6DncMqQU8f+J
         NGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpntW8qOQ6pR3vVGmsTYcGUv23Vlc0jF5vAOPXJRUnY=;
        b=HuHhznLUPCs58LjUZbq+wrGhw8XiM7eufQomI4rlXA8D0r35riBIUcLEfa2WoLTk3I
         D98QYE0u1jnhDtbqA7Fevkh99yg0SiajwBUW9c0J7JKgTGw9Ib9GsLYVpsh7QWWOzScu
         tpsUUEV5wMR5sw9n+GsJD4zzA/hifXZJ92fqGWB184GXv1W4pqlL0Y2EmaddMD3lwBeX
         EU9X4Uk34fe4yxlkErn/UIEbsL6ry4UGkdM9Xvlu+jyoywCI8QfQvhDwk2rSlfbNHRKF
         jujVML2AR13ayXHJqU0lf9Qu6FW13lfkFWzxGBrTJQXRcLJapUDeh6nGEOiJWI+729YQ
         5ULQ==
X-Gm-Message-State: AOAM530Dzcu2CVYkZB2+RqPa7qingMOCbJkdePURG2Td3ZHf1eVTyKbS
        eDPCS5tAyHeSSxgZ0cI/d/Rcjg==
X-Google-Smtp-Source: ABdhPJy7lC6AMRL2KE/wipkxB8umcxncOvMnI2eY0UMRnhlWsJzPyEX5XeQAlRFBNnIWzN7cmbAwaQ==
X-Received: by 2002:adf:e681:: with SMTP id r1mr19178910wrm.181.1604318269359;
        Mon, 02 Nov 2020 03:57:49 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Bradley Grove <linuxdrivers@attotech.com>
Subject: [PATCH 15/19] scsi: esas2r: esas2r_main: Demote non-conformant kernel-doc header
Date:   Mon,  2 Nov 2020 11:57:24 +0000
Message-Id: <20201102115728.1077697-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
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

