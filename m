Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755372AB6E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgKILcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgKILcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:32:51 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C35C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:32:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so4914403wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PeIzATuK4HaCEpAoHr0Z1pMl+lKl5fFRYxsg6dRwaTg=;
        b=SyD0mWa9i62nLyko7w4nkaHf7ozC+fygqfk86ETWkYyEDKiqrC9sxoXRkEb78sAa+g
         Q5YHHsufBgveiqRwJnVc4h75bxL7UirJVCgfACmmk0/wxzMgmhus7q9dfTf0+EGBYFih
         ++c2OLt6eafuSBAZr5rEkl04qlFEuqoGjl0BaealKzOslfViDNTgJRy8l072hl5Z0vO+
         ZGhIiRZTpow3BtUcNFeME9o4ZmiMYklE4DW8x0BxuytqkKsy03j1NMCFN2b/JlvlVLNk
         5dM23D18JCx33KIKpyB1zW/c1d+CJflcKJmxYjdoLt3i7qiM+VACIHVoFWUqGPEIf2RW
         eIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PeIzATuK4HaCEpAoHr0Z1pMl+lKl5fFRYxsg6dRwaTg=;
        b=d7r1v9BfKaMRUHlTX11bCnOJGCrcu29PhxYQZFEnIFnoCp3p2MU5WuUw+UUORQGeyo
         e1GmDFXIykkPh1OT8CKM64Is5VXdtVsF5LemSMkienrEudL8FGQ6b5gKmhIk0NY673Wb
         BovmeOi7v6REwikV/60gxfhVp+GQtCbJ8wkJVPRcJJmmVnt7OLoXSdmyeL+M/StetH0E
         qaNjrel6jWX1fyWPrcix7fJsCr8q4WQyKwJsc8pPpyICtKTdnDDg+pkKNlXCCdKUABLy
         EJbknohsAkxGzkZCmArAfrMCby+H9KInbfKY29rgVr/2IP5W2RaLEexJcFRBW7tUvqPN
         y/tg==
X-Gm-Message-State: AOAM533m0tj+Wgb0utL/1XkHqzidMobgI5WZAKMDvut44eFij1tSp7Rw
        kRibJUG0JCyt05KpdSdQBEnZwg==
X-Google-Smtp-Source: ABdhPJyobQPwdOjwCkk6kEF42K4XN94BQIwbCrTUXyd35ocJY0lhgKymeEjGBQwZcIFVd9d/y9rwQg==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr11343267wrv.355.1604921567943;
        Mon, 09 Nov 2020 03:32:47 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id o10sm12514211wma.47.2020.11.09.03.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:32:47 -0800 (PST)
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
Subject: [PATCH v1 04/24] kvm: arm64: Initialize MAIR_EL2 using a constant
Date:   Mon,  9 Nov 2020 11:32:13 +0000
Message-Id: <20201109113233.9012-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAIR_EL2 is currently initialized to the value of MAIR_EL1, which itself
is set to a constant MAIR_EL1_SET.

Initialize MAIR_EL2 to the MAIR_EL1_SET constant directly in preparation
of allowing KVM to start CPU cores itself and not initializing itself
before ERETing to EL1. In that case, MAIR_EL2 will be initialized before
MAIR_EL1.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index b11a9d7db677..96e70f976ff5 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -111,7 +111,7 @@ alternative_else_nop_endif
 
 	msr	tcr_el2, x0
 
-	mrs	x0, mair_el1
+	mov_q	x0, MAIR_EL1_SET
 	msr	mair_el2, x0
 	isb
 
-- 
2.29.2.222.g5d2a92d10f8-goog

