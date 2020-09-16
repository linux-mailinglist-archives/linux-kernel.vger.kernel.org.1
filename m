Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9626C9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgIPRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9518EC061353
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so7751494wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ki62FqIiIgJ8yaBZSKIYHGl1mRsUtoqotQFZS0p5Has=;
        b=kuz0lgsVij7wLKItfIOGcuCmtvwNys1htJnrFzCNRHaLjnVgElf4udXEubZns0dGAz
         NqFkPkuvm9TbHN4J5VCtVm7UDYsIf+4wGcbWnp5r2GIAd9r+/SBADS9HcvFM14SFeAoq
         P2YaGqpnPwU/jtKoPyr2enlSJh9RNiWe4T5dguCXaWfc0N0jpNjqUEXj8iL+3zzKLce5
         gQOmsMW24e8arpUJ3wc5JQTLKSJiijZpRkX/RtKzwFR8HA3+DbxQCE5+3Z9HI+eiTgxx
         FbB0gtfKqTpG/ce9J6iO28HJ/sQI4vk6jtZNWmtWmSFxB01rO8VQFJ/ro1Fry1BHESOm
         8VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ki62FqIiIgJ8yaBZSKIYHGl1mRsUtoqotQFZS0p5Has=;
        b=EwHtJ8Rb4Mi9sd288hky2PoBdJA8xlVbMZsIBbspjtS9RFsmuLzGT1d0IsKB30C7ns
         GPRwkR1CylJvAAI5g2PHUqEsGyBQpVGxQPHN8hEI+WGcH7WEr/pc4aIRcdriHEwqOrQM
         T/XJvzxcPtImFYzNaYozp1WnZxO0/nLBZPufTNIj7L+stoEKPc3wFwY8ZiNFkIk7azp9
         x8alFR1bbc68G0oyx/I1tGnPscmAAW3WI2eee14e6MZwq4U4j8qBaTuJ2dK9wo4oXywK
         AUMBz76Mq8anLM6BTLsKHKRvELs6PJmw8tHk9nLGh/aE1MqZxcmSdREuwOsfHRaAKPnR
         Uv+w==
X-Gm-Message-State: AOAM532DCm4vyk7rE8xGZahvjHvTQAoHCKdd90LWadU5V6+oG5htL/O0
        mvVoulvqYv5zoSLD2qE/XXmKjw==
X-Google-Smtp-Source: ABdhPJzQzJxXIxJM0jRA7b3rUmMwdVhHQPWJyctJSUBa7YGa64yNP8fcblWJOLLn4QkX3rVzCKMVDg==
X-Received: by 2002:a05:6000:1184:: with SMTP id g4mr27622757wrx.20.1600277691141;
        Wed, 16 Sep 2020 10:34:51 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id o16sm32123548wrp.52.2020.09.16.10.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:34:50 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 03/11] kvm: arm64: Only define __kvm_ex_table for CONFIG_KVM
Date:   Wed, 16 Sep 2020 18:34:31 +0100
Message-Id: <20200916173439.32265-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup that only creates __kvm_ex_table ELF section and
related symbols if CONFIG_KVM is enabled.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7cba7623fcec..0d543570e811 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -21,11 +21,15 @@ ENTRY(_text)
 jiffies = jiffies_64;
 
 
+#ifdef CONFIG_KVM
 #define HYPERVISOR_EXTABLE					\
 	. = ALIGN(SZ_8);					\
 	__start___kvm_ex_table = .;				\
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
+#else /* CONFIG_KVM */
+#define HYPERVISOR_EXTABLE
+#endif
 
 #define HYPERVISOR_TEXT					\
 	/*						\
-- 
2.28.0.618.gf4bc123cb7-goog

