Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64302D4316
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgLINSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbgLINSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:18:34 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA6C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:17:53 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r7so1708020wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ui2AyYakjARNpvT610MmpwVISaykxIjU1EziL4bq/8g=;
        b=TtPn5gbE5cUnZn/XoZAH5Q1SPuX8zUYSCs/O66h6C9BXK3fpK/Gxba6BH70xbSUMQI
         rysLsdyUKSLybXMLAMuifFTOgm/GYv7CzvMxgqTkJEp1Fzljb4N/quSYihWIbdHGfOMS
         YewS6M/7CjC7YsdpjGCrrDdk6y4EyOkTNlena25qIj6QWnxi/8p/lfEfwkgi6UyCbeb6
         sjUB6nqC+Uxvz6IBGuj5pn76G9Dt2QO8PEqw5mKADfHfuFpx49k489ssqc8jcB5yU5iE
         ahnxDbrtLwfx8ViQriceqefi2FsulHCF3546sTznByZRVN57V5UzPws2FuRb/mBmH1Xt
         6yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ui2AyYakjARNpvT610MmpwVISaykxIjU1EziL4bq/8g=;
        b=bZAMbxZQ7j1OxEQ+TDf+zwTkxKVBU2BwifnMtJ+fiZwDGFhDsXJabay+pMkkIa/Cxl
         aKxCETx+5iGsmA4IwZySckqVskOJczDhg/K4XoiCGsBk6bS8kvp8g8SKEEn+4tz+O2cw
         qHhvc8JqHlpHJdQVoLu/SDm2H3fov4nxD9mrgiVLBLgXBLrCZGVoK5KkxV9qxpiLXqLh
         G7OlPHbcAHKq/G1Wz/UetYD21mkDw8UBzIvz5gD1O73NIR3d2Rnk2vRdHLxHA/+YwJuZ
         pUtTtSJPqD0Q6ZVS0zQ+RwXeqideG27WIq08BrzGLxSq5cI5AXUdjx6RIZhzzQRJqYgh
         aiOQ==
X-Gm-Message-State: AOAM531HCacNWHUmeaud45bPxxRu93rHiaASV5yWjZ9JW2N3SFsXMNDV
        QErKPfRMBNlVS+TVyomGtXFFwQ==
X-Google-Smtp-Source: ABdhPJzlT1ZAQI8+iYY8fpTcJpj5l6KBwxxqgFiRZRdWFROI/wunQbz/voXHfXAhUBU4AIC7QtIReQ==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr2832541wrt.66.1607519872306;
        Wed, 09 Dec 2020 05:17:52 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9d1b:d0eb:db43:6cd2])
        by smtp.gmail.com with ESMTPSA id g192sm3294480wme.48.2020.12.09.05.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:17:51 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Jamie Iles <jamie@nuviainc.com>,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH 1/9] KVM: arm64: Correctly align nVHE percpu data
Date:   Wed,  9 Dec 2020 13:17:38 +0000
Message-Id: <20201209131746.85622-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209131746.85622-1-dbrazdil@google.com>
References: <20201209131746.85622-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jamie Iles <jamie@nuviainc.com>

The nVHE percpu data is partially linked but the nVHE linker script did
not align the percpu section.  The PERCPU_INPUT macro would then align
the data to a page boundary:

  #define PERCPU_INPUT(cacheline)					\
  	__per_cpu_start = .;						\
  	*(.data..percpu..first)						\
  	. = ALIGN(PAGE_SIZE);						\
  	*(.data..percpu..page_aligned)					\
  	. = ALIGN(cacheline);						\
  	*(.data..percpu..read_mostly)					\
  	. = ALIGN(cacheline);						\
  	*(.data..percpu)						\
  	*(.data..percpu..shared_aligned)				\
  	PERCPU_DECRYPTED_SECTION					\
  	__per_cpu_end = .;

but then when the final vmlinux linking happens the hypervisor percpu
data is included after page alignment and so the offsets potentially
don't match.  On my build I saw that the .hyp.data..percpu section was
at address 0x20 and then the percpu data would begin at 0x1000 (because
of the page alignment in PERCPU_INPUT), but when linked into vmlinux,
everything would be shifted down by 0x20 bytes.

This manifests as one of the CPUs getting lost when running
kvm-unit-tests or starting any VM and subsequent soft lockup on a Cortex
A72 device.

Fixes: 30c953911c43 ("kvm: arm64: Set up hyp percpu data for nVHE")
Signed-off-by: Jamie Iles <jamie@nuviainc.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: David Brazdil <dbrazdil@google.com>
Cc: David Brazdil <dbrazdil@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20201113150406.14314-1-jamie@nuviainc.com
---
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 5d76ff2ba63e..1206d0d754d5 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -13,6 +13,11 @@
 
 SECTIONS {
 	HYP_SECTION(.text)
+	/*
+	 * .hyp..data..percpu needs to be page aligned to maintain the same
+	 * alignment for when linking into vmlinux.
+	 */
+	. = ALIGN(PAGE_SIZE);
 	HYP_SECTION_NAME(.data..percpu) : {
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	}
-- 
2.29.2.576.ga3fc446d84-goog

