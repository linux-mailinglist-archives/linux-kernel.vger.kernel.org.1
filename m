Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E613D2A4956
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgKCNpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCNpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:45:07 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B316C0613D1;
        Tue,  3 Nov 2020 05:45:07 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so11532057qte.11;
        Tue, 03 Nov 2020 05:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2af8lawmvvDlOCNsCA7JIsdmqsCdB2rsVoy0htQN5ns=;
        b=tG8I/1z0TzI4q4NRqPO0rLNCTHRPlcbPUisuwZGCHkTaA7gq31V+sIhXGjEgV0/vO6
         pbNTw7LwqJ2BSRB+laFJtJlByIXmlZuy/6GU5jgLNMQiuBE8U4Tu//pUvxee4YY0nQ0c
         k1RsAaL8qgvf6GpS53ldLQwM5sFzu943PYddpW6yoLTBmPW5+fsmDiA58lO3h3YiZxKA
         1F8hhtjSQPz++5Bt4+shgsuVJGR+g/Uz2hsQEDd+OY//+xUtxXjKKJMY+Svoexxw1xC1
         y9Pb+KBXnUylNFffJknKNkJidEoXJl2Lsu31GCkZxAv5KRlR4wsY/4vmMfzf53jrb4Lg
         KfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2af8lawmvvDlOCNsCA7JIsdmqsCdB2rsVoy0htQN5ns=;
        b=Ebn1TweGkhKdcKJvsjTzcQmb4byAALvkGDQBFe4/Dj8CpV/vfnbrBMjp/YwfDCkHsw
         xJ0hTuQZVNR6rzxJooewiOPiBcJADZIEqeO9mSY1oo2vLZPbqVhqMdGVBnxRhWpox0jr
         rxjwIRjLMh85xByXr3QdUXb+8kYeuj5VyD/cgO56tNYE81332B8qpnp2F4oWnA9H17Aa
         vGo0FBaIZzKa4cJy2hG1tfFQ+dEohnryQxqRTuaOFsV3eIgSwOOnZklB+/CRL+FJsp8u
         cvQwZ/QsPHw3BIXMT+y/qcmfBnwrmbmf0bHVJm+qcFcJHRsmh/j+pFVDq/EHryxIXYpP
         ZWuA==
X-Gm-Message-State: AOAM530/tqtZXJuxU9a8In1OjGA0l/tCBldZd+qGBFhq4y1+4GFioLft
        VzilhujLb2oOfe/VAc2i+Bs=
X-Google-Smtp-Source: ABdhPJyVcGsn9BfmX6lMFbKU1u49HpMjynWi/XDV0GRg9SB/A1h+SY8oRaMOm+QQs2KcIwEHTdVD7w==
X-Received: by 2002:ac8:5a01:: with SMTP id n1mr19342230qta.52.1604411106177;
        Tue, 03 Nov 2020 05:45:06 -0800 (PST)
Received: from zhuyifei1999-ThinkPad-T480.gw.illinois.edu ([2620:0:e00:400f::31])
        by smtp.gmail.com with ESMTPSA id a206sm7356568qkb.64.2020.11.03.05.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:45:05 -0800 (PST)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH seccomp 0/8] seccomp: add bitmap cache support on remaining arches and report cache in procfs
Date:   Tue,  3 Nov 2020 07:42:56 -0600
Message-Id: <cover.1604410035.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

This patch series enables bitmap cache for the remaining arches with
SECCOMP_FILTER, other than MIPS.

I was unable to find any of the arches having subarch-specific NR_syscalls
macros, so generic NR_syscalls is used. SH's syscall_get_arch seems to
only have the 32-bit subarch implementation. I'm not sure if this is
expected.

This series has not been tested; I have not built all the cross compilers
necessary to build test, let alone run the kernel or benchmark the
performance, so help on making sure the bitmap cache works as expected
would be appreciated. The series applies on top of Kees's for-next/seccomp
branch.

YiFei Zhu (8):
  csky: Enable seccomp architecture tracking
  parisc: Enable seccomp architecture tracking
  powerpc: Enable seccomp architecture tracking
  riscv: Enable seccomp architecture tracking
  s390: Enable seccomp architecture tracking
  sh: Enable seccomp architecture tracking
  xtensa: Enable seccomp architecture tracking
  seccomp/cache: Report cache data through /proc/pid/seccomp_cache

 arch/Kconfig                       | 15 ++++++++
 arch/csky/include/asm/Kbuild       |  1 -
 arch/csky/include/asm/seccomp.h    | 11 ++++++
 arch/parisc/include/asm/Kbuild     |  1 -
 arch/parisc/include/asm/seccomp.h  | 22 +++++++++++
 arch/powerpc/include/asm/seccomp.h | 21 +++++++++++
 arch/riscv/include/asm/seccomp.h   | 10 +++++
 arch/s390/include/asm/seccomp.h    |  9 +++++
 arch/sh/include/asm/seccomp.h      | 10 +++++
 arch/xtensa/include/asm/Kbuild     |  1 -
 arch/xtensa/include/asm/seccomp.h  | 11 ++++++
 fs/proc/base.c                     |  6 +++
 include/linux/seccomp.h            |  7 ++++
 kernel/seccomp.c                   | 59 ++++++++++++++++++++++++++++++
 14 files changed, 181 insertions(+), 3 deletions(-)
 create mode 100644 arch/csky/include/asm/seccomp.h
 create mode 100644 arch/parisc/include/asm/seccomp.h
 create mode 100644 arch/xtensa/include/asm/seccomp.h


base-commit: 38c37e8fd3d2590c4234d8cfbc22158362f0eb04
--
2.29.2
