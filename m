Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE42956CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 05:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895441AbgJVDaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 23:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443889AbgJVDaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 23:30:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6189C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:30:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk5so253509pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 20:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X99NBuFPcGRj6GED0BSF89qjk1R8FD9RmNFHvFmVAAM=;
        b=MBtjWhu/uEvJGpYxkDDTQOBmoROGsXbUNmcwmt8MoWvdIkPo+wTJfS/1VKS3AAHkXM
         zYgNieX94PHSHqQVyJfyBjLmJY/5CjAMkXopFksV2F9KSbtJCyNMG5Z34eqe8UUHOYsc
         g6iAwu1+ICX3xV/o5w9PlbZ0xp7agEAfh1fso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X99NBuFPcGRj6GED0BSF89qjk1R8FD9RmNFHvFmVAAM=;
        b=FwH00dCbBY3a1//fnO6oPzs4d9iPKiS5vqkVo09C68RbuvqjyTk7Ut8UgQp6jqeoGs
         SlNEm0wf100JuZVDQ3HrXNdnbTNaPIiWMr+YP2Y9xOcTj41AbWfcsXu0sYSpKC4C7c/l
         ZCeAkNoNhm2a2rFQSGKdK+Sivbxja07RpHlMVD3BGo0DY68vaD2OUSvlVXylFol8wAkX
         64+mxWUNmsh/Tw7fM+r8yGmUo609DdAvsvVJd4CvnPJBceL2nOlf7ywPh0WggEjFTr6T
         20wlrGpS5I4rm7Rw821htc/MEsWA0EZF6s1oGBbsgSBAMn/dSSSXmnEMpY44GR1JI1y2
         RNaA==
X-Gm-Message-State: AOAM530dmUmZzLEG49bmrTie5Hn2uNIE7T4eP5gADX7FIzxQ5+4tv9ni
        j8KYLKm1af1OyVycCg8e/HW+ww==
X-Google-Smtp-Source: ABdhPJw9LVovsG5PU4F/tFdWHu2y/AM7zuSll093yvu/HSUAhQkfufbN+JT8sQKLlAPrXHHdZq9ikg==
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr450702pjs.181.1603337400445;
        Wed, 21 Oct 2020 20:30:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id p12sm297782pgm.29.2020.10.21.20.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 20:29:59 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Steven Price <steven.price@arm.com>,
        Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2] KVM: arm64: ARM_SMCCC_ARCH_WORKAROUND_1 doesn't return SMCCC_RET_NOT_REQUIRED
Date:   Wed, 21 Oct 2020 20:29:58 -0700
Message-Id: <20201022032958.265621-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SMCCC spec[1](7.5.2 Discovery) the
ARM_SMCCC_ARCH_WORKAROUND_1 function id only returns 0, 1, and
SMCCC_RET_NOT_SUPPORTED.

 0 is "workaround required and safe to call this function"
 1 is "workaround not required but safe to call this function"
 SMCCC_RET_NOT_SUPPORTED is "might be vulnerable or might not be, who knows, I give up!"

SMCCC_RET_NOT_SUPPORTED might as well mean "workaround required, except
calling this function may not work because it isn't implemented in some
cases". Wonderful. We map this SMC call to

 0 is SPECTRE_MITIGATED
 1 is SPECTRE_UNAFFECTED
 SMCCC_RET_NOT_SUPPORTED is SPECTRE_VULNERABLE

For KVM hypercalls (hvc), we've implemented this function id to return
SMCCC_RET_NOT_SUPPORTED, 0, and SMCCC_RET_NOT_REQUIRED. One of those
isn't supposed to be there. Per the code we call
arm64_get_spectre_v2_state() to figure out what to return for this
feature discovery call.

 0 is SPECTRE_MITIGATED
 SMCCC_RET_NOT_REQUIRED is SPECTRE_UNAFFECTED
 SMCCC_RET_NOT_SUPPORTED is SPECTRE_VULNERABLE

Let's clean this up so that KVM tells the guest this mapping:

 0 is SPECTRE_MITIGATED
 1 is SPECTRE_UNAFFECTED
 SMCCC_RET_NOT_SUPPORTED is SPECTRE_VULNERABLE

(Note: Moving SMCCC_RET_NOT_AFFECTED to a header is left out of this
patch as it would need to move from proton-pack.c which isn't in stable
trees and the name isn't actually part of the SMCCC spec)

Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://developer.arm.com/documentation/den0028/latest [1]
Fixes: c118bbb52743 ("arm64: KVM: Propagate full Spectre v2 workaround state to KVM guests")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I see that before commit c118bbb52743 ("arm64: KVM: Propagate full
Spectre v2 workaround state to KVM guests") we had this mapping:

 0 is SPECTRE_MITIGATED
 SMCCC_RET_NOT_SUPPORTED is SPECTRE_VULNERABLE

so the return value '1' wasn't there then. Once the commit was merged we
introduced the notion of NOT_REQUIRED here when it shouldn't have been
introduced.

Changes from v1:
 * Way longer commit text, more background (sorry)
 * Dropped proton-pack part because it was wrong
 * Rebased onto other patch accepted upstream

 arch/arm64/kvm/hypercalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 9824025ccc5c..6a62312d7813 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -31,7 +31,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 				val = SMCCC_RET_SUCCESS;
 				break;
 			case SPECTRE_UNAFFECTED:
-				val = SMCCC_RET_NOT_REQUIRED;
+				val = 1;
 				break;
 			}
 			break;

base-commit: 66dd3474702aa98d5844367e1577cdad78ef7c65
-- 
Sent by a computer, using git, on the internet

