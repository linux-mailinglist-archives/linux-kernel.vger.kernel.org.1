Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E97B2D2D20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgLHOZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLHOZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:25:40 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3894DC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:25:00 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so16429260wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkCxpWePsFfevlDcUEyEPGxcsnjzxasA1OIQEvsNU/o=;
        b=UH8R3RfyY4sPynLquFWkpqy2WTWXSSzIuSAp+rSQhizic1tnp9KlTS7Y7efZGAqAMw
         MuWmN0VcSOE7Y1ATcEcSGkT9NY58W2weDYlFHdCmmJ+OvSiaDfwuiKRe3Gt4FFvbiP64
         4azh0WSYbt0mS/zs2fxByv6me6YjHQQj4xGUXsYsFovPpv6vD+gk1npQf9zndpaXWfnx
         1TmuF62lTL29fBChAox+JnPUBpEgrxEK6x4ocItr0OEy88xJz+tpcpolNsKsxYkdFY3u
         w+oVXT2DBgxcBjpOIk2J4+Gj7R721q8NZdsa5uC9Q61VagBrwHxgA+J86j3TUZNUQPG8
         4FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkCxpWePsFfevlDcUEyEPGxcsnjzxasA1OIQEvsNU/o=;
        b=QTrsVqJW1LfQ4DQ+6rnQM6/fhtIJy+Q1f8vcwAPF26faTFRru4/+A5kFqtA1SnURJq
         Vr8G/TuKJvs8iA/j+54wVclbGQqMBWv2vGVphV+o/bkpAKmMP6QTfUyIMqFKy5uEl2zp
         tcuqi+pN4QyMvw4v5e3m0s2J3+3ALCb8w4eYONqgfj6XY5/kh5k3IZ5YmK5hJYGyDbjo
         81IQULBCwsV3sWFK155ydgk2+4PNZnJMO1b30SRfabH0+7n4evw1aCAgtCp1SvC12CcW
         mNFbY9l1suktDGHD+EOh7P7fuO3fvgvPNCYw/L8uhHDb+Hr8CgSk4U915rcNLW+xMzo2
         nsGA==
X-Gm-Message-State: AOAM531AUr52oixj3gGM80e7Me7C9NHZ6yJcn2dRJ3gtKZ6dIy/sCvQG
        8RcJSdMZ0Vq9MZ2e0l4/hC4D0g==
X-Google-Smtp-Source: ABdhPJwsb7RVuNDV5tHluPT3itlJhGZvi8mvDtVcsmCOFtJE87agLeOo3053LrTTOxV3LtILOYbdww==
X-Received: by 2002:a5d:6ccb:: with SMTP id c11mr7906522wrc.224.1607437498694;
        Tue, 08 Dec 2020 06:24:58 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:258e:cb26:cef:a620])
        by smtp.gmail.com with ESMTPSA id w10sm20739956wra.34.2020.12.08.06.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:24:57 -0800 (PST)
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
Subject: [PATCH 0/6] Fixes and cleanups of PSCI relay for kvmarm/next
Date:   Tue,  8 Dec 2020 14:24:46 +0000
Message-Id: <20201208142452.87237-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small batch of improvements for the 'Opt-in always-on nVHE hypervisor'
series, now merged in kvmarm/next.

Patch #1 fixes potential use of invalid v0.1 functions IDs reported
by Mark Rutland, patch #2 fixes a warning reported by Qian Cai.
Patch #3 avoids a code path not used in VHE, can be dropped if any
concerns arise. The remaining patches are minor cleanups from review.

-David

David Brazdil (6):
  kvm: arm64: Prevent use of invalid PSCI v0.1 function IDs
  kvm: arm64: Use lm_alias in nVHE-only VA conversion
  kvm: arm64: Skip computing hyp VA layout for VHE
  kvm: arm64: Minor cleanup of hyp variables used in host
  kvm: arm64: Remove unused includes in psci-relay.c
  kvm: arm64: Move skip_host_instruction to adjust_pc.h

 arch/arm64/include/asm/kvm_host.h          | 26 ++++++++++
 arch/arm64/kernel/smp.c                    |  2 +-
 arch/arm64/kvm/arm.c                       | 18 ++++---
 arch/arm64/kvm/hyp/include/hyp/adjust_pc.h |  9 ++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c         | 12 +----
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c          |  6 +--
 arch/arm64/kvm/hyp/nvhe/psci-relay.c       | 56 +++++++++++++++-------
 arch/arm64/kvm/va_layout.c                 |  7 ++-
 8 files changed, 95 insertions(+), 41 deletions(-)

--
2.29.2.576.ga3fc446d84-goog
