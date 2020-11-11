Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF502AF352
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgKKNea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgKKNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:34:30 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235CCC0613D1;
        Wed, 11 Nov 2020 05:34:30 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so1260483qtp.1;
        Wed, 11 Nov 2020 05:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADY2JmYxE9Xly9S24Z1LRnTUA3RyY71p6BFzajWHuao=;
        b=YJSxGfIbb1UUIY/29x8l4T1Jgc/yvQs31iNrz+gq8lShwrVPuHybhNR6GJR2b7ujTh
         QXkNda2M3eSKkjAcLLD3C+040OUac/TeqxIQ4kKWh1L61WubktOhPd4WOSZc7To8b+sR
         jcvHPDdLofNDeZQFZI6zTyzwiTZI58E4j7EHZSBLV1AVXppIZtxsLNOxs1YSHzxtaIyi
         /8HpFYA+y+MUg78ZtzBB1bfvaT8TL/NlfNctAizFSHUGW5eGeI6PDGrklFXYAAJQKgEB
         E8onifEyVUdSHl7UZUr5Lsm3j3fv9Fv5friHKntdo5FtOXwpCVL7DFWbsNCOMCfZLyYf
         O7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADY2JmYxE9Xly9S24Z1LRnTUA3RyY71p6BFzajWHuao=;
        b=LsFvUFhvtSYg5FariRxlsEZVqBjzMzARa8KF5wkM0NE7Q6ew73nia6T5CgOMeF3LEk
         irmbL9JJDjgnuQaJQpO43jFL7qqUH0lt7UCTlz+gy2z/RT+jBrlluX74WvNfwDM05gVk
         a/thaUMApzQhGJyg2CqeoB81ssIMyS1ykkFZSwg4WASmnYa7INsxeIfBeAh+jDJN0t3Q
         aOzti8U5QMK0gndSGZsQmD2nXMXTP7yZfsLUk8YycmHDalx/1ZHXlS316pFVa+CAP3h6
         abkEDqir5vcj+InWuX/z6lM9MWBeGI+ID2qC/oVUu0akYfw5UAdd3mohBXLFifZjG8K4
         M+JA==
X-Gm-Message-State: AOAM5336sTqmPporWB9gyUM6m4k3E9CjEQZQCHefTndrwSkWrX7l9m+D
        ArZ0NBlYkskdtJTx0gcBDhk=
X-Google-Smtp-Source: ABdhPJzHUfo2j/Nsf18vB+1vJm4vfXG7t/Ethu+Cj5/ykTWucn6CwriV6xUlfxlPz1n756bgw31C9g==
X-Received: by 2002:ac8:130d:: with SMTP id e13mr23000296qtj.3.1605101669342;
        Wed, 11 Nov 2020 05:34:29 -0800 (PST)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id r190sm1997814qkf.101.2020.11.11.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:34:28 -0800 (PST)
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
Subject: [PATCH seccomp v2 0/8] seccomp: add bitmap cache support on remaining arches and report cache in procfs
Date:   Wed, 11 Nov 2020 07:33:46 -0600
Message-Id: <cover.1605101222.git.yifeifz2@illinois.edu>
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
(selftests/seccomp/{seccomp_benchmark,seccomp_bpf}) would be appreciated.
The series applies on top of Kees's for-next/seccomp branch.

v1 -> v2:
* ppc, sh: s/__SECCOMP_ARCH_LE_BIT/__SECCOMP_ARCH_LE/
* ppc: add "le" suffix to arch name when the arch is little endian.
* ppc: add explanation of why __LITTLE_ENDIAN__ is used to commit message.

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
 arch/powerpc/include/asm/seccomp.h | 23 ++++++++++++
 arch/riscv/include/asm/seccomp.h   | 10 +++++
 arch/s390/include/asm/seccomp.h    |  9 +++++
 arch/sh/include/asm/seccomp.h      | 10 +++++
 arch/xtensa/include/asm/Kbuild     |  1 -
 arch/xtensa/include/asm/seccomp.h  | 11 ++++++
 fs/proc/base.c                     |  6 +++
 include/linux/seccomp.h            |  7 ++++
 kernel/seccomp.c                   | 59 ++++++++++++++++++++++++++++++
 14 files changed, 183 insertions(+), 3 deletions(-)
 create mode 100644 arch/csky/include/asm/seccomp.h
 create mode 100644 arch/parisc/include/asm/seccomp.h
 create mode 100644 arch/xtensa/include/asm/seccomp.h


base-commit: 38c37e8fd3d2590c4234d8cfbc22158362f0eb04
--
2.29.2
