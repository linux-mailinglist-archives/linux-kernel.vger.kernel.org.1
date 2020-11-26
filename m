Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3F52C58C7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403832AbgKZPzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403821AbgKZPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:55:07 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8445C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:06 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so2636471wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTPqxuNIHyHcxIGVDRFuzMb//a26J9RNoM2ThcyKbSM=;
        b=mX8bYR+xBsOyOIWEN8DX7gK/3reSGxDblgkVy4BFuCXdMl/4FvAYp/nmuGo1JoWP9P
         t6aYDDfb/OykyYNtU+YjrQpGHnafiTiCP67R+SMGTyaiF8vjgYt0Fvys9qkoErbLGFR9
         we1WLjGlgUNDIDPEBeUD4Alzz5Om/fnxds/Oxp5CzjqLXbiXrL9tA5FQ1fQEZMm617TK
         IdSpNFJ2H05e+uXFDCHwheCyX3oSyvQ7+b/+18Q/kDteenUlTRRV+WrhBV712PuxD+Kx
         wmzbfiP7gvyDFfsWCOAGPdMnOJDwhL/l00+ToHh9zpX87qwlANYNEterelAS3s8rUwBU
         5CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTPqxuNIHyHcxIGVDRFuzMb//a26J9RNoM2ThcyKbSM=;
        b=aEqY6zxr7NVUkYE5cC0O78WO+IazZdbE+CEO5EOaotnbbBsMqLpFOAGFZCsJMIkbBQ
         ZOEKxnrsifdQGxjNxqDUpYFEQr+e3oGgZTQZ+ZqoS8iXpmmt93LXbOzGJIvNy4eBjMlh
         /p/iM1zYVklRuqCTA6sN7MqJ2LL5PBkgnfKXInTTCv8ZMUovYtmoTp3O0Zp2MXzd3fyG
         AyAjyzuP2Am4vaoM4oorhXIBtQ9tr6iJZCSS3XLHQ+Q9jlAtoC151clbD1WhbmvcLZBY
         2fJA5fRWPdPMnGznlcKD0ew5Eb/3L5jKlIXorWR34w1wBoxjjmycBTYdjZsjp3Q5ktxC
         imww==
X-Gm-Message-State: AOAM531uJf562ws+ppl310mUgYkbcHYKYkPS+oYZJiXMpFkCU4ureoUx
        VCmz1jmQD4TYPlJ6o2qGw5ghyg==
X-Google-Smtp-Source: ABdhPJwX4rEG3aPSmYGdOs6RN45Cetge/Lz5Y7cdyVn5fxjNFMXKsImO/VR5cgpiiWFbabfK0CSr1g==
X-Received: by 2002:adf:f888:: with SMTP id u8mr4544222wrp.381.1606406105448;
        Thu, 26 Nov 2020 07:55:05 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id s25sm8628255wmh.16.2020.11.26.07.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:55:04 -0800 (PST)
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
Subject: [PATCH v3 18/23] kvm: arm64: Add function to enter host from KVM nVHE hyp code
Date:   Thu, 26 Nov 2020 15:54:16 +0000
Message-Id: <20201126155421.14901-19-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All nVHE hyp code is currently executed as handlers of host's HVCs. This
will change as nVHE starts intercepting host's PSCI CPU_ON SMCs. The
newly booted CPU will need to initialize EL2 state and then enter the
host. Add __host_enter function that branches into the existing
host state-restoring code after the trap handler would have returned.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 2b56f0bdf874..a820dfdc9c25 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -39,6 +39,7 @@ SYM_FUNC_START(__host_exit)
 	bl	handle_trap
 
 	/* Restore host regs x0-x17 */
+__host_enter_restore_full:
 	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
 	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
 	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
@@ -61,6 +62,14 @@ __host_enter_without_restoring:
 	sb
 SYM_FUNC_END(__host_exit)
 
+/*
+ * void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
+ */
+SYM_FUNC_START(__host_enter)
+	mov	x29, x0
+	b	__host_enter_restore_full
+SYM_FUNC_END(__host_enter)
+
 /*
  * void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
  */
-- 
2.29.2.454.gaff20da3a2-goog

