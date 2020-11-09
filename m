Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7764B2AB6DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgKILcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgKILcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:32:46 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:32:45 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so7642478wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f226i52yIUjNH4HBJOMzOEDrBWriDTS35aJrFSCy+Ic=;
        b=tKDv7a9REysuwMcfZXBWv7HtDLUfJLSTc25Wz4yG+dYB9FiY+ZSpS20+jeI7ruPf4I
         /fRs+zUVAIUMH1v15ddDDay1fvfPcrhZMC5kpfB1XWwITdN/8S2pMA+But30yQSNFNB8
         jXgP2h4bzV7gV3d+faa8zOcxytIQ75QP4e6KxzkSUI0fLT1OOhTj4AvNRjPQ6XdKxesG
         ND6CsW+tx1PrW/9Sz/H3LHqnbchMyHOUycxmZIOc1N/2GLN4ul752VNg35nnWTjEXdVH
         EK3JO5SzqaS0OeDrJpetOM5SGKT+6ZRfLDHKcoyYlwBds01zZYnphO02pxAGc+J+wzvK
         hRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f226i52yIUjNH4HBJOMzOEDrBWriDTS35aJrFSCy+Ic=;
        b=s+CM49ycF/rCAbtdUGBwpuj34E5OfUMWQ19YiDZLv2M4hvjvZo+4gQ0/c7YSfbKJFr
         +qeQe37NLoO4OLTx6T95mRoXXTjNaeaCMQnK7biptIu84d00Ot31VThm0TQU0k57eYRX
         0p8BUoB5z+YQnu/x3bXi1/SCafmb0uK41Dtx5RdvrbEFF05lZYn9Smj4qQ6wZmxCxzmc
         lyQWmYGPS47NA16a3V4IySnoFKDO7UPuzRlmH9hSI8q3H866t7DAaDOdkX8dipfN5GAV
         NLG5MlbZ0nKFyRwVzME9funbKKA+J+miZeOJx1dwDVCLF0nia3KU0qJosFFQaF8HjV73
         xBIQ==
X-Gm-Message-State: AOAM531Y/nh7fUCWxEmE7g6XbKlhXeqnkg49hp3zrZGdvDA/0OFdAxyT
        Yidd8gieGUfi3ze+dTDb/Cz+qA==
X-Google-Smtp-Source: ABdhPJwoENuVGCK5XFTaDJ8MaIk0VaZFOfs2tSaTvsARZ9sJi9l+ITqvhV3gCNpUzPG+TP47XhXsRw==
X-Received: by 2002:a1c:7dc8:: with SMTP id y191mr14412755wmc.118.1604921563823;
        Mon, 09 Nov 2020 03:32:43 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id h4sm12847197wrp.52.2020.11.09.03.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:32:42 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v1 02/24] psci: Accessor for configured PSCI function IDs
Date:   Mon,  9 Nov 2020 11:32:11 +0000
Message-Id: <20201109113233.9012-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function IDs used by PSCI are configurable for v0.1 via DT/APCI. If the
host is using PSCI v0.1, KVM's host PSCI proxy needs to use the same IDs.
Expose the array holding the information with a read-only accessor.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 14 ++++++--------
 include/linux/psci.h         | 10 ++++++++++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index bc1b2d60fdbf..b67b2ba8a084 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -65,16 +65,14 @@ typedef unsigned long (psci_fn)(unsigned long, unsigned long,
 				unsigned long, unsigned long);
 static psci_fn *invoke_psci_fn;
 
-enum psci_function {
-	PSCI_FN_CPU_SUSPEND,
-	PSCI_FN_CPU_ON,
-	PSCI_FN_CPU_OFF,
-	PSCI_FN_MIGRATE,
-	PSCI_FN_MAX,
-};
-
 static u32 psci_function_id[PSCI_FN_MAX];
 
+u32 psci_get_function_id(enum psci_function fn)
+{
+	WARN_ON(fn >= PSCI_FN_MAX);
+	return psci_function_id[fn];
+}
+
 #define PSCI_0_2_POWER_STATE_MASK		\
 				(PSCI_0_2_POWER_STATE_ID_MASK | \
 				PSCI_0_2_POWER_STATE_TYPE_MASK | \
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 5b5dcf176aa6..8fe681a7b43d 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -29,6 +29,16 @@ bool psci_has_osi_support(void);
  */
 int psci_driver_version(void);
 
+enum psci_function {
+	PSCI_FN_CPU_SUSPEND,
+	PSCI_FN_CPU_ON,
+	PSCI_FN_CPU_OFF,
+	PSCI_FN_MIGRATE,
+	PSCI_FN_MAX,
+};
+
+u32 psci_get_function_id(enum psci_function fn);
+
 struct psci_operations {
 	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.29.2.222.g5d2a92d10f8-goog

