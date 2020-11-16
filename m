Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2572B3C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKPEfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgKPEfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:35:38 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698CC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 20:35:38 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id h23so10776914qka.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 20:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=dwGE+EuvUvxVOeNwuorSmE5DCZ0byzW0xaKhrjXEexc=;
        b=H99SKUXX64FEZ0L0DZDFL7PBMvbh0WtZXXCKrj79Di6uyCKBepzBw4cdVVGPbeFABe
         4NMxaq1WCaXHqdcuR7FkisoHaP648WInpsTp+jfiBpGUy6CKo+sth6PwbM4Uh/jMJCgK
         j0o25q0zwXoGRLY98HcnMrcH/gAM7CKiQC4O5WXWIDI1g/msKvAR0TaLpCyuCtj//La4
         O0o5pp56+xVZofvyHaAor/ZdEWYRuZo2lGy3QqHzBoou4wgyUfxxwjw6KhmofddsIetz
         H1I2RaWoY20rLy3UwqVs4aQ66wV1SBbRIC8N6VaLBI4ySkaaXLHiLdUEFkSyMsroVe/T
         98SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=dwGE+EuvUvxVOeNwuorSmE5DCZ0byzW0xaKhrjXEexc=;
        b=QCD6bXM9IJlRfPlfat+BCGQiH2PFrDfricLJelDQuJXMtB2fTEw9J92FFTV33Ma7i0
         deHwTl1ybLUhELX7HMcK8sBwK+Ptm5kWYThRkZF3tnMVdmICnXyk0jufsp6V7z8m+8T8
         HlmA5SC3yz3MC8QslzJLU0nH8nv9SuqETmTOAan1H63ZH4zIR8x6r0ONGNLnNPuWIgSt
         YD7df2IcG4r/CkCpyMJJurqQB/ECI6nDnJXr4CWy6pcALiOkdffcNNp4yd8IjDiDPe5R
         qes9cDXkSpKvwjTMeCwbm15bM66ohubJENMckV8JHLn8F7kMQE6VJzc4FozFEGrHV0Mz
         8Z0A==
X-Gm-Message-State: AOAM530NpU7GZm153CRNhx+PngJIOU3zrS9e2AzhBdl74Iy8mPa+4XsV
        H/UOjG/q9Loe19clEODbfL/JAuk3+g+L2epGXss=
X-Google-Smtp-Source: ABdhPJz12dxc1TJNZLZgpfNy1rVDfQ/Md/DvGbTEtDrzxIUMLxx8DHgejJ9M6MuuQqwxMb9lyp3uZYb3Fu1D7zolZ80=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:524b:: with SMTP id
 s11mr14139796qvq.3.1605501337720; Sun, 15 Nov 2020 20:35:37 -0800 (PST)
Date:   Sun, 15 Nov 2020 20:35:29 -0800
Message-Id: <20201116043532.4032932-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH 0/3] PPC: Fix -Wimplicit-fallthrough for clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While cleaning up the last few -Wimplicit-fallthrough warnings in tree
for Clang, I noticed
commit 6a9dc5fd6170d ("lib: Revert use of fallthrough pseudo-keyword in lib/")
which seemed to undo a bunch of fixes in lib/ due to breakage in
arch/powerpc/boot/ not including compiler_types.h.  We don't need
compiler_types.h for the definition of `fallthrough`, simply
compiler_attributes.h.  Include that, revert the revert to lib/, and fix
the last remaining cases I observed for powernv_defconfig.

Nick Desaulniers (3):
  powerpc: boot: include compiler_attributes.h
  Revert "lib: Revert use of fallthrough pseudo-keyword in lib/"
  powerpc: fix -Wimplicit-fallthrough

 arch/powerpc/boot/Makefile     |  1 +
 arch/powerpc/boot/decompress.c |  1 -
 arch/powerpc/kernel/uprobes.c  |  1 +
 arch/powerpc/perf/imc-pmu.c    |  1 +
 lib/asn1_decoder.c             |  4 ++--
 lib/assoc_array.c              |  2 +-
 lib/bootconfig.c               |  4 ++--
 lib/cmdline.c                  | 10 +++++-----
 lib/dim/net_dim.c              |  2 +-
 lib/dim/rdma_dim.c             |  4 ++--
 lib/glob.c                     |  2 +-
 lib/siphash.c                  | 36 +++++++++++++++++-----------------
 lib/ts_fsm.c                   |  2 +-
 lib/vsprintf.c                 | 14 ++++++-------
 lib/xz/xz_dec_lzma2.c          |  4 ++--
 lib/xz/xz_dec_stream.c         | 16 +++++++--------
 lib/zstd/bitstream.h           | 10 +++++-----
 lib/zstd/compress.c            |  2 +-
 lib/zstd/decompress.c          | 12 ++++++------
 lib/zstd/huf_compress.c        |  4 ++--
 20 files changed, 67 insertions(+), 65 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

