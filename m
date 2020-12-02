Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AAB2CC590
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbgLBSnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbgLBSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:42:59 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15194C061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:41:42 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so5193492wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qXwVi8GgD0h+y0Z1L4Qz/RxstC0DDwAUVzhRN0FU904=;
        b=i+G98kVudQR6uGePmNxw8xCv7SMJAja1ZSWowPxR1m3WcQORTplZuJmLizNsMjEhCh
         wEKbRahBqXc7XUcmyktVRkyyRuiuvzzaXLq/c+bjP3tKDlOtoQz2LX6scrNS6qFBjsDZ
         jJFI5aZZ9jlIWXo5dAO5x0M14XqlhIjLXybyL7t9tmYSDxxm8vj02XMeVsJGeAbRe3Ec
         bHjOvS6lH4XPiSfInJTeRmGrp8KEenXa0rxR8rBCPjCgXRbh7UKOJ0EfJ0JxTI2zZtoa
         SeNlCdJAZECI2DajIMd/1/nTwrPVyOC5AzMf8GimCHFwpoSij5LlSefToJPi7j30LqQ8
         It/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXwVi8GgD0h+y0Z1L4Qz/RxstC0DDwAUVzhRN0FU904=;
        b=L+5+0RGLjqBvBuMEV4KDvfSHnE64pN0YMRyktYfHwrvDsBgJZm5/qKf5jFRZU2bqrO
         tHhZUEh1XK+5K09Dt6UTJtsgl8qmdBPdthTr7eu8XpznWrQ8TnV+pFPL4GvNZSRe7rbS
         GZA8zqmPNpvY9HPCNGNGmvkj6c9YC3SnK+ccvmMX/ncTM2EAeplhJHwlftCjWJtgSHZq
         VGo9M12KHSEiYA5pXA/LeW4TcQolJuP9MBch0Obtd4XCQv2tnHAbOeT3Of7VlzkxHeyc
         cmzHqVCyRSl8rUo4xXsZfTGwEtfcwyewBBjyux0cNBawKHuSmXn4FYfelXCJpjsFY7Lw
         UIXw==
X-Gm-Message-State: AOAM533vo7WTrc2aoN/4Zh6rnW8xrJ94/q4CFFM8kVuq9dcZdhdFQNIW
        +xvMHlHDDVEKJa1BPJYnw/NPTw==
X-Google-Smtp-Source: ABdhPJzo+3XrHLu5MZisvjC9Vlqkp9p6BFe0uyPEE/+3sbo7phn6YCf8SNKtKbXnK5PdAZQg2KF0+w==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr4996465wru.422.1606934500673;
        Wed, 02 Dec 2020 10:41:40 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id p11sm3257202wrj.14.2020.12.02.10.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:41:39 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 06/26] psci: Add accessor for psci_0_1_function_ids
Date:   Wed,  2 Dec 2020 18:41:02 +0000
Message-Id: <20201202184122.26046-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to retrieve a copy of the psci_0_1_function_ids struct.
This is useful for KVM if it is configured to intercept host's PSCI SMCs.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/firmware/psci/psci.c | 12 +++++-------
 include/linux/psci.h         |  9 +++++++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 593fdd0e09a2..f5fc429cae3f 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -58,15 +58,13 @@ typedef unsigned long (psci_fn)(unsigned long, unsigned long,
 				unsigned long, unsigned long);
 static psci_fn *invoke_psci_fn;
 
-struct psci_0_1_function_ids {
-	u32 cpu_suspend;
-	u32 cpu_on;
-	u32 cpu_off;
-	u32 migrate;
-};
-
 static struct psci_0_1_function_ids psci_0_1_function_ids;
 
+struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
+{
+	return psci_0_1_function_ids;
+}
+
 #define PSCI_0_2_POWER_STATE_MASK		\
 				(PSCI_0_2_POWER_STATE_ID_MASK | \
 				PSCI_0_2_POWER_STATE_TYPE_MASK | \
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 2a1bfb890e58..4ca0060a3fc4 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -34,6 +34,15 @@ struct psci_operations {
 
 extern struct psci_operations psci_ops;
 
+struct psci_0_1_function_ids {
+	u32 cpu_suspend;
+	u32 cpu_on;
+	u32 cpu_off;
+	u32 migrate;
+};
+
+struct psci_0_1_function_ids get_psci_0_1_function_ids(void);
+
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
 #else
-- 
2.29.2.454.gaff20da3a2-goog

