Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE832B52F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733312AbgKPUnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKPUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7069C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:30 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so20251655wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i1OvP2q61CHl1qszot5RZrAZIRY6eLpATjvcLw+mVNU=;
        b=VBVxPuFz0v1VTxIhWc+Lrxy25SeJfCOpJAG27XQAFG1IjlE2oXtGlzk3400Z+kESsc
         6V/4SHdSfdtr5e6x8XvFe0sKbm3FkQOw0FUMSTcQhpXIp23sO5VzwOQrvHR/FjNr+e+8
         q5UKiuLIqgP1GIvawt3LAxo1d314xttGEOemqAuZMnRmQ/mAjvi//QdMK5UQqUAoppoG
         GWMpUTAcZJlaL5EgsnZm2+vljkdDsttYq7vJ5k23DOVdeVbCzxHVWWYd4kItMa1gFkI4
         pomXJMJSspC0SOuZwKwAkSVw+xfZQALrUWVWGtsi8G9v4nuZyZxlLczAM4n2uo0dg8mX
         Av0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1OvP2q61CHl1qszot5RZrAZIRY6eLpATjvcLw+mVNU=;
        b=fXYmqYQ4hvaItNVNpYBWaeaPSn0kY2+eFew8M/7Hcs1L2s6LmaYh/jKiTL4+nqdliO
         QDlEwKC4X33qfPCd6K1qF66zDgOWpG7OrvRY2YEO84MaVTiQsYH+BRuIJK6LuWGu+z63
         LrOgh3+nSUrxp6cUcthvb5/KMG/tQ3ZOKwOIztwKg+Q1//S+hT8kKoXSEJ4oftrqC2y7
         tqIUAlu2u2ZHd4UJL3OFOao+Ackluduxhv54imeHgxpkN36fgyZbimnKRaNOgd99/J1z
         KfYn6bk8d37FjxST0uHngSEvZvEy/cUNai+DpHpVgvNzsMhBCBaRBdLjeTl+xItuus0c
         V81Q==
X-Gm-Message-State: AOAM5314wqB0MRVXtAthw5PHg/XZBc9wFILM68rIDA5OWEaSNAWu/x7G
        ZV6PAm6GU86KNEbaAyu3eJQp+Q==
X-Google-Smtp-Source: ABdhPJwo5wX54x3EI1cjb6V0hNUDo7O9qMuKIAu7Wtf6d+0psErzZX0pP09b5KCMiJdBDam8PwHRaA==
X-Received: by 2002:adf:f5c8:: with SMTP id k8mr22225271wrp.2.1605559409325;
        Mon, 16 Nov 2020 12:43:29 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id z3sm23263951wrw.87.2020.11.16.12.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:28 -0800 (PST)
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
Subject: [PATCH v2 03/24] arm64: Make cpu_logical_map() take unsigned int
Date:   Mon, 16 Nov 2020 20:42:57 +0000
Message-Id: <20201116204318.63987-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU index should never be negative. Change the signature of
(set_)cpu_logical_map to take an unsigned int.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/smp.h | 4 ++--
 arch/arm64/kernel/setup.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 2e7f529ec5a6..bcb01ca15325 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -46,9 +46,9 @@ DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
  * Logical CPU mapping.
  */
 extern u64 __cpu_logical_map[NR_CPUS];
-extern u64 cpu_logical_map(int cpu);
+extern u64 cpu_logical_map(unsigned int cpu);
 
-static inline void set_cpu_logical_map(int cpu, u64 hwid)
+static inline void set_cpu_logical_map(unsigned int cpu, u64 hwid)
 {
 	__cpu_logical_map[cpu] = hwid;
 }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 133257ffd859..2f2973bc67c7 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -276,7 +276,7 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
-u64 cpu_logical_map(int cpu)
+u64 cpu_logical_map(unsigned int cpu)
 {
 	return __cpu_logical_map[cpu];
 }
-- 
2.29.2.299.gdc1121823c-goog

