Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34772F6D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbhANVba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:31:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727893AbhANVaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610659718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3hpJw/GM23ZF6wgVTR+PJXyTiqzv/mqj3A+uP2OrRjw=;
        b=X1sCT9udwjMAIOcafvRbJRwgOegBPNqZCTKVdmzdVLdsdhpSmLkyKTV7mNqiewYuifJSO0
        scR5eQ6+xXAdu7DqDckSljFCNcATu3xu/aTF8aEwuGmRB+6IQ77EwxXQZwRHEaEyzbZMTC
        6WrfWaWuBYhLl+W0Te8Uzg6qvc9OneA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-WwrvgyBaNI-j91pbfylE0w-1; Thu, 14 Jan 2021 16:28:36 -0500
X-MC-Unique: WwrvgyBaNI-j91pbfylE0w-1
Received: by mail-qt1-f197.google.com with SMTP id t7so5497064qtn.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hpJw/GM23ZF6wgVTR+PJXyTiqzv/mqj3A+uP2OrRjw=;
        b=N3YvMQzCfUMdhIlIc9FxpcJ6JKiGX4CgEBAh7Jox8GOUVp2xcu3EhTI6L5recVxAT/
         32J7RhSk3oVFIZWrSGAhhdMD8EaGXSkA/gM3x0NLfGThs0tMsAW2OFsMXAb6RGC+rBw2
         72ojEMBKJ3hdO8PMbndRHAJLwLqRwBn1HuNm1tV5CrFvt4Gfc+gdGz+k1cauEA9sLkvh
         VXBtBDp62YurKRHoS/K6bM1fct0hMNrauAwUoZ6xjdEViu30Yt7q7+//k4gYRWiMxJBH
         Wze9E+yCIBzBXXWDFd/9fDfxaodKEUksvuBRjZjbOfkUM+W3NNMfxwMKqXIEp8bIoFqe
         jJQQ==
X-Gm-Message-State: AOAM530/qSVE4qjLEjArzOR1OIfUCmgHfAP4VhedJuisTn61Il/tM+8T
        ABqokA3tGn02VcPOvuMobA0CH6xCaahts2Iq3MFEy6epxYKkXkAMlWvpGsnu8PnI9rXFUsBaRDA
        TtwoQ3IlSyT++7sSos+mORXeL
X-Received: by 2002:a37:9a97:: with SMTP id c145mr9127872qke.350.1610659716435;
        Thu, 14 Jan 2021 13:28:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwXwqofQw+JR0KIV3nSCBvZc3y4jxu//vFV9/vmnFh3/JUQ+stLAlnS+cwt2ArUikQVdJHOA==
X-Received: by 2002:a37:9a97:: with SMTP id c145mr9127838qke.350.1610659716149;
        Thu, 14 Jan 2021 13:28:36 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z10sm3769857qtm.54.2021.01.14.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 13:28:35 -0800 (PST)
From:   trix@redhat.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        rostedt@goodmis.org, karolherbst@gmail.com, ppaalanen@gmail.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        alexandre.chartre@oracle.com, ying-tsun.huang@amd.com,
        mchehab+huawei@kernel.org, paulmck@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] x86 : remove definition of DEBUG
Date:   Thu, 14 Jan 2021 13:28:27 -0800
Message-Id: <20210114212827.47584-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Defining DEBUG should only be done in development.
So remove DEBUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v1: merge all 4 in arch/x86/
---
 arch/x86/kernel/cpu/mtrr/generic.c | 1 -
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 --
 arch/x86/kernel/pci-iommu_table.c  | 3 ---
 arch/x86/mm/mmio-mod.c             | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index a29997e6cf9e..b90f3f437765 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -3,7 +3,6 @@
  * This only handles 32bit MTRR on 32bit hosts. This is strictly wrong
  * because MTRRs can span up to 40 bits (36bits on most modern x86)
  */
-#define DEBUG
 
 #include <linux/export.h>
 #include <linux/init.h>
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 61eb26edc6d2..28c8a23aa42e 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -31,8 +31,6 @@
     System Programming Guide; Section 9.11. (1997 edition - PPro).
 */
 
-#define DEBUG
-
 #include <linux/types.h> /* FIXME: kvm_para.h needs this */
 
 #include <linux/stop_machine.h>
diff --git a/arch/x86/kernel/pci-iommu_table.c b/arch/x86/kernel/pci-iommu_table.c
index 2e9006c1e240..42e92ec62973 100644
--- a/arch/x86/kernel/pci-iommu_table.c
+++ b/arch/x86/kernel/pci-iommu_table.c
@@ -4,9 +4,6 @@
 #include <linux/string.h>
 #include <linux/kallsyms.h>
 
-
-#define DEBUG 1
-
 static struct iommu_table_entry * __init
 find_dependents_of(struct iommu_table_entry *start,
 		   struct iommu_table_entry *finish,
diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index bd7aff5c51f7..cd768dafca9e 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -10,8 +10,6 @@
 
 #define pr_fmt(fmt) "mmiotrace: " fmt
 
-#define DEBUG 1
-
 #include <linux/moduleparam.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
-- 
2.27.0

