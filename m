Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16921D0AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 09:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgGMHre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 03:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgGMHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:47:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so14688625wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3sXxKpQgrnotRyFJvyRPk0Xs+GRdftij+k/kTivXzV0=;
        b=LZAtex/WvZHUpRfBeIZuZKGHFkUEF40F92oWBBEHmfCNjAnSVVxMm34PN6BoS2WVBR
         KYr1bV+zFda1yL2IObHPGtXWzfFJEGpKUzjdRuvs3HDedNofLTE6NLNjnzxRcOd+Ards
         wA7tDnCIGATq+LFB7AgoBTKCJ0tsXjcRqLrFmjdYvkXpCT1sLQ7Vpp9gi+pLf2sWWWfG
         sR39e13edBAyWagxr31HeBUwhCgNqplIi15GyHABbVhdMFjB7/TBZAzAn1rPM7pP82hL
         UVraZPM3LCSfFxR+7TY1H46QW8UjSKNRhVcy1bSB6JY+4Ip/HZexJKDyijDXIgcEdqh7
         XAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sXxKpQgrnotRyFJvyRPk0Xs+GRdftij+k/kTivXzV0=;
        b=DfCaEcHtsaD+aoWo7vqV8XvlKpNLQbuclRcRPlefwC7HWVxTZzI9x4m3QeTMcuqU8O
         +453bK84BREXPzPb134SlARfihewXMXE4YevvYkGfejW5LzRL5YwD6UrMkXDmYuNZ09c
         P/sHcNtqsLn6WXSx/qCEIAsIaXCgztkhV62nNI+Zx4MAr3pGPI+nD+QgRE48mBYTdYY+
         N2ddCMWgHt2Kzsq3nnlBa+WvyljF+d01uhOWqzwBCjNaG7Uouw8Z62lugTkkowoJDcMd
         QMZYWShMEgLKV3HUzjjnXDwww8Ey8EUZ19xY9j2XWz9OxWj7rBjhwHmCJWZPsHTwe4e1
         pWyA==
X-Gm-Message-State: AOAM533IMiOkANvCrHKgOqxQ3w2iNwhgQ4iBFW3F6PLXBVa7DkA2xWJT
        +FIr3M6a7BnuS61H+QvCcpOWaQ==
X-Google-Smtp-Source: ABdhPJyJUEE2qprj118VrHMoVD4MJ7gID9qoJfCl9yCER6q4U+8w9qO0a1w6J+az2L3+e7K3DtVznQ==
X-Received: by 2002:adf:f20a:: with SMTP id p10mr83083836wro.41.1594626436567;
        Mon, 13 Jul 2020 00:47:16 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:47:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Luben Tuikov <luben_tuikov@adaptec.com>
Subject: [PATCH v2 27/29] scsi: aic94xx: aic94xx_hwi: Repair kerneldoc formatting error and remove extra param
Date:   Mon, 13 Jul 2020 08:46:43 +0100
Message-Id: <20200713074645.126138-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function parameters need to be documented with format '@.*: '.

'to' is not longer asd_start_timers()'s function parameter.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic94xx/aic94xx_hwi.c:589: warning: Function parameter or member 'asd_ha' not described in 'asd_init_ctxmem'
 drivers/scsi/aic94xx/aic94xx_hwi.c:1157: warning: Excess function parameter 'to' description in 'asd_start_scb_timers'

Cc: Luben Tuikov <luben_tuikov@adaptec.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic94xx/aic94xx_hwi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index c5a46c59d4f80..9256ab7b25227 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -575,7 +575,7 @@ static int asd_extend_cmdctx(struct asd_ha_struct *asd_ha)
 
 /**
  * asd_init_ctxmem -- initialize context memory
- * asd_ha: pointer to host adapter structure
+ * @asd_ha: pointer to host adapter structure
  *
  * This function sets the maximum number of SCBs and
  * DDBs which can be used by the sequencer.  This is normally
@@ -1146,7 +1146,6 @@ static void asd_swap_head_scb(struct asd_ha_struct *asd_ha,
 /**
  * asd_start_timers -- (add and) start timers of SCBs
  * @list: pointer to struct list_head of the scbs
- * @to: timeout in jiffies
  *
  * If an SCB in the @list has no timer function, assign the default
  * one,  then start the timer of the SCB.  This function is
-- 
2.25.1

