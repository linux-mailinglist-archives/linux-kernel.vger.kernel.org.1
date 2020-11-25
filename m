Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B72C48BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgKYTtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgKYTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:49:03 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:49:03 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id r1so3273803iob.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JkQcQp14En4LFF6E6DLPJVf1CuRwzYOmsbNNlK0uxQ=;
        b=Tov6PsmD8Sbxo4+ItvdeZDiNriLODkVRlay0EvIBDqtda9Ygtjri96Ozc3qF7O5pnG
         H6fjPu2ebpfcJCJzdHXJXDC/D6X54ycBDbaoaORh9VFy1z19yxKST0IKYTennsLNK5v1
         rwZ7kTe7T9IL8TqCsGSgGsoqNY1dyI16HcXoKBMFLDdeUS4tOHWr4pHJ58l/ehLBeqbn
         RiBTdWCDjBYaXbQwvoobpaBQKf7fu8EfHGQJeDxkxpEqQoX9GqV4BFVPqVIAkjwHliGT
         67ToBniW+7DXL6Ot73yTKqDOfgPC9hHSUl3wu1fUJZ8T570lixFu727zmbXqF6Fy4YbS
         V7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JkQcQp14En4LFF6E6DLPJVf1CuRwzYOmsbNNlK0uxQ=;
        b=CsQRh9Ykw+O/9uqVYc9r4HyKDITYie+YDWDlH6PJLN6pB+1e6irX2W4cw/W5Qmf2zF
         e8mmm5dmDqR5VZDn5rak5d5a/k8/V2pIgkA/fJQtLbWYXpnOzBUpOKS87CXpUKQuZg1E
         nfKcYqPYYY3j2XIEibzZM4uUBudnrk0vfwPgmTNYPonrTGSAEuZm5guV9X+lvmNFyjeC
         vNPwDQR+QQKJUONhYMW6i6ug+4WY+iaMnXm5QvxE0Qgu+CAlUgkq/yriMt0XitnWjpre
         w61UMQzmy8+U+Z7dqjm0pfuj8jnD0WbK7sG/TFOCxXX/nxgGj/QYRJO0/eplkVLGMQ5+
         bXzg==
X-Gm-Message-State: AOAM533tulsL0jgDnjZSSYMjJ7Z/imm7sxs4MWqqjwcTu0Zjro7mvXdn
        Qy9wkkfy1VSU8cB0DWieyrc7h+Ch9R8=
X-Google-Smtp-Source: ABdhPJw/d/Dvsw60ahpFIWp3FRBzbuvDCXfBqz7vEvVWAtlpDjSbNbjkEff5Oj+/iri8aLRIyUuLTA==
X-Received: by 2002:a05:6602:2299:: with SMTP id d25mr3911041iod.194.1606333742179;
        Wed, 25 Nov 2020 11:49:02 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n10sm1411799iom.36.2020.11.25.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:49:01 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/7] WIP dyndbg diet plan, paging Dr Zram.
Date:   Wed, 25 Nov 2020 12:48:55 -0700
Message-Id: <20201125194855.2267337-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

To celebrate a season of ritual overeating, Id like to propose a diet
plan for dynamic_debug.

dynamic-debug is carrying extra weight/memory in the __dyndbg linker
section, which is basically a struct _ddebug array[].  The 5 display
oriented fields carry hierarchical data, and since the linker section
is ordered, there is lots of repetition in .module .file .function
fields.

This patch-set:

1) splits struct _ddebug in 2, creating creating _ddebug_callsites
with 5 display-fields, which are placed in a new linker section.

while this adds indirection, it lets us manage storage of the .site
data, letting us keep the bulk of it in compressed form.

2,3) explores run-length-encoding as one alternative to zram,
basically throwaway, but for any ensuing discussion.

4) do kconfig bits - needs work

5) at late-init, copy site recs into zram (and save to .zhandle),
thereafter .site is "refilled" (when null) from the .zhandle.

Updating the _ddebug.site pointers also means we forget the link-time
refs to _callsites section, allowing its reclaim later (once I know
how).

The .site "refill" is by _getsite(); the corresponding _putsite()
works: it zs_unmaps ASAP and zeros .site.  This means that every
pr_debug will map/unmap once, and `cat control` will do so per line.
Probably too expensive.

But it works. Im seeing 3 pages_per_zspage, on entire section.

6) a hot locking mess. well, maybe not. plenty of uncertainty though.

7) does not work.  It changes _putsite() to keep each zs_mapping when
the pr_debug is enabled.  But it panics in late-init, with BUG
sleeping in atomic context.  ? dynamic_emit_prefix is in backtrace.

disabling all pr_debugs (--kopt \*.dyndbg=-p) gets to root prompt.
once there:
  echo module main +m > /proc/dynamic_debug/control	# is ok
  echo module main +p > /proc/dynamic_debug/control	# BUG sleeping invalid context

This strongly implicates the dynamic_emit_prefix call chain.  It
puzzles me that keeping the zs_mapping would cause so much trouble;
its not causing more pr_debugs, and they should all be mapped already.
But I really dont know what Im doing here..

WAG at possible memory savings:
- add 2 pointers (zhandle, site) 56+16
- drop 48 (sizeof _callsite) * num-pr-debugs linker section
- replace with 3:1 storage on same
- 48 bytes per enabled pr_debug, typically <1% of set

IE:
 dyndbg: 216 modules, 2058 entries and 8640 bytes in ddebug tables, 115248 bytes in __dyndbg section
VS:
 dyndbg: 224 modules, 2015 entries and 8960 bytes in ddebug tables, 80600 bytes in __dyndbg section, 80600 bytes in __dyndbg_callsites section
 dyndbg: 2015 entries. repeated entries: 1790 module 1668 file 810 func

Once __dyndbg_callsites section is reclaimed, %30 savings looks likely.

Jim Cromie (7):
  dyndbg: move struct _ddebug's display fields to new _ddebug_callsite
  dyndbg: count repetition in __dyndbg_callsite fields.
  dyndbg: add some code to see alignments of linkage data
  dyndbg: select ZPOOL,ZS_MALLOC in Kconfig.debug DYNAMIC_DEBUG_CORE
  dyndbg: replace __dyndbg_callsite section with a zs-pool copy.
  dyndbg: add locking around zpool-add loop in zpool-init
  dyndbg: enable 'cache' of active pr_debug callsites


 include/asm-generic/vmlinux.lds.h |   4 +
 include/linux/dynamic_debug.h     |  42 ++++--
 lib/Kconfig.debug                 |   2 +
 lib/dynamic_debug.c               | 242 +++++++++++++++++++++++++-----
 4 files changed, 239 insertions(+), 51 deletions(-)

To: linux-mm@kvack.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
-- 
2.28.0

