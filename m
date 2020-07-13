Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB4B21D10A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgGMIAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgGMIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:00:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C27C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so12213964wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xTqXVtAy6STm+CsKD82SFXkbTZ9Yyt2OGjfREOk+wxw=;
        b=M1jy5gJQ6q6Im0MkFHexnEREq0mj1rrikwdZtcYdA6zsdX/0IaDB10D+ciO2ksEULj
         jwtXJ3k/kj40jZ8nFulo3+wJ5a8rrkT1kZzZ2YCNAxDaxV1/Ffv7Issr8BJvRgocrr4M
         2SsslluBcGHQnu+v9r3QYQBFat4xkjWGmgGCwJ7lkGte4LdnM/a9K6DR/SlyPUDwgEXF
         UQDMakGne06+yKh1ighWESgggI9u+7C/6Js9c4kOL9EZVsA298m4B3xoBHwY9EArY0ZD
         4RWq3AQIonkUhmpq941Y3K6B+C8OBcTy/+Vmttz8vtBnU29zkqrndoIT/DDVWy6WnUyT
         n43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTqXVtAy6STm+CsKD82SFXkbTZ9Yyt2OGjfREOk+wxw=;
        b=H8UBtEAWpe3fCPHGt4rTRW5PBxOKK355+RsZ7bGlZdTDappy4cpAcn8xlwWTd+aIKx
         FeiInRwamIhcKw5hIuyY5qmX5la3xTcTfq6MVRzEOlj1Dec8sVwidpRN5pz52dMHIBbY
         IU/6K1wQLHhKSC30B4YUSleDAZAQw46WOdm3w0K2vy7Q+t+dX0fqaT6dyzFTLnKhzShq
         XxuXsbt9pjabkNhhtTWAjKGQ/Qs3AsXH/iRPkKqSOhNjHUgyzdzEey/O0rLE1uzSkyFw
         7sH+e/NBH267Xa+KPDfzW7lbHRxv9XHFlCP51BYNeXc32aGFKe0Jrl5YHxWUF7uz+rBe
         akcw==
X-Gm-Message-State: AOAM532dhaCAH6eQDWYbXW7GGZyvGq+g3rQGnF0zauB08I7flAhaqWwp
        jTIOXEMWdg+i8vlSisSCg/pyFA==
X-Google-Smtp-Source: ABdhPJyTMv5tMDSgCuhXi8HCsSyPHplkvrTob7qbPSgKoC+NvFButhbbYGnX22+SeXRtRZ3CXVx//g==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr17327334wmj.22.1594627209769;
        Mon, 13 Jul 2020 01:00:09 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id 33sm24383549wri.16.2020.07.13.01.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:00:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH v2 02/24] scsi: aacraid: commctrl: Fix a few kerneldoc issues
Date:   Mon, 13 Jul 2020 08:59:39 +0100
Message-Id: <20200713080001.128044-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713080001.128044-1-lee.jones@linaro.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions must follow imediately after the header documenting them and
all parameters must be present.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/commctrl.c:43: warning: Excess function parameter 'dev' description in 'AAC_DEBUG_PREAMBLE'
 drivers/scsi/aacraid/commctrl.c:43: warning: Excess function parameter 'arg' description in 'AAC_DEBUG_PREAMBLE'
 drivers/scsi/aacraid/commctrl.c:167: warning: Function parameter or member 'dev' not described in 'open_getadapter_fib'
 drivers/scsi/aacraid/commctrl.c:167: warning: Function parameter or member 'arg' not described in 'open_getadapter_fib'
 drivers/scsi/aacraid/commctrl.c:458: warning: Cannot understand  *
 on line 458 - I thought it was a doc line

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/commctrl.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index 34e65dea992e4..59e82a832042f 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -32,6 +32,8 @@
 
 #include "aacraid.h"
 
+# define AAC_DEBUG_PREAMBLE	KERN_INFO
+# define AAC_DEBUG_POSTAMBLE
 /**
  *	ioctl_send_fib	-	send a FIB from userspace
  *	@dev:	adapter is being processed
@@ -40,9 +42,6 @@
  *	This routine sends a fib to the adapter on behalf of a user level
  *	program.
  */
-# define AAC_DEBUG_PREAMBLE	KERN_INFO
-# define AAC_DEBUG_POSTAMBLE
-
 static int ioctl_send_fib(struct aac_dev * dev, void __user *arg)
 {
 	struct hw_fib * kfib;
@@ -158,11 +157,12 @@ static int ioctl_send_fib(struct aac_dev * dev, void __user *arg)
 
 /**
  *	open_getadapter_fib	-	Get the next fib
+ *	@dev:	adapter is being processed
+ *	@arg:	arguments to the open call
  *
  *	This routine will get the next Fib, if available, from the AdapterFibContext
  *	passed in from the user.
  */
-
 static int open_getadapter_fib(struct aac_dev * dev, void __user *arg)
 {
 	struct aac_fib_context * fibctx;
@@ -234,7 +234,6 @@ static int open_getadapter_fib(struct aac_dev * dev, void __user *arg)
  *	This routine will get the next Fib, if available, from the AdapterFibContext
  *	passed in from the user.
  */
-
 static int next_getadapter_fib(struct aac_dev * dev, void __user *arg)
 {
 	struct fib_ioctl f;
@@ -455,11 +454,10 @@ static int check_revision(struct aac_dev *dev, void __user *arg)
 
 
 /**
- *
  * aac_send_raw_scb
- *
+ *	@dev:	adapter is being processed
+ *	@arg:	arguments to the send call
  */
-
 static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 {
 	struct fib* srbfib;
-- 
2.25.1

