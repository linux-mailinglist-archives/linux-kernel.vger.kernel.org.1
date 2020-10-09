Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2286D2888B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgJIMaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:30:15 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:41523 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733117AbgJIMaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:30:01 -0400
Received: by mail-ej1-f66.google.com with SMTP id x7so2653436eje.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMeWwwANxhjjIfeIc8PXKMbqt4pds9dxGsPZyRdXfds=;
        b=CpsuZP/YCEcJHXh6y89xm4MyPuV2sHUQNDUH2Wtn/FBJnouZ/m+LnlZ+Jtv5iHKM1C
         vk6r4A4VgIroX+Qom3BxPn8wgQAG0NJ7Rf32aCJFswQtlrOZX0nZIETV/6bdS9jVpmUv
         3zo09Bp0njPbDCUJHLYC8bI26spKJ72ADRlTxz2vyfTtmYtF3pRX1Y+1SVXu0XFKQoew
         VYwmikNTHInxAsRve4UoXn78lkY6b1gdN4JlratkfW3rm26K+zUQowvTQtJ7Ol3idi9w
         8Z5YiFiG5OssrlfPGPftfsyhJ4XFSXjvCmgSuLAGgEG/JW4AUi5j1VlBIGtxsGdF7WXX
         ysHw==
X-Gm-Message-State: AOAM5330JJnNTsBnO/7CQlWgizRd5uKVDrnKRVqMBTFT9zaFySCZsfr6
        fIwuZqFnF0I19I7q01RJ+vc=
X-Google-Smtp-Source: ABdhPJzv3HUix6XXzlFbzeAbsVJQJUTyCLZBDegSgiofxT+Vc/3oA416WUNDROy4IUwLRNaYcKaI5g==
X-Received: by 2002:a17:907:3393:: with SMTP id zj19mr13637307ejb.258.1602246599417;
        Fri, 09 Oct 2020 05:29:59 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-85-160-42-169.eurotel.cz. [85.160.42.169])
        by smtp.gmail.com with ESMTPSA id q27sm6412701ejd.74.2020.10.09.05.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:29:59 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH v2 3/5] kernel: ARCH_NO_PREEMPT shouldn't exclude PREEMPT_VOLUNTARY
Date:   Fri,  9 Oct 2020 14:29:24 +0200
Message-Id: <20201009122926.29962-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009122926.29962-1-mhocko@kernel.org>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009122926.29962-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

PREEMPT_VOLUNTARY is fully arch agnostic so there shouldn't be any
reason to restrict this preemption mode by ARCH_NO_PREEMPT.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 kernel/Kconfig.preempt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..c460a9a2373b 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -19,7 +19,6 @@ config PREEMPT_NONE
 
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
-	depends on !ARCH_NO_PREEMPT
 	help
 	  This option reduces the latency of the kernel by adding more
 	  "explicit preemption points" to the kernel code. These new
-- 
2.28.0

