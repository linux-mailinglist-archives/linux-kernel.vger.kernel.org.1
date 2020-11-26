Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CE2C58B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391376AbgKZPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391361AbgKZPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:54:34 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6021EC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:34 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so2852538wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3ZEYk2Uf0v1klDyIVNllC4hj8a8TzhOU5HlrW3d3XY=;
        b=WB708Y6ZQsVTnPDe3k8SGt1N+Zi1ArG5DNJ8Ikjx+GwIsVyKkyANitm+7v9D8STbCN
         4sIx6XZ9WxtYX8XP7V/bVY64iZPta0oEQJhY5JctNUzEqp/siO8Mh7MOaSHI9jTKRX/G
         ba18CMjyRpguJUKBwLVRI8k5AHvlNVRnB1DKj5K2COahoTLJrC8pp74gWQmVJtRJ8ivp
         fJffW03dFEtg1jOc/x7+J4NtCy/6j6euZgUM7vcZ5okmBEc+hu9CLbAHOr83RhZZ7PAd
         Ya9qvceAHvZJLaq5R4L/3OTpAnWZot8Djf5EA45iNDBN22H7c4JKiI1EzSkX09tYRLsS
         Ahyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3ZEYk2Uf0v1klDyIVNllC4hj8a8TzhOU5HlrW3d3XY=;
        b=s9J7qmfzFECZj6W1BdXMk4M1o6hDxoaKmZeflaHPGRUgbjwzZ3DXHF+5Fnu6HkzJG2
         GGaIWGpoc6FMM4bz+bJS4oUX5QwOmuls/y2ZzRqfOLGvXV3KbsZEbayk/YSKxPLjqPey
         13xwsTBK3DZp12rD1TjoN8c6X5eZDBoIYen4vMz1w9C+zCSSqwoFbmNBbQ0gRxG/APUD
         oGofqPf5nXbEirEIShjeMCNAuTp11mmoMYOAjnhZuCB76ufrYUkU6pqyUi3wcUrAg/Vs
         ntYdgglPyuJ5ZkfZ/kjP8YvBzSqNMOQW6JtwWkfhnK2tEJiOu4vEuSUsybXmfS2HPmOd
         KQBw==
X-Gm-Message-State: AOAM531FAF9Re4c1ORSK+Tv6WGYibWk5lkurvHCBPYvIZ26+KAMwHA6N
        ZvlX/efA7yCK9+jcgCg94vAMAg==
X-Google-Smtp-Source: ABdhPJwqAqu5fiW6MkcfS54w+9X9od3V8YYUykJ0+y44LSiV/rX3jrG5iDECe1WB8DPMFJnBgkCsIA==
X-Received: by 2002:a1c:3b07:: with SMTP id i7mr4113356wma.118.1606406072986;
        Thu, 26 Nov 2020 07:54:32 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id d8sm8607196wmb.11.2020.11.26.07.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:32 -0800 (PST)
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
Subject: [PATCH v3 03/23] arm64: Make cpu_logical_map() take unsigned int
Date:   Thu, 26 Nov 2020 15:54:01 +0000
Message-Id: <20201126155421.14901-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
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
2.29.2.454.gaff20da3a2-goog

