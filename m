Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D33320968F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 00:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbgFXWux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 18:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbgFXWuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:50:52 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD562073E;
        Wed, 24 Jun 2020 22:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593039051;
        bh=RTdWkJmEWlr3331RT80WkFaq8OxKmIjqJQ5OvXIxZdE=;
        h=From:To:Cc:Subject:Date:From;
        b=N7m5arVKJN3esvocEZvHd8rDKDecj+jdesxUcccHZ+6szbK4PO+wmCzGP2WXW5c/9
         TlXzE9tJX2fJ1hFjsP1nv21YhP2JKQ5dUYAoIjjThfHJKHQl6m378WCu5o3TfJRTBu
         W6To9bGjQlebi81ZJki0anr4GjSf85oKr9g8oCxY=
From:   Andy Lutomirski <luto@kernel.org>
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] x86/fsgsbase: Some fixes
Date:   Wed, 24 Jun 2020 15:50:47 -0700
Message-Id: <cover.1593038991.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two are trivial selftest fixes.  The third one fixes an actual
regression.

Andy Lutomirski (3):
  selftests/x86/fsgsbase: Fix a comment in the ptrace_write_gsbase test
  selftests/x86/fsgsbase: Add a missing memory constraint
  x86/ptrace: Fix 32-bit PTRACE_SETREGS vs fsbase and gsbase

 arch/x86/include/asm/fsgsbase.h               |   2 +
 arch/x86/kernel/process_64.c                  |   4 +-
 arch/x86/kernel/ptrace.c                      |  43 ++-
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/fsgsbase.c        |   6 +-
 .../testing/selftests/x86/fsgsbase_restore.c  | 245 ++++++++++++++++++
 6 files changed, 284 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/x86/fsgsbase_restore.c

-- 
2.25.4

