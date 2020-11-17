Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBFA2B70BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgKQVN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgKQVN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:13:26 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BBC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:13:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b3so10932131pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUL+9SvzrRzllFEAM5OhpKctCqgJfj/sR/XV7GWar0I=;
        b=MWHmfYIY9ch9OvmV2riVcHnEmRpuPVUXqLW0gkD2sszZU8xssgw1NP5X1ShxEm8HJa
         0hsVkK3fKE20KdO6VmXkfWW+cgXtGbCsjVnNFMstYf+pK2L5LTkbrAxCuUfBB/WpAjAt
         75tDLdzwv7U0UzXqesHtuAuhick5Z8a/RrA2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUL+9SvzrRzllFEAM5OhpKctCqgJfj/sR/XV7GWar0I=;
        b=P6uUheI+UXU9jvDi7cX4Pgrlgy+FlulCIK3d7xDetx5TvrmcuiKMTC0czcagsd+v5s
         DZx43TsPNqE2BIxdcmMJ3FN1l5KT1H2k4x3/AgXmd67GNpElmLXS/BgN2Ydd0IuAfJF8
         O/Eb5C9TIrYy12WqSXJatbK94k5DcvKkpRbzHXrGeRfIyGnEPxyuDIsE2ys0SEJKcta+
         W5EVYCpCiNqRZuUVRE229NngYUAPL+xst+tIAAje50MqjbQG9TMB5L3RHKsaqNU/MFdh
         /oDoFsRy2Gl3sNamSEqLvUdPAbP4yyhSeex4Ho/rvAZ1LEv3LYpvaLFsTiq5orEBPF4l
         iTvg==
X-Gm-Message-State: AOAM532UweAyVGrt6A8zfpv3SiLeK9icGu8fVo4vAES/FrjP5sJXrZQk
        qWWH4nK51ENvxF47fYUEvhry+g==
X-Google-Smtp-Source: ABdhPJylohww9dg1GYyIbVMq/Nw8ytFEu6RVmpEehQbjLtvam+DWoalMEAMP5jppFr2nQ0E9S6IUIA==
X-Received: by 2002:a17:90b:80f:: with SMTP id bk15mr934491pjb.119.1605647606216;
        Tue, 17 Nov 2020 13:13:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18sm19469582pgm.68.2020.11.17.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:13:25 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     containers@lists.linux-foundation.org,
        YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Josep Torrellas <torrella@illinois.edu>,
        Jack Chen <jianyan2@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        linux-riscv@lists.infradead.org,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-sh@vger.kernel.org, Hubertus Franke <frankeh@us.ibm.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, linux-parisc@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        linux-csky@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org, Will Drewry <wad@chromium.org>,
        linux-s390@vger.kernel.org,
        Valentin Rothberg <vrothber@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH seccomp v2 0/8] seccomp: add bitmap cache support on remaining arches and report cache in procfs
Date:   Tue, 17 Nov 2020 13:11:13 -0800
Message-Id: <160564746555.1001899.9792418917631139658.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1605101222.git.yifeifz2@illinois.edu>
References: <cover.1605101222.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 07:33:46 -0600, YiFei Zhu wrote:
> This patch series enables bitmap cache for the remaining arches with
> SECCOMP_FILTER, other than MIPS.
> 
> I was unable to find any of the arches having subarch-specific NR_syscalls
> macros, so generic NR_syscalls is used. SH's syscall_get_arch seems to
> only have the 32-bit subarch implementation. I'm not sure if this is
> expected.
> 
> [...]

Applied to for-next/seccomp, thanks!

I made a small tweak to the last patch to add more details to the per-ARCH
help text, and to drop the needless "depends on SECCOMP" (which "depends
on SECCOMP_FILTER" was already present).

I successfully build-tested on parisc, powerpc, riscv, s390, and
sh. xtensa doesn't build using the existing Debian cross-compiler, and
I can't make csky with clang work, but they look correct. *cross fingers*

[1/8] csky: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/ee7ce951028f
[2/8] parisc: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/7f049cc068a3
[3/8] powerpc: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/95f8ae2624a0
[4/8] riscv: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/8f9f0f44a37b
[5/8] s390: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/5897106c6902
[6/8] sh: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/75186111c257
[7/8] xtensa: Enable seccomp architecture tracking
      https://git.kernel.org/kees/c/4f408bc643aa
[8/8] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
      https://git.kernel.org/kees/c/49a6968cc78f

-- 
Kees Cook

