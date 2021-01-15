Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845882F8202
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbhAORT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbhAORTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:19:25 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49357C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:18:45 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id z12so3223775wmf.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=PiTweHVaIWwM1Fes5h+y6wnV6pBG4D7sAqs6XrwD/WQ=;
        b=uryOYOvmlRLFF34f9bw5DcPeMa7fUPhnzb0V9TDTqAJ7Gyqcdsy8tLDdCIiMM7KpXP
         ZWMG0NpkZUrLs02mmuRkztZ+9mTUlTCH048QVnQCuqJHrgEWO2T4In7N07YBt7ehL4f0
         L0spBnK+XZW1sScs/zCKmedPD29bAV5XPo3UEW9dy5WCwBKtAROgks8el5MQANiFckDj
         4N3R6Qqj5gHLtz1uWLgdiNyW9rahx+K8UXLj37k80P6FrcH2H9BO15TiC2FKLk4Jb5O4
         nQCcXDLmjEizomkyHTzrq6uhKUn2DsAyIeMeN2sN7jtPOvi6pT0jhnKvlpBCJBVpE8DI
         OJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=PiTweHVaIWwM1Fes5h+y6wnV6pBG4D7sAqs6XrwD/WQ=;
        b=Okpp/sdrPrmFQ11nZMWLCS8YOG3QUd9mgLA/ly9y/eS90UsAx06gk23FtB+4MjM+FL
         v6lWtIAYWU6Pw/WDveV7pFW/xsFcWxsKLvMfqgwwSvWAMgv19DVnj9PhlDqrNKGRU67d
         M5AFGQdO2QnjGPoQlUAEX7Pa3z1ReIvqPOGXq5EzwQgAsp4bcMlbFqdCR7evV1Vyd0M/
         DQ74xnwAavsUlca4DANRkDskRgx8inTONdMBMnrj5bNdSBFt3Vw7+r7K5NCALnn5BkeE
         W/JFBcz/NJ+bFHzDZSw0V+ohGuHdeHS7zS8US2lNryp/UVSgSjWzxldY4kRyPuD+PrdQ
         jfqQ==
X-Gm-Message-State: AOAM531hhU0L4XM+/jMn2WUXpcyfUAwIAzb6hnLG9X9P077r8jpOOZI4
        AL4FINPJXrQc+7iy0oSBW2oUYSVPw/tV
X-Google-Smtp-Source: ABdhPJx+biyMD+eyfOowD9aimiJnsnswVeW3C5SizJvHyfSyI7N9jNVg4Kuzg91Zu9ZnJNFCeUIc9HWxEgvO
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a7b:c1c6:: with SMTP id
 a6mr9625527wmj.23.1610731123890; Fri, 15 Jan 2021 09:18:43 -0800 (PST)
Date:   Fri, 15 Jan 2021 17:18:21 +0000
Message-Id: <20210115171830.3602110-1-lenaptr@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3 0/9] UBSan Enablement for hyp/nVHE code
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

Updates in v3:
  * rebased onto v5.11-rc3
  * added base commit info

Updates in v2:
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


base-commit: 5ee88057889bbca5f5bb96031b62b3756b33e164
-- 
2.30.0.296.g2bfb1c46d8-goog

