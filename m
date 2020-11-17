Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9D2B6CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgKQSQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgKQSQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:56 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:55 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id p16so13431838wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9NJwaj6H9dpl3R5GKvz3RD0FPuXlHhNUuulS5FTh3Hk=;
        b=JQlCWex6GQEr90aD+Xq83dUt3R1pZAtX7hpfO3tXPKjNHdQDhvuF4w7p9Uq1cYYUYD
         0qrdweQ40YIYcJpB0rKkgokebr+IL6PKzeAVgT/WlcVavgVeGC39u48slN1Uf9VaNibF
         7mREaFFzfgYyEmzz/EM0L6NqrHnXIhZ0MgyYVApx8H6kpW0muE4kg6NHnwBm0Z89W6HC
         BnINsKivgdOVXfLE+ZlQWsr02uvo74sizwj9Y/eaZ3zIO9kF8K2u6C6mTeKsGxWotXkK
         amR0Q5jpJ0Dgqi7rng0ETiiuwY82ca7PMq+gKYVBGnztUjGQQ+TpyrGRWn42mo1p7mPT
         J0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9NJwaj6H9dpl3R5GKvz3RD0FPuXlHhNUuulS5FTh3Hk=;
        b=c/nB8BWWVRRu+ZYn9y49Yb2GUPmAMD7/ckxVAfVzzT1w+KnXCfLhaCdTh2d4O8lAMi
         vmzcp/QkrLqTbPp7+LIpojgoZdXpsygC1fA05b+0mVOX5pkyDuuJWonfIgSyMTYJseD/
         gEVnMg5VGKeQPz4eBcAVBK6wCl2wenLOuvjzBujmOv4WJGO7ZwcrV6ZbefTM1+CfS+KP
         D6qoMJIx+bv9ZvrsRfowdmeacUiFuYYKlfdHxUt6ntWPGfclldLdqQjWlYj+pdOUkdEv
         GaqYspOWcY853PdM5CEQAqvEF2mmP2nvOvA4/vNPoGCBkZSlb44Q7o7OwzXur/OGCXAT
         shYw==
X-Gm-Message-State: AOAM532G0S68H0tSzExAiHWPQlbYPrBmr24DfNg69ohmKOmc+X1yNz/I
        4uZXzPVq/YeJdwaj9BEk/2Ycm5am64gw
X-Google-Smtp-Source: ABdhPJyGVJgIcTCT/DdbnY1gsliRaeUzyr2tI4CihTRnunVErPVhmxXy6EImfhV9SGx6S5piiKOb6bkx3WEt
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a1c:44d4:: with SMTP id
 r203mr394378wma.60.1605637014324; Tue, 17 Nov 2020 10:16:54 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:55 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-16-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 15/27] of/fdt: Introduce early_init_dt_add_memory_hyp()
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com, Quentin Perret <qperret@google.com>
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
2.29.2.299.gdc1121823c-goog

