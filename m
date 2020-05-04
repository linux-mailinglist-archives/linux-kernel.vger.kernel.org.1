Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64371C478F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgEDUBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 16:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728082AbgEDUB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:01:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D4C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:01:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f8so228726plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFRO3RhADYIeDpbw4dnAWyjVt7yzrlI/aPmG+9d8qeE=;
        b=qrHszcJGGSIsCedROR57TweuB7bX5mbZsxDa1hb+YaSY5m/twRdgsGDaKjFpj1FT4N
         V3ECCU3uh6lis3rOAqcfqTQFIoLtc4zGPki5ISHQzFRgDjGkRwdfSu8CkSBUiSKcJgiN
         NM4EF5poDdfcNB/62wYhnyLMSNCzCJpcWte6mNPF9NsqMNcZhm0uMDZQWCgNOYDo1Ohu
         GlAjPDD1qGAC1SHA99cElOMjxrhYtOKW+YnG3vVMHZXdgDCy9UwHxWSNR0bKV3na+jYG
         eJUzGB70l7kBEHhrWRgbWMAsO+hihmceg9Zo2H2vXXs0My0GoiqKsOph6Z3gBJZL0qwe
         pXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZFRO3RhADYIeDpbw4dnAWyjVt7yzrlI/aPmG+9d8qeE=;
        b=oBoCyrqtE7yGjzYAdmk0JGjUbR7ENrzCCEhYV1/CkSkGDfGt/5M4ndffXXeQ36rH76
         Qqi2qdI/fp2TMz8UBtQbj1IM6wUOkdJqvJTArvJkGnYRLx9pBXo+fAQDa2SC/y1z6K1S
         uGM9QdCTunlZSWDJmaDkHmFyl3b9DCCmq9xvOE3T0KUVWDRvyJpQqiNeQ3kjMTSYMwce
         O0jU+G7UY+vAI1dfJmppxPbZ03q6XKuK7RsFNbiIw3L6bOGefzYVDKY5pui8USL4f3fQ
         ANSNeTkp+YR4yvlNnfHL12r767D22UH7vezQWlKtkZOZw7pb6B6zTjovu3Zv0sz8uwJQ
         t+NA==
X-Gm-Message-State: AGi0PubAYzNVK4XSF5RiIQAuxqNNXYC4K0LbybCQS/9Z0sQ4nIttjD2n
        PxCUE8zqrFx5lbrk6F/VO1GyZA==
X-Google-Smtp-Source: APiQypIFC8V36B+W7lp+3i/NHiQ8u4AgxMSexVW/Rp60TpLxCPv8LY5YL73POlfEskWD07QJhyN/kQ==
X-Received: by 2002:a17:902:8497:: with SMTP id c23mr868287plo.335.1588622488940;
        Mon, 04 May 2020 13:01:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p189sm9716682pfp.135.2020.05.04.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:01:28 -0700 (PDT)
Date:   Mon, 04 May 2020 13:01:28 -0700 (PDT)
X-Google-Original-Date: Mon, 04 May 2020 13:01:06 PDT (-0700)
Subject:     Re: [PATCH 0/3] RISC-V KVM preparation
In-Reply-To: <20200424045928.79324-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        pbonzini@redhat.com, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-be6b9ad5-d81c-4ae1-9eed-9b2d63600b37@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 21:59:25 PDT (-0700), Anup Patel wrote:
> This patch series is factored-out from the KVM RISC-V v11 series and is
> based upon Linux-5.7-rc2.
>
> These patches are mostly preparatory changes in Linux RISC-V kernel which
> we require for KVM RISC-V implementation. Also, most of these patches are
> already reviewed as part of original KVM RISC-V series.
>
> Anup Patel (3):
>   RISC-V: Export riscv_cpuid_to_hartid_mask() API
>   RISC-V: Add bitmap reprensenting ISA features common across CPUs
>   RISC-V: Remove N-extension related defines
>
>  arch/riscv/include/asm/csr.h   |  3 --
>  arch/riscv/include/asm/hwcap.h | 22 +++++++++
>  arch/riscv/kernel/cpufeature.c | 83 ++++++++++++++++++++++++++++++++--
>  arch/riscv/kernel/smp.c        |  2 +
>  4 files changed, 104 insertions(+), 6 deletions(-)

These are on fixes.
