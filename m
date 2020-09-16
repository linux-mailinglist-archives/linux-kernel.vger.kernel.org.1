Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13DA26CA74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgIPUAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F205C061223
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:35:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so3903767wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ZouLpoLHZGhnRn3IE3lAdYTtqQtOaDPWcW0BXT72MM=;
        b=HNZo35gC+J7olQM/J4RAmLlZS6QxVf8SG/2BDEI9P1bohZ+P5Q96wTZVwc7II0n9BL
         cgE7q3s2HuB8SyeYAwP76jfvS9ilgnaSdWf3BN5CpaP3PpCWpHo7OyCzXoLczzUjYIh+
         TAvf72HVFbYYjUfwXRs9KQWyCZzjv5SmQjRTwHXgeAoUK3/2zXTwbrvIkPx4Um1P5RvS
         TU1N+Ppw0DKArVS8ynQ4bf+jV171VTr1y4ZU53me1jkwW1cniiMaCioHU1u/AMChZdp6
         1BnnWaIQvyESEBhMsuSyugrLCEkTdp5crIYFCA9FneqGow+l1YuEeHkCEHhBbzEX3vON
         E0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZouLpoLHZGhnRn3IE3lAdYTtqQtOaDPWcW0BXT72MM=;
        b=j1arjmfs5qkpR0qD0bNuxBbPXx7FQe6x5U8G7G8vdr57V4rj76nLQb1Og77nDZPOw7
         RZy+TC9DW/f0J1eshIdgkC2rsmSkY+lAEBvoYfchLbo3gRnXpCHRCrVLQvL3hwiDU+BL
         8z4+GyJabitJXlFKXq/ETy6SNWYTawmeRCsyDn0Sn2T51ry1OLWYVDyvbqaB9eM9e3no
         Sbut1S4c1iO2DLFA/CARx/1E2Gkxi//VXYkFE/9/tJ16wxOiZw04LSlAAJ8JaYf+6Ig9
         +qyTnqieCkdGgTyHeFN543QtVKLzf0IXUsqcdVRrLZUbgwab72ruA43sg/kR1U7PzMc6
         WbTg==
X-Gm-Message-State: AOAM530Q1GV6L7XXbZwTb7nS72jAMgKalujLEa7JQZmZ1OUIGLY4/z+P
        51QCG1tYlppHjZTHFuRW1KMsKg==
X-Google-Smtp-Source: ABdhPJyjAeHVuIWwfCgiltujOqCdZJciMMvPMbdeAr38UjlrUERhWuN+mDjxXhXo26gYVThTzJRNbg==
X-Received: by 2002:a1c:2e08:: with SMTP id u8mr6233481wmu.156.1600277702955;
        Wed, 16 Sep 2020 10:35:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id p1sm8808360wma.0.2020.09.16.10.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:35:01 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 09/11] kvm: arm64: Mark hyp stack pages reserved
Date:   Wed, 16 Sep 2020 18:34:37 +0100
Message-Id: <20200916173439.32265-10-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for unmapping hyp pages from host stage-2, allocate/free hyp
stack using new helpers which automatically mark the pages reserved.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7af9809fa193..58d7d614519b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1456,13 +1456,58 @@ static int init_subsystems(void)
 	return err;
 }
 
+/*
+ * Alloc pages and mark them reserved so the kernel never tries to
+ * take them away from the hypervisor.
+ */
+static unsigned long alloc_hyp_pages(gfp_t flags, unsigned int order)
+{
+	struct page *page;
+	unsigned long i;
+
+	page = alloc_pages(flags, order);
+	if (!page)
+		return 0;
+
+	for (i = 0; i < (1ul << order); ++i)
+		mark_page_reserved(page + i);
+
+	return (unsigned long)page_address(page);
+}
+
+static unsigned long alloc_hyp_page(gfp_t flags)
+{
+	return alloc_hyp_pages(flags, 0);
+}
+
+/*
+ * Free pages which were previously marked reserved for the hypervisor.
+ */
+static void free_hyp_pages(unsigned long addr, unsigned int order)
+{
+	unsigned long i;
+	struct page *page;
+
+	if (!addr)
+		return;
+
+	page = virt_to_page(addr);
+	for (i = 0; i < (1ul << order); ++i)
+		free_reserved_page(page + i);
+}
+
+static void free_hyp_page(unsigned long addr)
+{
+	return free_hyp_pages(addr, 0);
+}
+
 static void teardown_hyp_mode(void)
 {
 	int cpu;
 
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu)
-		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_hyp_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
 }
 
 /**
@@ -1486,7 +1531,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		unsigned long stack_page;
 
-		stack_page = __get_free_page(GFP_KERNEL);
+		stack_page = alloc_hyp_page(GFP_KERNEL);
 		if (!stack_page) {
 			err = -ENOMEM;
 			goto out_err;
-- 
2.28.0.618.gf4bc123cb7-goog

