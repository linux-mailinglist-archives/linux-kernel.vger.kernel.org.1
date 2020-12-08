Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14032D2D2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgLHO0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgLHO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:26:20 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF54C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:25:10 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c1so4466343wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OsSmUS/TA4WzvLCDGFMnERywT0JtFSnemYNOkWYU7I=;
        b=cDmmm0JhZog6Xpj0xnjDgjeGpv3JmrqqAS/Hzljmtb8vCenaWLk0Ip2XeAbYBS9NqG
         qTsMIEOZtuf8EF7qteO+W8tpzKkzx/uo957in9mqwbKHsZMWpNpdi+BoYHz9fMaBQ1tg
         Dzt8LNJ1VAjZQuATmdisp9eUPX8q90eYl6YgQTCE4z4PCr1nx2+P7/buuKoRG6NHG8Aj
         46wk2xK1UOFU4WpTk3SghsahwJ/PcFhU7EYNW4J6ys7RaNjB2VMJko+6b9L31x4niW2K
         0brar/neIAiT9q2EGjPKdN0j711bn51YXlrehLWLF3H/yZiZF8jdIXIPPYylY64Q0oSU
         xl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OsSmUS/TA4WzvLCDGFMnERywT0JtFSnemYNOkWYU7I=;
        b=lLHQASTa3tQ1m6elFN0AO5DUo0JkayQngBJdEQn4lec0Rq3OvcjvmS3kKwpljamQOn
         9JfRoGGSE/usWp3g03oeOLbHNWdxHNNrH9t9OxPsCQTWrJ+uh3MuQiZZajbrzpGoguGh
         H5QsdG+yjYwMb7CoIixRDAU27wv2GBKfFyYW1wpsKKFX2eEwwKyKaoKV26RYj4qsaMdN
         2n5nT9KFA6o38BBmspa7/ipr6Jkj+NuLZz/boGLb1I1+2EPwB/uiiJYs/yoeSHDSJxsh
         o6scHqUZL05ibdCYLfIdYrZ/G5NcFVQJBHV+yA+YuOTzaHZKv6DuydUVq2nftTbgB/Rf
         untg==
X-Gm-Message-State: AOAM5333hlbRWrZuK9JA3txT+TN8Mmb82JGyOgJr/lpzlKXlMNd06TRw
        Ij6JMqUBiLOeW5QHhPER78/odQ==
X-Google-Smtp-Source: ABdhPJzAbt6RsNvdFXhB3aG8NC2B+lzZJ++35G/5BqR/OlHQfGVdFuDj/qtCUap6ioQzj3F+kC4a2g==
X-Received: by 2002:adf:e444:: with SMTP id t4mr25488751wrm.152.1607437509535;
        Tue, 08 Dec 2020 06:25:09 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:258e:cb26:cef:a620])
        by smtp.gmail.com with ESMTPSA id z21sm3843405wmk.20.2020.12.08.06.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:25:08 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 5/6] kvm: arm64: Remove unused includes in psci-relay.c
Date:   Tue,  8 Dec 2020 14:24:51 +0000
Message-Id: <20201208142452.87237-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208142452.87237-1-dbrazdil@google.com>
References: <20201208142452.87237-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup removing unused includes.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 0d6f4aa39621..1f7237e45148 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -7,11 +7,8 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
-#include <kvm/arm_hypercalls.h>
 #include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
-#include <linux/psci.h>
-#include <kvm/arm_psci.h>
 #include <uapi/linux/psci.h>
 
 #include <nvhe/trap_handler.h>
-- 
2.29.2.576.ga3fc446d84-goog

