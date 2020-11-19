Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D292B97D4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgKSQZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgKSQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:25:49 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:49 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id y17so8710489ejh.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GruhQdqr+wzWu7YIuTjo4e/TRyXrwSpjT/ODeg/Yqc=;
        b=HNhCr9vU0ISFuiHpPTfBE/dnSa1k1AQmT5a5owhc4HAvKKm3lmsYZp8SXMp+lTOqLJ
         oA3puTIhotxShLQBAg0rlM4WDEQkkC69CqcXEaiU9EAiBKKxtasmjjIbIeazLFtic2MI
         fLz07UvbuvQYFFiUzTKn15TR5mxfbYbxOQpkI5/9WHICtRExdl10ClVPeje4PwMD++Sp
         5gJtKtlsgxdEDaopQgVhEbsCfANljY7EtRJZz+x93MNooDxOX9ReqlU+WdfT/OoDCbh6
         DZ4+nKQgm0TMuhm7MKG6SISpKF0WEI9VVfoZtlPQUmeHaXi/qPVmsTWyh3Hr2yUJQNso
         SF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GruhQdqr+wzWu7YIuTjo4e/TRyXrwSpjT/ODeg/Yqc=;
        b=FPF0TsERvS0C5MOOlkWQLaUu/BRaj0ybVM55nmGcDNaBp2S1yh0LSVVe8EIiWEOCcF
         pGAmdtGEkULAZVPRXsZWVYhpGn0CNfFZ4yDGk20mt9FZAB9ZkHIhQZTlNEXmcbi7TIWd
         2H8h6mXQftZ0CEMOFDnxmqHTzA+CAnY9l36hsgqIQVEaXw8lQIHASjnIWbTbV+6kYsyu
         0VeSq3Fydjft1UWVOszCB9rKEMlx7z6t/Qa7R0uzx75ba/JEMYeMl71jwtdNKtM09UNj
         Ic4r/tu9I0Nxg2qJQXs7vN5TuTyX4URkUgG6/eheC+X1pMOmPqi4zgymsMZufEFBx/hx
         gHTg==
X-Gm-Message-State: AOAM530LD4mG+nPhQ0iZdQGaqCIVp9uM98rjoA6IC71QhVm9+5tkyQOi
        EDRNVUgAbLxmKED92ETLpiFHRQ==
X-Google-Smtp-Source: ABdhPJx5kfoZrvZqP/Uo4FFewwoV/LxEuk0ZaZ0aeXlkfVXWjL868auf9G7gfWTXVZ0FB7pclJWrVQ==
X-Received: by 2002:a17:906:3ec8:: with SMTP id d8mr29647604ejj.32.1605803147524;
        Thu, 19 Nov 2020 08:25:47 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9843:cd3f:f36b:d55c])
        by smtp.gmail.com with ESMTPSA id 2sm66968ejw.65.2020.11.19.08.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:25:46 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 0/6] kvm: arm64: Fix up hyp relocations
Date:   Thu, 19 Nov 2020 16:25:37 +0000
Message-Id: <20201119162543.78001-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

KVM nVHE hyp code runs under different VA mapping than the kernel, which
meant that .hyp.text code had to use PC-relative addressing because
relocations would produce a kernel VA. Programmers had to be extremely
careful with C semantics to not break this fragile setup. See
hyp_symbol_addr comments for details.

Now that we're moving to all nVHE hyp code/data being in separate ELF
sections from the rest of the kernel, it is becoming possible to revisit
relocations during early boot, filter those used by nVHE hyp and
converting those (already relocated) kern VAs to hyp VAs.

Sending this as an RFC, mainly to get feedback but also because it's
only lightly tested. It still feels hacky but much more robust than the
existing approach. The one place where I see somebody breaking this is
the list of ELF sections owned by ELF. That list is currently evolving
but should stabilize over time.

The patches are based on kvmarm/queue (with Marc's "Host EL2 entry
improvements") and my "Opt-in always-on nVHE hypervisor" v2 series.

-David

David Brazdil (6):
  kvm: arm64: Set up .hyp.rodata ELF section
  kvm: arm64: Fix up RELA relocations in hyp code/data
  kvm: arm64: Fix up RELR relocation in hyp code/data
  kvm: arm64: Remove patching of fn pointers in hyp
  kvm: arm64: Fix constant-pool users in hyp
  kvm: arm64: Remove hyp_symbol_addr

 arch/arm64/include/asm/kvm_asm.h         |  20 ----
 arch/arm64/include/asm/kvm_mmu.h         |  48 ++++-----
 arch/arm64/include/asm/sections.h        |   2 +-
 arch/arm64/kernel/image-vars.h           |   1 -
 arch/arm64/kernel/smp.c                  |   4 +-
 arch/arm64/kernel/vmlinux.lds.S          |   7 +-
 arch/arm64/kvm/arm.c                     |   7 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h  |   4 +-
 arch/arm64/kvm/hyp/nvhe/host.S           |  29 +++---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c       |  11 +-
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c        |   4 +-
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S        |   1 +
 arch/arm64/kvm/hyp/nvhe/psci-relay.c     |   4 +-
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |   2 +-
 arch/arm64/kvm/va_layout.c               | 123 +++++++++++++++++++++--
 15 files changed, 175 insertions(+), 92 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

