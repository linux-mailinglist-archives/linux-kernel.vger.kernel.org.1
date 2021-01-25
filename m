Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E98303117
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbhAYTjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731708AbhAYTVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:01 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7F6C06178C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:37 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id es14so2919621qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I2bLiPX3VTIFYdlWvHrlv9bi90SZn0tAgsUExdtL3vw=;
        b=e7EeqPlQvWqFBbDxIS+wdmiqyKoOqI9OZZCgYolvZoI6Xiol0eFKvHPC1pWgm6Fiay
         k8gT8zBoIce+Xnc0+wfreyByeComQF0lOYUuI2FV338Zysdkz2m76fy7N3c+/gmDJcw9
         Su+R42Mjqxnq0Z04YmcTRsTv2Dkqh0+vHQYSAzntfUfSzhuEiRsIZKtRGZNohQuoiMP1
         37lX2zUf84XJ8SC5th4NIOoejS1ep2O1KTF5HUrMordiA0b/YGqqyz/FlLrRWNDMSTQ+
         KGVrdwd2jN+Ly8WZH1xArA9m5WyRxE/jCVrqctcOR1sw8aXhiCqDGpRsGzUEBQZL0sci
         0F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2bLiPX3VTIFYdlWvHrlv9bi90SZn0tAgsUExdtL3vw=;
        b=B194hfK4CRglHVH9Oic8CGIwCKVRszyPUxNL2mo25obsM2IYb3MNhLAO4uVMqB/nSD
         SXq1TLJIucBVq1ac930DitTs8BIe2PObJQneB29HraFRidSU70A8Jd1XP0Vn5h0O4GH8
         pyOxaeuPOkwwhKgIBbfhdTeYpVwBGWEep8vVeGXVv1/xV3j5J/ZUpJoJH3JjsahBwFSN
         e5DVr6WmteZielFoxai3G5lQNymcT8IhawXv3KuJVn5i2T1LT8N/Z19W0TZQag5cBGs0
         hKsSUSg7A3q63vnxOp857yaFHMI2TEuMKDQ3LX0fh4iPhtVb7xi4J0Q16A+LhagGKTKY
         0U1w==
X-Gm-Message-State: AOAM531dHY6vpuH3tgzNnhQ/jxi8OBOasCQeTHplGsPuGSDxY9SaBDTa
        y7QS/ukkmb+me0R0MAoyvrwWGA==
X-Google-Smtp-Source: ABdhPJzA63TTz10VNLj7mmheU/keqIHP7LOeLAzUTHMXQrqU9ZPOb8WN2VV8RoUDjNxuh0fZX6dq9g==
X-Received: by 2002:a0c:d403:: with SMTP id t3mr2275554qvh.4.1611602376226;
        Mon, 25 Jan 2021 11:19:36 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:35 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 07/18] arm64: mm: Always update TCR_EL1 from __cpu_set_tcr_t0sz()
Date:   Mon, 25 Jan 2021 14:19:12 -0500
Message-Id: <20210125191923.1060122-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

Because only the idmap sets a non-standard T0SZ, __cpu_set_tcr_t0sz()
can check for platforms that need to do this using
__cpu_uses_extended_idmap() before doing its work.

The idmap is only built with enough levels, (and T0SZ bits) to map
its single page.

To allow hibernate, and then kexec to idmap their single page copy
routines, __cpu_set_tcr_t0sz() needs to consider additional users,
who may need a different number of levels/T0SZ-bits to the idmap.
(i.e. VA_BITS may be enough for the idmap, but not hibernate/kexec)

Always read TCR_EL1, and check whether any work needs doing for
this request. __cpu_uses_extended_idmap() remains as it is used
by KVM, whose idmap is also part of the kernel image.

This mostly affects the cpuidle path, where we now get an extra
system register read .

CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/mmu_context.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 0b3079fd28eb..70ce8c1d2b07 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -81,16 +81,15 @@ static inline bool __cpu_uses_extended_idmap_level(void)
 }
 
 /*
- * Set TCR.T0SZ to its default value (based on VA_BITS)
+ * Ensure TCR.T0SZ is set to the provided value.
  */
 static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 {
-	unsigned long tcr;
+	unsigned long tcr = read_sysreg(tcr_el1);
 
-	if (!__cpu_uses_extended_idmap())
+	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
 		return;
 
-	tcr = read_sysreg(tcr_el1);
 	tcr &= ~TCR_T0SZ_MASK;
 	tcr |= t0sz << TCR_T0SZ_OFFSET;
 	write_sysreg(tcr, tcr_el1);
-- 
2.25.1

