Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142DF2FC315
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbhASWMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbhASWIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:08:52 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E24FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:08:12 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v19so13815010pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELInWqxXJUdZABjVVRG764v9dascUS8CB4mjpW3H2yQ=;
        b=ab3oLJzIFTZQrdfLW+gTqruevNzRZlrqWK3e1HaKR0QYO8WX62/zQn5jjdoVjYBVzH
         THgMZi02TV4AWIP17lMi7ukSiiBC1MkCOBDLd5cVnIfUsGL5nzaSgTOOFAcp6+NiYju+
         lApCH07+GR9TCBZVjJgGcpwEyoKhC4pxpAJaNsG+PluEuRsibalfE6pX+sWyuMo29gIK
         eszAB4BYOG8K64pgoa0o8aBM7SV2Yf3PqIIKVFLk7kZ45k0wdQHClS2awoVOyBpK33hb
         sBaVTO2TMW5xXX1aSjHs7he5HAxVXoBp9dSEdIcXZz3LcupGcOGB0bgskADMw7BEzv0n
         1ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELInWqxXJUdZABjVVRG764v9dascUS8CB4mjpW3H2yQ=;
        b=MCuQY/1EHokw/wLkFa5t0MC4xKHvaRmQQQwh0TRaaus9cuDQpbMuadtV4sL2MLtEVs
         WGaSNgSeZpLs1LymWWcD0My24E73Q4uv4f8/iPa1A9E91gYBWQNTLbvA7JO3us+T9nFr
         emCSbdZmF+ya4dx8fm1xtwqnfSuipUYcNP1aYC/rF900NUFsC37cpBv28tbidCrnmWPO
         G+y0/NfatDLx8nFh5NsQo2VkzCI+zCgN3bbKsdQiea0B2BR991104voyfdVOmeeDUJfy
         hxveU5+qKwbvY2tQqU67tWAmaHspnQmRG8chFfwDcp13F8x7awHB+zuyD/WhaOKcXyAz
         HYPw==
X-Gm-Message-State: AOAM531YY6dcMU9ub73s1w8XpXukWGbAbLshv+6RhSOH1Fo6TvbCw7Hn
        3JT5KrT9Zfqp0vgnJe/cczM=
X-Google-Smtp-Source: ABdhPJwMxHwLKsiFlrwFkAwTdrgj+xxDw6GTXrxIh1XyAdCu+t7BUYe9op17/6WO+e6CKmI23S/NZQ==
X-Received: by 2002:a63:8249:: with SMTP id w70mr6347924pgd.138.1611094092092;
        Tue, 19 Jan 2021 14:08:12 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id 72sm95196pfw.170.2021.01.19.14.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 14:08:11 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 0/3] arm64/ptrace: allow to get all registers on syscall traps
Date:   Tue, 19 Jan 2021 14:06:34 -0800
Message-Id: <20210119220637.494476-1-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, ip/r12 for AArch32 and x7 for AArch64 is used to indicate
whether or not the stop has been signalled from syscall entry or syscall
exit. This means that:

- Any writes by the tracer to this register during the stop are
  ignored/discarded.

- The actual value of the register is not available during the stop,
  so the tracer cannot save it and restore it later.

This series introduces NT_ARM_PRSTATUS to get all registers and makes it
possible to change ip/r12 and x7 registers when tracee is stopped in
syscall traps.

For applications like the user-mode Linux or gVisor, it is critical to
have access to the full set of registers in any moment. For example,
they need to change values of all registers to emulate rt_sigreturn and
they need to have the full set of registers to build a signal frame.

Andrei Vagin (3):
  arm64/ptrace: don't clobber task registers on syscall entry/exit traps
  arm64/ptrace: introduce NT_ARM_PRSTATUS to get a full set of registers
  selftest/arm64/ptrace: add a test for NT_ARM_PRSTATUS

 arch/arm64/include/asm/ptrace.h               |   5 +
 arch/arm64/kernel/ptrace.c                    | 130 +++++++++++-----
 include/uapi/linux/elf.h                      |   1 +
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/ptrace/Makefile |   6 +
 .../arm64/ptrace/ptrace_syscall_regs_test.c   | 142 ++++++++++++++++++
 6 files changed, 246 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/ptrace/Makefile
 create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c

-- 
2.29.2

