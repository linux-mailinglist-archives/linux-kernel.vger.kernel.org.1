Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5D229A570
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507535AbgJ0HYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:24:21 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:50633 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbgJ0HYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:24:21 -0400
Received: by mail-qv1-f73.google.com with SMTP id ce1so295572qvb.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 00:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zIO7niUYC/KRwu/Yy0fHD/fKcjuWTyDimZWs21v1xms=;
        b=rii6pL/ZW3X7SRia9dL+5oIwTUDwLafe/m8Bl0zQyh8BcIJgeANx3n1+NkZCyMMyGP
         TfaOQ0cmlsUafcDJ1ajTho+HbAN0OfOQER2LiBojEl50BPgKZPXBx6RFzYcEC+9V5LIi
         TngMJT4lcf+r5jchE6S+/Gn3XV+flW6kv+0YfwfAtexZT8i0XhdhGFzACcQk1rzx4+SC
         YHLI2xH1lwhKkzQoBDkPAglAWdgMTcStv56fanULsvUH4i/M4DZB9N2tk1/Sem1jzDm4
         WFNpwLgdNbJSK+q/kSOTOpDbECAcfGee1V7DUqRvMiTd07hTI3vaZHbDo+dH4WLu3fWH
         Zj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zIO7niUYC/KRwu/Yy0fHD/fKcjuWTyDimZWs21v1xms=;
        b=I8Vr7QtttKdDve1EPTFLiCKov9Gw+hE12IlVLlkL+or7ywPzQ3V1bYXATYYey1bYvR
         iH9MoUnvewuVza4GWq4G93MZ+gafrfF0qNBX1kHcRYVZ22WTJj2Z2WZINs8+EvQVi48/
         rgVT9BpUyjk0E/E7hDAywQDsAvnSgplXFD+vw9nUouFCqUbZFruchKOmV3skNUjbfBMU
         9V9miA7ZR+qJE+HCrUSVxiR33d1SU48rCgCjNkjlfMKxsfYe6CBjJ72Rwb99YTwPNKiR
         X7h5sA1CxbnyS0iQBY4AKc+IrB4PerSaEQTRwI9a38R/oYpQ8qPwcIVRI3ZWrdXBNv+v
         sIlw==
X-Gm-Message-State: AOAM530a/pxANqoTi8cnim5V1xesJsI8IIeNq29DDg1RFwOCqXEnRPLa
        ETUstW2AcvwHYjw+WmtHCP1vgNV0r1/bdCnoKT82Od9JqOXW6HUIeMLVBS+TD8slnFxnA9lABi0
        Eonrv+f2xKcmfG3zjfHlPll9jxEw6DP87KlOshYJ/bp4QkVwoMJtdS+UPRI77DLgFi598Qv10Ez
        Tcwlyy
X-Google-Smtp-Source: ABdhPJwwIkaWrdZNJQaEvW9lS058OgOLNutaoICzsq0KQZxy+oeWhUGboP1xRE4vMis04pryJ/+bx6gaADy/UylI
Sender: "victording via sendgmr" <victording@victording.syd.corp.google.com>
X-Received: from victording.syd.corp.google.com ([2401:fa00:9:14:f693:9fff:fef4:fa73])
 (user=victording job=sendgmr) by 2002:ad4:59cf:: with SMTP id
 el15mr1184065qvb.17.1603783459621; Tue, 27 Oct 2020 00:24:19 -0700 (PDT)
Date:   Tue, 27 Oct 2020 07:23:54 +0000
In-Reply-To: <20201027072358.13725-1-victording@google.com>
Message-Id: <20201027072358.13725-2-victording@google.com>
Mime-Version: 1.0
References: <20201027072358.13725-1-victording@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v3 1/4] x86/msr-index: sort AMD RAPL MSRs by address
From:   Victor Ding <victording@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Victor Ding <victording@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSRs in the rest of this file are sorted by their addresses; fixing the
two outliers.

No functional changes.

Signed-off-by: Victor Ding <victording@google.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>


---

(no changes since v2)

Changes in v2:
By Kim Phillips <kim.phillips@amd.com>:
- Added Kim's Acked-by.
- Added Daniel Lezcano to Cc.
- (No code changes).

 arch/x86/include/asm/msr-index.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 972a34d93505..21917e134ad4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -326,8 +326,8 @@
 #define MSR_PP1_ENERGY_STATUS		0x00000641
 #define MSR_PP1_POLICY			0x00000642
 
-#define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
 #define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
+#define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
 
 /* Config TDP MSRs */
 #define MSR_CONFIG_TDP_NOMINAL		0x00000648
-- 
2.29.0.rc2.309.g374f81d7ae-goog

