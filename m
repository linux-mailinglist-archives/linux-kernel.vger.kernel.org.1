Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D992B72DC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 01:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgKRAIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKRAIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:08:01 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C53C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:08:00 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id x20so215436qts.19
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=V3tvIh5NHv05LPYSP9VOlCUVLr3gN78y2A44GlQ/+zg=;
        b=ddMrpjFpXh0ci590xEOLW7SJSIup4OgtQiHQGQ7qJKT5bTz6H0JhT6g/+XnLsGuqbE
         agLaFQDvs9x5ip/ZvJHe5SBw+tta4FuWRorIhOOJWouCuHJ5oxSiyiM0Dq0oRCepln3C
         UrY8dPQfN5sC6c6tLJzmPWnJOM7U3NffOmxi+/2T++V/wj6NzikDg8L4Jbrj3f+exuLK
         mlof4+m6FaWVdUzULd3YtCJRpJb4/kPeVPLW0HR2gdpHiy4vxMG50vv83YtD801HkeyP
         m1WJRCVkpX7fUJ6zGSuVfQRljJUTzEIrWttcMSALDzYdh3AQG1MZslH8qTzVqRj26HFJ
         +qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=V3tvIh5NHv05LPYSP9VOlCUVLr3gN78y2A44GlQ/+zg=;
        b=idn4AalrotiClkWtY3AhRNdvCFR0f3BCQqdbpTQFt/PLHQPhAtl6P+Jyu/NT4SnmXv
         Riz+79jWHay7reHVgMQ8MDdmc1UkcgaiO74UQhG3kth8gqxHcOyFtzQDKUEFHJI6iEOL
         vkKzx0bheafgK+k2pLGzbvXkQ4HotceZZWgr7M9UxqcEa5o9eSYvXMUbe8d+NPc9rAma
         h2CRGHgr47HO2Mgdp9pFVEtmWOeRTool8hHRQd29x6JMHjl5SI9PSgEBUWnrTBVZsLF3
         ao+uWIa5IdR1Zji1FY19iq+U5Zbj8CWxr6zPnBMYCwYELNY0tZ0ybI1JDDhtMhMxzFkK
         QFqQ==
X-Gm-Message-State: AOAM533MFFJCCSHaPKzostFCVPES4ON7lqAruzDp1UNfrBGA/IDIOtWd
        H4C/S7xCZR+KM4pKCGAKmLf7Gt/wsC7Yu7M7BCc=
X-Google-Smtp-Source: ABdhPJxyT4QSqjiO/hV2SGyByZFsZRA7niNoQlakX/V0MDwLgNhsF7VsvTbGKPGQxyGwFCBQLO7iPm/RgWu/MnQ8oPg=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:f185:: with SMTP id
 m5mr2278509qvl.27.1605658080093; Tue, 17 Nov 2020 16:08:00 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:07:48 -0800
Message-Id: <20201118000751.845172-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 0/3] PPC: Fix -Wimplicit-fallthrough for clang
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
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

Changes V1->V2:
* collect tags via b4 (fix Gustavo's tag as per Miguel in patch 2/3).
* reword commit message of patch 1/3 as per Arvind.
* reformat patch 2/3 as per kernel test robot and Gustavo.

Nick Desaulniers (3):
  powerpc: boot: include compiler_attributes.h
  Revert "lib: Revert use of fallthrough pseudo-keyword in lib/"
  powerpc: fix -Wimplicit-fallthrough

 arch/powerpc/boot/Makefile      |  1 +
 arch/powerpc/boot/decompress.c  |  1 -
 arch/powerpc/kernel/prom_init.c |  1 +
 arch/powerpc/kernel/uprobes.c   |  1 +
 arch/powerpc/perf/imc-pmu.c     |  1 +
 lib/asn1_decoder.c              |  4 ++--
 lib/assoc_array.c               |  2 +-
 lib/bootconfig.c                |  4 ++--
 lib/cmdline.c                   | 10 ++++-----
 lib/dim/net_dim.c               |  2 +-
 lib/dim/rdma_dim.c              |  4 ++--
 lib/glob.c                      |  2 +-
 lib/siphash.c                   | 36 ++++++++++++++++-----------------
 lib/ts_fsm.c                    |  2 +-
 lib/vsprintf.c                  | 14 ++++++-------
 lib/xz/xz_dec_lzma2.c           |  4 ++--
 lib/xz/xz_dec_stream.c          | 16 +++++++--------
 lib/zstd/bitstream.h            | 10 ++++-----
 lib/zstd/compress.c             |  2 +-
 lib/zstd/decompress.c           | 12 +++++------
 lib/zstd/huf_compress.c         | 17 +++++++++++-----
 21 files changed, 78 insertions(+), 68 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

