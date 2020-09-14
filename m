Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8126934D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgINR2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgINR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:28:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AFFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:28:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so458221wrl.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMQigiH2Yj3ljq0v4heVqWDyhdHIO/cGF9bhez3idR8=;
        b=gFAAaw1WaHNJJkqhAadqzBiA1dZjRClqlrPYUxSrgjylyL+3O51yk1GUMxuzgbcrL7
         UEXnOZ6SdaSQxqxdU5Gq/nOZDOBeyC45agRXAq6IQ9/C4Tq+2TWntn6rm/qWMNDLveP4
         ZBJNjXyqs9lt+JXuwoW0N7CsbD5E99Gk5vtG0SBxM74gwDVFDOzs7qQR0QrG0C9MwMJ0
         FvsbbMR6C8V8MoYSzEnE/1EoWvwV3+Qq0uE2kNxc0iB9ue2MKanbboImKXB+wypoSxUM
         flPyEk3CVB7Sq5yN7O0yFqpAxUNJwkoYNuXgF4KpEqkizPNprU86jvEUHwiJbZy8c6i5
         801w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMQigiH2Yj3ljq0v4heVqWDyhdHIO/cGF9bhez3idR8=;
        b=IB89MmPjKv11IEw1DT2mFkX0VsABGjV6uq3Ubw9DOE8TMkqgRw8ymW4TcHyKl82Txk
         K0viYlGbYFrktv7Wd1rKFEz7rj3J3PmkcP2GVL7TlFqU72Hkc/gbpugti4rv8SKG3lmu
         PzIfczGrX3Jm9BxmASnV2mp4SxIT0ImRSbGQaZaW9lvTL/+q5BcOb9Nbqb0XV1wgJzmB
         1ErQFVz1kT8NYrY/ZPpM3ht5kUTli7KrlOQ6VEmtzTBcF2J2g9swQtZrbrzxSt9259Ps
         9AALT9NmAyRI+LGb3qdy/noZ7//8IX4Zz4LTtKCkEARiOPDtbN0Tt5qvJJAFHnhnwNp8
         pGgQ==
X-Gm-Message-State: AOAM532Uz5lYZjpWPtYjfZi/EJ9c7Gpi5VevHJrYOE67ojhkIyjv3qNj
        gAdXmjbLTUrUKeIpJH9xqmjqnQ==
X-Google-Smtp-Source: ABdhPJyGmq1oNLTCt+QLZhrFtOEe0CSecXyWrLoDzrYdiMgpu22TCnydQl8WOCfVUWECPgwrH56Q2g==
X-Received: by 2002:a5d:680b:: with SMTP id w11mr18141747wru.73.1600104480318;
        Mon, 14 Sep 2020 10:28:00 -0700 (PDT)
Received: from localhost (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id h186sm20919367wmf.24.2020.09.14.10.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 10:27:59 -0700 (PDT)
From:   George-Aurelian Popescu <georgepope@google.com>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        dbrazdil@google.com, broonie@kernel.org, maskray@google.com,
        ascull@google.com, keescook@chromium.org,
        akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
        tglx@linutronix.de, arnd@arndb.de,
        George-Aurelian Popescu <georgepope@google.com>
Subject: [PATCH 00/14] UBSan Enablement for hyp/nVHE code
Date:   Mon, 14 Sep 2020 17:27:36 +0000
Message-Id: <20200914172750.852684-1-georgepope@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main problem solved is logging from hyp/nVHE. Because the nVHE code is
independent from the Linux kernel the logging mechanisms aren’t working.
For this purpose a generic kvm_debug_buffer is designed. It is composed
from a statically allocated array and a writing index and comes with a set
of macros to facilitate it’s usage. To avoid concurrency problems between
cores, the kvm_debug_buffer is defined per_cpu. The buffer is checked every
time when the code returns from an hvc call, by modifying the kvm_call_hyp
and kvm_call_hyp_ret macros. The buffer’s writing index is reseted to zero
inside of the el1_sync entry.

Since UBSan’s handlers are living inside the kernel, they can not be called
inside hyp/nVHE. To enable UBSan new handlers had to be defined there. To
store the data from the handler, the kvm_ubsan_buff is defined. It can store
logging data from the handlers in a new defined struct called struct
kvm_ubsan_info. Each handler has to encapsulate it’s data inside the new
struct and write it into the buffer. The kvm_debug_buffer.c file is
responsible for decapsulating the data and calling the kernel handlers.
To check if UBSan works correctly inside hyp/nVHE the last patch comes
with a test mechanism, that calls UBSan when the hyp is initialized.


George Popescu (14):
  KVM: arm64: Enable UBSan instrumentation in nVHE hyp code
  KVM: arm64: Define a macro for storing a value inside a per_cpu
    variable
  KVM: arm64: Add support for creating and checking a logging buffer
    inside hyp/nVHE
  KVM: arm64: Add support for buffer usage
  KVM: arm64: Define a buffer that can pass UBSan data from hyp/nVHE to
    kernel
  Fix CFLAGS for UBSAN_BOUNDS on Clang
  KVM: arm64: Enable UBSAN_BOUNDS for the both the kernel and hyp/nVHE
  KVM: arm64: Enable UBsan check for unreachable code inside hyp/nVHE
    code
  KVM: arm64: Enable shift out of bounds undefined behaviour check for
    hyp/nVHE
  KVM: arm64: __ubsan_handle_load_invalid_value hyp/nVHE implementation.
  KVM: arm64: Detect type mismatch undefined behaviour from hyp/nVHE
    code
  KVM: arm64: Detect arithmetic overflow is inside hyp/nVHE.
  KVM: arm64: Enable the CONFIG_TEST UBSan for PKVM.
  DO NOT MERGE: Enable configs to test the patch series

 arch/arm64/include/asm/kvm_asm.h          |   8 ++
 arch/arm64/include/asm/kvm_debug_buffer.h |  61 ++++++++
 arch/arm64/include/asm/kvm_host.h         |  12 ++
 arch/arm64/include/asm/kvm_ubsan.h        |  53 +++++++
 arch/arm64/kvm/Kconfig                    |   3 +
 arch/arm64/kvm/Makefile                   |   4 +
 arch/arm64/kvm/arm.c                      |  46 +++++-
 arch/arm64/kvm/hyp/hyp-entry.S            |   6 +-
 arch/arm64/kvm/hyp/nvhe/Makefile          |   5 +-
 arch/arm64/kvm/hyp/nvhe/ubsan.c           | 164 ++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/ubsan_test.c      | 115 +++++++++++++++
 arch/arm64/kvm/kvm_ubsan_buffer.c         |  75 ++++++++++
 lib/Kconfig.ubsan                         |   5 +-
 scripts/Makefile.ubsan                    |   9 +-
 14 files changed, 561 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_debug_buffer.h
 create mode 100644 arch/arm64/include/asm/kvm_ubsan.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/ubsan.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/ubsan_test.c
 create mode 100644 arch/arm64/kvm/kvm_ubsan_buffer.c

-- 
2.28.0.618.gf4bc123cb7-goog

