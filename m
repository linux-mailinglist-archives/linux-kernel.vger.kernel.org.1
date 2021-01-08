Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDAD2EF245
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbhAHMRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbhAHMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:08 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B823C061243
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:16:00 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id d2so4092133wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7wQIE5XecZh/pAi+A9ahJ0JiP2BIW9kKktEGdKjk9KE=;
        b=A8PxRTnMwBpbyy3mjy7HcZVKT4lcOkB6tCxDtqR0LOEWgzLXSW1lJKcuTnVfX5uu1/
         jEpCOtIwnUA6Uui3Zv+q3w+TGLuWznDsE+qg8r9wx5p29uGmwnaWocLUmC/y6c+VyPQR
         JXTLKVSCPBeri30E44X4gWfFGk6vhc8hUAWuFi91Y/XmSgxFa9zzwfapa5aRNyF0pqcX
         W+FbQGjkGPLb6qITvlNZvexo7Qlg1gJ/bFXZdVD0DPrawILRu3CDrLNQmjmLAQBP+SE7
         aXSaZX+KY+NRDYk5QN4FYmPthdCftGMPdExRyClSUnhfXCNXEl/a/ZGyv9b8Z98mpNJ/
         y2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7wQIE5XecZh/pAi+A9ahJ0JiP2BIW9kKktEGdKjk9KE=;
        b=Vd8s1UvCtpe4a2BFfHdLJ4GWR02NZo/ggtapBjs+jy9gSlLcqH1I20PHLjD3BGilF6
         cSGINAlsC7+jcLF/KAkTJLqnKLhDikosGbd+1qTUmF0ldRidG2jSiYYUTRllKJfTmWpG
         94HXRuQq+8uhRBqVSl7EslVkPaCSRKhnifOUYg0BdKLONBs0HEsDeg360II30OdBO1SG
         YXbkBPwT3t3N7VCfVMOFrwt5xlEByTkaEaGUq4ZYET8Jlwd9MuEpceZQgZsFreKldixd
         h+bjDsvX0W5Y00IfKJO75asxZChqJxoqyia/cLHJ2TpPlnaEq7GbaLSstwMBcX8m/rcF
         Gfgg==
X-Gm-Message-State: AOAM531jgSIG6QP1rM13cEbjngQM7uiivCePliFPMgcVEt+Iev+zC2iK
        rhCvs31gnauD9P0loAUnXFZN7N3gcmEf
X-Google-Smtp-Source: ABdhPJzSE1Qnh3bmoUiNpT3+OMdMwVfkpG80eqm+sA8SoXeBjeN9dqGurdaqfhYzIGM73v4r+iFahg4hIkFI
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c044:: with SMTP id
 u4mr1783959wmc.1.1610108158307; Fri, 08 Jan 2021 04:15:58 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:13 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-16-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 15/26] of/fdt: Introduce early_init_dt_add_memory_hyp()
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce early_init_dt_add_memory_hyp() to allow KVM to conserve a copy
of the memory regions parsed from DT. This will be needed in the context
of the protected nVHE feature of KVM/arm64 where the code running at EL2
will be cleanly separated from the host kernel during boot, and will
need its own representation of memory.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 drivers/of/fdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4602e467ca8b..af2b5a09c5b4 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1099,6 +1099,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
 #endif
 
+void __init __weak early_init_dt_add_memory_hyp(u64 base, u64 size)
+{
+}
+
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	const u64 phys_offset = MIN_MEMBLOCK_ADDR;
@@ -1139,6 +1143,7 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 		base = phys_offset;
 	}
 	memblock_add(base, size);
+	early_init_dt_add_memory_hyp(base, size);
 }
 
 int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

