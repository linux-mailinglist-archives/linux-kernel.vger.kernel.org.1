Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1392965EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371549AbgJVUYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894716AbgJVUYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:24:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B035C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:24:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j10so2906415ybl.19
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HUKMjAMdYgAudHjv40qJho4+mpPsVV2zIf1Pb9dxju8=;
        b=bJDYKackW4gnmf4ke0c70lVD/bvgt4vxrVlTfcw021E+/nI0zlLw0Rr5wu6nZzdJgT
         fZoZk5T+jtiuRl6Rssqck66cxO+v997nKlECMftQ+LGsmdSVzGz+pxfMtBD5IBjEIu6E
         ApDdkKQuW4QUNsmzaJYrkDCqymE/wen9+bvhshK3X/untssj0s0rstgCTA+AhlwcBLqB
         yuTtiBFKJAWL+4zKPM0X4Gqrb6tB9wQ+yb4cwSLVGiOtIsFX4nf+xyzuUjCvExYvotN9
         tAazT+jn6/FbN5tuqyT0IIJt2ngP+xxNYRJ+yPEe8dkqXgfOfKx09DiDlpjjNE17Ak4e
         oWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HUKMjAMdYgAudHjv40qJho4+mpPsVV2zIf1Pb9dxju8=;
        b=sfWE6uDNBh4CrtfliNUak8K8DF0KOaZk9vqSdi6kjeYm27Bd6ZiYqKGcZnrcebEPyH
         r2OdnH/3A5SfEw5HKfnmcKZF+GyhjGE4/4LMNQa+bYlHFIV7lrIfLnDCzXcDa2jEGXU/
         xreZclVivV2Jca12u8NujkifVF0+xNqlcIszJTmGe7hfM/+Cms7KbbkOwcLL5beUZIDK
         5z40jzM4n1II7uOcmlTRYWuBEW0VZYdmK/Tm+P95hE4iulkSou71LSwkQlY0+e2kbH4i
         t8vfSiPZ+nXk1wJT07D7YGlVg6sV35eWBFwSi1R19BHYS4nmc9N4hlL4y6qswFIycG7F
         GEyg==
X-Gm-Message-State: AOAM532lu5yUgKxtvCgcr4eY+D4O6fIs7k1wVFcfP2kQXRrZZQn1NTsI
        mUJV+MbPZ+nzEMKZ3G2eYgSS8uKpMSrk93kEJRM=
X-Google-Smtp-Source: ABdhPJz1QFO4Sm3gtxxFG/5nw82gV7L2ChGBMWbfdgNmnRF6Ft1+bcSrSU7SSX+U0dOB1MhI3HCKjtPdi1PvKNAcQdQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:ba4c:: with SMTP id
 z12mr5684689ybj.366.1603398242686; Thu, 22 Oct 2020 13:24:02 -0700 (PDT)
Date:   Thu, 22 Oct 2020 13:23:53 -0700
Message-Id: <20201022202355.3529836-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH 0/2] scs: switch to vmapped shadow stacks
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed a few months ago [1][2], virtually mapped shadow call stacks
are better for safety and robustness. This series dusts off the VMAP
option from the original SCS patch series and switches the kernel to use
virtually mapped shadow stacks unconditionally when SCS is enabled.

 [1] https://lore.kernel.org/lkml/20200515172355.GD23334@willie-the-truck/
 [2] https://lore.kernel.org/lkml/20200427220942.GB80713@google.com/


Sami Tolvanen (2):
  scs: switch to vmapped shadow stacks
  arm64: scs: use vmapped IRQ and SDEI shadow stacks

 arch/arm64/include/asm/scs.h | 21 ++++++++++-
 arch/arm64/kernel/entry.S    |  6 ++--
 arch/arm64/kernel/irq.c      |  2 ++
 arch/arm64/kernel/scs.c      | 67 +++++++++++++++++++++++++++++++++---
 arch/arm64/kernel/sdei.c     |  7 ++++
 include/linux/scs.h          | 15 +++-----
 kernel/scs.c                 | 67 ++++++++++++++++++++++++++++++------
 7 files changed, 156 insertions(+), 29 deletions(-)


base-commit: 96485e4462604744d66bf4301557d996d80b85eb
-- 
2.29.0.rc1.297.gfa9743e501-goog

