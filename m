Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87E92A2A3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKBL6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgKBL5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:44 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6EDC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:43 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id w14so14236592wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1a6YHQXGZMUnJNF8MJYubaqVfXzvcvl6CdQ46sxWjM=;
        b=C1ICrjBz2UIS55v8A0CVuV+UzsXzVI894OzCoqDDetDwz+QP87nDEV2jAZGJw+p4jH
         /K2iKBRHPA2uNEz2pbYI2TQ1RGeYsQAvHfuGehiYVHtRx8O10jh/q/hu0ZsYKLo7OZ0w
         70gpPYhIotirXoOP8721xB4oAGuMV3+353r3yXEz4Ksaq46s6T9d/QGvhSvroxwtmkBr
         b12KgL5CPLZwkuS3Po4ymUrOhRhzejpPj92K9NZtYRbYqhSz/kD6SS4qAWxxrB1UkMM3
         J6i6DGu84pqD3DCC8mEADo5M95mjsPdOdDH1Fg/4xcdD1yN87l3JY80TLLrZRNT9sz8I
         Ro8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1a6YHQXGZMUnJNF8MJYubaqVfXzvcvl6CdQ46sxWjM=;
        b=LEfsZQ8Gaa9vaG4FqaQPypdGwdIaWzNLP/1SPjhbgEgpilnYh5M+pdsvaGt5sM5SCe
         6uEW2n6T601v+xxu0hz7M+Gc7Xf1dexmcPPxxqMjnvlAnj4h5GrAWeO2PykxXIlt6VXD
         X4zNNbSO0crZiUKFnR0JcAbhsrfeImE2WIpEsJB7LRkKF6cFrYbP2rSTAtiSsYzplXL3
         Ea/INvT0YeZJ9nAJzT9X8AOdsYpuI+NK+yHqMuPkvYIG9hej7xdH6P/8L7DIZ76EoR2u
         ocrGolPJB3hqUJyt110LVi1yMpVW6QEtGhKZYEFZ1ciqWw5E5WIotliAh/+Sg7adJZgW
         hmSg==
X-Gm-Message-State: AOAM532fZVocKPAc25ffXTV6l3sLKYTRGAQbej2ev+H5pJmW661QApqa
        kQqHqpmxPsbbTKg5WCyGBe18xg==
X-Google-Smtp-Source: ABdhPJynQCqatZnhipiqIMyZae6ISKViXGxh/+9xGX3NtYl3mkK8NTctMF/TIpI55X1Q6cJ2vummpw==
X-Received: by 2002:adf:eb47:: with SMTP id u7mr19577423wrn.163.1604318262690;
        Mon, 02 Nov 2020 03:57:42 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Bradley Grove <linuxdrivers@attotech.com>
Subject: [PATCH 09/19] scsi: esas2r: esas2r_init: Place brackets around a potentially empty if()
Date:   Mon,  2 Nov 2020 11:57:18 +0000
Message-Id: <20201102115728.1077697-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
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

