Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72162F6780
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbhANRYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbhANRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:24:43 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C37C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:02 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id u3so2857995wri.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=b+Ye3TYRisrKqQrXNJpmpiFshzIGIpWbzHYw15/uGQ0=;
        b=Gf94X+SdoJcvLp9TAYUoAktCYhMbtuWD+Noeo7wo8zUCS57TWxk/68vv4/Twa7dtNP
         cP86ca8Q3ypiY8eiigVLyS6SV2aoE0Jg+S1WA5EijwTqjiiVirPmbuBBeAkBZvKr424l
         +4nXcDQV56K+L7oVwhL5BNXOkc6r3AO6wCl6bRvloxv03YQX57uVmKPZ9j+UZeR1xS4E
         WrOCSxRCTquWZgZ03DOyYKI3v5fCFHOnWod2Rog0lRRzKlrFSk/sEcSDWZ5IzuV6KMar
         LkPWSf5uGWwRCzDsEtAZyxUgqZDAYcoXfpzaVxntLiEbSbLTeE/WvaPnGTTzlkNU+9Je
         Pcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=b+Ye3TYRisrKqQrXNJpmpiFshzIGIpWbzHYw15/uGQ0=;
        b=hH0Z6hIdi0/yEWRsyIHmb2a+cWcbZ+5wjvhCMJ5Y/L2B1tcICWpX8bXDELV6UaN0As
         HP+zbv5jhPSLrZDsjQ+c8VLxKHp9s9NYUfoTm43hbdRwuFJ7wSCSzGqEijuQCP6GeEGn
         H2PoRrr2cou9YMTOmZe8E9wgPCudU/gAM5zsm+n2pCYU7NSAyuutyEHzlzPdMecMfQCo
         K0X26vjABugKQ+M0wnBWiV+Nod+55l2MSp68pSWZxU9BJxNfsa+OcizK3xFwgESqD8ia
         rnqbk1vCIK2mQ/rpu+jBNZ9hWNWTMQNMyTuEic20BFjE9a9FufrgKxzymtbqAY4+2AbM
         lsfg==
X-Gm-Message-State: AOAM533xJi+ZOXEViUjr+MzuWgnuii4rGVPNC0N1Pl4bK5rdTU4nxJKE
        lpGs3A4ZPgeKq35EYTdSkQx9r1hL2p9p
X-Google-Smtp-Source: ABdhPJwTYAAkzYk59FnB1hjoYlusOxFpD4H7R29LpkykSS5VUOh4jh+cTktTHTd6BMVLyxsk7TTG5Gkp+fhD
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:adf:fd41:: with SMTP id
 h1mr9149005wrs.284.1610645041229; Thu, 14 Jan 2021 09:24:01 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:23:29 +0000
Message-Id: <20210114172338.2798389-1-lenaptr@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 0/9] UBSan Enablement for hyp/nVHE code
From:   Elena Petrova <lenaptr@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Elena Petrova <lenaptr@google.com>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        George Popescu <george.apopescu97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respin of George's patch series enabling UBSAN for hyp/nVHE code.

Modification in v2:
  * CONFIG_KVM_ARM_DEBUG_BUFFER removed; __kvm_check_ubsan_buffer is
    called directly instead of via __kvm_arm_check_debug_buffer.
  * Bugfixing commits removed as these are already upstream.
  * Some code brought up to date, i.e. moved from entry.S to host.S.
  * Merged "Add support for creating and checking a buffer" and
    "Add a buffer that can pass UBSan data from hyp/nVHE" into
    one commit as these changes don't work without each other.

George Popescu (9):
  KVM: arm64: Enable UBSan instrumentation in nVHE hyp code
  KVM: arm64: Add a buffer that can pass UBSan data from hyp/nVHE to
    kernel
  KVM: arm64: Enable UBSAN_BOUNDS for the both the kernel and hyp/nVHE
  KVM: arm64: Enable UBsan check for unreachable code inside hyp/nVHE
    code
  KVM: arm64: Enable shift out of bounds undefined behaviour check for
    hyp/nVHE
  KVM: arm64: __ubsan_handle_load_invalid_value EL2 implementation.
  KVM: arm64: Detect type mismatch undefined behaviour from hyp/nVHE
    code
  KVM: arm64: Detect arithmetic overflow is inside hyp/nVHE.
  KVM: arm64: Add UBSan tests for PKVM.

 arch/arm64/include/asm/assembler.h          |  10 ++
 arch/arm64/include/asm/kvm_debug_buffer.h   |  34 ++++
 arch/arm64/include/asm/kvm_host.h           |   8 +-
 arch/arm64/include/asm/kvm_ubsan.h          |  50 ++++++
 arch/arm64/kvm/Makefile                     |   2 +
 arch/arm64/kvm/arm.c                        |   9 ++
 arch/arm64/kvm/hyp/include/hyp/test_ubsan.h | 112 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile            |   3 +-
 arch/arm64/kvm/hyp/nvhe/host.S              |   4 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c          |   3 +
 arch/arm64/kvm/hyp/nvhe/ubsan.c             | 164 ++++++++++++++++++++
 arch/arm64/kvm/kvm_ubsan_buffer.c           |  81 ++++++++++
 12 files changed, 478 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_debug_buffer.h
 create mode 100644 arch/arm64/include/asm/kvm_ubsan.h
 create mode 100644 arch/arm64/kvm/hyp/include/hyp/test_ubsan.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/ubsan.c
 create mode 100644 arch/arm64/kvm/kvm_ubsan_buffer.c

-- 
2.30.0.284.gd98b1dd5eaa7-goog

