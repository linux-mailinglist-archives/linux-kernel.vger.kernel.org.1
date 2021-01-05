Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77A72EB209
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbhAESGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbhAESGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:06:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD8C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:05:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q18so120858wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlENDTIUol+EdN5VnNheWvF9f4CyJQRs2PzF8BBX3kg=;
        b=ekLy75Tx+nSo0ogvhMaVAY8BSdgyBJVQYLbNWQJtFMIw1d8REekvcR0P2SSbZgpjWq
         5N5G5BKx4y0+C+jgql8evb9s+764J/xZGnwf2ubC3hrwRiu80A+I+7kMMWzDRwhSFEXG
         YDQTIvMfqZFQrrBABGuKu02ZFfnrMolhcaM/yNzWD1RZMrBOc9wta1h+G0G5aplpepEZ
         L89uKV+jC6ib+YdkUEQrU2kqZaOgu6C/yUbs0tzprKGRgsJoByHd+BaiAQRTDAKQX77P
         GUZdEP94V4DfWGv3/oMnqDV1hmhxUF6razvUh1ocEByCXH9vdz9n1w6DPgmx9K7SQBuL
         pzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlENDTIUol+EdN5VnNheWvF9f4CyJQRs2PzF8BBX3kg=;
        b=mOSQ1qzvU0yQzRqsCq6SGOyZQcIU69FhkLziIY0+Lxt7X4PgHgLL3KWHqx9D8k8OFB
         RptfCOvX9OXgIrvPREFyIdt2tksPaPOzc7yasDnGgICbNRM/bC7W6J52mA4vnOBFkV4w
         IKhr1GvJ3KB38/UQCqLZTDbTbleee7fk32Pn2y9/kS+dorvO3QnbZNMyTcpkGKKfB4qJ
         N4zwn581VlDjgICRPmk4pLn3nihXqfGdYM2AHIpE+EXAFA2bvbSCSKpD86CGAJIsB3J7
         GyccolHl7fvfpLQAEIGPPp7/zyHUewEfrPZAb5KJWd3k7Z0Te4xzNpnWfKH5r6JEsR5b
         cOgA==
X-Gm-Message-State: AOAM5306IP/s6iFC6mUknnR+Y32wdNUxjGsBZAfLgbxvsB26xE46p1m4
        4aOtp3MwU8Y7f0lOlWEbRCzhxw==
X-Google-Smtp-Source: ABdhPJzzI0r9N+4/GiWQj8jGCkL+Dm2s32peLrs/YvGf/0LqboOlGOCfcaXZq5RT/gNiTgtdV2/ABg==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr775813wrs.82.1609869949626;
        Tue, 05 Jan 2021 10:05:49 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:4957:71a5:7b5c:c94f])
        by smtp.gmail.com with ESMTPSA id t16sm374514wmi.3.2021.01.05.10.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:05:48 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 0/8] arm64: Relocate absolute hyp VAs
Date:   Tue,  5 Jan 2021 18:05:33 +0000
Message-Id: <20210105180541.65031-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nVHE hyp code is linked into the same kernel binary but executes under
different memory mappings. If the compiler of hyp code chooses absolute
addressing for accessing a symbol, the kernel linker will relocate that
address to a kernel image virtual address, causing a runtime exception.

So far the strategy has been to force PC-relative addressing by wrapping
all symbol references with the hyp_symbol_addr macro. This is error
prone and developer unfriendly.

The series adds a new build-time step for nVHE hyp object file where
positions targeted by R_AARCH64_ABS64 relocations are enumerated and
the information stored in a separate ELF section in the kernel image.
At runtime, the kernel first relocates all absolute addresses to their
actual virtual offset (eg. for KASLR), and then addresses listed in this
section are converted to hyp VAs.

The RFC of this series did not have a build-time step and instead relied
on filtering dynamic relocations at runtime. That approach does not work
if the kernel is built with !CONFIG_RELOCATABLE, hence an always-present
set of relocation positions was added.

The series is based on 5.11-rc2 + kvmarm/next and structured as follows:
  * patches 1-2 make sure that all sections referred to by hyp code are
    handled by the hyp linker script and prefixed with .hyp so they can
    be identified by the build-time tool
  * patches 3-5 contain the actual changes to identify and relocate VAs
  * patches 6-7 fix existing code that assumes kernel VAs
  * patch 8 removes the (now redundant) hyp_symbol_addr

The series is also available at:
  https://android-kvm.googlesource.com/linux topic/hyp-reloc_v2

Changes since v1:
  * fix for older linkers: declare hyp section symbols in hyp-reloc.S
  * fix for older host glibc: define R_AARCH64_ constants if missing
  * add generated files to .gitignore

-David

David Brazdil (8):
  KVM: arm64: Rename .idmap.text in hyp linker script
  KVM: arm64: Set up .hyp.rodata ELF section
  KVM: arm64: Add symbol at the beginning of each hyp section
  KVM: arm64: Generate hyp relocation data
  KVM: arm64: Apply hyp relocations at runtime
  KVM: arm64: Fix constant-pool users in hyp
  KVM: arm64: Remove patching of fn pointers in hyp
  KVM: arm64: Remove hyp_symbol_addr

 arch/arm64/include/asm/hyp_image.h       |  29 +-
 arch/arm64/include/asm/kvm_asm.h         |  26 --
 arch/arm64/include/asm/kvm_mmu.h         |  61 +---
 arch/arm64/include/asm/sections.h        |   3 +-
 arch/arm64/kernel/image-vars.h           |   1 -
 arch/arm64/kernel/smp.c                  |   4 +-
 arch/arm64/kernel/vmlinux.lds.S          |  18 +-
 arch/arm64/kvm/arm.c                     |   7 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h  |   4 +-
 arch/arm64/kvm/hyp/nvhe/.gitignore       |   2 +
 arch/arm64/kvm/hyp/nvhe/Makefile         |  28 +-
 arch/arm64/kvm/hyp/nvhe/gen-hyprel.c     | 413 +++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/host.S           |  29 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S       |   4 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c       |  11 +-
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c        |   4 +-
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S        |   9 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c     |  24 +-
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |   2 +-
 arch/arm64/kvm/va_layout.c               |  34 +-
 20 files changed, 578 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/gen-hyprel.c

--
2.29.2.729.g45daf8777d-goog
