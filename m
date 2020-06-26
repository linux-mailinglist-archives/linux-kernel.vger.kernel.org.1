Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1951A20B6C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgFZRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 13:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgFZRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:21:19 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4527320707;
        Fri, 26 Jun 2020 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192079;
        bh=NJPS/mjB9XwLVSj2acLE1ljUYNuPaAGLyzKxQizvU5I=;
        h=From:To:Cc:Subject:Date:From;
        b=NV3OalI/tpTtU2Am8O8763LzJ/QY6gPgysoYNBKPIKp4+9xBDfDa1B7IPNZ5khLJj
         KpvHThV8u5YP6CG8bwZsztqzrX+qOAz0Gl7/77RP6S6OJY8p5ocmPcwIBs9MGgohUO
         S+Qg0eJRLREUaWwFR6Q+xsqPLYTtcuJbGwtg9iQA=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/6] x86/entry: Fixes
Date:   Fri, 26 Jun 2020 10:21:10 -0700
Message-Id: <cover.1593191971.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Half of this is selftests.  The rest adds some confidence-improving
assertions and fixes a crash when running on Xen PV.

Andy Lutomirski (6):
  x86/entry: Assert that syscalls are on the right stack
  x86/entry: Move SYSENTER's regs->sp and regs->flags fixups into C
  x86/entry/64/compat: Fix Xen PV SYSENTER frame setup
  selftests/x86/syscall_nt: Add more flag combinations
  selftests/x86/syscall_nt: Clear weird flags after each test
  selftests/x86: Consolidate and fix get/set_eflags() helpers

 arch/x86/entry/common.c                       | 30 ++++++++++++--
 arch/x86/entry/entry_32.S                     |  5 +--
 arch/x86/entry/entry_64_compat.S              | 12 +++---
 arch/x86/xen/xen-asm_64.S                     | 20 +++++++--
 tools/testing/selftests/x86/Makefile          |  4 +-
 tools/testing/selftests/x86/helpers.h         | 41 +++++++++++++++++++
 .../selftests/x86/single_step_syscall.c       | 17 +-------
 .../testing/selftests/x86/syscall_arg_fault.c | 21 +---------
 tools/testing/selftests/x86/syscall_nt.c      | 36 ++++++++--------
 tools/testing/selftests/x86/test_vsyscall.c   | 15 +------
 tools/testing/selftests/x86/unwind_vdso.c     | 23 +----------
 11 files changed, 118 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/x86/helpers.h

-- 
2.25.4

